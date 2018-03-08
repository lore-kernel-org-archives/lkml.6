Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491889-2-8376286998897469694
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
    t=1520491888; b=rmkoqe2mFJObpwFukkM5uDoPRndxDcxE3t645ID58GRXBlE
    NMr3X+WaTHMcEl/aD4kCjN1rCiljRmIuaa3l5U85jkzUQR+bzZ/W/CIDWU64sG89
    wYCUt2R/E/e/bfxOfyTqCM1f5ZU2RxA/tpIfOTK1Zxr+FeYlZUoLsT0Wc7xEaLB0
    oF9VxMEQ0Q4m+C//K7QQcbHb8hCemjRmQR/8Rhz0boGYYxPFO0SkytQSj2cBYIw6
    R8ehXOj2r729nW4k+rTfLm0eNbxYgCb5A9SbBxIfAb7uu7kUXKLXDz2wkWJWq5mZ
    hDJbXOd7BwTMJ4xFxqGfQWAwLUqVlmoy54ZBi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491888; bh=OSgQk3
    DqvpXaVcvRnmL+b7qh1J6onKOavw/GISZAzz4=; b=Hcp8o7zIcE8xVoWZmf5PYJ
    cTCAdaGx/FDfgKQpEsjWRUp1yOTUprLo19b/NGJM+TZY7Ua9eu7SSgXtmyzueDEl
    +sqAS2sLrAghLrgva/cmgClqGH4ncZikFpthY+Y/Z18cLptTk4Jhg4vXOWUVGdee
    jJu7H2wrLpF9s/hcADTdy+LgF0v7xDYb8dCqsyEbWPMjI4Yw+4F4GOqCvvUC752L
    2KuoAClIYItulfC7C/a+ziNN01jdgojDrQ+yUwoJZpWTJOPLvZyrCM4eXKJLXFiQ
    S6NtNlSy+bbNN1CLoX9uBzP1K09DlVEHtSMqZwBEpxNJbrZnfUXK+ypWOA4a7TUw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jFxZsrnp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jFxZsrnp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935223AbeCHGvZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:51:25 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965003AbeCHE6I (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Joel Stanley <joel@jms.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 70/78] ARM: dts: aspeed-evb: Add unit name to
 memory node
Thread-Topic: [PATCH AUTOSEL for 4.15 70/78] ARM: dts: aspeed-evb: Add unit
 name to memory node
Thread-Index: AQHTtpnTBGEtSkL+CEKgUp8G3Y+JNg==
Date: Thu, 8 Mar 2018 04:56:32 +0000
Message-ID: <20180308045525.7662-70-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:4ag+1S1ikIGpHYWwS6FftlXP8JlO6yPyitxgD1eBTXVY9hF3nOPfaw2+UH6vFHwsrUc2vT6a42eeX3owaC7X575FE/JNm0+HhgRFMneHJySkTFUkGhZFGrYj7VY5SfkV4Icp7e6NyXCS3csSv6GJzh/oBcQH1E9ZR8uHWs1xNeOW5flPH/Tho3F8e1d6WFtHavHm6/N4Y9sGTKCoWfeNUSZWSoahE5qzK7UeYCU7msZaZVLxustD19w51elfdAiy;20:m0AMHJlkLlOJpifir3/inK/yN5vHz5Y/RzK0TvlCFuxcZP5MnupLwCUArSFzaCyKJPMxQnPkV4Bj4lBnN2Ms1QJjHGKoIYsZ06lGSR7+Ru1b0FG8SW6lVIPgGh1A0F+PFBD3pyyh3+xcLb+yzsjOYfXb5CvLbXjpts+z2zvfdKQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6faf3851-67d2-4c0e-bb0b-08d584b1290a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0888211C5E3C515C65ED4D9CFBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(59450400001)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 2PF4T4G6qprNTS2LkNsZZ6WiD6oyA/uGG8YpzsW0F93ACx0tELVJsgyCr2OyPEfhOaovGgSJUc17PnEcFQJDCX3LUw06hUthK7YCMQBmasA8LtcZvEJ5jEritsagtCouvHONzUVFIkzGnzDM72ytdDBPMUYK8Btfsq/jNvse5sqkwzEGrK2B8kcqTrtonYnANAkr0zOIVOAu3aDKFKWfd/PRYDRyDV9knpaiH+LM3VOY7ZVKzqU+KZ1thOgMJSzxrg/lPildwsUFBjOVpFqV6VpwcYb7CLUAalYUq+FP+i8RNYyYQhACoHeyTez07AXg4dONTvK38DNSxJRl910r7w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faf3851-67d2-4c0e-bb0b-08d584b1290a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:32.5496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joel Stanley <joel@jms.id.au>

[ Upstream commit e40ed274489a5f516da120186578eb379b452ac6 ]

Fixes a warning when building with W=3D1.

All of the ASPEED device trees build without warnings now.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/a=
speed-ast2500-evb.dts
index 602bc10fdaf4..7472ed355d4b 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -16,7 +16,7 @@
 		bootargs =3D "console=3DttyS4,115200 earlyprintk";
 	};
=20
-	memory {
+	memory@80000000 {
 		reg =3D <0x80000000 0x20000000>;
 	};
 };
--=20
2.14.1
