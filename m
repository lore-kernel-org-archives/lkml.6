Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD1AC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C492D206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NIVV6f9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C492D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeI2Xrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:47:45 -0400
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:44437
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728462AbeI2Xro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5bPYfPZzaK4Vyr9cCxfy3FRmamZ5GaIz+GeT+IoJdc=;
 b=NIVV6f9d037OrFG8tfkygq1bcKNXzuaXRpL1ixxJ6AEHVbOjMWltnFrL3WBO4RaUBPj+aKKpxLhVyZWbaQFlCPtAW4/uUH+Wi8ULJHb2lDSefZ3ouEIIRlAuU2EhB2q9Srao3MyrXFUK5l+JEIfifu/NYZ9VaGT8Ue+jqDyd810=
Received: from MWHPR02CA0024.namprd02.prod.outlook.com (2603:10b6:300:4b::34)
 by BL0PR02MB4467.namprd02.prod.outlook.com (2603:10b6:208:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.20; Sat, 29 Sep
 2018 17:18:25 +0000
Received: from SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MWHPR02CA0024.outlook.office365.com
 (2603:10b6:300:4b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22 via Frontend
 Transport; Sat, 29 Sep 2018 17:18:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT036.mail.protection.outlook.com (10.152.72.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Sat, 29 Sep 2018 17:18:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1g6Isp-0005ZE-V4; Sat, 29 Sep 2018 10:18:23 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1g6Isk-0001eE-NL; Sat, 29 Sep 2018 10:18:18 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8THIHrb021904;
        Sat, 29 Sep 2018 10:18:17 -0700
Received: from [172.23.37.150] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1g6Isj-0001e1-Eq; Sat, 29 Sep 2018 10:18:17 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id A32503C4060; Sat, 29 Sep 2018 11:18:16 -0600 (MDT)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] dmaengine: xilinx_dma: Refactor axidma channel validation
Date:   Sat, 29 Sep 2018 11:17:58 -0600
Message-ID: <1538241480-13844-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.480-7.0-31-1
X-imss-scan-details: No--6.480-7.0-31-1;No--6.480-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(476003)(126002)(50226002)(54906003)(11346002)(6266002)(48376002)(446003)(14444005)(16586007)(50466002)(90966002)(42186006)(106002)(2201001)(106466001)(6666003)(47776003)(2616005)(426003)(63266004)(486006)(76176011)(8676002)(316002)(34290500001)(305945005)(186003)(2906002)(4326008)(26005)(8936002)(81166006)(7049001)(52956003)(51416003)(81156014)(478600001)(103686004)(356003)(36756003)(5660300001)(110136005)(336012)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4467;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT036;1:2ksvmRBPdDtD9wMXAig0eQSrO2sWyfNUk9e7CP4quKoz/FyMsP/vDH085IGtAT43GpAHJx/XBGg76gNcdVzlsHkBt7OwCjjnFgaVqLbwEKqxseqdEXgqdg2M1Hvs3FT8
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef0df8d-9068-4ac2-f9a7-08d6262f904b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4467;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4467;3:q2wj/fuXYr00rWhBq/qhF4gZqJyPpF4aPjHJDf8Ow3d0V5GzlHBdnQepAJ9gx5UtEyEXEVJjF/FJus922sEOkvx3v/mZoPjiZ0ksvPhrvyg5THPnGEgX5WMMgvYZPkNWmt7R/5AFfjIi25qkY5MpDUTqIhyB5MkgK4EHnQBgBr/DJHFOd30zf2VoqYka47CipohbxHYk1zpWWoQZFr0sCvPd5llojaWcFmHGgNvm1v5+1JELMHXUDbOL2WtZl0M3MFmwyrC5xUmkfH3D+fmgXXHfeGfVcqgXxJQUYLhVOzuQcELe1tqGThcMC7GhWf1rnLfxPFlEWweLAnZXG+TD+/hzZJ4ecig0NiN/jwwHY/g=;25:RjoD7CB2X2A3K80PNaY3Wth393R6R38Zec/YgRw//MthFbKCl+TyVGSe65B5LTiklcqNs2cGikA+yzXZP7vmGhxZT8DAJjaocxUiL3KtqHYK3uKKL0sjg61Z4nqiMWsuLigS4ReeKcA5J3xiO72tMlckAB194JKXIYH+Hxw6RSjz+tqEHXVQ3cA2Cb+CC3c4SnxScKqYdn3wT9hfv158adnY7METoh71aG6uqJNiL0vWzz52H9F8Tg1uVgaLfyFqpaM6ZsierrhcTZKjHVbQJyCVxV8/rKap6BPUltUdIvTMkXJAezgcL3sGaXWCfJzuO2a1hu/73zACo2vj2iG4zg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4467:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4467;31:nlroy1ump0vYheKfBHNURf94hcJaTO7J5DX1VpBLhy1PVfpsgLPD+W1f/8GNl2yEP1gZyetKVvvZ785TXIP6Ew462tQYMU3dLQ6GyRTJYpa6iJyWBrT2NqaVOo9Ln3qTc7uACJodeLHTRvTfRinl/AYtXid9a09gfJVFEgQvsSWCGzXSKAxqu0jZ4gd0lWWQ21jFm9mhttQdO3jSBNWcjiFPZn1t2+AXjzv52wrHtzA=;20:UvOHB5dmSW0zff+CNp7b+uk9ddgj6bumYyfgOGt+VPMmFsKZVmN6sXA5DeBIoIlqIKXSqZdIgKSfdICDU4cJemCqBf7LNO2+cZ8dvFFW7oKsRV7WMuG8UnbFgxLLp4BLnuK8flQ5oOWiN5gfby9dlnhGNnHgQIgGT1eCk69jyn8XB75+tkLff7ZOT1WSD3fFZ9r4e6vl8z9Z0deQUcbIlNDODsPzUcGl3HMm2DYDgFD6e7NBafYHlofov3ZU0smrBYhF0XXohONGUP5MURba5SQ51at+gFA84uhEKcyqOuYE2/DL0n4cKqqKeCi/yaeVNgjo6V5VqoIqyRV/VP6qjV0Y2zl1gljxXub69UCWVXNCP3R7DTdUPrEGlC+AeFC3UsLXTmEfsNQO/yBzUt6BUsUqdgz/4bu2Zp3Nw9iG1ROzHX/4rIwkBPYkhoMsppFrI5/a5gA2ZguGz2U8NUVz+CuAufTFNt6sx1ACZum/1H3h2xLV7yeYvf9hPYLL4CVM
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44672A6EF0ABB5637ECBB813C7ED0@BL0PR02MB4467.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(163750095850)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:BL0PR02MB4467;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4467;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4467;4:HQ+Nq8GOG/FY47UBwz3vwuPtOXV/DhtAFGe0Ve4yCk1zp25m+sob9hJuqaYjFtXpqWQQmrZmq46B3DXErL0Yup2EzVeF12H2XYqUpaWWIIGzOZ941QD1VjHdXkSYYdUdN3sX1mlSw4Lc2llP26dOmo7whHK93H61hVmy4n2hlvUjPXV1+wdIOBgXVkFaEHHyTvNXvxuRQK/UdYczLPRHEsnEekMINRyqxs9HdVmzGZq2/HyG2I6ycegwvTPdHg/GrA+zxToRcGltOxyNmFVeBaqpbqvnJVYlyc8iat81um07b7yiDadLtFExDhvQ6mV9yFj7IkWng61L1B1qCyyrAYnnOACinbBvVjFgUlEjJ08=
X-Forefront-PRVS: 0810818DA0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4467;23:4blUcqoC/DQoqdARXF2BQfrHfDnRcW+6zLcYDgd1c?=
 =?us-ascii?Q?nXoLt+s7gyt7BOs05YgagO4j+JTbf9xH4K7EjDuruX6lnWZA0Bo2ijOCEn9Q?=
 =?us-ascii?Q?UFGeHC6UjQbC3iNUaJlAJKgPN6AnTQM031NZctZnyGPcDl4IsX+xhvs3mUyu?=
 =?us-ascii?Q?u2yZVi5rvxqgI1Y/8V2hy4LG65hkmeIlCVgNH4w4GzL0sN4ixxgkwHRufzjV?=
 =?us-ascii?Q?pEpU9rjvI5HxU/rsF1S5SaOxRHpG44x/FhbGIarYgoBUYqqlfa+tcDFDZcxc?=
 =?us-ascii?Q?nLsspbFY0hpQVsIdOZUBOiTYZCZib97vOUU0E4LHf3yssky2MnMPirm/CvtK?=
 =?us-ascii?Q?d6B/sL2Dk4Q3GS6wronfnRPBkZHUNc4bI63A58AzQvtjbqOFNCfNu9HvfwBz?=
 =?us-ascii?Q?pLAugYyqz0wrFP8wxggVPQTUdCzf+2giBUlSKfZ80v4cu02g0SI8velG8Wzn?=
 =?us-ascii?Q?YQvoBgub5nqG/Dxhn/zW1AnySzCdrl0t7BYnq+ppWnCLb6MF8Y3QYPmJiot7?=
 =?us-ascii?Q?DjBrDgMPRhpir4kG46Zq109R3O2cVRgKZmYycFkkFShuERQbZz7MrMT+mrEZ?=
 =?us-ascii?Q?Huiujm6BOJZU46RiPAWsuWS6JooqPTY/BgjdWSQ0rQtBNQt6MN1EEAzxhB8p?=
 =?us-ascii?Q?C5r6eG5p7BxGU66Bw0XX05go8x+fZYPsukrhiYtRG1o7bf/dICM+nT2NGgPv?=
 =?us-ascii?Q?CNehY3G4q2aeoa5KX8vekJOoEvztzICuvUrMBgcHUwPV+yk2S3eVWnQv5LlA?=
 =?us-ascii?Q?PCpk0aNqvC0Nk6nvE6w/6IeC5NJuW6tH3oB3TLq3+isfY7Gyo3e9agFQdplj?=
 =?us-ascii?Q?iVfwyzzCYpE4FIx5BkD0Tl2kS2EACHNr5TehGBVYzPo1smdmrtutidoJ7rWW?=
 =?us-ascii?Q?5vk6a/UYBK6R9XloESvlr+9d2cyUehBa+Z4L7YlWTUQ9i16v4nb/XQWYzomF?=
 =?us-ascii?Q?m5J6gUO+Zk8aeZYv4qz2ij9zHwLTlg/q3hpdzOqq1U6F+zZcLsh/r1yi3um4?=
 =?us-ascii?Q?91PUTi6XWOyJCeBxA4r5s2zcQkolrROqjvKx/zc9xjrfmHDo32FzZQJ0f4vp?=
 =?us-ascii?Q?asYFkxyRFRc1TBsmkfYXQ8D1TrtZTBkn2FA3tu06IUvM572d3HMXIRWMtFi4?=
 =?us-ascii?Q?MfDFWFPQnnjtw4ypFXtJ9dAWQc9EfZwoVWxZPciALmAOh7Js01Iaxhm54LXW?=
 =?us-ascii?Q?TXpQ4RXJWXz9sY=3D?=
X-Microsoft-Antispam-Message-Info: jH/sMZjuRAsGPHZIxvZoXBwvp2YLhGm32ti8EeRbpX3/fvI8ZlG9uhVAqSajV3pXWnGzM8ZRNoqs8X9kD2tOnye1yjw/KRW6+fvFzflqfbiS9oLvIm19xYZDlbJEPo4t+upq7l9KOUeR/d7/xDXqvyLmXWxtxuL8mB/ZpHGqNi5wb2YZTPH2vDorBpbWXsDhtCYb0IZJkJ7gRkmS83RIRAPtyabxyywWg9G3uYkVe1jwug1XEiLDc25oMcZYdDJX+9kzrWywPbscjZBQE6JiSUC7hkQWiO64Tmrsb13S2s86FWgbrupiB8kMFd9HXDmvUhAW4kUyxTS5+b6e2QhJVJ8xrLX5vwVsUIpsbTzxbdc=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4467;6:CfE3G+RhKW0Bfs8X8eMlypcKWmbuvw+xyOg8eM7b+ZDusHY26B77qjCq/ooegK3/f8yLrkLQFmK85dBXfveGXNRqMv2em7ZNdn2cPkQfnWrjlbqpxdxCiuxRrApf/S35nwpLxKMCMAT/dCp0iE9uT0YpWDhiX1LYBDpK/8v20pD6KI6HgiC7Q+N52O8fJDo7sm7IBws7BMW2/EcSU7xyT2P2ejb1dFsbleOMpISUPYmmKvRQbtcH2RiJsrAAe4XoWUFjEShK6687ogIbqV4MfEmiJe3DIu8Z66uVC4DGBwz/LZ9psFKQUBIWMKa+tACNOLG8r3t75jBUmvKPU0o5RfDXTZpn+0jETqMuT2p+rxNXDxHkfSqlwEYNHmX+5gbDKdXkq0frGWh9+d4g+g/Q5txkE+wjDAfdcHWrxjiEa0OPC0c2FKUTYCz5BFglYnk1scn2Qle0UP9ufYrfGFoUZw==;5:oonghp6MNUw6FcT5rdUNiTrfM66IbOqr1tKN6E/sffvJ2F001YXA4B2eB2nZjiPmpWHVHWoRuOiFFjsbuD8W7H212/A3R32zE+EJzczBrdt0ags9jORWuImeP06iG+otfWueOqyVFWh2m/0/nhusehXCpSuMfmlrbxzYRbUNbPM=;7:c+V7CpYG9mbutNXKONU1SWrQYGiM7qh1mLgfhqLpbiCL5h5NVza6CQCvlVPf/LwiRAP41wsNB/wXHcx1SH2AEy0p4dyxc0v/4uwR+LCfNpEu17SiXI5UNXHk4OVEXMhmqqFgqiSGML4CmuktjkCLLyYYyUPaDWtvzFtMWBofCmpGgItkZGlzj6bmrkLhGNnEuNAO+jxjq0I0YzvDGaXjpEdJUF/+zMIw/FnArmxRTO6VQx3GYPR8tvv6qxZN5iLv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2018 17:18:24.3220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef0df8d-9068-4ac2-f9a7-08d6262f904b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4467
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In axidma start_transfer, prefer checking channel states before
other params i.e pending_list. No functional change.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
Modified the commit message to mark it as non-functional change.
---
 drivers/dma/xilinx/xilinx_dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 06d1632..a37871e 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1271,10 +1271,10 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->err)
 		return;
 
-	if (list_empty(&chan->pending_list))
+	if (!chan->idle)
 		return;
 
-	if (!chan->idle)
+	if (list_empty(&chan->pending_list))
 		return;
 
 	head_desc = list_first_entry(&chan->pending_list,
-- 
1.7.1

