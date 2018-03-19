Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480574-2-5425335271928222409
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480574; b=Zk3oAIXiFdFuNt9aVICohFosiH4Eo90qq5DLRPgQV7YsNjA
    2gdXzzt8iOTwBzu2GMMhnIrVNFl1qJuhuwzj6W1xiI3PA/3f+pWFePFRPo69/4SS
    0VBiZqjl6BNllUcKvQRy4zZaPZfJOFNYJY84fMNXDpmRE0IeqXA8hQBUN0RjcJq3
    DLJB7NeBv1WXzdkjlqSbs6xS43HBrV/cKPN5PTo/lAxNcW5+rxJfEBOMsZ2wNEhT
    xXdDppEJwTAw+x2k+GVZ+s1755GsMxz51MTqqH2G1gqJYOmWT+tYYEtfPjc8y+9F
    YWDwKk8/+CqDuhq8lbMiOFVtfcr0v792CoToI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480574; bh=3HcRms
    wF8u8fOMt1L7wlsJMg4cQUAW8p9Cy1udbwg3U=; b=UG34bj5u6RoGySSFyLRdxF
    bWOTbQGThshAG7uFnOwspQ0dnygkC/lVGuhK/DhQrE/+eTyS2X5Q0g8U8vOj/ndW
    ba/euqACVIAcsp51ilY8OgFVoEYnQAxSt2HdkGAdqcqeinnc2+KoLe2badp+3oJ8
    O/SCodHDA3q/K6ynnbQmB7oyyd3oReJ9GHJYuES8fRHf55lxJg6GqDKMq02gktpX
    SRiOKBjsW9HdRC1BSG2u7XP3mvPsWXGxfUdwrSX292FQQ46i9ra8dKBjqvSd5t1H
    E8R6OsqYh9sr9ZUj8FkyZmDNU+HgOB3kj4SAp4VuMuvTtuo+YqZ3Rc66TWUZvdGg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mWz2AILu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdegtdenucevlhhushhtvghrufhiiigvpeegie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mWz2AILu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdegtdenucevlhhushhtvghrufhiiigvpeegie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965749AbeCSR3P (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:29:15 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:54368
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966064AbeCSQHh (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 033/167] ARM: dts: imx53-qsrb: Pulldown PMIC
 IRQ pin
Thread-Topic: [PATCH AUTOSEL for 4.4 033/167] ARM: dts: imx53-qsrb: Pulldown
 PMIC IRQ pin
Thread-Index: AQHTv5wttCtRm6wq102WYAnuWyEKmQ==
Date: Mon, 19 Mar 2018 16:06:02 +0000
Message-ID: <20180319160513.16384-33-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:GXdkYhWA5kEmaMCwOhTQOAraVME5IqK21fBDGirNP2zLENRfQP6KXI6rKJBvTcfekVX4ncbLU3PR3saL8N2ItrFv1nzBpjULxUJ4V68UXFXi7+Rb/AlS8gAicq+pYHX+8lCXMNB8CkzO0cphTtA8tUWFlk/VFA4MhudYkkKnFFkHUAvb8phcX+ZSCIcT8PgEd5g1x2sjT1wmzHEH90Zt+/FwBXEPamOa3/s6HuKAdDB1iV59XCbt39JAA3LqqRwd;20:9ofBQNI/XMFvEhE3DwmvEU+JEE2KiK/L4DgyN6GzHe211l6hGPazyixnSKuc/kTG8TXE+WDnUaX3Pd2WRQ5eXoQvw27Md5Ox3n6bI4S4Iv2I7Y777IPm2W+kGmE3refUHjkyE+a+sbdm62VHfZ0rbbQtNZRwe8TnVjRTspai0Sk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99ed238c-da59-4072-1efb-08d58db38779
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09205DD267DC483919076164FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(8656006)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2UY9hrmBD3aVgC7lb4vm+zm396rViFiLvnVeQqEw/MoiPMYX9wSJ4ERX/FtBpZ7184hJzyBJhauQeAXenVCt20WW7BxaHcd9x7Ldvn/38VUmjeNcqGmO6QsjXGm1TpXzxmiO7ZJl66sKcUzT03diQCo+PUYsavYDz9K8lGtzh91kJ7p255SJIxVhe82wIYdHkBTyRRyQjoSCQCPE3Dj4r25N2Z349JzmKnpYQi/urU58Oh6NYxpzmtYKL0DVq4JZ4KFLbo0+iLka513ztFdWfejCLRsqKtDVA6v9vy8f63/b4LlN358ZjWlTMxRsg7EMfPKlM7XJDooC0dt1lMHYRw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ed238c-da59-4072-1efb-08d58db38779
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:02.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

[ Upstream commit 2fe4bff3516924a37e083e3211364abe59db1161 ]

Currently the following errors are seen:

[   14.015056] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.321093] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.411681] mc13xxx 0-0008: Failed to read IRQ status: -6
[   27.456281] mc13xxx 0-0008: Failed to read IRQ status: -6
[   30.527106] mc13xxx 0-0008: Failed to read IRQ status: -6
[   36.596900] mc13xxx 0-0008: Failed to read IRQ status: -6

Also when reading the interrupts via 'cat /proc/interrupts' the
PMIC GPIO interrupt counter does not stop increasing.

The reason for the storm of interrupts is that the PUS field of
register IOMUXC_SW_PAD_CTL_PAD_CSI0_DAT5 is currently configured as:
10 : 100k pullup

and the PMIC interrupt is being registered as IRQ_TYPE_LEVEL_HIGH type,
which is the correct type as per the MC34708 datasheet.

Use the default power on value for the IOMUX, which sets PUS field as:
00: 360k pull down

This prevents the spurious PMIC interrupts from happening.

Commit e1ffceb078c6 ("ARM: imx53: qsrb: fix PMIC interrupt level")
correctly described the irq type as IRQ_TYPE_LEVEL_HIGH, but
missed to update the IOMUX of the PMIC GPIO as pull down.

Fixes: e1ffceb078c6 ("ARM: imx53: qsrb: fix PMIC interrupt level")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/imx53-qsrb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsrb.dts b/arch/arm/boot/dts/imx53-qsr=
b.dts
index 96d7eede412e..036c9bd9bf75 100644
--- a/arch/arm/boot/dts/imx53-qsrb.dts
+++ b/arch/arm/boot/dts/imx53-qsrb.dts
@@ -23,7 +23,7 @@
 	imx53-qsrb {
 		pinctrl_pmic: pmicgrp {
 			fsl,pins =3D <
-				MX53_PAD_CSI0_DAT5__GPIO5_23	0x1e4 /* IRQ */
+				MX53_PAD_CSI0_DAT5__GPIO5_23	0x1c4 /* IRQ */
 			>;
 		};
 	};
--=20
2.14.1
