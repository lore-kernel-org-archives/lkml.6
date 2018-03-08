Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487042-2-1220228119309192467
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
    t=1520487041; b=n5LgegWZDaN68Oqohkc9BL4NgKhtRQut9ZSxDqm8H280LZm
    2AcP7tRr8u/ySs/g5BlYQskOZDNgnsICsoAWFTQGa1Uv8IC4RyBzfyYB/JjLs09Q
    icjKgPlSEphb4xL6R8JKXNVhwuuYzTCu7iBpHOn8lANKUSXsC8VtBcPEBK4lWqDd
    pYQpCP+f3k3pYMabG8vdZpdxka9x3Grl9YfPFdSl1H2gFQGkxOOKUU73jXbq2lMX
    sK7r7O0nYyCHmKG+lHkWBBE33+eUDbZF5v2MZMskb6YKL8PPfr0oVTWHckMuzBwC
    p3rOcSIto2ZO5SckQVr6i7YsJtg9XXtntnb/Spw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487041; bh=FP+uqX
    dfze/bMdyiAa9zC3PNli55Mbt9+V6CtFX6eFw=; b=Fnjacl7y4FLi5tgohG+SbE
    z79BQbuTN/tL9l+FGC7pbI1eFsO//h51pLOavvyrHXuqGarsdNeoT0CYD1PRSsjI
    wM0F0Gs5gSsS0Fhrvb/mpAiW+10kVSqdOywsOO6BpyIqQ/Pm2vqncXg8wnogJAov
    KyRl015q+SiVi/RZzyV7YjSaPh/2gUau6Cp9Fse2aLbzKA1PjSJE1smVbRPnWEcw
    jkhfsa9K37BdPIOPlDSPWbwuZKiALLsWv1jn1IdaZJUgGyB5FZH+jF62t4h6PPYA
    FxJjfYYCy9quKxUoLFmlEw+4nc9+/JKkHNJ+v22Xy2htwJOC0OjPJ3o6qskNvJHA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QKEWUOHf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QKEWUOHf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966395AbeCHFah (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:30:37 -0500
Received: from mail-cys01nam02on0127.outbound.protection.outlook.com ([104.47.37.127]:59427
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935462AbeCHFGy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mario Kleiner <mario.kleiner.de@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 064/101] drm/nouveau/kms: Increase max retries
 in scanout position queries.
Thread-Topic: [PATCH AUTOSEL for 4.4 064/101] drm/nouveau/kms: Increase max
 retries in scanout position queries.
Thread-Index: AQHTtpqWgpQ6tKLgykWHD9DjtmbOrQ==
Date: Thu, 8 Mar 2018 05:01:58 +0000
Message-ID: <20180308050023.8548-64-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:pOjUqf8p8pMm/J0BoJyPXEGD8yp9BaJYEuHZRFORPdBeUTLizQZ44hRK05PXHSPb5h3xSgxMyKOIKqjIVZDkOjejMMe+QZTY8EWWWlAmvEVNZ8Hqw+0cTBSYqw8I7+S9GzHnjtXMEBRgM9ivhNE4YwceOusyKjuzAsPnVZv1jmXOOVlcI8nFJ1YOstCBGrwP+JzmoLDNJ348ny7JextBH/EppfLI9NNHziITMovAwPOxQR9J2xHeZy1bfHwouEeM;20:8y++mOqXVkEjU4dWi99J0rg2D+unFKn6YnAiNgppTfJG6rfIhHUecH9ZqSv9WGC5uGhRZygz6M2twpWb6KNPJB8Kovt0avHMEZUovNKegXcI73m9W1XqpEaBE606VGF9fO4A51F/7cICcJ236HEECSNwI7Lo7DFeBov+eg34fyk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 499978c3-ab5f-45b3-dcee-08d584b2667f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1016022BAD1CE52AA7F08031FBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(39060400002)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(59450400001)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(26005)(186003)(107886003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(2501003)(66066001)(106356001)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: LrPBucHaIJyG9VuW/nhQcHJHpgEg2A+N58pnXVOj/Qy1t7r+YUdZC6zVtTQPClgvjZLwkx7OJ/7j3V6wum1ERE7RkhhsD6FVL2vXcylNTHW3tyKjgtF5HWKiQ31CESOUHMFQqVvIBKhHTKtVqchDAgRa7gE6GLZkrjxrAPl876Z0Ff8GHelS08TJOmo2T380orTeI6mhz1ApGJpnbijyhZZfSGbGWz6sqoBt8LqoRqPFqwfv0npQr2/IUER4I5mvWCoTvrYpg2fml2fYDymz/iDu9Pc1Pl7YpVwhibhC1dctGltqJ1WYSdzCdmSKPFKxI2XTugxUO/gJL6Y0RbLkYA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499978c3-ab5f-45b3-dcee-08d584b2667f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:58.5572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mario Kleiner <mario.kleiner.de@gmail.com>

[ Upstream commit 60b95d709525e3ce1c51e1fc93175dcd1755d345 ]

So far we only allowed for 1 retry and just failed the query
- and thereby high precision vblank timestamping - if we did
not get a reasonable result, as such a failure wasn't considered
all too horrible. There are a few NVidia gpu models out there which
may need a bit more than 1 retry to get a successful query result
under some conditions.

Since Linux 4.4 the update code for vblank counter and timestamp
in drm_update_vblank_count() changed so that the implementation
assumes that high precision vblank timestamping of a kms driver
either consistently succeeds or consistently fails for a given
video mode and encoder/connector combo. Iow. switching from success
to fail or vice versa on a modeset or connector change is ok, but
spurious temporary failure for a given setup can confuse the core
code and potentially cause bad miscounting of vblanks and confusion
or hangs in userspace clients which rely on vblank  stuff, e.g.,
desktop compositors.

Therefore change the max retry count to a larger number - more than
any gpu so far is known to need to succeed, but still low enough
so that these queries which do also happen in vblank interrupt are
still fast enough to be not disastrously long if something would
go badly wrong with them.

As such sporadic retries only happen seldom even on affected gpu's,
this could mean a vblank irq could take a few dozen microseconds
longer every few hours of uptime -- better than a desktop compositor
randomly hanging every couple of hours or days of uptime in a hard
to reproduce manner.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/no=
uveau/nouveau_display.c
index 00de1bf81519..9dfc2471ea09 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -104,7 +104,7 @@ nouveau_display_scanoutpos_head(struct drm_crtc *crtc, =
int *vpos, int *hpos,
 	};
 	struct nouveau_display *disp =3D nouveau_display(crtc->dev);
 	struct drm_vblank_crtc *vblank =3D &crtc->dev->vblank[drm_crtc_index(crtc=
)];
-	int ret, retry =3D 1;
+	int ret, retry =3D 20;
=20
 	do {
 		ret =3D nvif_mthd(&disp->disp, 0, &args, sizeof(args));
--=20
2.14.1
