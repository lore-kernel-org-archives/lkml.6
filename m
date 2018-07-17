Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D47CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AE22075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Q7b9j36r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AE22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbeGQUeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:34:23 -0400
Received: from mail-eopbgr720059.outbound.protection.outlook.com ([40.107.72.59]:62560
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730003AbeGQUdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCdLtrA1kN8/0je8FqQpiN8x3unLbKCW3xvP6auRcy0=;
 b=Q7b9j36rA4zPAWFfM1gcjACvD1rkdhMts107HGQj++qdXUbSDo1P3f/LccfAMZ1ozZfFDTtEDIg1EtTD2onXkskwo90GdLAnCSMzuAcd8EWhsf2qtiHJw2BPuqs3TYA94mEHQiIs5FSj7mzUWFInGBFindRZ2/5P01ywMstWX40=
Received: from BN7PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:20::23)
 by CY1PR0201MB1913.namprd02.prod.outlook.com (2a01:111:e400:527e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Tue, 17 Jul
 2018 19:59:34 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BN7PR02CA0010.outlook.office365.com
 (2603:10b6:408:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 17 Jul 2018 19:59:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 19:59:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW8C-0001aa-1y; Tue, 17 Jul 2018 12:59:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW86-0004zI-TT; Tue, 17 Jul 2018 12:59:26 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1ffW85-0004y7-ED; Tue, 17 Jul 2018 12:59:25 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v10 05/10] firmware: xilinx: Add clock APIs
Date:   Tue, 17 Jul 2018 12:59:02 -0700
Message-ID: <1531857547-16652-6-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(438002)(189003)(199004)(16586007)(106002)(81166006)(8936002)(47776003)(7696005)(39060400002)(81156014)(8676002)(76176011)(54906003)(107886003)(316002)(4326008)(51416003)(110136005)(305945005)(356003)(2906002)(50466002)(72206003)(63266004)(478600001)(36756003)(2201001)(7416002)(5660300001)(126002)(446003)(486006)(2616005)(476003)(44832011)(11346002)(336012)(426003)(9786002)(48376002)(77096007)(6666003)(14444005)(36386004)(106466001)(26005)(186003)(50226002)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1913;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT007;1:LccfT2RQNUeHZunzffw8qQyR5LB0i5/oWqkn5Gx8zc4CvMs13xqUuR0jyD6KRphCRGneW0hjf39yFmWwAKPBDx8Wn6WgNeW3eo84Oh6cEnE4xzlI4zv6vuSMZIrVImVk
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9264c414-882a-401b-f9ff-08d5ec1fd115
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0201MB1913;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;3:CaFsMCYW/p1UzeOqzZo0gzjmj4tefHzKRnZXSfA5YrN31CDoLO2OJ57OccNrJ15XBSX6RVa9T3MCSjf9+xTaTowHKc6muZuhW4/mrD0Bvw8Taup0oQ+684xPDiuTRBsp33Yq5PDW9z8V2BRkQcg577O56z7vnet9TfAKBZmA37xBLXY4yX4E5+77lCtwh3LDlj8y6nYr+96v5w1HVxX3pxoN+TN6wwLtSMcazeawZ96Zvt4tH2+GZyfZV6EY5XlSoaBEz7jc0BN8+Zero7PKbKvB6KQXA4vJqXDv3GWc6g6YlFfiMLOIvXbHN2Dv0Z8iUWFlWU1+5IVvPRGsL4vet4QONiBZlSVN1cBZizw9inc=;25:PTdtvccTEhfZPTiPggGy4LxfFVkgds5rUPXIpsp+DB53PEJGwIFoCSJXUTl8FwylztTu1EX1tT37KWy+I61ACBkgkSPkCwvh0lDHCQ1xJ9LfHJxxY6LrIotYspR1eFvzZR7fqYJ+Mcsv+critWCgxi5YQZjHHqECs/siVR7HBBl2SxpjzPAgH5CpsdHQhJ+9UYKZsLRNUW4rpPMAAVLS3pGi7whQuUgTCaGEO2bDZ2Veg037arwPt2Zrm3In00BvqrhKJ1biRzu2A11UmcdHfcBdaEQQfaVGuGhxlk/nZhKLIJ+r+WOOe2FS/eBWvZbZCSirChhoMo7znK65rL9Lhw==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1913:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;31:BXACtlcygA1Te6zUPI3JctgzCfqbm/dYMGiIOg+QtAwk/JYh9/l//CeXnWNayERpX0B5Ulq0DX3CZEPDcoouFP6jJ0fvn7HoL+/HOddnRhS41x9hzRx9OVh0z3/Z+8vEUx6EUW268UKAUp0jktkl1mlKrz5VEBQRqQwN4IAZbfXa523M7LhkEWTGyxJodY3WhCIW5tGz/PAieJtJog/1UU0y0aZ1JsV4GPV2NZWJ/X8=;20:JsQKdmBPqOC8Y20GVoYEE8pd4O1TRtjEUya+WTVWgdakNacgExGFukY9jMm9mdh8zYiluvmLZR14p45skbIJPX5pRkXmfdEqEWtRSi3DPkeAVp/BFyt0eJk8NTFY8duCZ2Vu7Tj75intFvSOG7V30cd2JbpUSN761CFbfXuvqnSzWh/+KFSB78IgGPSZkADhiXvqzxdbdLZ4syoROmiia3jBG2I64zVPKejr8nqj8809qLH+/EH0LQW81H6jWU+T4DXnJBYQZuq0P27qXLwF/BY9N+Z74AYB1CRF7p7LeoJbIizWqLG2GFjzOg1QjgDlWIrdwHmTI20gVM8/46CvS42UeE+OZIARebHSrYhQs1z+61XBYh/p5PiBiWz8mtEMk4Eif4HyqW4cOFLTGvfwrA526upHqjv0p6pbJWwMQNGeEi+Pa97AHYPNl3rqUkuT3c08YmbkSbLoKskKMJzQig9X2yA+bh6uVLTFGAgDZqysb1x/umeUFjHwhIolZL6D
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB1913FD90D9DD914D91B6D060B85C0@CY1PR0201MB1913.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR0201MB1913;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1913;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;4:THdiwdQCcgr8zextnJwmu2OwV8ytREq9r3Qm9K1PtQH3RvTXoPW7j6e8AjY9hjog4fAIrq9XtTKvRZ/yRIhLhwslI7HYdGFi09bAYyVNzSaxXJxN0vByea5+xQ1zk4/xIehfq1PDrl9ehnNqhe1nF3muaukpBxm093ZlpmlvEipf1l/635nIxJbzDuHb29fDo9q+9rPB5pOP4afslWbN5HEhxGZBxJPfip6p+xUvgBEdsBBDjw90hkuwyixeUceV1hLDua1YFrmnCxY2hUcamLn7yyod0+PQi6IKcOEh/GkT4AUr7TsKRQ7epITspSav
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0201MB1913;23:gs61DuMcYMCkxI0mcjQKFJOXU41WnlSZkQdIBZq?=
 =?us-ascii?Q?SE23KzE14j06aszCcwcGWg+lTPk2eAEc57aMPCvylr2jMlt1dI8jgW+h/A+z?=
 =?us-ascii?Q?oecZ947YgOvEk2N1ei/nn0s8kd49OBYWJPIPsXjNNY9r84liJ7xkCr7RAQoc?=
 =?us-ascii?Q?poEEGrgjTWuyJA90UK1k8dBGJR/UQ5Uhyb/crHoMXGjpdJiCtLipJ4QAuxC/?=
 =?us-ascii?Q?uH0wFfIxtW5RIh+afQyGYOzDx84l0/30U7N2+BJKjc3xz6sEWza9pr+tqALH?=
 =?us-ascii?Q?bX+PIU1SnLmi6UCdbWVyC+LvGHN09/yAmF/8127Kg1OtI79TDmCPKRnGDF6v?=
 =?us-ascii?Q?e5Av1x9Y3JypvmxPVQ9tfRX31bRIUI3wx6XdxoLIwGReR462zhSUQG0sa1UB?=
 =?us-ascii?Q?k59i4MCzaLsjeEfsh9ZjrV3aF8FMQuiWwQVw58seKd1RLtCDGgej2xhc51vG?=
 =?us-ascii?Q?qoDQMQJRDYtBJMkyNJJZ9pZVQGicRWaW6NW2yB65e/Agwbf4S0UekExxQ4OB?=
 =?us-ascii?Q?2c/c+FDj2vcWeEMmK9KNZwSwwetp1T7JVeLC2yskFNeoUVbbjthMERHH7i1a?=
 =?us-ascii?Q?PsP6GTzEC+l6ir76JMGqvh10j2lyA7GemFi0TBbgQ447lCKulQ3Lt/rTGh22?=
 =?us-ascii?Q?zTZW39SBE87O0Nfj981lF9qqNkC62cehrtbXRkj3mHAelNTATT/fYc7G92wD?=
 =?us-ascii?Q?3gTPmQUVvDdEgn4oQ4YKWUn8ed5nAJq4wn7FIhl0W2YiN+hSBY+nJ4ZiKLgG?=
 =?us-ascii?Q?AraJt1QDJF9yP1nzZM8UdITcj8gAKDiVKOdZb8uT4dtgHoXHes5ilAgZYJgV?=
 =?us-ascii?Q?qnwzlsbMrA2ZdCEl9EFWH8mijo/0DXNjwAfQn2aCIHRZRFCPKGeobefLNLr/?=
 =?us-ascii?Q?sb4c7PK9o0TyFogfoZuCiml5HaX6Z+jKsRvve5fNtOT/pu+nZPodF+mU3pZ9?=
 =?us-ascii?Q?ik/Awq8nIvygMFdA+H42W1qUPU+cjgSVLVGi2p7GXYvp0Leo6TQ/fo9xtT29?=
 =?us-ascii?Q?eJoOge/nQgran6gNEPYn8C9ST2YszqN6Gamh7G4YF0DHAkibeF4yIptHVmYP?=
 =?us-ascii?Q?7p4W0UZ/Fa/M+D7SYvUSqvCVs4aULyp1wRK0nKmArnDUM+C2Zz0acwOtpgWv?=
 =?us-ascii?Q?R23EL8D7z1FHkvi2uHGGfrxE1qyS3anuo2WbxvttRNdn1bMEjbA36EBMypvT?=
 =?us-ascii?Q?ivHI2lZsWYcu2ZcUs6Xu0tkNdhBMM8C0pNf8EF+UVmK7f25G8zZC4nYUoOfp?=
 =?us-ascii?Q?ctCzppDlCpVfGPJYaJw6A6baVvIk/EMkJ2oLazXk1?=
X-Microsoft-Antispam-Message-Info: 05S8ip5LbYhaOVFmhlNWdXSyF4AcCbSGjSJ5G7Qx3tBvksk+GtnbPrDMaXXVJ9un0cV2Ns2kCZuzxkvtm688BDIOcsZbras9C8rAsuz4WsfJIWJcBzuMbtcRp1ytXqW5jg23v9aWm1D+buJZ0HqprvIh4Et/BnzkEK7GUfPBYuDQ4nN3QjSRwUjBt/VE0CLo9gZjnxH1G7eEzcR7cATplw7pFYJJFxl1XWYXMP0L3CuwwXuaIihuzV9oHs4jhq0FOFFkSU3HMdUVnob1BQwG1+XHhERdUSLAaPofvQnyEILzGU71wRj+0ZP6L3nmHvva1REvJSA+I3IRqR9ZFTVl3xUh2FfFNx95QNvciPmjCBs=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;6:BijJByWdvQLnkDZnYjbN2n2UnssknCObumE6DHrzh6OzDNiNJnkSPGv9ISTrLUH8M7L7NdwA4LgK+3mkoAAM7nbJy4aj5byXmlEcMeHMb251JGSQkbqEl5finarpaZCeOVc2L1gId223F7Uwl8/fVxEuKY8Uu4s2kKgNaU7fkA17Q8e+ixZfFkWel3MMbXlwr6HKcxmMujFKdGYueYQG7p4FoE+IOxeUNfyisIV1JQ0n4KqL+Ny1GoJFrcz3j4veO/XunZDAFasQuuvkj7GMlUJcNvEt/IFmnVBAgp4fNHS2B6Dq9OaWWvRuaxO/sEMg3tClyAl8Rrf/sN71nzPUT5uscXk8c99FNFcQfaus2J929ix8UQijsYnEmAE2L4TQCPKllKm+BccyOiRckFbkcOAnTQ2JooZgJmtYdj5eTWsypI4q/3oiSdZa2UCTRlrZTxnw+r089jSuBuOd73TC/A==;5:0g7sF6T9VVqHFSshopf7CQs1722YHqx0QSc6Cix9ivArSfOvbxiYaiVNDPyZ3QpAbutCfrlkc69vVmciTJpCNxQ07w+Vp80UOpfHk71/+HzXeIfRhjihUY8/iHfdkSNgSEWkNF13FOzJIOZGmdF1eSfHasPXhCyBQYwooU5rENs=;24:kC6Ktr23GuvGBzNCyqWgQQW/S3avQGhWbp8ulM+zTwR8s8OpOeM3ezorw8ai18wggovV8US7bAt9E8cwOzXpC8RS1L9x7Kq548mVA1th0f8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1913;7:r0P4m1WiJnFLZzsdjh0MWqvdOCMz2a7LNbZ5Xwn/DWbI3eMRuS/zSduDIkEPwvvjwSbedY29avTf7ZljdL+xACg028adKFJseDcKSc64nLoXrStxPKVGDfu1L3rwuTOcabI0N1EKtIreiaOaDcezeKCfQec71OawcOK/tH/NPs5HvVqHkQ1cI/z6vt6URCbWnVGz7nZcxjXminxwfDnuhQkYFmxMjezZdzXi3JgAOax5SnALZDk8OqfbDYrLE+zF
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 19:59:32.8968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9264c414-882a-401b-f9ff-08d5ec1fd115
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add clock APIs to control clocks through firmware
interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 186 ++++++++++++++++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h |  30 ++++++
 2 files changed, 214 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8ec5682..41ed800 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -269,14 +269,196 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
  */
 static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 {
-	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
-				   qdata.arg2, qdata.arg3, out);
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				  qdata.arg2, qdata.arg3, out);
+
+	/*
+	 * For clock name query, all bytes in SMC response are clock name
+	 * characters and return code is always success. For invalid clocks,
+	 * clock name bytes would be zeros.
+	 */
+	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
+}
+
+/**
+ * zynqmp_pm_clock_enable() - Enable the clock for given id
+ * @clock_id:	ID of the clock to be enabled
+ *
+ * This function is used by master to enable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_enable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_disable() - Disable the clock for given id
+ * @clock_id:	ID of the clock to be disable
+ *
+ * This function is used by master to disable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_disable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getstate() - Get the clock state for given id
+ * @clock_id:	ID of the clock to be queried
+ * @state:	1/0 (Enabled/Disabled)
+ *
+ * This function is used by master to get the state of clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*state = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setdivider() - Set the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to set divider for any clock
+ * to achieve desired rate.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getdivider() - Get the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to get divider values
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
+				  0, 0, ret_payload);
+	*divider = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setrate() - Set the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to set rate for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
+				   lower_32_bits(rate),
+				   upper_32_bits(rate),
+				   0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getrate() - Get the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to get rate
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setparent() - Set the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to set parent for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
+				   parent_id, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getparent() - Get the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to get parent index
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
+				  0, 0, ret_payload);
+	*parent_id = ret_payload[1];
+
+	return ret;
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
 	.query_data = zynqmp_pm_query_data,
+	.clock_enable = zynqmp_pm_clock_enable,
+	.clock_disable = zynqmp_pm_clock_disable,
+	.clock_getstate = zynqmp_pm_clock_getstate,
+	.clock_setdivider = zynqmp_pm_clock_setdivider,
+	.clock_getdivider = zynqmp_pm_clock_getdivider,
+	.clock_setrate = zynqmp_pm_clock_setrate,
+	.clock_getrate = zynqmp_pm_clock_getrate,
+	.clock_setparent = zynqmp_pm_clock_setparent,
+	.clock_getparent = zynqmp_pm_clock_getparent,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 55ed2ba..58a7478 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -36,6 +36,15 @@ enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
+	PM_CLOCK_ENABLE,
+	PM_CLOCK_DISABLE,
+	PM_CLOCK_GETSTATE,
+	PM_CLOCK_SETDIVIDER,
+	PM_CLOCK_GETDIVIDER,
+	PM_CLOCK_SETRATE,
+	PM_CLOCK_GETRATE,
+	PM_CLOCK_SETPARENT,
+	PM_CLOCK_GETPARENT,
 };
 
 /* PMU-FW return status codes */
@@ -49,8 +58,20 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_ioctl_id {
+	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_GET_PLL_FRAC_MODE,
+	IOCTL_SET_PLL_FRAC_DATA,
+	IOCTL_GET_PLL_FRAC_DATA,
+};
+
 enum pm_query_id {
 	PM_QID_INVALID,
+	PM_QID_CLOCK_GET_NAME,
+	PM_QID_CLOCK_GET_TOPOLOGY,
+	PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
+	PM_QID_CLOCK_GET_PARENTS,
+	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
 /**
@@ -71,6 +92,15 @@ struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	int (*clock_enable)(u32 clock_id);
+	int (*clock_disable)(u32 clock_id);
+	int (*clock_getstate)(u32 clock_id, u32 *state);
+	int (*clock_setdivider)(u32 clock_id, u32 divider);
+	int (*clock_getdivider)(u32 clock_id, u32 *divider);
+	int (*clock_setrate)(u32 clock_id, u64 rate);
+	int (*clock_getrate)(u32 clock_id, u64 *rate);
+	int (*clock_setparent)(u32 clock_id, u32 parent_id);
+	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

