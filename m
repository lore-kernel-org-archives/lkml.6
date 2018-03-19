Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521477933-2-1146442879004396881
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477932; b=pWPdHgx2+pCgUhYY2h0ntCzT9kHYfd/yrohLskUw2Yn7WIB
    SN+skQP/e8HnDap5iL/I8xkiggGAu4IE8M2Y3FGCUVSkVHKIqd3krOV8kTlNnQRf
    4nNKu71iC9l6RimimSyQQ5oeaZwkFlSwJzJGO42BdsUhPwGnfrMqRZnW1ZnYK1Go
    zdq00zCK1V4+gCx04DccyPIvYO3ZR7cAuc92LQigWMvoZov1ypmP0t2k1LPMcaZ7
    BtRmpYrUsylaZ4qHF9EhICtT0rwxDnDz+2rLVQFcBgELgqqR3X00MfHPSW0LarXW
    YIWkodEOSaRVj1POW7Fk40VrzZKcM2PzO6kgWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477932; bh=A3Z3Te
    3srpi3kt4x+ZARtMafrgZsnim5bXAqGqq8nlU=; b=S3iEFG0epheuk9DUL3/eNG
    +8q1yKmb4ae7kJt2bmMocaDFl260rHLdRVEw48ps+KmzVOR4QVno+7csW9Ik17Db
    WJusXjXc8H8iGcJSMbNTJBY2Fa0FBABm92HIvbeQUnSZl3edfUtH0tZPcfzRhcOM
    tyePp6LdpT2F9E/p9iJ7y7iBl6mO431n4xrlDfce8ST0zObspN7/kxcNN739p1SE
    VAbXvCplSryBvM885c4gARyDzC6SSNgZkZiVrCBaSrh81VcZRWAIlxybFzGVtlZn
    KtY/GcQfTaIUdbbq0aL8NLl37BBQCet1RH/18v0l2OMeAfuZeKF64nv0USXnFcgw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h9ni0jCb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeekfeehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h9ni0jCb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeekfeehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966999AbeCSQpK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:45:10 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:30227
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935162AbeCSQMR (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jisheng Zhang <jszhang@marvell.com>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 029/102] usb: chipidea: properly handle host
 or gadget initialization failure
Thread-Topic: [PATCH AUTOSEL for 3.18 029/102] usb: chipidea: properly handle
 host or gadget initialization failure
Thread-Index: AQHTv50ESpuzRjmvTkaubIaUmI+Jaw==
Date: Mon, 19 Mar 2018 16:12:03 +0000
Message-ID: <20180319161117.17833-29-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:y0S8aXcG4l9WO2seHOhtQLSWwxuS7UBVC0ISNnKzFjsEAvVaxa3hOUZuN8QntSHUUOrQcBVDRRA9wYh0JyHnKWG9YXdqYpjqMv415OYmDy7cI774gNZJfmdbjNgtglPBG0TMuo0XsWqgKO9BvxJPWJZp9EWJxLxU4e8PaMc2Q90oN8a93nfBii/i+I99IG+BL4hkPwSFr84yD5tWdOik3su03jStg1feAq59AtSKVECzYMKEnha0WByGR4SlUzoe;20:C/0oJ+l+IYbcz5vLkuu36ZlqBiD2j/7OxDIlMdEtRMMwCP0u2Aw/J/XV0Er3uCAFHeVkk93wpe2HJZPyQ6BMtfzG2rwzbHZx+XTL+qCbmngREcfI8YIFffSFJfhHVtiBxBog5yXj8pOfzEM2PFgr03u2adgRlJlFynLMLKZO1gs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31cf45c3-1b64-4e81-684f-08d58db42a4a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09200D4AC8EC2C9707D88D2FFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(8656006)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SF0pFSOKLJp/7tT3BBv2T6pOjdypEyQckKOU0umdIddx3Wciy2M4Hhx4H4gO/x46pgoXspDIyXtpK+UK8YOGCR2yegQTjGhTPYG59NPJy/kfSan/6aX8HUOtLHImlvWXkB30hIpArDGf9BWTV0EFo7wCgeVWJQiYpas5KhVlAo5NmPtJrNR1XrpGX7NAm+q4NiYylQxmzG24Eee2Xu14fGgAc0KQjtIM+v2Pg8roGke65RW5Oe6F3E0YlaK3CymzCWcE659Flp6btvKYr8KYW/7PtXz+Wj3YenLxjxkJQ2kHxrMyAduWJ6UkCljvvkGXbQtAl9Mkbu5hahD9EfpIBg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cf45c3-1b64-4e81-684f-08d58db42a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:03.5987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jisheng Zhang <jszhang@marvell.com>

[ Upstream commit c4a0bbbdb7f6e3c37fa6deb3ef28c5ed99da6175 ]

If ci_hdrc_host_init() or ci_hdrc_gadget_init() returns error and the
error !=3D -ENXIO, as Peter pointed out, "it stands for initialization
for host or gadget has failed", so we'd better return failure rather
continue.

And before destroying the otg, i.e ci_hdrc_otg_destroy(ci), we should
also check ci->roles[CI_ROLE_GADGET].

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/chipidea/core.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 78f4d70db917..4a8934abdac8 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -553,7 +553,7 @@ static inline void ci_role_destroy(struct ci_hdrc *ci)
 {
 	ci_hdrc_gadget_destroy(ci);
 	ci_hdrc_host_destroy(ci);
-	if (ci->is_otg)
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
 		ci_hdrc_otg_destroy(ci);
 }
=20
@@ -653,20 +653,28 @@ static int ci_hdrc_probe(struct platform_device *pdev=
)
 	/* initialize role(s) before the interrupt is requested */
 	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_HOST) {
 		ret =3D ci_hdrc_host_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support host\n");
+		if (ret) {
+			if (ret =3D=3D -ENXIO)
+				dev_info(dev, "doesn't support host\n");
+			else
+				goto deinit_phy;
+		}
 	}
=20
 	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_PERIPHER=
AL) {
 		ret =3D ci_hdrc_gadget_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support gadget\n");
+		if (ret) {
+			if (ret =3D=3D -ENXIO)
+				dev_info(dev, "doesn't support gadget\n");
+			else
+				goto deinit_host;
+		}
 	}
=20
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
 		ret =3D -ENODEV;
-		goto deinit_phy;
+		goto deinit_gadget;
 	}
=20
 	if (ci->is_otg && ci->roles[CI_ROLE_GADGET]) {
@@ -676,7 +684,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		ret =3D ci_hdrc_otg_init(ci);
 		if (ret) {
 			dev_err(dev, "init otg fails, ret =3D %d\n", ret);
-			goto stop;
+			goto deinit_gadget;
 		}
 	}
=20
@@ -727,7 +735,12 @@ static int ci_hdrc_probe(struct platform_device *pdev)
=20
 	free_irq(ci->irq, ci);
 stop:
-	ci_role_destroy(ci);
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
+		ci_hdrc_otg_destroy(ci);
+deinit_gadget:
+	ci_hdrc_gadget_destroy(ci);
+deinit_host:
+	ci_hdrc_host_destroy(ci);
 deinit_phy:
 	usb_phy_shutdown(ci->transceiver);
=20
--=20
2.14.1
