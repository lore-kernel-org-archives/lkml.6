Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B31ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCFD2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3m1k/lxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCFD2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeIQTxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:53:20 -0400
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:65408
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728739AbeIQTxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMxgXdpaNgAtH53DtPuEZr/rZOAcaWNlw0OvpH0MhTY=;
 b=3m1k/lxhwC6QPShtBRr9IrhFY88ZmpmY8EiJdHGeGjzku5Z+ChDwcWCXCOY/oR06MCl78+DR8KBTaSrZbqGic9ky0MnzZEwbukHLQhwjJ5Bn0ulO+1KLWHF9h+XFh3OaOAjG20yrTXUyLyvm6zqmWcSWxIGDL+j3sbk8f9EZ3GA=
Received: from MWHPR02CA0009.namprd02.prod.outlook.com (2603:10b6:300:4b::19)
 by BYAPR02MB4471.namprd02.prod.outlook.com (2603:10b6:a03:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Mon, 17 Sep
 2018 14:25:41 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by MWHPR02CA0009.outlook.office365.com
 (2603:10b6:300:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.18 via Frontend
 Transport; Mon, 17 Sep 2018 14:25:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 14:25:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT6-00056T-7P; Mon, 17 Sep 2018 07:25:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT1-0005Mt-43; Mon, 17 Sep 2018 07:25:35 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HEPQi0003537;
        Mon, 17 Sep 2018 07:25:26 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1uSr-0005Lk-RA; Mon, 17 Sep 2018 07:25:26 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 0CEE41214B4; Mon, 17 Sep 2018 19:55:25 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <sudeep.holla@arm.com>, <amit.kucheria@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 6/7] arm64: zynqmp: Add DDRC node
Date:   Mon, 17 Sep 2018 19:55:04 +0530
Message-ID: <1537194305-9243-7-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39850400004)(136003)(2980300002)(438002)(189003)(199004)(126002)(14444005)(16586007)(47776003)(426003)(2616005)(81166006)(72206003)(316002)(8676002)(63266004)(90966002)(110136005)(2201001)(44832011)(356003)(446003)(52956003)(11346002)(42186006)(575784001)(54906003)(486006)(305945005)(8936002)(476003)(4326008)(81156014)(6266002)(103686004)(336012)(478600001)(2906002)(26005)(186003)(50466002)(48376002)(7416002)(50226002)(6346003)(5660300001)(36386004)(36756003)(106002)(51416003)(106466001)(6666003)(76176011)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4471;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT057;1:hvzA1bupUpFLRZDJx4R20dn80xg60m0nmSxdIhIAwbLbIcrNQ0DVdORXnMaD1hjEXUdDBf+0+7wdzbel9QVPjlRBLxXWeILMoJsAx318M0JddVHLIEzmQzU3/aegh/Sw
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc44858c-e012-44d8-83fa-08d61ca9723f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4471;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;3:Qo/FI9nxQbMj65+oEX6+0zDh3CvTp5qAbM3C1UMzsg1pwlxIgxz3r4mK1Cy1FQqIGR6sD8urA7IIt0e8Ibpm5HOYFUG57wixSDn6awUcnIJlW50gkFhkvzJpAbzJ8WoPQJhTAEW1hFjSFwCHLVGWRFPRqOKNymfeEV1qEOU/OzNH1lmpSANHj/Ldna/VLrcH59unFJe9QYq1iwI6d6ZXUBv6NfC57XfqukGsm91d1sVAwkqLMZzT0kzWGdg4XbrhsQ6BjLUASUDS69JCapowjeXLOIpATwHDO/34wog5eaYI/8MDZ2bslkIApd0ml3cbE66vdCCUUbit+iW79F9WMT5yfNdKQ3JosEjKh4wSjXg=;25:UWBN03GgJNEhB0iQTTnwd+ErZViKzgOT1ChuntPo1ikthMfVi57AC1HPxA/+hk9BJZv8srSrZYDKXQJjOLVPVtK8BwWiyfn1AsXVS9ELpcEq1PNm7eVyf0uXuPFcu3nTxgw2VYjwLAbGTlpQdzt7OuRjV7g1UtqvEg1nrFsABKaSKtu9qoIV8pir/+yFLYxiwBYBi0KUN31g+WrbJIYWJFHeJ6LQbfWPDgvUYw28Qr9lK1g+k+acBvhaYEeWXHZhIB4ZpcBOcT9jsQYucXqzwmQj12r2xC8QyKSY1MEHMbK9p7FKWNl2Ga2j7i19kvl8OG9AtKu4boe3EUDHfJVLHw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4471:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;31:quOFjC2Z9tfzVDaPpcU/QFWpU6uGCdNoLCCyqhzs8gxoCB1DceKgoYfy9n99ffMASXaabVIT3vKjkSvHyj74rbkpsi/zo7cqp3GPkQYLuWqXHQFaaaOzmoBzllBZh5GIPK3X3mCnN/4RinRCuqz6NA89NrmPc8uvYyt8SYsvsR45f/CZ0aFMAhSxJzXwVmQtTv2CDAB/Io+lJoOCKPC0l7LcSiLlgOtNiEVELstp8R4=;20:Tt/obAhGIPxU2FywbqLLfsS23y4cTBGA+AX7HwG6fCVNeQZfRgDOeZ0rS68PpUzztjIvzaalcRQzauhXi/0JfgROeYEMSU9AtC9jHaBS4TrgLEN7XUkLytsC7Y3v+TG2rUfmMwDAI6P4lJlVDSez5mlVMvNu76p2V+134c6LijkBf8bdlaa5p+Z7RyF02eLZ7YK5pvgYX6OIAK342yXjh94S5mbSq0amkWyeZ5bmejHMiOMfUikbPtGrfMFlrXyRMzQyZ7fm44qBsFJOoTYQP0bamvh365y1D7GmEaGHaGLZFrNhFI7pm31z8RnxkP06x2Y1wVAspZb06i8TZNoRCHdzaN+PPCZVm6va7yBGab4IwDdhqD/F9SeahUcfPrATLcEwa9GQHAH9y6Q8nJyWfJxB8P5G7yxA733RNijqN13asnjxYeEQr5XQX0NB/BOfssb8C/nVwLvNp451v3/mVkoGc183tbNKSaPA1VYq1kLFp+rS1yf/3KEx0qxDVUSl
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4471CBEEFF329C9C59C32DCDC11E0@BYAPR02MB4471.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:BYAPR02MB4471;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4471;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;4:JG83qhPOdKU8v6opc65NMX6L+mOoTJBmuZmBbC00hyeaBf/DylnPJ3nCVXidzO0Y5CauX7XtvpP95S1V5PxuIKznh7C1FOde78L+i6BsnwYhJk81O2ryeRru1M1yZRgXWa+1MJ+MNHbXHVObbHlCjlc3jAFHlRonzyajZKwZjTtrRWLVDdEpLw+uIWeZkoyBi/r8LMuvnFfZXRHn/YLadTSvRY0JS+QSd6F8YBvqCxxzqAmTqfqTvSvW5pX2NYBI7LDeiDuYe3JRqGv58x8pfjdSGqXH6CCNfsc4rYaNk06aBv9IhGaOZZYQqmgmpnzN
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4471;23:Ua9GdRHEIk3+G1DD/LIlgPPqrYnYCbu7VFu5wh9UG?=
 =?us-ascii?Q?b2nXV7oeucawX14+M/Mf/RKi42rw9bN+KlH6pSzArtqhIS2Jgj4VGP0VHyBo?=
 =?us-ascii?Q?ZUUV83IkKAMMWX7o/svTKlo253nMvi5CVK6xtTARUBLskpKZ4RZxhZ/qLiF9?=
 =?us-ascii?Q?5vABFG4t43/S15U7IyYTHmQEUc+o8tGFJ0kpEZcAsAsNumB50eJWee1qan1T?=
 =?us-ascii?Q?9qSsdGCYxrpm6WKcGEcYkNaqgYlgvEkgihAISWv9MovSRB/IiqKNlgidrCP1?=
 =?us-ascii?Q?HvDx1MHHFDvmQ65rskIbSCQxlkAOMZVQPCGoQAecBUgUUoQq0R7Ukl8QzgCf?=
 =?us-ascii?Q?kOWbm5uLeIi6d0TWd6cbqNYbYkshmTRgs34dwGIRzYqs5hZSLmhpjtMEutSv?=
 =?us-ascii?Q?gE7BtexjLFJj6g185xhjHEvH4aUOchMLpV7YjgPge38cLz5W6i7qg+wupf8N?=
 =?us-ascii?Q?rIMLcnfROThl3BsKhFs9zAAa5eJU/c/5W0tj1cuj6BiN0vcX2LeAB7KQ6D5E?=
 =?us-ascii?Q?hImDARh+fy0ViN6m0yarq9JeOoy3ILXWWKDTbX+UzkgjCtWnVKhN4HHa1s9d?=
 =?us-ascii?Q?7/9DLeoK4Mt6bR3BWUGeqm+5YWFm3yTGtZ/UYTEU1a31VCMTpEoD2yQL/4CW?=
 =?us-ascii?Q?ZXXIIMj/T673FkZAVAx/KGK+E+8w2Io9uTg9spVyk6NSWdbi3lnn4uY3UlTY?=
 =?us-ascii?Q?P2I17PaNBMo/mrfzWQtnM6JM1igLwqqf48SW65F+5BY+sxReJ8PT4qRqxBDt?=
 =?us-ascii?Q?mejPxBCAe5SCjDAEzuMRZChCUA7HC83ebS0nn4ieO5SwR7DdEk7pa2iVHdBp?=
 =?us-ascii?Q?UW+GpPYyXu3NFSioSJdeS45Ikb/+CF4di7cxb8BiWVrg629c+c0HSKmh0pWe?=
 =?us-ascii?Q?ouN4eclSRgXHyMFQ+1PQywTxIDSEMk//I56K1vF6bwM2RAcyNYXxLNUqzZTY?=
 =?us-ascii?Q?AeNsHSoTZCl2seL/xk99DTBebFin1f5RPn7Oig6+0Z9ZXhuCX3n36avVmaUw?=
 =?us-ascii?Q?LQhzbJmo3OlxIQq320OxZnznwMpZP26bUTc7sQYjw6O6vIxhCEqCpAu47CbU?=
 =?us-ascii?Q?j8NXaHowls8wCQrMhh8k7uVsVYfGeziY+V9i6VkUbZDH8lfEl9mJ1JWeMlj9?=
 =?us-ascii?Q?JbXcUcupfnevIIPyGysfU+HaFIPFBb3dGZUPvj0NaQmdUFRGm1bQIU1mr7+r?=
 =?us-ascii?Q?xI8FM8cOawuxdX4wggvzwYqhYzA835bDjc8VZFEGa5IaSzD7m7oHS91XLvGG?=
 =?us-ascii?Q?bH6X2xL7Ln9oIP0E291jXrj24qju0m5n3UgYu9I0Yghyo7Dlbs+zzduQg5S7?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: B5k1UkK6In1TN/8LZAK7mta1n/9K/USp90CB+1wsVuK/bN35E5fNmTNXlgjYGQRlm4i4j0ZDYoZPJHP3TsSEjTmEhgpM9rF+gjJahvRCyIfL1m1QH0ihtY+nPH/PBulaVKQ3zT4U8pGo3bHTSvGN4rAaKdygArFMGkbA0869exEvNNq51nOD053TaJQwr1MES5XGUuUMd6IzS8Ut8Jfz9ikmcl7mLiwhNEvBPq90JXwQcOKwMPk0kXWOO9FcjeZfVdb1phXxO1vos06+sxL5zPNV4BChRx2L6T0ai+NmhR0xdEoOqhp346ubAbSizD0zulEHw+FWapydwrVrzamNgeuIpowZi0qjQyKNb0TWrDk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;6:e9ndTV9xwNNNxfab8gSbvzM6VazKSsepcFew+fgSQhBuRSMx9aXoA2VlWGpltddZ0miXTAhO0f3M0+/HZ6utABGmDnduwfWxM3kpS3tI2I6MZT0GoGFc2KaB7Gq2pN9Vd3I88Ym+vNAslrzrr4DmbSPOt3dxffzT0w3fBkl1vgjXU70y0hl+BHtrI8lfTOL8EDB7dNvODjdl0s2MzlsVqjiCd/oJ5xSxmwV7/ZhOMRU8Mee0G4eTEaNZ4DzBO7Va+sObM9UvzGkbeefIhwPa7T4qMGHoeE2jk+266HPv2IxiJulP95ReDFPrZTre8wWJXnXkU2Xh5SeGiGpa9LRIiPMiJawb5hCm2ZhxXnT/rnxH8i7jA3dXbedeAZZmxTDOoBejGyeqey7EeewdkinKK+r4Yp66BwFwotHZHaPZ/icU4pqp9n19ZLY4LxHNS6aI++rHsUHFUY9ucKSm7DNLZg==;5:Xl+Oj9/a4bTvq/h7GE6c5WgcskXvi9slpvo5YAW2pVoQYIghWOncSxCgUg6WzQfKCsT/Aqih5M4qnOgbpIIPub3oElTiYqjeG4VE6T9QA/uj4Y5CGVCqhN/5GBv9G2rTaFnpfqdJGhIud8fl/LKIdzQj2vGdzk05qfOAnua76hQ=;7:Bqud6sxX2sKkeu2IFmeY875IyJV5QN3aeUW0bqOHPXnHuhr4CtYZVxUAGrkEkfxkRRGkQ738TFBvKgYv26PEvwwugQTGu+/sdVXwyPNGgdVyjJrt2g9YfCmMDJIFw1jpeRmuHJTSUDiKvJvig+63XdASpn7RZVwddW4Z1MxsJpRf95mirsd8rPCcCrOl2ZiYryDLSE/Q3O4ciTShYFUepFvjA63AYFlwwKNc6T4xrJwuezTDtxnk3YneHkZZ2Wh7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 14:25:40.6944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc44858c-e012-44d8-83fa-08d61ca9723f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ddrc memory controller node in dts. The size mentioned in dts is
0x30000, because we need to access DDR_QOS INTR registers located at
0xFD090208 from this driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..a81d3b16 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -355,6 +355,13 @@
 			xlnx,bus-width = <64>;
 		};
 
+		mc: memory-controller@fd070000 {
+			compatible = "xlnx,zynqmp-ddrc-2.40a";
+			reg = <0x0 0xfd070000 0x0 0x30000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 112 4>;
+		};
+
 		gem0: ethernet@ff0b0000 {
 			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
-- 
2.1.1

