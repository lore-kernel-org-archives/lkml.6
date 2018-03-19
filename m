Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497085-2-16037280175144077652
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
    t=1521497084; b=X5uCHSyHM/IRXt6t9Ojay6R7l+tpk4hqxMV9zxDsRl5hy10
    rqhGlncGnlIyuXgz8+ra7IeSXgCAw1TUkdpotB1ODmkbXKrH2mPaHayWa/hebSFo
    5ReIChY0bkeyDNTHUz0iM6q8bl60JDoJF3fmICNOpBLZyO9HyCqfmPEgnKKONTOe
    JJCeVW+oWBA5V96VZK8UpuztNfdVZHEzNWer16GAjbh19QSgID8gZsX+/YoQ8g6M
    q0+K1lDafwIUkUTjaQ/+xZ0Hg3uZtBfG/kkb9EcTC50Np33sliXzvTLoIUIqhSVq
    U82Yvd17EvLchPiN/JgGRg7DMi9tNGUaZqMYYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497084; bh=HLkZyf
    Rp7S5/Y0POzDH+iiHaSysu2mRW8WSqMfND0G0=; b=f3Dow+o6pUd330eRMDopG+
    54XQ5gL8jb6vlE/YIP8vkZvAYo6WUQntICQOX+bwycPrfzXvRRg531eiEdHQ685N
    JnLkvHpszXwj3ILrJM9s0nAvYv5X28THE7am6K7Q8wuoLiuTg43OhMZcNcQf2vR/
    qiJN+0I1YUShGKtp7kfTig6vbmBVh+DQTDrGfZZSXtw+F8erV//krnZRyWnfzsjy
    owmZJ8SeFASQCR3hMUqhOogAa2WuMDVbjk4GcrLtxzbXpmaDca/nKFnHogOYsC7J
    EFe6XGwMnrrvjk5SILyhmfAlHuTtSQqf3qievLbKxvCKgeTEVu4coRFcHZokBoAw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ULkg7vdS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludduvdenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ULkg7vdS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludduvdenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934406AbeCSPzu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:55:50 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:43956
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934379AbeCSPzo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Pieter \\\"PoroCYon\\\" Sluys" <pcy@national.shitposting.agency>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 37/97] vfb: fix video mode and line_length
 being set when loaded
Thread-Topic: [PATCH AUTOSEL for 4.14 37/97] vfb: fix video mode and
 line_length being set when loaded
Thread-Index: AQHTv5qqYdj+W3Q+GU+92ZGH1J3oQw==
Date: Mon, 19 Mar 2018 15:55:12 +0000
Message-ID: <20180319155411.12348-37-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:AxUtvdPHl0/HfjAtf/5qyK4uUsOWWTmXMKaR2Uo1TOPxJnn/S+7vAZEH1CO73/WGKc9lDc/dmcJIcqkW25P73i4UY+6MVFI3I+rUJJXvztQ3EYBzvIWIemuF9jfskCR2JmYqPUzQtt3cDTwhlSKnLYiimQyBDToX6Jt7rvjfWj+hgvlVikYm1JrcfhvShBXANEMJ0btX6DYu6iyAFfgb4sNOyt/YGMka6nyuVTC5WTadYDaJv1XUtkPfni6j4yG1;20:mY1frTsBSws6AogIDWQxZR0AOg2k3iOlu1vEyKwxvs6sIZtkOKgqN82oCmc0CCulDSl/wnk+WBtatLbSBDcBfx0Gs7tloPHOrXKb1m/IT4uMaNfUAON3iFCA0udRsHwGNw7nxgcXifshxomFBSJXwSTcVWEP6/WXYgTTT2pfVSo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3558f68-3c1e-4c9b-bb7d-08d58db1de9a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09677264A8152B09B3D6B82CFBD40@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(39860400002)(366004)(346002)(189003)(199004)(54906003)(10090500001)(110136005)(5250100002)(2501003)(1076002)(6116002)(3846002)(2900100001)(99286004)(22452003)(3280700002)(186003)(2906002)(76176011)(86612001)(26005)(6486002)(10290500003)(102836004)(14454004)(36756003)(68736007)(3660700001)(72206003)(478600001)(107886003)(106356001)(53936002)(6506007)(6512007)(6436002)(86362001)(575784001)(105586002)(316002)(7736002)(4326008)(305945005)(66066001)(81156014)(81166006)(5660300001)(97736004)(8936002)(25786009)(8676002)(2950100002)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: EBJkex3PBuyl0NxPRIgiN30hPbHcwF0kTaGjRKJ6+Dc5Ow9amsunf+N3JhGy2Pk7MY69pUB0ENL5h00BraEAh1oCor/X89rzCHOIp0QDrUfEra74PEw2q8e344Z3QyQk0CF6HSMiEbOgFs+cxXFIYnaFaLusykvgYgQzROngIyDnkl2PyofdozjlvE/P3g+0+IzEEQvk5jkpmSpz3n2Wz/wE+lmX8t7O4kKDfDh7fCjn9oZp5XPiaxEqWp/KAeaZp2kDijN77P9InmQNZeqC3XlrnTKC45CAkS4RZNbU5vn+nXkEUBokOFZ3xEE2JAdBdHIbPyIvugxsOyiFaGR5Vw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3558f68-3c1e-4c9b-bb7d-08d58db1de9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:12.6330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
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
index da653a080394..54127905bfe7 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -239,8 +239,23 @@ static int vfb_check_var(struct fb_var_screeninfo *var=
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
@@ -450,6 +465,8 @@ static int vfb_probe(struct platform_device *dev)
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
