Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476104-2-5057109602616205886
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
    t=1521476104; b=WVVib/eMUXbHMsj+dUBbOO3x9eQJwoqtuS6glA7xIBY1+0V
    Ssten2Y5gUOV6TA55jZ+YpW3OIMjBvpEWV9N20YdWWTKdtrmU+KeoZBtx/RPrjlt
    YiphTkT2dzd5QZtEBKRKRx9/qompJVLky2K6mh7Sx4nVVFYbhayC0evwNQd8zgmo
    /mo84bx6QSxSdui5iCKGJrOIMgYFq4vik4kCGps0mVr9C13jX0iqzkepl0MoTBKd
    aOYCzZBksNW8PXqZbTozww/DZg6/4Hn7QqRqMxm35Dsutktda3fKMeKxELEnxEB4
    7jY7DIasFJhMYg52i7w9QT43THWU4aCyohUR/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476104; bh=DUzFcA
    Cmi5R0bzdJrNescKZxqw5kq8b2Baheh8F0CM4=; b=dW4dH1laFrlY2gCLLF56g4
    HYu3aaJJAOjnIexNEaWf1BZHU0aSurrKpgrkNCk9znqfH1S76JeIl2uMh86VKwJY
    PCu6cLuwgdZLAzttjoHtTBcfqgHFZJyU1tT9SKR2Lk2KWQIW29zw2dB6lgRNvaak
    PiRNay/TX4rDcedw9o+3HYY4yblTN/CwWjGzapnb9krg01nBmvXFbZIPnLohr4HE
    qAru1pH9t4yBHqJzDcH2Mtr7D5XNcuWxTaU6182HG1M2FE3IS6l8ybW2FFtGX8cx
    B/cyOcKkNqeyNTsb+AFo2bAQ7kozpJFh48Q+ULqNXvYiYPQDW3l4LiRD6kaTWK2A
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DJ6IOYDZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedtfeenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DJ6IOYDZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedtfeenucevlhhushhtvghrufhiiigvpedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967033AbeCSQPA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:15:00 -0400
Received: from mail-dm3nam03on0129.outbound.protection.outlook.com ([104.47.41.129]:29327
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935246AbeCSQOz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 099/102] EDAC, mv64x60: Fix an error handling
 path
Thread-Topic: [PATCH AUTOSEL for 3.18 099/102] EDAC, mv64x60: Fix an error
 handling path
Thread-Index: AQHTv508VM5oELiy30WwCTBQOI+HjQ==
Date: Mon, 19 Mar 2018 16:13:37 +0000
Message-ID: <20180319161117.17833-99-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:uK3d1LLzw3O7cGod5Lz2juAUJEOvNWFZnRy3dSGcz84Wi7TTJHtPdtjeydWtDDzSs1ydGXBDYxIKouq7KMx8aDCYe+ZDyWQP6Oby+CtWoj9QIgl7rvyYZE/uc9F5WS1xk2ojYHJHzBeaLwgBj7nERcO2VKr8cA3ELoMdbU2HzVxveF4XhanPYV9MxqqGZLyp8B3Xt4CAcylXs6CNORQa756qz2hZPa5Yb3M+fC1pM5SQT2j7a51itgwPgHg8yPxy;20:de53J2Ryaj8A68I9OFqukdPfa0PhXZ3rmkT9GP9SddcsCe067pZwVF0j6tIGsj1r+HA5miTGRjwwZJSvyL8JEK2rxafotpszksu+ulkj9oMxhQ1c1MY+hPPwTrEmeQ+ykzE624p0gzN7qImQsnhlFEy9ApOYsilKEqcIGWtVEeo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ae16346-38c8-489b-5ca5-08d58db48b69
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB086939E7BEC8DDC23C4363F6FBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(155761271638844)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(39380400002)(396003)(376002)(189003)(199004)(3846002)(6116002)(186003)(1076002)(53936002)(97736004)(26005)(86612001)(105586002)(2900100001)(575784001)(86362001)(66066001)(6512007)(81156014)(81166006)(68736007)(102836004)(8676002)(72206003)(966005)(4326008)(36756003)(6506007)(478600001)(3660700001)(316002)(8936002)(54906003)(14454004)(5660300001)(110136005)(76176011)(2906002)(6666003)(6486002)(2950100002)(25786009)(6306002)(10090500001)(6436002)(99286004)(107886003)(10290500003)(106356001)(22452003)(2501003)(7736002)(305945005)(59450400001)(5250100002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: N2gXcMpLC7GRWBfmEmQlYw9XFNxcxHhYzCDZJlIer1UDFT1yVVOB76zOteHEst+U7SSa2m1M1wQB5JVDnBJW6hdZNl0YAW5FNdPIOyAV1xaU92JxYYgW5gVbptSIv2fdbaeaeCMrR3n7SyOx49xyk/jduMp0m1XcnHyPstkv+/NWKQ7MoeKpI/6tEsgCuUuU6VRYCCGhbic9tJ4KBlf92aMIxhP+5SdVULaCXEcr6OKiAkt9FbLdVVzjWBCVLbIyS1j0NorxxJ8FhzA/+8BHQP34Vg2uklgfxXDl5WN8qofPo/nj0q5/1KbO3zHIAfwuuwaTqMxmtYLPozU3/zs7/g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae16346-38c8-489b-5ca5-08d58db48b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:37.5169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 68fa24f9121c04ef146b5158f538c8b32f285be5 ]

We should not call edac_mc_del_mc() if a corresponding call to
edac_mc_add_mc() has not been performed yet.

So here, we should go to err instead of err2 to branch at the right
place of the error handling path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180107205400.14068-1-christophe.jaillet@wa=
nadoo.fr
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/edac/mv64x60_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index 542fad70e360..f0e5a6aa2371 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -763,7 +763,7 @@ static int mv64x60_mc_err_probe(struct platform_device =
*pdev)
 		/* Non-ECC RAM? */
 		printk(KERN_WARNING "%s: No ECC DIMMs discovered\n", __func__);
 		res =3D -ENODEV;
-		goto err2;
+		goto err;
 	}
=20
 	edac_dbg(3, "init mci\n");
--=20
2.14.1
