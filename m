Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB13C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E865F2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="W1JgZ55m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E865F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeIDORY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:17:24 -0400
Received: from mail-bn3nam01on0056.outbound.protection.outlook.com ([104.47.33.56]:35356
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbeIDORY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hPiTMmwNFMkHx9XMI1R+d/6v0aZ9E1WluH+OI7Xq/s=;
 b=W1JgZ55mYQGMmD3dfYzDVeyzr8r9nkJ67ShhWh98Uf29BrLQQx3t2i6DHRa2ShZzzgWvGWDwXB7AS5RMG1U1Bo8YqYIvzb9l9MPDn1syXJ3MI5bH06ydI4F2UYr0O7TsovlZ3KE9RkcdqSztbmgmPJ8rebZ69AWvltb7h2XV+es=
Received: from BYAPR02CA0020.namprd02.prod.outlook.com (2603:10b6:a02:ee::33)
 by DM5PR02MB2681.namprd02.prod.outlook.com (2603:10b6:3:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Tue, 4 Sep
 2018 09:52:58 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BYAPR02CA0020.outlook.office365.com
 (2603:10b6:a02:ee::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.15 via Frontend
 Transport; Tue, 4 Sep 2018 09:52:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Tue, 4 Sep 2018 09:52:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43954 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx813-0002Lp-DF; Tue, 04 Sep 2018 02:52:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx80y-0004vm-9Z; Tue, 04 Sep 2018 02:52:52 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w849qoZP024739;
        Tue, 4 Sep 2018 02:52:51 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx80w-0004tv-9s; Tue, 04 Sep 2018 02:52:50 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <srinivas.kandagatla@linaro.org>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 2/3] dt-bindings: fpga: Add bindings for ZynqMP nvmem driver
Date:   Tue, 4 Sep 2018 15:22:33 +0530
Message-ID: <1536054754-3119-3-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
References: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(76176011)(2906002)(476003)(2616005)(50226002)(11346002)(8676002)(7696005)(51416003)(9786002)(305945005)(36756003)(2201001)(486006)(6666003)(5660300001)(126002)(81156014)(8936002)(14444005)(81166006)(356003)(48376002)(50466002)(217873002)(16586007)(316002)(110136005)(336012)(106002)(186003)(77096007)(26005)(36386004)(106466001)(446003)(426003)(47776003)(63266004)(478600001)(107986001)(921003)(1121003)(83996005)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2681;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT027;1:Qo8VWe2taYYP07S4cWgRH+Ou4mHuKSIl6VtVdngvnshWCUly1A7mdHqW8dTzJDBRPFmFCXgzIlgWMuagfi5KHd8rFMMMVCphbgIkhqbNxiHwpjklWb9YABachaRknwcL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c9d928c-086b-4514-2c95-08d6124c31e7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR02MB2681;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2681;3:eScxigsKis5AKZ/qtshTYrMxRFWA5GUXsv0ZTks50ydIlZW3md+d6xEskaW1vTlQW+xc60qjix26zUAfJcJrTfwaNodvml7ID2hKMU3em3J8ME0YEXZefkk55KsqrW91CC9rmtlzRygk0X4vOLCdGdygbJ6GUGR6EYIuOLNMoPOUhxbyR2Io0R1MLmWf7H2uFk2hv10aJ4c8gAHceuh73OTLiTYs+5vi9tOuloutO8VxoLCda3JPsILr8jBlljo/36WmyQMahYrEELekA4aESbfImAfFuzUyYRiPkFg889McwKYLtt/9qEBhmCQ4dgz3e9ldoxEVwFKlnYItT1lSFY2BozuUrfoTO91iZYnIBXE=;25:ZJeJsn/0wgnf5icdKVzRtSik+42iGB2IRU9aJgt0ePLSW/ThQ6nALYPcnn2xloXRfyifS8t6r3tvcBg7qQRpZyqISqsjVyCljboQS6eFXAUsHZZegVU5dktJ+OnHGig86p6YwWUavaRjjxbxA/WPFjXPYR+egkuK3HfWDrSoQR4DpvWN/Ie/3UovGJJ4F+dtpVG/snsUiZrfyumaSe3z43Sh8H7CG9Y+9Ut3Vrm0dKiYVq6hFi5Wa2hdmOUEXx74khbTR0/pFKzgXyFCtxCfvkT4fnGNPRKuraGOOrQ2TJQ/GJn3z/LrUWjsl34mwSoIA0d6ZOSltVBXubAPQJ7ORg==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2681:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2681;31:CJ9d1jhRoc4rgjL+8Em1mSBHz7Tl70s9D2Jz9e9x0YMdrILG/XyNly4svA8cQsfFZK97AS6C0rq9ON6W66Kc1O8MsCT0lKc4+2OZVwH0qyjvohCkBvyXbuoXUciiJLwfsH7eKXY9/3PhWL7L7lvAv9xwqt5Mn0vhF7iqoBI6KYBHrDykCB5En4TU3jamYv0hig9NUUDvKiWrMSU4V3uk3GPj7rLco+BGHhDTkEvy2j0=;20:+B0GscxTJ/tWZe9JwEbl6aSbqHlG5zW3FRrLFEmD3pyeJ56rgfwwIuf2cMILHCONy9aFkQEXicf8wbUQMsBf+xy8VkPxq9bnNeq8zh5ixGc3gDCztdFLi/K4FeNyyqn2j75HuyvsZ0FmziOGF0RqXCbYf17jCRykSVLG8I2BvLu2TuWAamCIqzxzYPhnJIumwgLBwgZ76SKKcW43371K7cHVzkqG4D1J85u8yupedua/5AQNINpo4U0rWug9drrT6dLitOwG2yUqSgLzY9wb/VmlC2fv04mfFf/vg0TPU+LJryzRFgR+uwXt7mmgiOaHt9CLgKqBTGggukHdBnHkg0/hw3FGS9KAbQue8G7UR2uzXRJkIdxdS3FMcAamkAcw/jJulEI1igCZZd82oZAdMinQ5kQy/AulRJQG2lYHulnrRBz2VVfaZH2P/yhV1j7xrFASFDOXIMeX2LixgaGw9FPNqblg/Ce6vvMzmVW42AzpymVou0S0SyYUsh+ci85O
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB2681DDD3EC9B78AE74E4E052C2030@DM5PR02MB2681.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:DM5PR02MB2681;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2681;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2681;4:bDqSzpnMmmW9rX+oHA+MR59EFIpObZJgi4sjDlROk7IHFbuHw5NHTJwGqtZAmOcM50ydqRyJvy+/72lz5YFk2G1Mm9quwjrIccYLfJCYC67zG0UMF5uEbk40PhXurnmxx6PD96kVpaxPYO2bMiyvFjJpmdbcrp/gqP6MXejx99llCJ0vmGBrlEwfWxMK/0tqxG3izN5Y5F56e1FO7ZCIIie8S081ddrRR1fS6oNt4RtSrnnY94dbGTDZn/tWBSva7Ims7SE3qB/CKVC6yMM5ImyzANtsg65YtxPD1s+Gh+5fERYtpENueVLRbpC/EXbe
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2681;23:SoKI/IRB+7SphEIlfK4j5KPxh7p5yd8q0yyaPmEmv?=
 =?us-ascii?Q?lwFrJ2RQB3DfnwbCQOK7ASYBZmAu9axAEoHfB+HBaDnF+wbmeQxm2j/hLqmB?=
 =?us-ascii?Q?2cUUgF0aTmRZiEiyh6k9XV32JlshN07crLQZFvbbD5Ss/qv4Okg3EgZlPV/P?=
 =?us-ascii?Q?4idNj+LkABBb+Bq/k5fJSQocx9tIFJ2JcTHK18eVISyNz/R4GhKygzikFg9l?=
 =?us-ascii?Q?P0L7LhswkNXyU+/STegDWBv6IiEyBDoHTEvDC0xPTMtff5KZBlhlGV+KqwWg?=
 =?us-ascii?Q?iZ/jV4P6+pZO4vC6fkGwAaQII30qdrv/YRLHVQo1SElrS6zfGXp56cAdOYGG?=
 =?us-ascii?Q?6VS86hVDErM49GKy1ZSYbI7+i8FicDjDOX5jXGrU8JbgBt4hDzpK9mtUinbY?=
 =?us-ascii?Q?2ZEKLEb0BMYY76pRNst6oRP0agKe9x/WocrEcuRyzcIHckAGKdRSiRCWKNyO?=
 =?us-ascii?Q?IR60zWsq6JofQt1YWCRfA40O9hNiyFFQHeYLBQ34FCcrKMYbZb18XaqpbCfo?=
 =?us-ascii?Q?MTWFMRgTpu1tidiLW0OKiFJLRcjrh4+pP6mwcPwI0ew62JrxzDiCP7/DBU9Q?=
 =?us-ascii?Q?6als9nvj2YJ3h5qopwfw72Aa2ja9eraJpb8rPDbue6pEARcIVXIfjLiXcGAq?=
 =?us-ascii?Q?L+fh9xJYdeEunr6JvUTr/KnPPko5eJAq1zbiki5M2In52aFp66YgF4q5CMEI?=
 =?us-ascii?Q?tVX/dKdcNTUNGp2j2qmqKFsGAwprHxbjPd4RWqsFQI3yHE0njJzBfwHFHmrZ?=
 =?us-ascii?Q?DMikppwjFV9eBo3bj0BvWh1tj0KM5sPoiCHgwv5KlsNFZeDSpjAE3TMn12ka?=
 =?us-ascii?Q?t9TIynu62U6vcavJ9bjqlflo7NRt1vrgQZLBDdefjZzQ0Zyx+wT/HS4qi1To?=
 =?us-ascii?Q?NNAiYZhzCwNSVQHpACrtI2fShvrB3o7ji+wdq/F6Zj8DwYUJ2swuA8Z/nYxt?=
 =?us-ascii?Q?Mgk+0zj9qsKGWQ6EeXXADl4DbpxYrRc1yaudfP33vIFXLeN3mkoy+66mc4P/?=
 =?us-ascii?Q?8jmr7pah6x809d6riekfcvSHOE9riimWoXjTG8oXnNELVK5S6x+Y3c9UF/g/?=
 =?us-ascii?Q?aVQFCD1SUyYHqt/Kdm+hqnGllZEKYowKIMXBxHmI38yFTgB6IWCFD6nKrFo7?=
 =?us-ascii?Q?lb9pj34sE/t2+Swnsk9dJUP4+cgYDDwb5DKHqy53ArqF+Lr0KT5/61l8vLZT?=
 =?us-ascii?Q?rTQprIXpgobELc35Sa64DwecLdCzljasgwI?=
X-Microsoft-Antispam-Message-Info: X9M3ukx+yYnRkH736tI2dSQYpCoQhQYZuumZ/+EJl23koP1TZKA++VL5aUZCyFcz5hsNuosHuR7zROc7958nVTWRzOQ9kQSxKq/HfkwukSN6/vysKuBLrGvOCfV9MItKGTJiKiz/w5NRkgxieFMz7qMJRb5yrCdu8aM0cjs11H06GCmWPAW3+nX++9ziFaB3UzQKM+YPDWliFwTPuPwRt9nI9XQON5o0Ilm0gZLjog6qT3TgErAdRuuM2RByNfNb8+2QNLSwLTNkcqP8YZT8jyY0Uorvc2rsKOE9J2z8VoHfa6DLc1y1JWZYMDGaw6zQmIzEUQedtruzH5AUk6m24Cn3FEASUnLBkNm93Y9VYBw=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2681;6:gMtMxBg4Qc4lV1qYfBixhNZWIKqfJznfgked/P/3EINFwxCmvFhkNCO+YAyLmxcLqsBIGloPkmlNZcCkOHTL0YHeP8yxdPMPktIVIVPkMOFcsiQyFF0+7X7vA2rVUampddskmTxlJahPXMHd27RJ6JaxmXpXR/kFgk5Zy1ji6/4W8cA21FYYe3R0xY0BQqQ5ALGt7GxjJX9f04cH/QE5Jxzc7/OKPKupn8DKVJY0Uewpfm65lO/6Vf6oT+/NDbpylcPwmJSjL4x+C/wGbW7HLJq7dzGV3jFP2UlRs0aiN3oqbDI7uMjoGJNjvLqpANHValzkjd/oRKg9H6ma2o4qKqfQHYoRLxhhDmzsUPV3vV5NZjQqxh8QLatH8HDFGiOWZl7K/Icv6joQ1aNCyvZoPxGTa1qfK878vG3iaRp3qJ1/ToyBS3imqRwfFCvmhZBbDnF/5WknxT1DVHPJ3YzQgg==;5:kccpit1NqtBl8maHwmDfe13ovrSIa01S4OJFff8qE2yhSwqda+qxO4Rom9tbD2RZaSWIfj2fOvYGtQrEm/fTOAFzeovC0qGrqRRN+WjIZZ5m5mY9RKr5BpGFnrMsAtGcS6a2tvlg2E0VZGCqEaDCc8OsWupL9o8icK5BAqWg5ho=;7:2YIwtL5yzYYP9kL95wEhtXXWKTsLfuwiAXDGnSTjp07aTDr11KAIMC0IHnVynWXX8Tjz/gW0tpaXGWKTVV8g90okBepIL8mLTCG+G42FZMSVj5Cqr4UpNFMwcOdZ1N19Frm2rDwL4d+uKZcSq+ei05IqUsAzj+uWfmAPriOoPmFCTDVdfITrAkePFbhnA6M5ry6V8eijsK3maXd9s4wQ6JK0GN9BVV6twBEOx/dG0zW5uRC/en25nTjBBwBgtPPk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 09:52:58.1052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9d928c-086b-4514-2c95-08d6124c31e7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2681
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP nvmem driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-Moved nvmem_firmware node as a child to
		 firwmare node.

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..4b95fcc 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,19 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+--------------------------------------------------------------------------
+The nvmem_firmware node provides access to the hardware related data
+like soc revision, IDCODE... etc, By using the firmware interface.
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
 -------
 Example
 -------
@@ -25,5 +38,27 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		nvmem_firmware {
+			compatible = "xlnx,zynqmp-nvmem-fw";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Data cells */
+			soc_revision: soc_revision {
+				reg = <0x0 0x4>;
+			};
+		};
 	};
 };
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+
+	pcap {
+		...
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+	};
+
-- 
2.7.4

