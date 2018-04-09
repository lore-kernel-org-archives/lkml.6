Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237194-2-14006738645395879737
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237193; b=R1p/8qtH3ALbrP2I49kDNd18z/1xLSZhZOxvmlHwa7WBv7fTQK
    dRCBN3E1bbjeirqas/bCmx3HYaVqdWAAov/lN8zz7ECbWIq5qKsP0csUJ1yjuopu
    mtpDyMPK1Nm+9M6gxSycFBtgGc5gqU+Mgp8pIuGM4GEvAkwle6mlsKzLcw6nhDtU
    HStQsUv2/z3NHj0VqnSYUdA1UfxyVl4FzvKCBIm8dsvZO8ky/TjrNTd2i9sAou7I
    zK6BlJQ/3ipQH7ZahuXXxIsjAX5jDdiLGe0mmM9cqiKC3ZogJ8ci0Yn9CdvCS7/E
    /9y63bid8nvC26mwwSk3+sYW3fJLylScpRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237193; bh=8G4RNJBCSe
    nTmw8Gquzf04hRGUt1fWipzQwt6O31ZHc=; b=FHsY3UdJx6hHGGdYpcKxGxRwon
    KK9dtpiHNkSZoLKgVngwWQ8/weoXzTVWN5G0X/YYBr+LcZSR4n3LSz7WRFnL+vVO
    7ICKdSL45j86mM5jBKswgQM1Fy9gLMePgRuhW8yh5I+Hfbpd9AbBzTqrMCiLnjyA
    2zyoeGMuSZjZVOpbgtqfEkGCEAYhyTR3b41QP0ggR66E7Y0AbbxCBSjVP2U9Gm/H
    rey37GJfoMDd4PTWGrPprCrAahsBuMbXOsX3W2Iv09jyk27j4HS+GfN5oiMELu5x
    zdWGGCyjZtvct5IqAYXJE2jkgtGP6xZMBpvsqmcxyt5iVM8TaYiP77TBLxRw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U6KiTguM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U6KiTguM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKUOLEr19dXKaAhdKgBleze1IJn6Q0kcdlSfgSLVzWKHz5O/ighGVjO5qBiLiaGfCn4w6bzW1+93TRW9DK1lsrGLTrdzoGDXQJOvtAydLq2iqLd+3h96
    /MCjj47L1nCE+NuVKdJt9Mftli9hQOchj79AJENYh2IElbXkbZ6Zu9VYMN0t/gnAaxhTLo7zr2mSAjp32iPNt4RTvwl0Y3ifW1Zn3LktN/TezXMhwqZ/yTr7
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uP1ucDPQAAAA:8 a=-VAfIpHNAAAA:8 a=e5mUnYsNAAAA:8
    a=yMhMjlubAAAA:8 a=wh7yg598yndT3i2I4poA:9 a=wPNLvfGTeEIA:10
    a=9a9ggB8z3XFZH39hjkD6:22 a=srlwD-8ojaedGGhPAyx8:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932655AbeDIAgr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:36:47 -0400
Received: from mail-sn1nam02on0107.outbound.protection.outlook.com ([104.47.36.107]:45025
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756161AbeDIAgp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 061/162] drm/vc4: Send a VBLANK event when
 disabling a CRTC
Thread-Topic: [PATCH AUTOSEL for 4.4 061/162] drm/vc4: Send a VBLANK event
 when disabling a CRTC
Thread-Index: AQHTz5mtFkXmrgc+5UOGiqZKKnXo/Q==
Date: Mon, 9 Apr 2018 00:28:26 +0000
Message-ID: <20180409002738.163941-61-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:vBTXX17Elw0f3D83qqcUgcAjUdA1eqvGr2O93wYCipCdNMyZlIOU6t9UNjw9j1IdPovbmvn6wQVoy9dVpGakn6cfpnbA90Bd1jvN1im1buBs8nn141iCIQkqlclkFkkE/LNZGuNYb3FP1aRGRESboCtwzuJtlew+nXG75jQfqAnxzjBdUbPxfpK1gUMayoUuv5n3y9dxJrCTJX3MYf1sLMpCW1sEEhHoGGN/p52dSTQ+pA/mHnduJQCI/QmJowVS;20:xLZfC1T6Lb8dnYnP/1RDkd9HwsIRaxeaVn7dtyM89HiOXXZS9Jp4NLCYLKfYucVW6n98l2G8uhaXnXiep13xSTHJguT+/jcE0hgATe6jLHaiD2o0Fiki+Vdbl2SKWBm65xA9JMlZvG19QN7zCw7Sp6WJeSjNx4Qo8+uSGXCWL5A=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d8cd029-3a0f-4808-1484-08d59db1f821
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08853107C3361EFBC6450425FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(575784001)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(966005)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(6306002)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QqfWZUnjBN7PP3TPFfMYRkzaMjoiU/XdwCcy/+15gP4ZHvKQ4xOqGdx+lbrnU4vXWsnk3j3HFFn8DLXa8DiUSWujch8AAp+cdW1/Hdk2bP+eWuoUyqpIjIKz71Oqg3bfLiCC+Z85XMZkZlkxD6cCirakaXYEE21kgUNXyezm/duxOPOBaex08sffJ3ccT3q399BADiQ+syGWQZdjlftwfq2wZbmWiuKScM9dZX+yA/PilG5qXejPKR6787YzK86M8un2PHijeOd8rWYmnOO9LkgJ1uHm2szo6ZvvIXVIHezS3Ufvud85U6+BhtIvi9tWLfWAQgAIDtz5bLOxWitdP9zEdJQD5V2+CleA6OM5o8q3Pwxmnwld9sblJ4hz5KdHDpp326UaG6LU1ubUlsQMfNzOo4cUzgBQ0lfvApiFo3g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8cd029-3a0f-4808-1484-08d59db1f821
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:26.8800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Boris Brezillon <boris.brezillon@free-electrons.com>

[ Upstream commit edeb729f7929d1372ab426a7f56fd0b337ba5751 ]

VBLANK events are missed when the CRTC is being disabled because the
driver does not wait till the end of the frame before stopping the
HVS and PV blocks. In this case, we should explicitly issue a VBLANK
event if there's one waiting.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: http://patchwork.freedesktop.org/patch/msgid/1497601833-24588-1-git-s=
end-email-boris.brezillon@free-electrons.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.=
c
index 265064c62d49..6987723c23ed 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -290,6 +290,19 @@ static void vc4_crtc_disable(struct drm_crtc *crtc)
 	WARN_ON_ONCE((HVS_READ(SCALER_DISPSTATX(chan)) &
 		      (SCALER_DISPSTATX_FULL | SCALER_DISPSTATX_EMPTY)) !=3D
 		     SCALER_DISPSTATX_EMPTY);
+
+	/*
+	 * Make sure we issue a vblank event after disabling the CRTC if
+	 * someone was waiting it.
+	 */
+	if (crtc->state->event) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dev->event_lock, flags);
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event =3D NULL;
+		spin_unlock_irqrestore(&dev->event_lock, flags);
+	}
 }
=20
 static void vc4_crtc_enable(struct drm_crtc *crtc)
--=20
2.15.1
