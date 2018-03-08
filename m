Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488377-2-14671241738927870293
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
    t=1520488377; b=lbZ9vLrvVCj1OA4eHY0/PuQR7qs2HGvk2sRtMUdhph6M0d0
    vmFlQgTINXYfEtufv0rOTojMyMjN9kaGDERQTutHZiEvnxZShV/VwRlRTcsTciuq
    3QT8jiI1UJFy6RbihcINYe8mlcX3NLo7gSvwJlO+yDYEK6bHC0mggkknAISkzDA5
    A52j07APIzqPsbnM0TbBbc1SHprPARgkLU/40vB5jB3sTSg4Ixx3cke0oR2fUgQe
    bVdcuU1wvDEqj6vhZ7bn8Gakzu74j+1lsbk4iCYixxpCUJp9MM6K9rblHRLMtCZH
    1wzzX5Z/zmosIdOcRewG3AiLjECwsEt8/IRmvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488377; bh=x0wbzz
    qRiCksxIpk+eAl6+19uerlS6VOl/Bckj0znlE=; b=IfmQZFwiVsUhvSEcONTcw2
    hlop+6JYHZ/wQjUpgIa3NHaSI1EZnSvNqyRztXz5vqWy0jvjd0Ry4PKJQkXlQNgm
    6V0CDu5acBrmfDl6As65+wRoLhIRM/mDo49+3SwuhokU68nr8sAtVBzyF9pIKviv
    lJy4bhBT6i5lPtqeJC3XYy1DyKfXX5LTV2zLcTbYPrs/tra1iy5YO+D3LnhscE3R
    78iaiukZ8QbFoI72KSQP3ytPsv3BwJD1uOffoPlOJaF6UaVSr+z6DFqbmSF8ecUz
    bcngmS1O4G3Zw5vBx2qUkxiX2nn/UdpFg2MtkJ9a9YBPuK0vhT/9MoXdiTTPv0iA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ntOOEUhy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ntOOEUhy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966155AbeCHFwl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:52:41 -0500
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:13700
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966121AbeCHFEH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Logan Gunthorpe <logang@deltatee.com>, Jyri Sarha <jsarha@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 168/190] drm/tilcdc: ensure nonatomic
 iowrite64 is not used
Thread-Topic: [PATCH AUTOSEL for 4.9 168/190] drm/tilcdc: ensure nonatomic
 iowrite64 is not used
Thread-Index: AQHTtppT65mU3mw6Bk6tfa8kw51rng==
Date: Thu, 8 Mar 2018 05:00:06 +0000
Message-ID: <20180308045810.8041-168-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:LzgsHdcz/LjH4dt93Og95IdwZmEfSjEZjLH/g8bSkNCrQks2f8JMejPl/ntD1VaPcyi8Z/dYxswzJje6OkLCo9ThK137ZML4ba1KCQtZrN7Hnu2uCoUotiXOJNEIyVMfL5CEuaNmcAS0I09yh+pFcbRstiMPhSJ6FjROt495TIwjS93PmJPKqH0I37zBs4iIDKg/4nsn5/lXb6OhcTCU5yhCZ84dAIB2/N4VvRGbQoSJypj7AZZPyEGtIjq3DkvQ;20:HFAHN0Prg743eXVAsuJEkGOUyMOnELRQJaouLGecfuke4NZtpzS3gdJQgtGTTAV24pOvtQoiRfJyf7Lo86KRxjeNhpECHpEu8l0wxyIWQe/odQ1t7zq7HosbCeVCw3p/h69MxL8iPb2ssddmUMmHEr98pXhFY4zP2I8xIVwj2a0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5348b065-994b-4705-19fa-08d584b20257
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919187FDB1630BA07B18C52FBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(575784001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 71VrZXpkLXkYXKcTXJAZUKiGJMsW6CjHqg8IN5vVTKzHTSey1cJM2tnh2S/vGFNayKAQQbsYrJYCY/i9WZlCGhdsFFtR1N3jT+lg4BYy4E9okgqyqUnwp5nF7cpSdJJObpaPOgjIK3pW2z6gQmS1wlLzhQKg8QEDbB2Y+ZSzSbX+M3scqhrudcAMGCGSHJb3wymTYocxSQYEo+mQg7Og3BGXojOJeixugTLlFfMGTxnVgenzQVAlyrA3pe/XQSnxlRzc2JPnP7X3emX8lKhddVsAH/IrpKLmH42ZAX1Hwod9VBkQ6fQdtoedMWG/eL+u0HuxsTehcYgMXPY1VW4TBg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5348b065-994b-4705-19fa-08d584b20257
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:07.0053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit 4e5ca2d930aa8714400aedf4bf1dc959cb04280f ]

Add a check to ensure iowrite64 is only used if it is atomic.

It was decided in [1] that the tilcdc driver should not be using an
atomic operation (so it was left out of this patchset). However, it turns
out that through the drm code, a nonatomic header is actually included:

include/linux/io-64-nonatomic-lo-hi.h
is included from include/drm/drm_os_linux.h:9:0,
            from include/drm/drmP.h:74,
            from include/drm/drm_modeset_helper.h:26,
            from include/drm/drm_atomic_helper.h:33,
            from drivers/gpu/drm/tilcdc/tilcdc_crtc.c:19:

And thus, without this change, this patchset would inadvertantly
change the behaviour of the tilcdc driver.

[1] lkml.kernel.org/r/CAK8P3a2HhO_zCnsTzq7hmWSz5La5Thu19FWZpun16iMnyyNreQ@m=
ail.gmail.com

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/=
tilcdc_regs.h
index f57c0d62c76a..19d8dc3cdd40 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
@@ -124,7 +124,7 @@ static inline void tilcdc_write64(struct drm_device *de=
v, u32 reg, u64 data)
 	struct tilcdc_drm_private *priv =3D dev->dev_private;
 	volatile void __iomem *addr =3D priv->mmio + reg;
=20
-#ifdef iowrite64
+#if defined(iowrite64) && !defined(iowrite64_is_nonatomic)
 	iowrite64(data, addr);
 #else
 	__iowmb();
--=20
2.14.1
