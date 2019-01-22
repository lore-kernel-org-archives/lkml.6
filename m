Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C87C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6AC21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="bz21cfK7";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LQ0Niqdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfAVKm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:42:58 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:33988 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727048AbfAVKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:42:56 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MAXmXR008383;
        Tue, 22 Jan 2019 02:42:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=V6De1Ab06ISbcaS3aBuUgTCU4bqfMXQoTXx3yAilPrk=;
 b=bz21cfK7JIeb3QxkJXogfwJtStiUVMo/vbMtSaCZHh8u1xVprM9svkhYS94sT04s/LaP
 0o67lAHigf9Po8v+O4K24cOIyJRX6TS3K/GH0QkCZ0DnlLYFapc4iMGMJSxnFlHngx7o
 6YZ2/AMbaJc3ScxC8pI3yk55ODYP+smqasV1CdYaNyCXq2lmfvu8WmQaUk8IsZLjE+7/
 jq63Qe00GUxNKrM7TdiSrTqjOv+mdGsxgjXRkQFOVBrS6HPCxOvbD4XlJ7H7lqCeGLCf
 MfhQYzEFyVW+v3Gwb79N2L72ypmUBytdYviZunsPnS4ZXa2HLUhmVW7XP3eK3WJ/zPVc /Q== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2052.outbound.protection.outlook.com [104.47.44.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2q40bxbfwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jan 2019 02:42:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6De1Ab06ISbcaS3aBuUgTCU4bqfMXQoTXx3yAilPrk=;
 b=LQ0Niqdnah/SQ6g9CNSTqSe76cDc3lYOS8TDkLyHyzb+gL3kdTYQxU0OnyrueEm5WjgTi2P/5GSYE3TIk5oy7QnINS3pCYs9XBE/nOVNK0E3fFLFz64mw7wxswls+VFXwu8mKMEp/cJEpVKXfLV5KxAZvqv1NuAgIJ2pZkVKIjc=
Received: from DM5PR07CA0102.namprd07.prod.outlook.com (2603:10b6:4:ae::31) by
 MWHPR0701MB3722.namprd07.prod.outlook.com (2603:10b6:301:7e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.27; Tue, 22 Jan
 2019 10:42:26 +0000
Received: from DM3NAM05FT056.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by DM5PR07CA0102.outlook.office365.com
 (2603:10b6:4:ae::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1537.28 via Frontend
 Transport; Tue, 22 Jan 2019 10:42:26 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT056.mail.protection.outlook.com (10.152.98.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Tue, 22 Jan 2019 10:42:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0MAgKxJ031105
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 22 Jan 2019 05:42:24 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 22 Jan 2019 11:42:20 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 22 Jan 2019 11:42:20 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x0MAgKWp012270;
        Tue, 22 Jan 2019 10:42:20 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x0MAgKhI012257;
        Tue, 22 Jan 2019 10:42:20 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH v3 1/2] dt-bindings: rtc: Add bindings for Cadence RTC
Date:   Tue, 22 Jan 2019 10:42:15 +0000
Message-ID: <20190122104216.12077-2-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190122104216.12077-1-jank@cadence.com>
References: <20190122104216.12077-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39850400004)(346002)(396003)(376002)(2980300002)(36092001)(199004)(189003)(86362001)(36756003)(51416003)(53936002)(186003)(26005)(446003)(11346002)(69596002)(336012)(2616005)(305945005)(106466001)(426003)(76176011)(105596002)(486006)(4326008)(8936002)(476003)(50226002)(126002)(81156014)(8676002)(107886003)(81166006)(68736007)(1076003)(50466002)(356004)(47776003)(6666004)(316002)(48376002)(26826003)(16586007)(42186006)(110136005)(87636003)(97736004)(2906002)(54906003)(478600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3722;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT056;1:dQxiClGPKSF+s6V76HSNAkrDI7mCu+8QIGz0I3EbWektlvGE7UOBf2kH9EYEl+V7himJGMTfJ1GdMQqJpI9+u/jmkPUVQoxU2/+IKG9BrC6O3fmEsOdF9xUHiLJ9bD0dOQt+GCc84ee/A1jstNa0xVzNwD/1vBPZUSOmEgI0X4A=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 123852c1-24d0-4672-891c-08d680564c9e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060);SRVR:MWHPR0701MB3722;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3722;3:rUgYPJMGtE8ROFFyhab2tlavxN+YnJ2Pdks9zwTF30Ygxmqj0lJvItF+oKJDEG9S4kNjqfgGlFfmRSY6hmySTTR/jUre+j+jJBAyVWu7ELKGr8p12hgRjHGUdl0DhRVHA2e+sFJYXe9B5R6SSjDC1kuCC/LxKSSzfQ6zLNuJ3bIGN9g+Ihcg+VDQtgGm5paHRfrlj3NSCOaOzfR6S9BZsXimNuh92qgZbk6TFRfjxiSBGTTYPjm/WdFXSdu3ORU5FLZTrdmFbeu29fJaCgE1IquNIGW/ZZGxnIF5SEC/gyw21jmH5pFC45gMzsu52xzedct+D4TPcDAiFOYZzyyHjU4w2XVwNasdxDNXdtt+GXnLMqxhQb4cYSpenOpnHeY9;25:E8z1vrOC7AzX1FjtKO+Kx4aq3tBMKvTjKjdpGxryzO9A0WFJtjsK7I5vjZtcz08cdTAempCHHehZVxuZQ6Epe38S/nQYxTJBYKNTx4LZv5oZIKcuCV4p5lYij4JGCOSucgAzw+lbp1I0EVxc65HfPo7TRr+opoodDKDCK9xvd50mvaeXSF8vyvpoxCxDeAgIkBi57nnvWl3gG0G9kuMLtO9TE8gFJt8/Wt67tuMy88qMgqJ1D/Eg4uuDTdMcBoElJF6/ikFggNZiJyIyzOMgAVe4Z0w7LQ4kYgLVuiBG1retUMqQpoQHCEntQLLrJgCRLYpN42xYDx9aufpQxSIjjw==
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3722:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3722;31:1boGVoCP2C2eblnCmsN2mRBEGlFxbaIBpiIumLPWh4Eg3f4/QYT+qQiSHRz7X6ZBHsh2RBXhCxurnejVMBbaAE9VJ1mT3f1S6z9lfn4f0V5bGwtuVneoXtqf9TM7DD72lRx9dE+LtfX7gzVJyNpxUfr1ZxX40E37TzUqaE10tg2hDUz7a1fzb7YhND6wuD5SGObWggQjVF334TjjDGs3fXXA02tqKzYjN1pajwtn9Nk=;20:wAx7hsiCSPO0DfrKhU1DHzQqtbfSyFeu0qwtW2ADN8YLVT1NvQd4Vq2kGRfmmjsztLxbQRUDF2P18wl7a78MuIpWlpRgpJhKjMiXmh5z/891ICA+ejtfemFKyGk3c2DlUJeHe0ptJgF1ZVjjWE3+KMIaClrxj4nqA0Qbct2M0N+GftvTPDeLeuARHqq/1gkvGjHKosX8cqdZor0HJ6XAweWnCETJLezrnammz3/CEIoWbTuDO64dJNlxj//KNiYuMpFWtznbXUiS/J1POimf7ybWHnhF2xxdBvDmSChwUGjiacZLfa73CRmiX1dwcmYO5pSvtuaOj7rN5Xx+24whZIYPvgKZResYhYKv7Db554ANTxpzcw5jVY2yfzL3zSx+1cUPgOY4577oEuJH2y6WnC+QOsq4zfLCC7rnauZdi6lh3pzA6blSqsaY8N7quIY9k/t7mtAgqMp50covNDjtMsN+34iOms90yExkVCrXhFP/xKkkd+O+/eBxuQW/W8TU
X-Microsoft-Antispam-PRVS: <MWHPR0701MB37224956CC4599B5EE4591AED0980@MWHPR0701MB3722.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3722;4:o73Gdt4r78xm0Xy5a8IcXqzFLpvrw1DbTml9k0wWJLoLtkHFqZUSdtJt2Iuc3gPs54WiIkPPIYAfU20vfAe73XKDsK/YhtQMw6FlAEhiqmCrAbdZxYASIMbNLqzCVcjbvMSPHJPXDu04O9ty46yIGs6xG+sqMS+Nq5zGNirUMHbGNY2yZNgaX4KItwL2MnhYHob4njQMxRUvlcbUYmKDUO4UJOXzs6GmjiUdHbSshI3hfLqFoGRVu2yg9E3gMRO5FwSGvzkSeK8X/+7srZm+omz+qSCF6NE3Hya3hthzhRCawkEha4Y3B3AIlOk+1BAj
X-Forefront-PRVS: 0925081676
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3722;23:jBb2mb+TTWKFDOYvHIf7E4sqwFmfmEBYkrU/Ftf?=
 =?us-ascii?Q?oMHMM1SixA6XCPJp/whiJQSWKwwjwJfCTINjGK2qyJaOBvzonUfHHUXwTi6y?=
 =?us-ascii?Q?PC2HD9y8y0Sc57N3XyQSA155klLq1PR2jMin++rXuLtYJLPyi2EEZcf4aGlm?=
 =?us-ascii?Q?wqiHhvrJ9QTzJeqo5WfeMLfMp8xqlULfLJtDmH4kBGO3b9NWoby5iOKPXw1y?=
 =?us-ascii?Q?4k+27msYhJr9ggmkq1LPUrmhYDzmWUd46BC2XUqtimJycppJUy6EM//m+cFn?=
 =?us-ascii?Q?Id4zlVaRxMDRpxxHFmuW/EoOBKCzkjiqkhgFLwMISNK60MRdawNgsVFORVh0?=
 =?us-ascii?Q?FOBY1bEyKTnrHEwSs9od9C4PR5KOMtskuvFJX3du41tQM3evBbmC9gsKQj1U?=
 =?us-ascii?Q?dcTXzz0usOQzHBfH86uZL2xpVp5O7U9jzwO2Y07DP9eB/vKlbr+M0NdOhQKa?=
 =?us-ascii?Q?DQuhuRZ1QKSp5PM0fOlH4HlptTvEALpZ0I4lianLVi0Gs+bkJUHGjlXC5mak?=
 =?us-ascii?Q?fYnj8ztrx55aOdttypF8pYLBocZX8nzJIB/48lXuTQgH5YGyptTT1lcxXe11?=
 =?us-ascii?Q?dumbOSVkDCyRJj67POnCrbOo3Xh+AErwALtOczpb4oBeK15R1HdpxWKtD5EO?=
 =?us-ascii?Q?zc95lUY3GRas7LwI5mNlq02FOSWHJksrLPtTltzUL66S0zTh6nrR47/nU5pX?=
 =?us-ascii?Q?UxOdoWb42X9yCGpMZ/d91dOqpifHd0JoO8iC6QhoHYEXuTHomg4fjgsMuele?=
 =?us-ascii?Q?8sMHTYjYIX+kN8nqfgNOFiRXMyHsDUAykveYwGVlah7AD7kN0s0+3gnaljPz?=
 =?us-ascii?Q?ym/magkp3qYsL9R3cPjxEohuo9odOu8CXjz38IPGt+bTpiM9IyuszYPugl6y?=
 =?us-ascii?Q?3UXZapgY2K2fYjzrs3Kp1QBq5gBD+X0mpNbywiZrn/SdLR2kjE+9s1I41aEG?=
 =?us-ascii?Q?66RM7Auzu4qq/tyHBTm32+TUdlgi6WBJzQN9GDR3Zz009YMqZBILwOJ5a8Xp?=
 =?us-ascii?Q?35vjoKq5d7YozbbpmIMh1bL+co0+KlsqgFNDc7bVTvCfCFuEnwG8ErNS1ycP?=
 =?us-ascii?Q?TQUkx3SH2EZA/F+l4w/h+LV+1h/+wR45hQb458m1o9p5De7qLfgJ6X3cMzV1?=
 =?us-ascii?Q?vnK7XFZsdiAUI6XlfzhHlvpfNFAiixJMuBlJPBYFd5cQSTEee6sye+S0uzsE?=
 =?us-ascii?Q?Df+srryPf+c1sf2A=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KbDvp4OYuQ4lV12CEEuvQfgubo7tmeJX4VIdvwWLb+/498qrYjq8jUCucIZhzS0GskN0bQtGWN85TSZuCq/yL5Yotw47n7sOOizasEHIdZp8xd1vjuLicQ93z62pRtK6+RCyaRiBCnsqT8yDpZsdv/2R76SEcuafG2E8xz7otSB1FqRt2qXQKg1366oUOpAbVEIgwpYMQ3VoWOawmg9kHDBCPJSjP6zymKndSjmwOkchaXkul40fwM5n8+r9SbyqRVCuwkcwt0jm6f39JBObdu1x2cOm54aQLjQR+pwWW9o0PpT6gJCHLkyM2So8JUyReif4rDdQwPfqP3hp74lspyzOmWgCsxayNnlhHHyLYl4tT43PTVw51EsYezd8XEyb/M+U13GRpzKQwi40aGHwlXyEFCEPERhBBGpVkqWGgas=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3722;6:bm1grTJc8ZyceKN8KhO4FpMnI/2QnsJ7TdrEc+xKZqlASfG+NG015Dj7/H2tx+qVT41l+uQuArCUq5yCJvZ3hl66JsgYwspEyWz60P5+kcraM56/MQRXN3LixG5rNk04UEgCm4dGzpkMejBAPXDXmC++6kWWdBWrvvkQngaWjHYd0QL77HLnDxdeDGI+FX4jyNzu+xjZ3gDT9X03P/+Yf08Kxowty5P0RN9+sjWhx9wMf9fvSSA7bRjtyuAfwSMfDhflQCewxhYMcvEp+NGzcgMfbeGog3BpzLNJL0tdIaA/rQcsDYVwQAY4+U7WOZ9pGNYnJAfqE77HM9MTTI0HzHJJkvkea2/E36LOOxWKI4ST4fDq6g1rxxLjuzm3nxsU7OTiwPTWXFq2eEDMWKEEb9VPJAckExrVsS8qWFbYByPHKhHFn8ipcP5Ro0DMHvd7Rwg9eWt0XjQxQ97+i7kzLA==;5:EgSqfw1FGKlUpHcF5mpLOgGSH79Iv6N8Zi2cgZeDhPTC0/Kyyal3xJtpr+91nBXCbsdovvSyycVtjoHQFcnm9TdIKVoslPDbBn56G8VuHBcu8B4dlT0tTCILgFUEue9s7OvlPGIBvDY18EhkuBq1XW7eUaZWB9VkmaPXun/3TZ360I8XLYfTnTVLEkMtpL6nxzIt0dQQGqOP9NTMuekFkA==;7:C6SHZkrrvSdhGmCT9bK5UKy7xE2I6aGLtHB1g/r10bEkzyBH29tQQREWH4M3PcIyDC0PBq4uxMGEn10Iz2C9y6qkfK4L6L5zC+ujQIR1QemSU3of5q5UCLixr5ZGI2f88e6vhCEtKEEexbYRSDfAqg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3722;20:8DlWQtsTeE9NfMt0GZedDH7R1p32X+TM877VQqEU+wPBA+9ZVGypzjpveOjkgAuGe+k5oO1b21B5R0uIBe5a8wfsIwAnGuXpSBdHOC0qiWK4lCNECvCkUglbxuxjjXY5YiB/V27tGVallQIeYzDhrPiDdbqPlv75jb9IyQd4MJgpco846Px9jC+U3K9PorYI5uJQ5Ng3izjzvY9TNvuW2ca3M+W4Thu985cFBsvPPmohe/ioMjgynx2PBM8QAUUR
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2019 10:42:25.6251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123852c1-24d0-4672-891c-08d680564c9e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3722
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=650 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a DT binding documentation for
Cadence RTC controller.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 Documentation/devicetree/bindings/rtc/cdns,rtc.txt | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/cdns,rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/cdns,rtc.txt b/Documentation/devicetree/bindings/rtc/cdns,rtc.txt
new file mode 100644
index 000000000..14a04487b
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/cdns,rtc.txt
@@ -0,0 +1,25 @@
+Cadence Real Time Clock
+
+The Cadence RTC controller with date, time and alarm capabilities.
+The alarm may wake the system from low-power state.
+
+Required properties:
+- compatible: Should be "cdns,rtc-r109v3"
+- reg: Specifies base physical address and size of the register area.
+- interrupts: A single interrupt specifier.
+- clocks: Must contain two entries:
+	- pclk: APB registers clock
+	- ref_clk: reference 1Hz or 100Hz clock, depending on IP configuration
+	See ../clocks/clock-bindings.txt for details.
+
+Example:
+        rtc0: rtc@fd080000 {
+        	compatible = "cdns,rtc-r109v3";
+        	reg = <0xfd080000 0x1000>;
+
+        	clock-names = "pclk", "ref_clk";
+        	clocks = <&sysclock>, <&refclock>;
+
+        	interrupt-parent = <&gic>;
+        	interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+        };
-- 
2.15.0

