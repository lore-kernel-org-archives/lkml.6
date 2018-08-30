Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98029C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2820D2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ln5hjfzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2820D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeH3OYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:24:32 -0400
Received: from mail-bn3nam01on0064.outbound.protection.outlook.com ([104.47.33.64]:57024
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728295AbeH3OYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVJMUFwvOod03yDrUeijBm+X+yfL8DSDT31ZrB61iE8=;
 b=Ln5hjfzv3WsotigtkLveqCAgkb0+SO20CzeGTN2ShAtvHcVbDw3XQR+pGuWGjJ2VtSea57fx4sFK6RaBe4PpM7MF3KTw38rDbfUYBAHixIBcaLozFakcNIW45t61mIIweEsvukKc28Ux4D+Wr/N1cvUw5AidUxvyni0POXY6AlU=
Received: from CY4PR02CA0012.namprd02.prod.outlook.com (2603:10b6:903:18::22)
 by BLUPR02MB501.namprd02.prod.outlook.com (2a01:111:e400:88c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Thu, 30 Aug
 2018 10:22:58 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by CY4PR02CA0012.outlook.office365.com
 (2603:10b6:903:18::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.15 via Frontend
 Transport; Thu, 30 Aug 2018 10:22:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Thu, 30 Aug 2018 10:22:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvK6A-0005nD-O3; Thu, 30 Aug 2018 03:22:46 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvK65-0002P7-Jo; Thu, 30 Aug 2018 03:22:41 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7UAMb2w003997;
        Thu, 30 Aug 2018 03:22:37 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fvK61-0002O4-1N; Thu, 30 Aug 2018 03:22:37 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 342D012159B; Thu, 30 Aug 2018 15:52:36 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
        <leoyang.li@nxp.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <broonie@kernel.org>,
        <arnaud.pouliquen@st.com>, <geert@linux-m68k.org>,
        <eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
        <lukas@wunner.de>, <freeman.liu@spreadtrum.com>,
        <vilhelm.gray@gmail.com>, <tglx@linutronix.de>,
        <baolin.wang@linaro.org>, <gregkh@linuxfoundation.org>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Thu, 30 Aug 2018 15:52:19 +0530
Message-ID: <1535624539-7839-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
References: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(6666003)(42186006)(106466001)(2616005)(4326008)(54906003)(16586007)(6266002)(8936002)(106002)(110136005)(63266004)(426003)(5660300001)(2906002)(486006)(39060400002)(305945005)(316002)(50466002)(72206003)(478600001)(126002)(47776003)(336012)(476003)(103686004)(356003)(36756003)(48376002)(52956003)(44832011)(81156014)(14444005)(26005)(51416003)(90966002)(81166006)(446003)(11346002)(50226002)(7416002)(8676002)(2201001)(36386004)(76176011)(186003)(107986001)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB501;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT004;1:zcuBl/WgW4vhwjFYPIJqD7DZGBmBxirp3TIZGlMU196t5nmvxDkweUZIUmtFbOG7Vpf+Sa/VmwfyuZwctLv5wmNidVmaHCHnhNJ9bNuobs3KbwIkKEWFZeRm8f+s8ue3
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d1633af-bf67-46da-3bbf-08d60e628d9e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB501;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB501;3:mRMGVdAICsAJunJrYNXlAu1b7P4K/im7KcdPJj5/AZEakcXdqa8ycP6VFa4tpaeur0VuSiRKe/PxHSf9kH764NB7s8Lve7kPUE8wf3yDZPojg11nAwff+AHY2L2ZkEJY7zgsryXO1ipCh66cxGP8QCC0vG16z3ZZPXabP/GAsor3I1fLSc12PMefLd3VpJDC2vitR1oCeixwAC6aODbeAtJrjydgTUnd4NyUO8RYL041/yo45TSsOsfnv+YWpFj2wRQ0TmICdwMvFq6AwGTgBlby4xB+V55psIheDlWh875YsA0yuz8/7meuGxextd4OvsxbISwCyRwfez1HegtoGHOLJEQBYg/83aSApJzxQNQ=;25:9OX+gl5r/sBVll2LW/0a358L7QS8uMStXtRFxiKJTGGCnq2YHjiYLIU0zTrU6tKb4fciofUVnXSACWuA/2lOQIu8JAoec6bBMU5yJUlRJ+4pvWDEpRO6P9wHQUERp/PJnmiCOt72n9YjE8sqJVhkf9cXOsF/IoGfORu/m9TbeBAnjj0UYesNda4lPSQw5mTxE2HuRiWoSeqh20nv4RpXxxKXdy43I6lOD+j9qiAL888xn/tReAU4JxauOrjrXM9N933jizrEuhMv6ckUeXU4PxD+iA+BUBpuRJe8MA3lDgORNciKHQMPT7ENT4G8Nmc/G5ga+OS8TEavqX7huVfdJQ==
X-MS-TrafficTypeDiagnostic: BLUPR02MB501:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB501;31:GswuanhBFLCd1Wk2Gnu8TciLP9qCf9Go0n9OOL+1+rjJYJXNtdBWLfxJOHrf/NRrBTT/GyDehqf1gTnZyym3f2v1WJ/jXs8vRz3RGJVkHTaDm0l6ixpCL9Ah6i9a0TenC5fcnTnSP9nLHCp6Ofa4UdRfKThfq2K4eFwD2NOTTyIV41pUNTf/izjLIwaa/g9SQQwYbj09/uZx9bW+0FzpOeZpiyvSTU7RsQrN2oFy8dw=;20:BmZ1tzNABPy80j6XcauAJJ75llk4UvqgNb9FQoI9r24Hw2Zx01lMQ+ScevcP1YwVDSIWFEeJ1K5Y8qZmIqkx35bYb7jXLMajZ1hynApQs10MFmTJ8a+KN711qPmsXxd70gNBlbMhLilwLuxDR2g3sjd0bxFw7JF6rF5qQ+b0llt9czvGagq7SE6Gc6uS5ZxvYG7gxeV8WwCcrkCO4f51X3zELKbDZiBsq2JUsogNSFqLfT5mbbWkPTcZXr6VUHqBfa5YQ+8hEOslYN5EszE2BSY+kmkTVxXYF6mQz5RtmhTOc5YAHG4oUBYrvP6xm6RgA/4acnJ8LSg8bygiP5HjHD/k00l5+RCEctPZiZfZEhX2jxh51f9cVCC8W56Hj9GTd1sFwxtfHQln3vzwW9ik2Hk/LkGFz80q3ui9G7lAcpErklMFBTJo5AfpO0Kc11Zeuz1nfTN5A9rEdtLJbMt6TFTW+YWad8Jl7wglN3+OxsdohNaB1ZCwqD8ZARthbpzj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB5013FECB5BA6C620538E727C1080@BLUPR02MB501.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BLUPR02MB501;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB501;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB501;4:DpLkmw9OsANYbT/h7zx9/D7syJCX7ySdWRrxIo1dwr9yR8Vvf26J9fuQb8noTq9ur7+qULBGg114b9WkKLqv4RFwdq/lojWXKvflYB5AdoSW+gyxPAk0QxHMrodlk2+3VMuVtM66Qv0wY+oOw93zOg2kBYFp6QZ05XDtdc4STeCZU12rpB85Gh4MMY3F2zIdGUD27M+Qa3CqtzIo9hCboB4CUiEXpwm/9KEa3cIaSmuW/Ge0WGm99oONLQn4umktpWWcZDVoCIDbe5WDrKbb47X20Kjrszo/U7IcFDL2OdPx6410uuERaFe12dnTtduR
X-Forefront-PRVS: 07807C55DC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB501;23:E1dCRBzWz+6CSLvoVAB3Q3pHse3OE3dVSEAvRH6KhT?=
 =?us-ascii?Q?GGSCvgncFA0N2pPehE6/J8njO6vNYLziPOr5fib14D32i3jroHJCUlheaCZm?=
 =?us-ascii?Q?xKFYkfnrY4lQFlELdDIRm6K8XW5aVGII5MoRsKLVDCRdlTsI4ZCKt47jqBqt?=
 =?us-ascii?Q?ISEodO3W+Cfxa5+5fTbqfbjclAHwlhjljQIgTXIUS6VqKVKESNaMp3MmfzWL?=
 =?us-ascii?Q?3Vpy7LYnCr6ngje0JT+xUpx2MreZnrTOvcrxVC7TalBa99f0tLorO1iavk9t?=
 =?us-ascii?Q?3xFbqPnQmmByA6GSaWI2sVjl1nmEi6IekgKUW4CrN4Id5B7mLf9BhGAUnhyQ?=
 =?us-ascii?Q?ETrYGDJB5A2VRab14WNdQFcdyzF3KPhYlBSymD8VbmwFcS2R6VY8RaYz9nKP?=
 =?us-ascii?Q?9FS16yFHi5TH/BwtF6s/nkD0KIy6MASye9WXZG/zOJPtABNqQ0b8dzfO5ovi?=
 =?us-ascii?Q?BENjvHTU4JgG9laHL3NAFoJkmtSIQ0iW9yRuVOiYVJWjXKKZFxAVFyjNuLnh?=
 =?us-ascii?Q?CYlLCQZAti2RTG4pgr2fhGFGVNrhrKctRyPtTrf0nyHGIVeTWBJkw2mthlPG?=
 =?us-ascii?Q?g3bf5AGhdpQFkpntL05hlLW5dIFSQKLFHJEb5UJ/eV03MTyByox150HEEKbG?=
 =?us-ascii?Q?McWUpNa5TqO3NZbgNcAw1Tm20lFumQEwclHalNzR2SK2gPeScTA65AP9YAhY?=
 =?us-ascii?Q?Rs9Gupnc6rHGVZq6rlSsi1RvvR71uoKipYneqAdZIvJ1WJIxlfB01kxlo4U2?=
 =?us-ascii?Q?0ZoKQQmTmCJqbbtqR5EQusopC2/t1L7KwoDe6zsUiNex4nKApv2ZnpQzGDHH?=
 =?us-ascii?Q?OAgYm4pB8utxWluH8yOwXrWL4x8JLTZF//TDFtlNfNfsQldvcO/pRBdPWNso?=
 =?us-ascii?Q?Vro4qqL0p1lDgT+oYM2GeMDrbTC9LhjEv3lgGHPuRovVsXmbflcJhzk+L/r6?=
 =?us-ascii?Q?0Tum68f8pYVz36xBF16j3+agHFgyUXgPGRPrBGUTTfbHBLIyrvOY9vEj0xT5?=
 =?us-ascii?Q?HGD2ITi/YgZdXqhRQ5censObTANC4zHJEPweGoRAXsiCnIrx2STH7pl5pLpF?=
 =?us-ascii?Q?RHUAXOLRewNI+7YzIgJ295WMFQZ1W6LagJ8cflEZSP1Y07B53bnFWcoRaayM?=
 =?us-ascii?Q?yN8gGG/+y/VLoBUEI/LRdl4MRPvPVS6E1ekUUDEgZPMmo5QBSGjufT+GcwXM?=
 =?us-ascii?Q?HdYr1/uqtIaKiwuKEBcd0nJnWSBuFkL3Ii4/rfBDvI0wQY7Y+jaI4mRelBgy?=
 =?us-ascii?Q?1pi7CWDD3WDzlyV0o2sAI986GbmntDvxr8SCvbvuzxV+nY2bukelrZEmlzku?=
 =?us-ascii?Q?nsRzXeKtFZFkb89dOY0fOrrAuOEwujbxtCddnxT3cSLIQOw8hart3Okw3A6S?=
 =?us-ascii?Q?SIUQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: Wemjk0xiNMUHmyG4BiIIIO3W37EkggafrWnlBmP6XxlmKV8Xq2kIoBD3Ro3FpNi7OWmCs1g8xRavfMUb8pvmbXObpKLvHOWzG7bdETvNQiIAkX5QdnowcZrGtLx90sKBRXjUlWa+T89Q7qyJHERZckvnlb2rjZtufS+vJezhoDGSlIehrNocKxNaJgD1b6NNj22mKET4c+5mFcdNEUAtWVg7Qh+g4pcE1m3khy0j6QyJC22PunxAxIaNLtdLaVjfILHQSGvw7OEyhcAXM/uvEqYNUcQrirMbjl5iI0SyOELMKusB97qQjVknJN7Oc4SRh2KCw5uuesuW4bDLAm+5YalHXoVPVAS4t5yGuEXieP8=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB501;6:GSyId1gwENTYc3CdgU+Ote7VXcTWDYP90/z1x/xptAhdj/nHUuXbILgXiYkcmj4mTxxo/tExNcbRRT/tue3LBkE1a1s/SU0nZ/7y6TCUI9tOjamIXbc5Av5WifHo+sEUEKwZ457QxbbWgcjN2yuxIlba98L4jPQuuDpsyVZAZfPZeVv8eNx123Ga59fHhWUaf6g7ZKw8WD1z9zMjwLIiN+7pi9o12K298uC3XQUF0eSpGYi1IH0gs4g4TdP31XqxO17bfHY8UQ96AT5oxozQUJyk3slC5zRPe+sxb2SmIGZNuLWGn9sG+rWObDBua2DM1bOTOByRKXqY87CXLHOwv+0LAVZnnmTZM7/xDS1eDXsWYM4eBMmxhlPUVAWEzzGEouvm1EKjTrYpT2weKMQmO0zhYJGCCJyRH0A3tsZzvR54KhiJGy6sKUbMDdL1Mqp7I0o5rzeCn8ZvonERXHB/ww==;5:ygnRVIImMY2ZFEzIyNJt1gfYcEIXThKwgbKM9ry2Py8Jr5G0IhbZEcs5xXbj+vIu3N8KVZSrbMxQZ7N2nPx4G1wKu3wfG/Yo4DoE93EdTww3HkivGH5zzVeVUamU0DPUS3V4PTvmkd61OhGnTobg5Rz2BSjx26fmBNHe11jud9Q=;7:i3E/cRxN8b/x75DbvYyDrtu8hT+oycM4FYZFNnEvBJlkBEff1jSYEXFgOggua36P9uz7PwiCvlLcCBHAG57RwpkWOvIW2OfEiQIouAE4/TlnSYAf58o5bW5/hMIhHT6GFZvFSlVHc0gZlHeKuvdcLkp3yyR00DnO2VrfYvklqZpz1uQtmbbggGF68oXjAmmrPG3DJ66BvGmSFMzI+yCzTzhETZvWJcPl22OMIZkSBtstx/6BvzFh4OTb25LBQFgJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 10:22:47.7325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1633af-bf67-46da-3bbf-08d60e628d9e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xilinx AMS includes an ADC as well as on-chip sensors that can be
used to sample external and monitor on-die operating conditions, such as
temperature and supply voltage levels.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..6e42ca2 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -617,5 +617,31 @@
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
 			timeout-sec = <10>;
 		};
+
+		xilinx_ams: ams@ffa50000 {
+			compatible = "xlnx,zynqmp-ams";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 56 4>;
+			interrupt-names = "ams-irq";
+			reg = <0x0 0xffa50000 0x0 0x800>;
+			reg-names = "ams-base";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#io-channel-cells = <1>;
+			ranges;
+
+			ams_ps: ams_ps@ffa50800 {
+				compatible = "xlnx,zynqmp-ams-ps";
+				status = "disabled";
+				reg = <0x0 0xffa50800 0x0 0x400>;
+			};
+
+			ams_pl: ams_pl@ffa50c00 {
+				compatible = "xlnx,zynqmp-ams-pl";
+				status = "disabled";
+				reg = <0x0 0xffa50c00 0x0 0x400>;
+			};
+		};
 	};
 };
-- 
2.1.1

