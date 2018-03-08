Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520489009-2-15681562367550959098
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
    t=1520489008; b=woB9MjUqKfcxtTn33RgzmFfFOygl4uYceyFl1qJQ6S626DG
    gVdDy9MHbhO3xMyYvTtSYVXPkCfL0pscc9QKdg1JwOuHiu4vjZ7/iws6KAr3UkBg
    17TKzb+JMbceRao/34scZ8+6PpquhS7H280oamLmtwaVOF7bgboVyUgDQDPAvIrK
    qzyeCpc02Vx2+FZuhKmi9HIb4YgSUADEtBmvuKR8tK8mN5U9P8bLmif6Rk7S/MHO
    a4NIP+Jeg9TIkbmszkpwd7B5gV4TPPnCK6KWEfmvL+Gfs/oFh7BaRU+bshWk2HsZ
    OfX3h/EpvOynEacWz/DVSmHgWpRQiC1bQ3Gietw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489008; bh=dQbbIJ
    EEULukxXBo45/pFkh/nBNdVbTaLaRqfQOVKmc=; b=xFpaLj1pfYiSG1wzyXWqrS
    Rl1X57p1+cqisKZurn8LLTOyKw4sHzDmkrRCeu2BYhWMF0bL9OkbxmuEo4eQASe/
    RtNXBO2nj0RzhX92RZyjRFafqTjfcepn0eyKvweb5Gh6vU9mG4irfPaTLLTh1bzJ
    7NdFp0blUFpFMP5duA/YmkB40Ph66i6kPXtlxqiGJNQhFVubjawFrz3RHhXIsI5w
    JI2bSd+iY7bnsEDArxy0O6bCKxup63vd6pzt2EXmHvUS9f89y/58LiefIxuPIruU
    tkXFSPwPV1ApwR37vN1TzswKhKn3BxjUtwx1SdrTvlDwPxvGyfd8uVI+svgIf5Hg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oymukamH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oymukamH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeCHGC4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:02:56 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:45129
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755372AbeCHFCc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:32 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mario Kleiner <mario.kleiner.de@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 118/190] drm/nouveau/kms: Increase max retries
 in scanout position queries.
Thread-Topic: [PATCH AUTOSEL for 4.9 118/190] drm/nouveau/kms: Increase max
 retries in scanout position queries.
Thread-Index: AQHTtppFuAzV0vJ8L0CphRSV9EalGg==
Date: Thu, 8 Mar 2018 04:59:43 +0000
Message-ID: <20180308045810.8041-118-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:2iL0pW/5EWWHTpdho619ysygUzfoFRKJLhrGNMM0XqNzHRJnPFCcYIfy8Lr45Qcr/OR/OJMOqxsD0AJEBW0bAz+aiG+TDt6YrLGfsjM4hoTE0s1f2qMTA3+ZNb9+bigLK8BBstDKFJcf5q8b5myMrwH06TwDz7JEyWqqlUgeVnqvEsqRRppzKjWjeixcKANK7UxXW0oktvSCuQqPXJa5ASF80VFpzml3HNatQKsVyRr99eXlq215LGledIcdPF8n;20:BcvsJHdhNryiacoA2nB5XcoU9YPOT+0QxuAq2AwUMPCBlNZrF2q0p5Q92whgmVoxo85qIvphdaTel+O+kidnjbSDMDaOO817hYwJAUSJdzZ3dqyIbxZRzfs6Wj71e78MfEcrIbrfWoNJjDGWP8BBR3kDV1ekRgDv5JsepDksuz8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e15dafe-c39e-4476-e8a5-08d584b1c50e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB099759847D31345F67512235FBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(39060400002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Tgpp/UyZ8cC8i5badV/FSElFTJamvuTo+JCKhEwCZHdHYuBgxJO18fMVJZlRNOYz99mwTojRyAAgshYiHzBlO1UW1h2sFn9+23cEglGa/m1KgrtG5KU9QvQXuo2oD0Fa4GNnZNFkV7bucLJ1ZgVjemWJqKhF2pekwfbATQr55BRDU9JJruaONDRn4whFRW4nBZZ4FdwK3Nil4bGMUG1vzX1k5oOCmrOHDHTe/dFHWV0P4xuRg6s05OSYXmDcknMpAV1Me8etzcam2ovxblRgCtnLn9wi9ROzC9jXJV34cOva9FjeFcG3mUV4IaOPeReS53V71/TOJsPGn9NnBMc95Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e15dafe-c39e-4476-e8a5-08d584b1c50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:43.8059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
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
index 2c2b86d68129..6526a3366087 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -106,7 +106,7 @@ nouveau_display_scanoutpos_head(struct drm_crtc *crtc, =
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
