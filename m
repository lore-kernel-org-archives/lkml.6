Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B97CC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEAE20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="cMgyv2gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEAE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbeLMEuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:50:02 -0500
Received: from mail-eopbgr1410123.outbound.protection.outlook.com ([40.107.141.123]:37088
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728767AbeLMEuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdhfWootP1oOzYxEyQIrMlzYKXyVnLoFgei/3fFqdVA=;
 b=cMgyv2ghxMLLiXWXNrgOD8X3g9Yb+B3BaIJrzwhzIuAGpHS/bbqQvkFLuvWD4HTmXTJ87qT/E6Qppg8wgREQThFBT2J40NtNe1+fNO/rPZ4ue83t6DGdgclghZ1/kX+rXkUMcetzrYSV9oUT3QCWJq3/VdRCr8HFfwqTD8V+JeU=
Received: from OSAPR01MB2290.jpnprd01.prod.outlook.com (52.134.238.13) by
 OSAPR01MB1460.jpnprd01.prod.outlook.com (52.134.229.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Thu, 13 Dec 2018 04:49:56 +0000
Received: from OSAPR01MB2290.jpnprd01.prod.outlook.com
 ([fe80::a8ae:bee4:d7e7:e5b7]) by OSAPR01MB2290.jpnprd01.prod.outlook.com
 ([fe80::a8ae:bee4:d7e7:e5b7%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 04:49:56 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH AUTOSEL 4.14 25/41] net: phy: Fix not to call phy_resume()
 if PHY is not attached
Thread-Topic: [PATCH AUTOSEL 4.14 25/41] net: phy: Fix not to call
 phy_resume() if PHY is not attached
Thread-Index: AQHUkpy8B9VI65svRkKazq8Q08b4RqV8GPgg
Date:   Thu, 13 Dec 2018 04:49:56 +0000
Message-ID: <OSAPR01MB2290611D34DAE2774FD72C5FD8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
References: <20181213043054.75891-1-sashal@kernel.org>
 <20181213043054.75891-25-sashal@kernel.org>
In-Reply-To: <20181213043054.75891-25-sashal@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.140]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSAPR01MB1460;20:vQG0Cb4TY9IfHxmKdxM8VBtj/hHmufMypbMB/kZpyrHPEPn/p62hXiYckHRZyBQfAd17xILP7jc8Oj0yZOnAPqjvZOFL4yQcIVs41hA95kmt3tgUJ9NFGZXNX3JoBZwUwgjMtb6qjO09yazVHDNM4H1SFAuiUMCK6iKnqhUm2+k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9d9481f6-cd63-4860-1126-08d660b66e26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSAPR01MB1460;
x-ms-traffictypediagnostic: OSAPR01MB1460:
x-microsoft-antispam-prvs: <OSAPR01MB146080E203D7DAD2045C5022D8A00@OSAPR01MB1460.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:OSAPR01MB1460;BCL:0;PCL:0;RULEID:;SRVR:OSAPR01MB1460;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(346002)(396003)(366004)(189003)(199004)(186003)(6116002)(6246003)(6306002)(229853002)(2906002)(45080400002)(6436002)(14454004)(478600001)(966005)(86362001)(3846002)(81166006)(8676002)(105586002)(575784001)(2501003)(8936002)(33656002)(81156014)(97736004)(2201001)(25786009)(11346002)(68736007)(110136005)(26005)(54906003)(71200400001)(4326008)(446003)(99286004)(102836004)(7736002)(486006)(316002)(7696005)(74316002)(5660300001)(76176011)(476003)(6506007)(305945005)(66066001)(71190400001)(9686003)(53936002)(106356001)(217873002)(256004)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB1460;H:OSAPR01MB2290.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dcx5ef5hjG0X8dok2JNe7wcZ8V5DDvs999hYRL8EuXFrpBKDPj79N2nw8BxTpzUNQVXmafca0peUSsv2lZH9MmiudAn0c99u2inJYUYvedIoE8BLnDB7KrH4A3+hKvoI8gy0/qHive27HQyq/hyoKkDGJ/RR+8QErmkZ7mMtj1UIl1VgPWPRWg3IdqeixTA9/qO1y0PjFS4Kc5wvaMt8Nz0UoFzUA5cV/xVvAZR0dv3Ql4q6qBTd+WSr1Uy6ItSNlTa+L1aeTtd9v635ZKkvm4cMBbo8UtFy0H74Z1ApSyL7ALs2gY9lSdfWPAsO+NVY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9481f6-cd63-4860-1126-08d660b66e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 04:49:56.5254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Sasha Levin, Sent: Thursday, December 13, 2018 1:31 PM
>=20
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> [ Upstream commit ef1b5bf506b1f0ee3edc98533e1f3ecb105eb46a ]

This upstream commit is also reverted on mainline
as I mentioned other email thread [1]. So, we should not backport this patc=
h.

[1]
https://lore.kernel.org/lkml/OSAPR01MB2290FE36AF50B2F29170383DD8A00@OSAPR01=
MB2290.jpnprd01.prod.outlook.com/T/#u

Best regards,
Yoshihiro Shimoda

