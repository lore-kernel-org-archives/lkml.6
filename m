Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C1AC65BAE
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40C12082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MRsjgc6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40C12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeLAW0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:26:09 -0500
Received: from mail-eopbgr790081.outbound.protection.outlook.com ([40.107.79.81]:18388
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726756AbeLAW0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAeWIpde05s6gDOiVtppofyLiUtuO5xWab/uKuFbCb4=;
 b=MRsjgc6hGQD7k3xIaPxD3AXSJJ3K8Xy3LhhMJJ68Nofmp+EuGK2AIvDvY+nncR47aH1XC18iK/dNIbd+wbh/wW37cczCwu6wZvwag9b2hmOVZFYT/PD0HYXdVDtU4HHOCbtlQRyjD5Pa3VZ7tk2A87zPYAtxxRPEpCliUAypwjk=
Received: from DM6PR02CA0022.namprd02.prod.outlook.com (2603:10b6:5:1c::35) by
 CY4PR0201MB3508.namprd02.prod.outlook.com (2603:10b6:910:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.16; Sat, 1 Dec
 2018 11:13:46 +0000
Received: from CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by DM6PR02CA0022.outlook.office365.com
 (2603:10b6:5:1c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.22 via Frontend
 Transport; Sat, 1 Dec 2018 11:13:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT004.mail.protection.outlook.com (10.152.74.112) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Sat, 1 Dec 2018 11:13:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DU-0002W6-HS; Sat, 01 Dec 2018 03:13:44 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DP-0001kp-Dj; Sat, 01 Dec 2018 03:13:39 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB1BDXen015251;
        Sat, 1 Dec 2018 03:13:34 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gT3DJ-0001jj-DU; Sat, 01 Dec 2018 03:13:33 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 96953604E9; Sat,  1 Dec 2018 16:43:32 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v7 01/10] usb: gadget: udc: Add timer support for usb requests
Date:   Sat, 1 Dec 2018 16:43:22 +0530
Message-ID: <1543662811-5194-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(199004)(189003)(8936002)(76176011)(51416003)(446003)(426003)(48376002)(336012)(4744004)(106002)(356004)(6666004)(47776003)(16586007)(316002)(110136005)(54906003)(42186006)(36386004)(50466002)(14444005)(8676002)(486006)(2906002)(103686004)(39060400002)(36756003)(4326008)(106466001)(5660300001)(186003)(81166006)(81156014)(26005)(90966002)(478600001)(52956003)(50226002)(11346002)(63266004)(476003)(126002)(2616005)(7416002)(107886003)(6266002)(2171002)(551934003)(305945005)(107986001)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3508;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT004;1:vxHfQc15iGxZNxEi7xB4ogz5DeDDKTDALztA+crBwEw53WeeYFzSuyfgtuApAvAZ7Mr1rqtYeVtK3b0bscdRA/1wqLdP//VzJIQAQ5pbD7/C2JPDf7LF9eLjuRb4EjYf
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab7de776-acf3-4c78-50ec-08d6577e0fbc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY4PR0201MB3508;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;3:PAahK4VhaIm8X9aXO0D2CNx8ViTCzrYOHEBHPnx8VE37hxzjVJtFnEnqAvotInHw+ThbpKT+H5nSmOaM7LerojNxAD/38YCFzNnfij8taS4ZQGwh7Gc5WrgvXTLJqIM3ChRyn6gD9eiIiwY5pKeVq4eEsi++2Fb+r340yxnCPFJddni3dy14FBm6dOfVa0NE3MjIwow1WGSc4XtQXswoH8C0ky1wBSzDsRD2g9SVEtJb1HvdLUGjKLIWOS8MlLzby347mSzqAYVUOdh/4VYI7XkvSp6t9Iv1RIYQo8THcaAmZM8Ek86Z2vko/dpu2rg9TVw4DswlS4W2ZYrFwgPlKlFdYL2dqMQLiIblJskvqpQ=;25:cB4vD88JivU5Oh66pdsBf00tpi0GfOPklOQuUDpNH4yEni3h2JcpBd9dxvpW3EEStpyU7YxJN1sQuG0i6CfCqvmaRpUseEVzww6d1IZzizjDxaxBqm/pzoiRaGkAW7cJpHV0LD8fwhYXJwR7xwp0iy/ujYdmVuofW57O0CpQw7mJa0K5L2bWsFKZ6OWUhhYqm90i8tRtB8Fqy/6aw4zO/XQ7Hy+tI3f1Ubgf1A9woouD9KXh2fGATsyKvdymwO+Mz6InX0hk8yhlvTZ2ahRRNj7iB8oL3+wzhZMkg3jxNZp0L2vaEsy9E7m+aDGvvwHbwl66Vkp7t1g9gSjt+4dUPA==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3508:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;31:sfD9l8JnE9jKehESuQ+ZXY1jZ9RlDIL3uQx1v08NjsLwl6eyIrr9ycAWJUwv9SOPrp5DD0h8RAB11LwjzA/DnEOpaQwXJgoWA4teUOtgXUZPzbHDM1OeVfC5T16DL8evCl03gdJ6RQHDeu2uOwnaXkUI5JMigLR8G2C0QfvLRr9FCNX22bzd6X1gaP5hXEhDjXIsTPiXcGkb4Ja3XyuiE3Y4jtKpl/vEtncGrQxoOVI=;20:cAjjyMmoLfw5Wwo9dlAay1sPwa6oACpQayoq0VKdVjV77xuFaFr6RMwElJUs8Yrtfj7IymO8d959088LJkgn2xPaON4/bAB/V4j3KquK9zH/rHoKHCW4kHk6sCenl5SBqm53cTyvY5StnDXSPccOnfkDqT2twJ4FZng+DBbgGNRspMFTpkwQJuLsn+AyK3Gdc9xuC/8UAXbzI2G0pprAiYYxgD3bVa3HBuMgrfpTuQL3WTbzZZB3YO455rxCz5v0m26OV9xxDSM+eoExCeJDi6k3HCAT5Izr6tIC/LEK+TbzT09UQX6kYFOawuGMfp2PV1DNa8twptffT6m7YH1HE5eUwPqbq+WwqmkMWIKaM4AWIqbCNOXF1FgGq4um37KtMOw/ylmTP+lPfbvM9CxAhWias7y1wakA8obBRCTw3ROdDiYbi4PQ9rzGVJ6odkKJCXltDlll7YqBK9sW/bxU9g0r92GKbQfSkkdKcE4v0A79ZT9fXgyVZxaBkTHpBQdU
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB35081B2B540394A2B5DFFD56A7AC0@CY4PR0201MB3508.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231454)(999002)(944501476)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR0201MB3508;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3508;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;4:gPY0GEG+8a0i3vZGmHQjlBcEiZACKDOlEog2xCmeqzAT1Bj+CQBRnhe98rLLEQS6d9hRXpOwllhxw2rsWechwp0D2lp2wmIyOtHTRNZIHU6/QZjXTi89OCPsD1mptehLb5QvqD0+fDcOMb8DT6UTsxqK0rbyhxijBy0gwKjEno0E5ttJEnUgp3xOTcHvfhiyIcUwOWCZTDgWro1t+ItPQWWI7OLI/PAeXTxxvJBB4hRTJVICwo9SCvE33DjWJZgyl3XpMKP/UjOxJVNuJpch1Q==
X-Forefront-PRVS: 087396016C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3508;23:H5bxasAdlyHpsFWWjYPQC2kD72rl/NaRS/vjdDF?=
 =?us-ascii?Q?QjJg5SzvOa7r2jACZyQURV/5DNPwao4PrFw+SKYErJnzwj/muFLuzKt8eBz4?=
 =?us-ascii?Q?mdwSV1LyiNV/FDjr19z+qW26AgLsa1XVkOasQDA34IDjItTVvNE6WeSH1se2?=
 =?us-ascii?Q?60N75VPXRBRu644ne2Mfx2GQuoI6pVKW+iQ4j7FtrpqvREcrrX2NOxCsQ4ST?=
 =?us-ascii?Q?EzaYZ9Rvu1IIi/kZJ69bH5cetbooLnZ2nev8PMePrwnyujTjwzZdUYwVOuow?=
 =?us-ascii?Q?5ZxTu8DqgI7Sskam+KwKl7S54uuEpdeYc+YEhTnpCDEmkge/lWlixkq8TnQX?=
 =?us-ascii?Q?kBAlyjAenpAvY0aeWGw9ez+35BYDuzqLKvXo+v/53jXlQ3a03vpiGPE2Rr3n?=
 =?us-ascii?Q?7kqXsMzuzQhsYCIymNPdAd6r/qBix3sBeiArY2dfJJT69H5ubKtt2/s7u6E/?=
 =?us-ascii?Q?Yi/iNOnWAUEkiCTXGmPJvs1InpTzjf+y9ku5QplOIfxdPTRqE1OxThWRhoWy?=
 =?us-ascii?Q?7CmzICQnsGgYRFFd0prVQl4YimBeXOSqKR2ndO++MApQu1tLz2EVZ8Yw2hT+?=
 =?us-ascii?Q?9px8iwLKBZw7YxBsgIwu44KYyLp633oojyZ4HYZ2Tk9fJCBz/wL9SBUn2GZW?=
 =?us-ascii?Q?vXUbJUcOWkXtlrjBWB8PNJi9RM5DWMkqg9mW161wI0akE5iA6YBVnENjsKZZ?=
 =?us-ascii?Q?bzb2NJyc0reg2Hl5806NsaxbzOqyqo5mPBvUpgJHxAqZkpKsjvUPVhibd0G7?=
 =?us-ascii?Q?sAnpfTYhL1gFnWPJ9KenFK4PAeXUVECk/2EIWQGbUxmpRK4bEPGFIPCgfkDW?=
 =?us-ascii?Q?XsHJF/NpLNC1oklDU+TMKePzEcjgZVJqEnacnuZFp+S+98L40m4FnxXlDtSi?=
 =?us-ascii?Q?8zeQcfjN3yzAqTAkqz3iJEaxwlMzm1EuKMt6dzIUAQplJOAm7gzCSgcloGZj?=
 =?us-ascii?Q?LV38ShG0dsVGWAWb11+WJIk5TdIX7rTcZE93k1KthOJ1JSiiPlxF5rX/MzvJ?=
 =?us-ascii?Q?hVuI0k1n08kEVahQ9m6pk6SrbQ9chL59xRrCu2vJAYu3lpoE5rQ9Mwjo0CNb?=
 =?us-ascii?Q?QK768tEhF2F81exN9+m+kgfRlLiJXbHUTA+cPTX/P5HAyguwRRls43X0SKdn?=
 =?us-ascii?Q?Pc+Y3bukZ/rarCuQz8vWMwxeBCDkyH1/+AaXOEIJpQj7O7NwHouaxvbKH64R?=
 =?us-ascii?Q?hUECQXM/lcR6mfJrBhKB5UodrUaL0Que7v9+CvWx8o28bYfneNt9/e+zK2fW?=
 =?us-ascii?Q?gX72DZUcMFclNx53ZmKCjgAxg84ASU+1lnWbzbEIbW6Hx4+YAxSM8CLhUVeB?=
 =?us-ascii?Q?E5r2J7CvXZJ8yC1d207sP3cv8BJqBgUt7dCETtR4SrODyVp16ZYtIe2/Ew8D?=
 =?us-ascii?Q?rIDCGRQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: uIXs20Tnn3JmEleTCxR83EyJpUyEIfOjJbWdpdZypoiaALmZ9NXmLWmXfH3osndicNuWzfbBYXoZMQRNYNg3fX01OIhGcbtgXJJ8pZoe5nSRTmkhtjzexREoGa28nY3wcXdy4coXDq/LnS7M2XCdN1oK5+FBq6/iNiQaVGFnYfvnYekswXX10l8Kh/2dvY8Ch6L91I8hCb4zcS9ZMka9EFXfI6DIY7484/zI9wtEDaXfeXIagkm7cIo0mduM5KzGYYf9/qeNgmNe34A2v8xhQVzyt4wd4RHKOqtCFsI9o4TNV/LyFLb+k0BgAyxTR2jwkpvUsCRcqZUfuW4kDI6xLAMWP3HS6A7kSizjjrO11Jg=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;6:O7vIVFNFnDJbcNuIJEuJn0RZR8mslWWck5VaGGtSLXhDGsw5AJqqcI7X2drCroci/IYefIyqO9D3zNH6CVs2q3Vy7ToIbtMRHUq7dcWJRGVRzw8lg7LSCkc9sEzk8i1xZxA9mSyDmdp11oSpL5b98KT/GLO+K3ea4giYHoExoNyMBZPacGj2TgTM7/8+3cl72fcOjamd5aEAiFXam3txXmTKLKF+MkvWtmpiGxYbPtZHqCanaoYX2Aua/zi5YzffeifdJvXrCq18khZGeC6ytuJ12JFvXjDuIEf9HxeGxet6AN85m5JrjwlmklVoYVz2MjAosmihmONApmAJBVTuZIu09BCpIjNsdLGVKuC4GF54MR+7OHq+TCrSv0IaFKeEBF0wlFgZ1BBCihku63dsDhaqS9rc/10GniZZ2eetr79KnU3HyiKD4NFDqSn6irw7jfe9lfWyAoGgrK/N8f58qQ==;5:lWoFBfTKe2wqZcUlKv9Mgsf+/mSbREtFvbTeGx41J/V4n8yAlQJsTP3LG4Fl9OZBQjOJ2i+cGpJS+Y0ya6R4wSyhQQ+jv7Hx6tNsg0F/3iWw/i/plriwc85D8IAZUJlNJ7cW9ALrrEE/GnDmh73VTLcPHc/S4VGB0T9FvHasfdE=;7:qA5DipwVBGDUCaH+tF++zAKtAEh3zVwtg+BrYd2VcCb9ibLVJDbDR+Wqms3pRS3ElDSBAxEuoQczoyNuS4SqVgJNqatv3V8fCPOK+iVx/o3tBjf3tSNfMs4IHQTkVzDMSxOSArUToveeeusLnh+SSw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2018 11:13:45.0061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7de776-acf3-4c78-50ec-08d6577e0fbc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some corner cases the gadget controller may get out of sync
with host and may get into hang state, thus creating a dealock.
For example when bulk streams are enabled for an endpoint, there
can be a condition where the gadget controller waits for the host
to issue prime transaction and the host controller waits for the
gadget to issue ERDY. This condition could create a deadlock.

To avoid such potential deadlocks, a timer is started after queuing
any request for the endpoint in usb_ep_queue(). The gadget driver
is expected to stop the timer if a valid event is found (ex: stream
event for stream capable endpoints). If no valid event is found, the
timer expires after the programmed timeout value and a timeout
callback function registered would be called. This callback function
dequeues the request and re-queues it again, doing so makes the
controller restart the transfer, thus avoiding deadlocks.

This kind of behaviour is observed in dwc3 controller and expected
to be generic issue with other controllers supporting bulk streams.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v7:
	1. Added usb_ep_dequeue() & usb_ep_queue() logic into the timeout
	   handler as suggested by "Felipe Balbi"
	2. Created a usb_ep_queue_timeout() & __usb_ep_queue() functions

 Changes in v6:
	1. This patch is newly added in this series to add timer into udc/core.c
---
 drivers/usb/gadget/udc/core.c | 119 +++++++++++++++++++++++++++++++++++++-----
 include/linux/usb/gadget.h    |  16 ++++++
 2 files changed, 121 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 87d6b12..daeb9bf 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -52,6 +52,25 @@ static int udc_bind_to_driver(struct usb_udc *udc,
 /* ------------------------------------------------------------------------- */
 
 /**
+ * usb_request_timeout - callback function for endpoint stream timeout timer
+ * @arg: pointer to struct timer_list
+ *
+ * This function gets called only when bulk streams are enabled in the endpoint
+ * and only after req->req_timeout_timer has expired. This timer gets expired
+ * only when the gadget controller failed to find a valid stream event for this
+ * request. On timer expiry, this function dequeues the request and requeues it
+ * again to restart the transfer.
+ */
+static void usb_request_timeout(struct timer_list *arg)
+{
+	struct usb_request *req = from_timer(req, arg, req_timeout_timer);
+	struct usb_ep *ep = req->ep;
+
+	usb_ep_dequeue(ep, req);
+	usb_ep_queue_timeout(ep, req, GFP_ATOMIC, req->timeout_ms);
+}
+
+/**
  * usb_ep_set_maxpacket_limit - set maximum packet size limit for endpoint
  * @ep:the endpoint being configured
  * @maxpacket_limit:value of maximum packet size limit
@@ -190,6 +209,47 @@ void usb_ep_free_request(struct usb_ep *ep,
 EXPORT_SYMBOL_GPL(usb_ep_free_request);
 
 /**
+ * __usb_ep_queue - queues (submits) an I/O request to an endpoint.
+ * @ep:the endpoint associated with the request
+ * @req:the request being submitted
+ * @gfp_flags: GFP_* flags to use in case the lower level driver couldn't
+ *	pre-allocate all necessary memory with the request.
+ * @timeout: The timeout value in msecs used by the usb_request timer.
+ *
+ * This should only be called from usb_ep_queue() or usb_ep_queue_timeout().
+ * This function queues the requests to the controller driver and starts the
+ * timer if the timeout value is not zero.
+ */
+static int __usb_ep_queue(struct usb_ep *ep, struct usb_request *req,
+			  gfp_t gfp_flags, const unsigned int timeout)
+{
+	int ret = 0;
+
+	if (WARN_ON_ONCE(!ep->enabled && ep->address)) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
+	ret = ep->ops->queue(ep, req, gfp_flags);
+
+	if (timeout != 0) {
+		timer_setup(&req->req_timeout_timer, usb_request_timeout, 0);
+		req->req_timeout_timer.expires = jiffies +
+				msecs_to_jiffies(timeout);
+		mod_timer(&req->req_timeout_timer,
+			  req->req_timeout_timer.expires);
+		req->timeout_ms = timeout;
+	}
+
+	/* Assign the ep to req for future usage */
+	req->ep = ep;
+out:
+	trace_usb_ep_queue(ep, req, ret);
+
+	return ret;
+}
+
+/**
  * usb_ep_queue - queues (submits) an I/O request to an endpoint.
  * @ep:the endpoint associated with the request
  * @req:the request being submitted
@@ -260,23 +320,45 @@ EXPORT_SYMBOL_GPL(usb_ep_free_request);
 int usb_ep_queue(struct usb_ep *ep,
 			       struct usb_request *req, gfp_t gfp_flags)
 {
-	int ret = 0;
-
-	if (WARN_ON_ONCE(!ep->enabled && ep->address)) {
-		ret = -ESHUTDOWN;
-		goto out;
-	}
-
-	ret = ep->ops->queue(ep, req, gfp_flags);
-
-out:
-	trace_usb_ep_queue(ep, req, ret);
-
-	return ret;
+	return __usb_ep_queue(ep, req, gfp_flags, 0);
 }
 EXPORT_SYMBOL_GPL(usb_ep_queue);
 
 /**
+ * usb_ep_queue_timeout - queues (submits) an I/O request to an endpoint.
+ * @ep:the endpoint associated with the request
+ * @req:the request being submitted
+ * @gfp_flags: GFP_* flags to use in case the lower level driver couldn't
+ *	pre-allocate all necessary memory with the request.
+ * @timeout: The timeout value used by the timer present in usb_request.
+ *
+ * This functions starts the timer for the requests queued to the controller.
+ * This routine does the same as usb_ep_queue() but takes an extra timeout
+ * argument which is used for setting the timeout value for the timer. There
+ * can be some corner case where the endpoint may go out of sync with the host
+ * and enter into deadlock situation. To avoid such potential deadlocks a timer
+ * is started at the time of queuing the request. This timer should be stopped
+ * by the controller driver on valid conditions otherwise the timer gets
+ * timedout and the handler is called which handles the deadlock.
+ *
+ * For example, when streams are enabled the host and gadget can go out sync,the
+ * gadget may wait until the host issues prime transaction and the host may wait
+ * until gadget issues a ERDY. This behaviour may create a deadlock situation.
+ * To avoid such a deadlock, when request is queued to an endpoint, the timer
+ * present in usb_request is started. If a valid stream event is found the
+ * gadget driver stops the timer. If no valid stream event is found, the timer
+ * keeps running until expired and the timeout handler registered to the timer
+ * usb_request_timeout() gets called, which dequeues the request and requeues
+ * the request to avoid the deadlock condition.
+ */
+int usb_ep_queue_timeout(struct usb_ep *ep, struct usb_request *req,
+			 gfp_t gfp_flags, const unsigned int timeout)
+{
+	return __usb_ep_queue(ep, req, gfp_flags, timeout);
+}
+EXPORT_SYMBOL_GPL(usb_ep_queue_timeout);
+
+/**
  * usb_ep_dequeue - dequeues (cancels, unlinks) an I/O request from an endpoint
  * @ep:the endpoint associated with the request
  * @req:the request being canceled
@@ -291,6 +373,8 @@ EXPORT_SYMBOL_GPL(usb_ep_queue);
  * restrictions prevent drivers from supporting configuration changes,
  * even to configuration zero (a "chapter 9" requirement).
  *
+ * If a timer is started in usb_ep_queue(), it would be removed.
+ *
  * This routine may be called in interrupt context.
  */
 int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
@@ -300,6 +384,9 @@ int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 	ret = ep->ops->dequeue(ep, req);
 	trace_usb_ep_dequeue(ep, req, ret);
 
+	if (timer_pending(&req->req_timeout_timer))
+		del_timer(&req->req_timeout_timer);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_dequeue);
@@ -883,7 +970,8 @@ EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
  * Context: in_interrupt()
  *
  * This is called by device controller drivers in order to return the
- * completed request back to the gadget layer.
+ * completed request back to the gadget layer. If a timer is started
+ * in usb_ep_queue(), it would be removed.
  */
 void usb_gadget_giveback_request(struct usb_ep *ep,
 		struct usb_request *req)
@@ -891,6 +979,9 @@ void usb_gadget_giveback_request(struct usb_ep *ep,
 	if (likely(req->status == 0))
 		usb_led_activity(USB_LED_EVENT_GADGET);
 
+	if (timer_pending(&req->req_timeout_timer))
+		del_timer(&req->req_timeout_timer);
+
 	trace_usb_gadget_giveback_request(ep, req, 0);
 
 	req->complete(ep, req);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e5cd84a..5b2516b 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -61,6 +61,13 @@ struct usb_ep;
  *	invalidated by the error may first be dequeued.
  * @context: For use by the completion callback
  * @list: For use by the gadget driver.
+ * @req_timeout_timer: Some endpoints may go out of sync with host and
+ *	enter into deadlock. For example, stream capable endpoints may enter
+ *	into deadlock where the host waits on gadget to issue ERDY and gadget
+ *	waits for host to issue prime transaction. To avoid such deadlock this
+ *	timer is used.
+ * @timeout_ms: timeout value in msecs used by the req_timeout_timer.
+ * @ep: pointer to the endpoint for which this request is queued.
  * @status: Reports completion code, zero or a negative errno.
  *	Normally, faults block the transfer queue from advancing until
  *	the completion callback returns.
@@ -111,6 +118,9 @@ struct usb_request {
 					struct usb_request *req);
 	void			*context;
 	struct list_head	list;
+	unsigned		timeout_ms;
+	struct timer_list	req_timeout_timer;
+	struct usb_ep		*ep;
 
 	int			status;
 	unsigned		actual;
@@ -243,6 +253,8 @@ int usb_ep_disable(struct usb_ep *ep);
 struct usb_request *usb_ep_alloc_request(struct usb_ep *ep, gfp_t gfp_flags);
 void usb_ep_free_request(struct usb_ep *ep, struct usb_request *req);
 int usb_ep_queue(struct usb_ep *ep, struct usb_request *req, gfp_t gfp_flags);
+int usb_ep_queue_timeout(struct usb_ep *ep, struct usb_request *req,
+			 gfp_t gfp_flags, const unsigned int timeout);
 int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req);
 int usb_ep_set_halt(struct usb_ep *ep);
 int usb_ep_clear_halt(struct usb_ep *ep);
@@ -266,6 +278,10 @@ static inline void usb_ep_free_request(struct usb_ep *ep,
 static inline int usb_ep_queue(struct usb_ep *ep, struct usb_request *req,
 		gfp_t gfp_flags)
 { return 0; }
+static inline int usb_ep_queue_timeout(struct usb_ep *ep,
+				       struct usb_request *req, gfp_t gfp_flags,
+				       const unsigned int timeout)
+{ return 0; }
 static inline int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 { return 0; }
 static inline int usb_ep_set_halt(struct usb_ep *ep)
-- 
2.1.1

