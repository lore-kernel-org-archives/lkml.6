Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C36EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE10B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VSV0Qomj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE10B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbeIGRzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:55:36 -0400
Received: from mail-sn1nam02on0075.outbound.protection.outlook.com ([104.47.36.75]:24208
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbeIGRzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU5EDjVjI/Vujq1G6zcObL6PV8DHkUwAO8rxO6V+a58=;
 b=VSV0QomjvXSBDc/QZ9BEq2QMPvBSbfNmnRSkDTR0qlsgFjiSHMwB0x+VF/dt4pXi/YmOgpsmYN1Pp9j5AtQf/Mi8JfkA1W6gU1gl2pNwPZYn7ie4pzPlpw2B9dche3xkdRJgg1MKXSxFBTfVwlMhLv1xb3rJ63zFOyVn6WUAuJc=
Received: from BL0PR02CA0037.namprd02.prod.outlook.com (2603:10b6:207:3d::14)
 by BL0PR02MB4929.namprd02.prod.outlook.com (2603:10b6:208:53::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.13; Fri, 7 Sep
 2018 13:14:20 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BL0PR02CA0037.outlook.office365.com
 (2603:10b6:207:3d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.16 via Frontend
 Transport; Fri, 7 Sep 2018 13:14:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 13:14:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46002 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaZ-0000Wd-8s; Fri, 07 Sep 2018 06:14:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaU-0005mb-59; Fri, 07 Sep 2018 06:14:14 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w87DE8of019605;
        Fri, 7 Sep 2018 06:14:08 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyGaO-0005le-1T; Fri, 07 Sep 2018 06:14:08 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id A7CEB604DB; Fri,  7 Sep 2018 18:44:07 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3 8/8] usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints
Date:   Fri, 7 Sep 2018 18:43:49 +0530
Message-ID: <1536326029-16327-9-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(63266004)(52956003)(36756003)(14444005)(54906003)(8936002)(4326008)(90966002)(26005)(106466001)(42186006)(316002)(478600001)(106002)(305945005)(110136005)(5660300001)(486006)(217873002)(16586007)(476003)(126002)(50466002)(8676002)(103686004)(48376002)(2616005)(76176011)(11346002)(446003)(6666003)(47776003)(336012)(51416003)(2906002)(426003)(36386004)(356003)(81156014)(6266002)(107886003)(50226002)(186003)(81166006)(39060400002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4929;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT008;1:MpTIdaLj+2D/xRc1Ad+/+RwbGiXJW23anwNV6C67KSJ/olsDhafSQ6kPGtuQGH50+VdV3pr6BBcYjvPeLPRR74kAqt4ouGIsSD/9MgbyE2H+idT1OT3KlIqOgSav0scE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 705badfd-0f27-4ba5-913e-08d614c3d270
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;3:+Fou3kMX11LSQ3yKm+aEevxAQsk5tNAPA3uLAqD5BSVAsWqFSntGXgUWwPC6k4heE2vFR/LptY12x/HTkDlyBbb3UxHJVJeVPPG3hk6YMX0I4XD0pR99T7OUiqCgQgMCJSPjrWMVGIBpcSerXPzy+8bbY2Rl4tHsvowPMnARLi5XO2NhlFLfKhSs4O0DPp43YxIwMAqmwa25+ZgqbkyJ72FUGrGI6mcUI3UsQ7Uy0PWpz0tYEa2ugpUiKDb767fF+fOvD0owbCInIpRqZtfLyIlDTabHTxpOsPX+8Rtvrjtgjl6vAzk4A2gUF8Z78zf0Bony4Gh2fbaOrnANsG06rRknfKDL7dsrLHxyx1pCXJM=;25:7JgEjnxut60Tul4h2rIwntBFqjD77Y1zQP2Ac46wXiitNMG5I3jDyoZS2mi6teMNYi1QlbEx7S29Nn6EIamybW4s5jnkm+h/z3JYFGLAOOJwAZLGB0uitHvza3T+zsqX5/qttK9OTzUAbyEi8i7KYvqXj7bY/Gyl5Lr1BhK6SbH5F0g3uNEmxOuPHSVRnBj2nB1dDmKFAIGbCEmxb/n8r+pHkyHf3dH2nN7A9d3qY/+FCS9L3ZwzcJINQZi44fngOPFBwF3Bp6oUItcele2ENzlZe+COtT/WuIek19rMBHOVcCu9oTokQhybCidbvX1PGdSjKM/+Lufm6bs7E6TrAg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;31:mvPSKTgxloUGCCv9dNfxLzOnMwyuyXyKIoKTazMgwSpKwcE8knfI1UCYs5v1Gof2PLLN5SmZOa8HyKXO0HZ+EPQZyT3BmCrK5cDtliGvKpWmKRgIZS3axBIpxlst/BQV7h4lNCZU5M5hDcKzdzL8C92pjW1I69Q3mARtfZo65xSAQSqfCJ8jV0zmTuMvKb85qWQzVJgFd/0Wg7j2N0VM5zj+iGv86WgGcGCaXLqQP/I=;20:cyUWNvUeEuutAsS2GPA1ttLm2bTGY2PYO3E/zfImk50dH6ssIPpXXvsq7hnrb+RFSAZEd6a20w9R4YWNdQMJSnheyt0dId7zl3vDKQqcg9k/4vM66KW2nDTEx0HwyNMg0KWYS0fb/KSuoBKJQNPKRtkc/HnaL7TruiqJxfWSu2+7sox6SF57sE5luYabKsIE+yIQdby5D0K9nib2oLgeiRJMlIBoRxxUqeHrmXRsEpCwh0hMs+lgFqhUXpVi4/Wg21A8woYo9DNKoDFTkLuTQ8SDuq/yGEEThum4sg2qjA+Gn8T73TSUz/LEpsIhAMBsUBAeLJiNyyneZAD4jk0siL8pvGcBOnbiHHOcMJZgxCzjY4sQKYZnvXOf6lV/ncXVr7duTX34So0pzOSkJ52eIz20XzOMaaQWG9Kp8XME11CozkaLj/kXhLXmeGc5g0Xnn/Wh4vTTZb6D3+WYGXS6tGvDB4GsGn+NQz0QT3HVg12f2WsD0NjjHtzVXTorUswR
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB49298D69A76CAD40F5FB8095A7000@BL0PR02MB4929.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:BL0PR02MB4929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;4:Dq6R/k+/n1lx7yYn9C3qSus2RE7sITvpt02Jt7L6GCT7TBKExsHslyUWENAh2cL33WGoE6oZyqWDSfPT4ffELUn98M1xGOGDfcl2zKD6UTYzAcr71wWkRmRklV+04E59jH1PyEMQ8I20euMAiu6mfiQIB7D+vbitxBPs9j+LmYYn17aD2PCwh4PUvDxuH1t0v6PmFneXo9hWqLpQjmQhabWtE8Agb09/Ba/tUUliC8nRC6pPVviiYh0G/MiIg11wWvmfC/7spBllup9dE99QWmKkVd6LPwEYyTx/iBPwZhJs7IZNBEn3EcKeg8ehPD8G
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4929;23:oK5xEqb04YAmfoSUk6rqaNTYlrlH8f78bSullVwFs?=
 =?us-ascii?Q?mjmWOMUwRGksol6OcYhuO/OGyEOfQKfbLbap4adY+sy21vGPlCNhAboQTP30?=
 =?us-ascii?Q?9Q+f+aDMkTm9J56nkySKa6/gpYcHcW8Y+hBCIjBNCUvpO8BlY8Oq+xkI/vg0?=
 =?us-ascii?Q?JcfEg4o28Ok/3pYxoP8eLPlLs9PK4/XpXJjmU+Ot7to9KPv47P0rxQRcaZyd?=
 =?us-ascii?Q?HyfUanKumM/s0ZPpHWg+OqMgcczVPBFPAsVhIWVOnVF4UCPM07SwygiHH9hA?=
 =?us-ascii?Q?fBEOAiIxd8+JZYAKThFCQm0wFWtFFcN8Mm4mGlDRT0LTIgNCvUHL/Y/QdfKJ?=
 =?us-ascii?Q?yLnyr/ueHyJ5tqqZaRMhaO/5/tMdtY0V9N6gLAGa7X4L+ft8AippSjTViND1?=
 =?us-ascii?Q?9zuFQRCBfu/3pqnL11Vap+5xHJgnPbINvXIDl4IFp4hYuJUsyKndeS/4spQC?=
 =?us-ascii?Q?/nTyIA9N9/H+qtYmDy55x/mG99NqL8ShcJwaqEiML6VKsELuXsBHKNR58chA?=
 =?us-ascii?Q?yr2P83+6L11AetWKGLn4p+hyKtzLMr3pmBG9j1Qp1DBL50Y1ng2kL7SQs3VO?=
 =?us-ascii?Q?Yt2/Um2DRVyvxMZ0VVvnSUeexwYRUSv29d5wtCqa0m1RfRasYxPFugpG/rjD?=
 =?us-ascii?Q?Ht0rVTr6/guWUGGMYKst26yjTFPUOGltBSK6Ke0heRmRTWX8waBT1fa14zNs?=
 =?us-ascii?Q?Wpv+3LLLjRtpZYKw604rah2ROTAtpjdxrwk4cDvERZanC2ig6UCcLNHKe6ev?=
 =?us-ascii?Q?MpSn2lxhz8Gj11/gCMN0FomEDiqZNdKCePlljSzvMQAnzgQ++ViBYfyBasVq?=
 =?us-ascii?Q?25q7WhdcL5yYtTo5gZEMW5EdCwzdM92wWeu3dAPtBechD+FizSHqNk6f81yZ?=
 =?us-ascii?Q?+kfqQvur/eF1BjTaCN3CYP3aGOxNZN3Wta1DP8DpMKSnEOMpr4fj+ozBQPhX?=
 =?us-ascii?Q?XBC9AsySUuy7D2c3bkWjiJrIWjrtybPUjQaPb0s0TSpUph1rRYP1IVpvKcd3?=
 =?us-ascii?Q?2cuhPAzq+zQwb3UDnlzPwj+xZSQvykoskq6sV6aYFiC4lxCBZ+G5Iqgtr2FM?=
 =?us-ascii?Q?/QSXLPtQTSpNyka0LTopK4oxF3DL3tnTJUqQDWzya5iAAHUxAmDRnnc8OL8C?=
 =?us-ascii?Q?Rgal9tC07etqJ2zqFVAiK6+1eEzQZdKX1cS/eQhTM/nNCZEM1tUmrCBC6z8/?=
 =?us-ascii?Q?+hr5TF8FGcTlHgQkxPD9j9mBtpqDEU0qL9DMFX4eu5TUWxgI0pujhNSw9KFO?=
 =?us-ascii?Q?UHJPCU/qqXp5aFPBS4=3D?=
X-Microsoft-Antispam-Message-Info: X7abza/ANVD7IQ/7AVe8iaaJuM66Qi0VP9aDSlBOly0JebVkTPqQhKnye9m4zPnSboa8fo0AaEY3ZoWn8hEXHk1BTbLKrN4BjvIquKzBMS8PmvJ3XOUmYzmpnKBpYukO925B8ziQx3Vr30Ux45Rbe6J1OxY8RL06M82b4OYzAMcrKChCwxKuiIfzKJhW6kIyK5agf3rmatY+hycbjrcaBVGKZHKVai+a2a6FEovWs824FnZ58aBeM8v3QgoTTj/CQtisWsjzFKUI7JK8J+s7UeiyHgYoYonhvyjn5nofM5qTRKm8wK3eihRTxXjuirN+HMWSE/tfWgPER5HZ5otWEriOW/hRW2SIYbPLkuENnCI=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;6:gSnZ6gE7YW500mUO6m2KFxjDPpW74MSmlbiJkv5tbyU2eKRLQNyMR01tZDm7Z4bdyfxy35yuoOcUBgnqfUSZ9m3C1SAntz5IBZv65NzNZoo43/ZliHzgIYafjsDkUr55j95pokQm80jgbUv/WKbiHvtd+aXlgQplizV1tpFA18qDuixTTjbVxOdTiSbMoprTcDE7y9Kp4gB7zxMcah0zn5nDAaMls4osCVPRiH4rCC80oA6wO/E3GpKSEZiY78dtIJV33z6Xq7FVli5ei23R/B5Njg8Daagfj8kuYZ0J4p5xwS+uDLTgl3Sovs72zeiMNBuxf08TR0fmbCrg3pR4E6b+r/z7peBSnzT0wt0bNu2CC6DBX03Lt1no2kEGGc7gACQ0vldcMgcN2c6MOZ7kcWYwFf0sMPUzI5cpOprGJRHL17DmedWQ+Vnyfs24RASBZ1htD9VDYmkw5gMGvLoJHw==;5:03bKyzh9laD9vBSBlqczO3KOmHvrM3rFGWy1egUf6cJSu2Bn5gsMsZP8ccjiNJtZjxDBtm6i/4NcpW979MRf4J6v7Q3CpoCzD78K+FHOwVdHQB0YfafGgitM1M10s0jxCXvkXvjo+uLkeCYLe6Xap5z+5Msv62oXO1Xk8b1Y9kY=;7:UqXIf7uIWY9wsPspke3gCEW6w78fk/Y3PKr2/sXBO++qRoHMmwnfoRBRBY5+Y+ZkQI4B1iGORZoxrgh5tkYkffjs0JjS81+R4RWINmoDcbmu8cjDfv0PYs9a0nu7nnvyepe/8Kt8kyOQaJSlJY7fEoMoH51lRHQvPpyfT9ibyQcQrJP2zWQOVEGXJtxrKHSlDAKIYeGta9HjahVsLJMoelapKCLCDKKddqTwYRBO53f1wxC11QVvWkXmSvc6Hicw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 13:14:19.7524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 705badfd-0f27-4ba5-913e-08d614c3d270
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When streaming is enabled on BULK endpoints and LST bit is set
observed MISSED ISOC bit set in event->status for BULK ep. Since
this bit is only valid for isocronous endpoints, changed the code
to check for isocrnous endpoints when MISSED ISOC bit is set.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e1d4b73..a4ead33 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2413,7 +2413,8 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_BUSERR)
 		status = -ECONNRESET;
 
-	if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
+	if ((event->status & DEPEVT_STATUS_MISSED_ISOC) &&
+	    usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
 		status = -EXDEV;
 
 		if (list_empty(&dep->started_list))
-- 
2.1.1

