Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293580-1521477645-2-8174804025118333369
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
    t=1521477645; b=b9yMsPlhH2bGwr1mkcwnsyGsbDQazAp0HBaOAQux+4XFeNK
    mYfIJ6BwSmg1QyM14HywxvJub7Vp19CkZBS5dINX7QGV4AdnOUTFnfxNJu3ib0PV
    JOdXGqrxj0RF3wtWMkPNhBHBf4X4xM0NYBWD9bky0YaQO/QfO4cRns907oXd74LL
    Ijz0G7am9NHj+sKpt2AIktG1tgnAZn5u5ga8Sf5FOcKny1OHHWi21OD7A6nP1OhX
    2XnWH2AUnhRuyi5R6bZhxcgvLPGi36wesSUSFKQaMLhYe05sOoszWse8g5SUzGLG
    5IQqSEnKi7CTS4B9V2j5hdAcZ7XegB7mMGdPQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477645; bh=wdUCt2
    aP3m3utOxAD38Gkap1WMIAIF9sCyQYb1nrctk=; b=Ti8PAZ/9Po1l0hSc7s91gl
    tnCAWOhP4EnlAThkz1isE//2RApXggIIW5DYrffG/DS+9SGbBBTZ4/byG39gLLrK
    p7WXHuhxSnbmmVwOuoGcN/4U1GBbrJCMEq6w6BXpHzH7bO0KE2rhDA868o6cD+3L
    VthSakye/SjO74Gx91pceGGzCQT/jUQtlMXLdxjPDOsFYniH1PxPB2qoPh74cSuv
    9bmQT/GSrcxA6KWkzz+DFUv8+k1uSdkd/7dnMS9mN17ooSpjBmUOMaqf6V0ewGiJ
    Ji9r7Vyo0nCcpW7JNYdpMeTOjvvxKVsJCKm58SbKLymthDFKPpEiJc/hn4samqFA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sc0fpWBa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleduudehnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sc0fpWBa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleduudehnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966868AbeCSQkF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:40:05 -0400
Received: from mail-dm3nam03on0095.outbound.protection.outlook.com ([104.47.41.95]:57888
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966858AbeCSQND (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Pieter \\\"PoroCYon\\\" Sluys" <pcy@national.shitposting.agency>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 052/102] vfb: fix video mode and line_length
 being set when loaded
Thread-Topic: [PATCH AUTOSEL for 3.18 052/102] vfb: fix video mode and
 line_length being set when loaded
Thread-Index: AQHTv50XBn0o9ADyOEyEGfzlZKFZlg==
Date: Mon, 19 Mar 2018 16:12:35 +0000
Message-ID: <20180319161117.17833-52-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:HCZn04drk1vwzz/Njv0PbwNxia0Ity1eKh74Duf1QZ3L8FuV2LjAVWuwaerq/O+f/G6xkxDE7VZw70hSNmZROhS0aVFYEzWItzEk/aReN4daQL0jmeVQFpN24/uJyzy3vwzLzPs4OOVF9FtFC/ysZaE2/nRnEM4PDtk4CL02dIiLB0OfeaE2D97Djd287DPlrx3kMqi2mzbDk0B2Xkn8M0bSg0gfLrJk58RgX+OeXC57q6lkzl6BkJsnkTv5CL5/;20:WG+PzTa1DLq3jCwnpDJPyqamdBCNs0wp0+06VFfLE/viCKfnnFD6Dn7s92HYansdulcpsLGSUy0/hPZvKVaY2y30t6kBTegarEcnAav12jbnYRdZ88SdmedDlSTdPHntHmljKKoi1+nMBfW48D0neaX5MSoMyyLdKBPW9n66y30=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbc690dd-b525-44b3-7272-08d58db4474c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032836B472B8AF4A9622CB5FBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(575784001)(86362001)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: H6/PRp2K1N6UHRWGqqcNWVpn2Yf45fLodjhiYJDq8ruRJ92hgQKz1QF3N0fnATKzPhBvSSw/ocU/ugPea6xDZP9rO61gqc6Gtv3KIANlWmXQmYJaR2rr6iOUo8VTlASTczavS3gSTzwo98UisTR97JVv2ecSVAFXGuBNyimEPOjzWwcn53OhDR7ui2VqEfDl73YH9ebcwHd+NGtLml0UvcwWgQZ7HIGBHRDnd5WWuvRrCCZFOxJwMsj0lQ6GWijr9oUxell3riLeNL6W1rJxV9HZMw+hhfANnlMZWxmPrE/waUvOMUN3iAJYG2LOVwehPVlsbroWTLvI1lVmuXqstA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc690dd-b525-44b3-7272-08d58db4474c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:35.5522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Pieter \\\"PoroCYon\\\" Sluys" <pcy@national.shitposting.agency>

[ Upstream commit 7b9faf5df0ac495a1a3d7cdb64921c179f9008ac ]

Currently, when loading the vfb module, the newly created fbdev
has a line_length of 0, and its video mode would be PSEUDOCOLOR
regardless of color depth. (The former could be worked around by
calling the FBIOPUT_VSCREENINFO ioctl with having the FBACTIVIATE_FORCE
flag set.) This patch automatically sets the line_length correctly,
and the video mode is derived from the bit depth now as well.

Thanks to Geert Uytterhoeven for confirming the bug and helping me with
the patch.

Output of `fbset -i' before the patch:
mode "1366x768-60"
    # D: 72.432 MHz, H: 47.403 kHz, V: 60.004 Hz
    geometry 1366 768 1366 768 32
    timings 13806 120 10 14 3 32 5
    rgba 8/0,8/8,8/16,8/24
endmode

Frame buffer device information:
    Name        : Virtual FB
    Address     : 0xffffaa1405d85000
    Size        : 4196352
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 1
    LineLength  : 0                    <-- note this
    Accelerator : No

After:
mode "1366x768-60"
    # D: 72.432 MHz, H: 47.403 kHz, V: 60.004 Hz
    geometry 1366 768 1366 768 32
    timings 13806 120 10 14 3 32 5
    rgba 8/0,8/8,8/16,8/24
endmode

Frame buffer device information:
    Name        : Virtual FB
    Address     : 0xffffaa1405d85000
    Size        : 4196352
    Type        : PACKED PIXELS
    Visual      : TRUECOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 1
    LineLength  : 5464
    Accelerator : No

Signed-off-by: "Pieter \"PoroCYon\" Sluys" <pcy@national.shitposting.agency=
>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
[b.zolnierkie: minor fixups]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/vfb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index 70a897b1e458..146cc3516f61 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -284,8 +284,23 @@ static int vfb_check_var(struct fb_var_screeninfo *var=
,
  */
 static int vfb_set_par(struct fb_info *info)
 {
+	switch (info->var.bits_per_pixel) {
+	case 1:
+		info->fix.visual =3D FB_VISUAL_MONO01;
+		break;
+	case 8:
+		info->fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case 16:
+	case 24:
+	case 32:
+		info->fix.visual =3D FB_VISUAL_TRUECOLOR;
+		break;
+	}
+
 	info->fix.line_length =3D get_line_length(info->var.xres_virtual,
 						info->var.bits_per_pixel);
+
 	return 0;
 }
=20
@@ -526,6 +541,8 @@ static int vfb_probe(struct platform_device *dev)
 		goto err2;
 	platform_set_drvdata(dev, info);
=20
+	vfb_set_par(info);
+
 	fb_info(info, "Virtual frame buffer device, using %ldK of video memory\n"=
,
 		videomemorysize >> 10);
 	return 0;
--=20
2.14.1
