Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120770-2-6227669666019836502
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120769; b=fGmNiOjyiC+y/XyvDZ1K1cNjd1pZViTmXcFAleoZT0CHzBP
    FqU0g9cx9FrjzL9UPVDsK9bSMohrPE9+Qh/q7KxTAY5wKXDitErkAdF6doTKqV/1
    yVgy+vIQffj6gauvGuoCSwhDJjRNucgnNUOa41WR3mIaIjvVUf8xduo24niIUp1V
    kcGCDb5rFc5rwjabnwgDlzHufUhqcgncyXfW9zoeAXnOUDMvRvjCfCQPMCQ9sudJ
    ygl1xlTPCM+9CxVz/VeI4AbrdhjWBGYzuNOTCiMLHpFVCFWA+lKF5BF20x9b0eH9
    WbKDk9BGO0NmHEhIfAaWa2Jl3qi8k1PJEH1tpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120769; bh=UT5Kaf
    SNt9CC3Ygy1LNhf4NcwmP0yNHa2+BnAa/fxNw=; b=i69hk7nGeLHlbHSLcr2NDB
    5K5SIMCCyWuTBG5PFuVhfJRsMJ2xAdintSKgMXETfCYjiDUsWQH/z6QsiihHc7jn
    iRWTE8rT3A9UQbKnfZRI3GOe1t/HsCUwzPym/nbsxmIhh0J2UiLu6nqOP9OzyyjI
    6ts6tQUXLvpEINhoQOGPHRZIJeLq4NdrnNEfvaw6xx/go5SAvfZmTiBVtk3OZTQH
    1X94VHdyBCtaGuLMYVN+50frKp657VR9FoXWTSOLraG5LPXDBLk3MZtrVd5B7XCr
    TQt2BWPvZPvLTDJxk3KYMDPf4dmYU0iCoOKNW/IvyRfpz/eyL+ZIM5gF/ne3iMdA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BKe7xJzO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BKe7xJzO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933883AbeCCXp4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:45:56 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:36491
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933892AbeCCWeK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 107/219] drm: rcar-du: Handle event when
 disabling CRTCs
Thread-Topic: [PATCH AUTOSEL for 4.9 107/219] drm: rcar-du: Handle event when
 disabling CRTCs
Thread-Index: AQHTsz8F5jkqEtr/x0WC7KiBNmkzlg==
Date: Sat, 3 Mar 2018 22:28:58 +0000
Message-ID: <20180303222716.26640-107-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:zOhpqNQasX8QdmCM4zWZT2HXm1CkmFRo/X/AKcJ/dAqGhS+LGDlTtJQWxGI13tbvniJAarnQPbx6eQQTLZb96iKzVS1hAZm6baFDyhMa4XHtc1sBpnpNy4dg3HbbXHIfvqSoyBOESRgxNffGImG91WjkAFuxyQRTSXLrvoxMRLQFRP1TXZXwHGag7t26Zsa9sTIng0tdRkDGj8C0j5Ht7lb1At6h+9PWIvBMWdkO5IQr+GE6mXyQZJXcXnvOBdpc
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e3f882e-01cc-43c5-199a-08d58156de88
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1065386F4381E60567F31FA5FBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(17423001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: H2tngeYVCdUgef26KAdPq48qFCZjdN+xmYqg0uRDDjZr6q6kcL99Zm+K3cy46F7fD310XCHd867kVeTLk3gkWQSuYWtFTc0BE7E2R8QeT3szjLPMwT3ipdD6m7fOxmMKYkCmLTf9U4aBNY9vDuDGj97rGwSirOOwzWez89e6w7U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3f882e-01cc-43c5-199a-08d58156de88
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:58.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[ Upstream commit 6dd47cfd03a058d08b8caffb06194aa0eb109cf1 ]

The driver currently handles vblank events only when updating planes on
a CRTC. The atomic update API however allows requesting an event when
disabling a CRTC. This currently leads to event objects being leaked in
the kernel and to events not being sent out. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-=
du/rcar_du_crtc.c
index 3322b157106d..1c4d95dea887 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -512,6 +512,13 @@ static void rcar_du_crtc_disable(struct drm_crtc *crtc=
)
 	rcar_du_crtc_stop(rcrtc);
 	rcar_du_crtc_put(rcrtc);
=20
+	spin_lock_irq(&crtc->dev->event_lock);
+	if (crtc->state->event) {
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event =3D NULL;
+	}
+	spin_unlock_irq(&crtc->dev->event_lock);
+
 	rcrtc->outputs =3D 0;
 }
=20
--=20
2.14.1
