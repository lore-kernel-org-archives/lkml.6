Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAC9ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598202145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bMDj02Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598202145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJSQsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:48:05 -0400
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:36567
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbeJSQsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgNjUfoP9dkS8u7k+xDZ2cF4HS3Mh5bmV980e4VYKmM=;
 b=bMDj02RaZLsH6ixLl707rk7Ly9bW5vXD+7pfs+X8KSWXYEzVZLcMh4CGRdrmahgRoyl3DK/qA4lQ+YEMsY7z4MRl/h9wnXT/xlAfEC46H3EO8U3N68EYriUMDUpsj8ZdZn7JdQelFXel9Vp33WQQKK49mvpV3YHgxnHw8xvXUZc=
Received: from MWHPR02CA0004.namprd02.prod.outlook.com (2603:10b6:300:4b::14)
 by MWHPR0201MB3513.namprd02.prod.outlook.com (2603:10b6:301:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.25; Fri, 19 Oct
 2018 08:42:54 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by MWHPR02CA0004.outlook.office365.com
 (2603:10b6:300:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.29 via Frontend
 Transport; Fri, 19 Oct 2018 08:42:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 19 Oct 2018 08:42:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56466 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQMv-0002FQ-6f; Fri, 19 Oct 2018 01:42:53 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQMq-00024i-2k; Fri, 19 Oct 2018 01:42:48 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9J8gfgC030765;
        Fri, 19 Oct 2018 01:42:41 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQMj-00022V-71; Fri, 19 Oct 2018 01:42:41 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH 2/3] dt-bindings: reset: Add bindings for ZynqMP reset driver
Date:   Sat, 20 Oct 2018 14:11:06 +0530
Message-ID: <20181020084107.28251-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181020084107.28251-1-nava.manne@xilinx.com>
References: <20181020084107.28251-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(36756003)(5660300001)(1076002)(2201001)(9786002)(77096007)(63266004)(305945005)(26005)(47776003)(110136005)(106002)(478600001)(8676002)(50226002)(446003)(106466001)(81166006)(6666004)(16586007)(11346002)(81156014)(8936002)(316002)(486006)(476003)(126002)(336012)(76176011)(7696005)(356004)(2616005)(51416003)(2906002)(48376002)(426003)(36386004)(186003)(50466002)(39060400002)(107986001)(921003)(1121003)(83996005)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3513;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT006;1:VRmZ65gpubnZL3QTK4sqejbB/qHW92zHn2G5TyleCLWhf4bmAjwVFzy3n0HiJZafIZ5NkOLekfSFeNCMoSzGzIiQLh98hOeSsPrv2Q4bsqv4FwRC5jSapJSTBpF2OSjL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f48fa54-7f76-44ec-4dde-08d6359edc94
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MWHPR0201MB3513;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;3:epwvfb2LptlbzpZLr98C85MTjPUjbTC/Puu/kFbLwkmYl+mGP+vFV3zDy0fBBS5oM0RnTkQCmCUY8Ia5tOw90smtV58WXhHXh8TEcfxGzPGjAqNZMr9akMGMpiFst8t82GeO1X8knEdPAatNK6SE218YYZ4To0DMu7zFurTwV3YSqQ2+h8Yd6+hpqYkXph3INIqEIYsIbs+yaNdNYF2FDxaCwChKZkGvTpd999MJhmW4oPN62mR7Y804cYMpmY+WqwOakHlOXodcFVxYxAUexmzP5w7/DHPUEsl2x0JdHsb4f5BHECa8MxmzWuv8WvqZZosT66OmJpr3suw4/UZI9Bo0DbF13boZWxBD9yiXizA=;25:88CKoQ8KikU7NKvdFCbvraNIBetmB1nnTbPPRGFUOPxA8WEyGN81CGebeU/yE47VuTdUQVNTGwG3VSAGB38AdkYgdbMVaJ9IuAqdWAkdMd/oM7fnScd/gfy6VCVlz1WmxUQTgJ/3Ac0mfKqPlcmdTbZTkWn5giY5L7naJwQtMLAmPSshZw013Ys/juNVWAmWpy99awbV6cYuxG0/jEtnZVJCmNwh28zabZ4kAy7+znEbuIeNYZCfnzPONxVvfojnXoRGKerHN/m+fz8DpnJBYiOlS8mYDIieGAGfG8JRPrOa+3Gt/3iXmcWbH7OxzgyCNdBSMy+xTbZUO+9C1Kzthw==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3513:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;31:yLsLrYQZAmzmHjq84QOTLdeETcOt+7YgpWQYzPH1Cf+0b87XTKQuvxNvZ38tTgWL4Gj72a8aOGxQ+nKZopQnzQPdse9mIMPlWT55ouex1kSJaMZ7CH26c27FenBbAEBXK8lAZpmTNMRPJptOan0AN787E/1829yelOhtDxtilTO2y56LO+0opag2YkEDp3jIZIKMQzjcmKaEpQruC55S9vFi/FwmExGs7SBRrpA/pxo=;20:MqRQKI999y+FgbZoB1HHRK0LkyM27ioRsvMNTWX7KApl8U/wK3r6DL8GxQeNP+zTzc89iRSPQIpa685DgGuN+FD8JUfl+7GGk1s6Bzhyc/t+NgROcGOBlrGasXnO2zl0IXD29uDbpekCeZHFkYaThUZcg61PTa2mIjd3kArZWsWJInIyD4Fekv5KGiTgsGg5ZqGW/6pD4lX7giNu1yX3bxzzr3Y9goJRk8ad96IA1HT1zgDE43TRzDHR2feQD7HfbTU/zrIFnhJkAO3o9Pn/AljtCiAw0YkDwDcU/o0XCt/CGwzej2wey/c7QRKKcpmQR3y+V+KF2raMveyBj0HUwsVt48hNbnRCd0nJPv7/jq7yFNMjbwg5WEnraT9kUhU7eGtHUL63ot6cho77hgK7+MkzoUJ3LQyrR+G3xiiWMRqyD+/kJFp+I9GkCwWtKEgmUZ5hAnt8jhUoP6VHkCbKF8XpIuGlykj7P18U71VRfJsM7/uejLZy0vB5QpHI9u3b
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3513D0EB03831A37998CC249C2F90@MWHPR0201MB3513.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3513;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3513;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;4:0FjylRjAxUgo+uMjKTPJvh2MsDTG1sHqHKrMwc1QEQiyMm7ehAS/FF37V7iKzarcP6DeibQCX1bSSkTLB/mzi6e/0p7UM6fMuVAST9OAzsWZnvW+1+TyQMz9LOlVFqspZsnhF86lUWNzFPRQhX9n/G8meHt6eIbU4FC+vaB5qJgzKiqFB4vXebqE2ct4Oa6BANw/SQKw3uv9WvoD7jr+aOiZyghJGUWbrtVKKHjKajwRnri93R+NCeZ+n+iFfD99EtD8n4GecFc/o4up5uoNO3Fc3tKAI3NjMkMeMPc46K2r+avbHxqqELSkwd53opvu+MY7HZamWzhkkBMiqepfXePHRyINfgLEUJxEXk791YA=
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3513;23:XGHE4bR4ll2bImBe6jYAeMfJ3+GBTfZN//Pv3Mh?=
 =?us-ascii?Q?yYUpT45Pn0oZKnl6v4dWOo8XosYQzYqa0bn7nzoW9iXTgF4BWDc7ThSpRkIb?=
 =?us-ascii?Q?XP8O7nNONVIPaJFLRjaruqstTw72dZKHhiYlvI2Rg3GKi7mYGwTaPJMxGBXh?=
 =?us-ascii?Q?1feEyT53bjxjgGLjgNumxdDLek4YKN4pCxEc49UwlZoBV+fft8OWbKrqiCKQ?=
 =?us-ascii?Q?2dOP0TInBuZaj0gEChNYyG4ln7XEGvooil7vxwJb4GTVRhwmmrpo58eyBOGt?=
 =?us-ascii?Q?wUZQNq57bugj/67gR8uPLn6LMsdeyapNWB/EWg9qMDXUgeplKNQIEcjjRTsV?=
 =?us-ascii?Q?HMBV/99/T/UpqK2x5VQCGsYZRhdZYxBf34YQkx3SnW4RV3dz0vOG/GjAr4xr?=
 =?us-ascii?Q?pgOOx4Bh9LynO20eclpDQz3Z9QsYSoXEYe6K5XAwS7srwhdYZRSeH3mypup/?=
 =?us-ascii?Q?dSodgXPwZuAD9CMmpNrUiADahvfFEy167VtXevxLPAt9ByfqaqaGJfmO/z1k?=
 =?us-ascii?Q?8tmpDFHtekUGxLe85VyT6nNRS365aLxZmMSHrnVKaJO0Ox/JXEoC5kGYye3Q?=
 =?us-ascii?Q?az6ar8+qrUdhgZFapelpVW2Ww4EGABVBDVE87ljDAY9kq+QRN3b38/7Gbrr2?=
 =?us-ascii?Q?j3DEIw7+l4/I7QS8lq/I2lB+ueshCjxrYi9u1/IuA1vt7Rw7wBqdM1Te2k14?=
 =?us-ascii?Q?X88QvIvoy2cJquYL79AmfCxpSPeXF07NC9UT3oA8ZtilsF7xuO86uOgRjKsi?=
 =?us-ascii?Q?njF6b0PVbwT76uDjXZdjtcB+/GFszSbBBqLxaPTEBhAUj5Y1UrTHpN+5AAB8?=
 =?us-ascii?Q?XeGWcAOtTbX91GiXs6PJEG5sZoIZUgWHNSLMl3zuVjUwLwXTd8MtjtzkiX+d?=
 =?us-ascii?Q?5FPtJ4l7Md0Q8oVup/dcF6PyX+eGQtP0LI8oeRHZw9Rr3Oguw+XVcp729Gq9?=
 =?us-ascii?Q?xcVQWV2R6VMx8rtWhEfWQAZZIdV2YH9ONw6TEiAeImtCilxBFf1wPafwGuW6?=
 =?us-ascii?Q?1eAIY+az6ahQ0r2Q9U1OAQRH1wnVhU++rK22oWSCbtL0BDlJsvEtxCEe4aZT?=
 =?us-ascii?Q?wCdGrY/7IseyE5XtnkxExDGwdL9EGwBExS3lksm7xak1DOaknP4qAvwao6e8?=
 =?us-ascii?Q?hWSQN/E+wTgA/xz2cMbxEz2WGvAs4GSXbT9fSUIlXWisQ0ayidVNBrTmiezA?=
 =?us-ascii?Q?NEgNxVqRGrkE0zH+O1PIcaDnLdAQ195UwcqSjYROJDaUTWcqWrSnuhg2eGg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: h+uejI+xndAsI3picxxfRvi7ksEwrfyeT1SM/7q6eBJYRZwICOvuv1r1+omiBEzaADt4gMcYSORIaBxzgvz7TmD22nc9A7b+651piiofHSJOTpVb45EsjT80iS9bN7HGr0CjI2uq7JLXdIHZStrOOCNV3WIrg2suSKVQODPDJMSCnvAQNlVxPc/Ljjq5ZYY9slLPnhflVVkND895SEibNCfwPmP5zfD1MmHEpYRR8qN1asuZyK742YpIfnbOxfr7I3Hv9E1K6hl/2kT6TFfrfBmRb1TdRCSHziHr+pX05DU+SO6dNoo0c/qnvH1qBI54uYeQY0uAl+8uuko+/uwzTaet+F2KydaPpDhCHmuU6h0=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;6:250rg8GvMNe370quZ/nKRjRwvlE8DHvzLTnioktgW/Y0t5OsR6E0VvISgpFWS9mzQJeiXflH0int8Do6Vqn2R/5JW5aAZKXtbB4nNsU8rUw/xXG2mU6aTZJxD+57GhR6UKgAS4nkR6/NPB/kg/VztltfK8MOdoADXVHRgdesERnby8b8knBKJEPMVMRqDqZMPW91duoxjGMNzQum4u/+oTN4dywJepvRSI40PFYsasRHkjJYFBlLCVCnToaROmpZTfmw/3Vz6DgZoGc3cUcNFD42UgP2stT3OZL0Q4Obms6spMX5TXKcjsIxa7kor9XXdVhRZhD/ZRJhAWQi2BR5uQh07D6bcO+VCGZ0pdvwaYhGiZEoOsqPld3XYNZIA/EMEEZYMCV9a64zcDJGVch9OK4k3cFLnS5SwLq+WrbnmNFEzZUUkvUbGOAJX6aACEKc/50mDUBa/4X2khXqDHT3/w==;5:3HTnxDd2PrFvnJH+TnRoDzYz1FUWh5QKKW3Q+a49kbFEpXYD/aKt9G07QUXW3EiMyzubPVMiiVBpUYG8gE6hc0g+Q3VbRFHZO3jYusErKB8XsstDuhJIiMfuTX0gWKakcxoEtDDu/8y+L3JhtVqiSUnTnKgOJ54w6PDFK6wowiM=;7:awiUdZATeHTGh13lvBcXnR8nw1fK4W9mVdsbnasCPxBxdnhmOPQ77wIW1ULKwx+r9ATr/1Hf2D9BXdUDIQ3gJ8RpZ1Cpu+RXDXPSW3v29ROWCghag6n7/bGnZIXRdtgIemJVD9tWPHsgdIOumulWfTx3GW1LqiNHDa05+nCgyH6MLAbDpc59QYDqf3PppmI+eOXjscY1e0YRCw1+u3LoCTB/N97IOGh6wCZzf2VYK0hc2uvezMVrkPdTHEtD9kNC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 08:42:53.6315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f48fa54-7f76-44ec-4dde-08d6359edc94
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3513
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP reset driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
		-Created a Seperate(New) DT binding file as
		 suggested by Rob.

Changes for RFC-V3:
                -Corrected Commit Msg.

Changes for RFC-V2:
                -Moved reset node as a child to firwmare
                 node.

 .../bindings/reset/xlnx,zynqmp-reset.txt      | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
new file mode 100644
index 000000000000..c42b6a274597
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
@@ -0,0 +1,146 @@
+--------------------------------------------------------------------------
+ =  Zynq UltraScale+ MPSoC reset driver binding =
+--------------------------------------------------------------------------
+The Zynq UltraScale+ MPSoC has several different resets.
+
+See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
+about zynqmp resets.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required Properties:
+- compatible:	"xlnx,zynqmp-reset"
+- #reset-cells:	Specifies the number of cells needed to encode reset
+		line, should be 1
+
+Reset outputs:
+	0   :PCIE config reset.
+	1   :PCIE bridge block level reset (AXI interface).
+	2   :PCIE control block level,reset.
+	3   :Display Port block level reset (includes DPDMA).
+	4   :FPD WDT reset.
+	5   :AF_FM5 block level reset.
+	6   :AF_FM4 block level reset.
+	7   :AF_FM3 block level reset.
+	8   :AF_FM2 block level reset.
+	9   :AF_FM1 block level reset.
+	10  :AF_FM0 block level reset.
+	11  :GDMA block level reset.
+	12  :Pixel Processor (GPU_PP1) block level reset.
+	13  :Pixel Processor (GPU_PP0) block level reset.
+	14  :GPU block level reset.
+	15  :GT block level reset.
+	16  :Sata block level reset.
+	17  :ACPU3 power on reset.
+	18  :ACPU2 power on reset.
+	19  :ACPU1 power on reset.
+	20  :ACPU0 power on reset.
+	21  :APU L2 reset.
+	22  :ACPU3 reset.
+	23  :ACPU2 reset.
+	24  :ACPU1 reset.
+	25  :ACPU0 reset.
+	26  :DDR block level reset inside of the DDR Sub System.
+	27  :APM block level reset inside of the DDR Sub System.
+	28  :soft reset.
+	29  :GEM 0 reset.
+	30  :GEM 1 reset.
+	31  :GEM 2 reset.
+	32  :GEM 3 reset.
+	33  :qspi reset.
+	34  :uart0 reset.
+	35  :uart1 reset.
+	36  :spi0 reset.
+	37  :spi1 reset.
+	38  :sdio0 reset.
+	39  :sdio1 reset.
+	40  :can0 reset.
+	41  :can1 reset.
+	42  :i2c0 reset.
+	43  :i2c1 reset.
+	44  :ttc0 reset.
+	45  :ttc1 reset.
+	46  :ttc2 reset.
+	47  :ttc3 reset.
+	48  :swdt reset.
+	49  :nand reset.
+	50  :adma reset.
+	51  :gpio reset.
+	52  :iou_cc reset.
+	53  :timestamp reset.
+	54  :rpu_r50 reset.
+	55  :rpu r51 reset.
+	56  :rpu_amba reset.
+	57  :ocm reset.
+	58  :rpu_pge reset.
+	59  :usb0_core reset.
+	60  :usb1_core reset.
+	61  :usb0_hiber reset.
+	62  :usb1_hiber reset.
+	63  :usb0_apb reset.
+	64  :usb1_apb reset.
+	65  :ipi reset.
+	66  :apm reset.
+	67  :rtc reset.
+	68  :sysmon reset.
+	69  :afi_fm6 reset.
+	70  :lpd_swdt reset.
+	71  :fpd_reset.
+	72  :rpu_dbg1 reset.
+	73  :rpu_dbg0 reset.
+	74  :dbg_lpd reset.
+	75  :dbg_fpd reset.
+	76  :apll reset.
+	77  :dpll reset.
+	78  :vpll reset.
+	79  :iopll reset.
+	80  :rpll reset.
+	81  :gpio_pl_0 reset.
+	82  :gpio_pl_1 reset.
+	83  :gpio_pl_2 reset.
+	84  :gpio_pl_3 reset.
+	85  :gpio_pl_4 reset.
+	86  :gpio_pl_5 reset.
+	87  :gpio_pl_6 reset.
+	88  :gpio_pl_7 reset.
+	89  :gpio_pl_8 reset.
+	90  :gpio_pl_9 reset.
+	91  :gpio_pl_10 reset.
+	92  :gpio_pl_11 reset.
+	93  :gpio_pl_12 reset.
+	94  :gpio_pl_13 reset.
+	95  :gpio_pl_14 reset.
+	96  :gpio_pl_15 reset.
+	97  :gpio_pl_16 reset.
+	98  :gpio_pl_17 reset.
+	99  :gpio_pl_18 reset.
+	100 :gpio_pl_19 reset.
+	101 :gpio_pl_20 reset.
+	102 :gpio_pl_21 reset.
+	103 :gpio_pl_22 reset.
+	104 :gpio_pl_23 reset.
+	105 :gpio_pl_24 reset.
+	106 :gpio_pl_25 reset.
+	107 :gpio_pl_26 reset.
+	108 :gpio_pl_27 reset.
+	109 :gpio_pl_28 reset.
+	110 :gpio_pl_29 reset.
+	111 :gpio_pl_30 reset.
+	112 :gpio_pl_31 reset.
+	113 :rpu_ls reset.
+	114 :ps_only reset.
+	115 :pl reset.
+	116 :ps_pl0 reset
+	117 :ps_pl1 reset
+	118 :ps_pl2 reset
+	119 :ps_pl3 reset
+
+-------
+Example
+-------
+
+	reset-controller {
+		compatible = "xlnx,zynqmp-reset";
+		#reset-cells = <1>;
+	};
-- 
2.18.0

