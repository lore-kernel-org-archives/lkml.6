Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244454-2-5789106187170536430
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244453; b=t1//L71EKasWbLRLf6CAmB0jPqNgwDjCj+r9rVPNM0+GOOoH4m
    oPIoi4/VDiDO7sRO4WSqOb38ZHren9DN2FCyMtAmOdDQL+zdoEVzOe6yTufp6fOJ
    LPPO1oESfSFYxhd5CxaxT8omQ5ybrnLI+4Llx04dRRlylytz0qhtKIP8QoqY22/t
    hasNa4e7c/SyTxI/9MLrmXxI9j3bZ1+N6rLRVWqcXeF7MYkpFMVlghYbJYNVIip7
    kFLK3mEucHn1WQ1kZwPwvic1X86P+jjeQ6pwpaeMAmZw/inAspJ2hXQbbRCVy5Pb
    Fp+sBvfmDJvWNPgvMZdnxFTwsvTb8zfj2ewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244453; bh=ov7i5M7KW4
    Po0Ci3WBv4x4o4ezVtx1SgIxXaQtz9zQw=; b=PGr579dGKm5K/iZM4cbuXTmrUn
    12UW6qRw7SKu7/8AiZPP0hAb5ZTTAOh+xgCykSswAiSlLlh7LTVUM2onjndhMGR8
    PGHtcZtlZoNqSP4Lf/xcH/Rn+6fOXXP993i8DqaR3B8niAHLazlt6nGbhYzmgTMd
    a+KLogoHX55nQr2gSRm8qifCdFdJr2Z9lB4sBo+AgTAew2wZQy4ZIfL5+6XMX/Ev
    vQc4X7T5IB9AlHnQrAtxhJSxbiorc0BEdnpH1OQ0MTngpYO8udiZmg5wIopnegzm
    R9Cb/M8Xd5aolNI1CKnjGg0avonqFGrRgCVg78F0pCsezYEk7/COYchx4Jdw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CBGRq5/D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CBGRq5/D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM3M2M5JYNFJen7eysB7yX29Jc2/pony704ocjtvxq8QeNz1ktbNFzBSVc571UpLGWB5cfw2paZed2eda6Ni2cCndcAq1K1Cwmff7KURrPHMntkUB4JZ
    mErBWvhI8ibWdHG44+4/Qqe5SkrTFjTSV7u+OrGPB/4AzLjgYwbACh3e/bb9f72EkoJamsON3fKUeVN19Vva4t2BslBGLMUj/jifsRVmRCmD3thY4ViArtAn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=U1dBML2taTuOmboFKOwA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeDID07 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:26:59 -0400
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:31261
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754625AbeDIAWI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 018/161] Input: psmouse - fix Synaptics
 detection when protocol is disabled
Thread-Topic: [PATCH AUTOSEL for 4.14 018/161] Input: psmouse - fix Synaptics
 detection when protocol is disabled
Thread-Index: AQHTz5h8P0MbVBwJQkCmiUz/qb/6sg==
Date: Mon, 9 Apr 2018 00:19:56 +0000
Message-ID: <20180409001936.162706-18-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:DTjhbC6EmoFWqeVBmjpwB22VrzFWYTHkBmWu8lYFe12v+2TaqhnyjMwVnY9luNXlJWWy4phAOPTvAYzoD6uUNe9iqA3P2pHoIuQrghWUjxD00KRQvhpPS52NbaNWCT8jg1aT4l6TmWGnyC+H68wWRHQPKNOh/cPJWG2SFu6sWdMPPcZUnw4648k5S3raKINhKg+ec2IzZ1qZ6fLwa6GyQT0KIOTItO8CQ1u/kKhu0nqRgbYuplSsqWV5VfRCxBBD;20:/lmlPcGGi2WWkahWjlfeCLPzTAWYxSuKoD+p5uhqSxLITIC4qEU6h7X7OIaJAVE1+LoCwYR39aeMIauxaQbMC48B/JAez3UADUKM/mZpFKN6E5BUEV+A9PKeMjx60omDwx/bb5zgudxNeY4EyzAqVp8vxW5K7mY9pTWo6eKBIIs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49e7f1e9-0efd-4a33-38a9-08d59dafecc1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966BD6A9F98E9E4328E5B73FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(59450400001)(6436002)(186003)(6666003)(2900100001)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(39060400002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(575784001)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: iAUhXUFhotouPcNvgeTlMGT3yvQUXC/1d3inKS2pAUsZ+2F2qCMwa6PQi3OuLBx98FoHzr4X7dFuuCYvcMINIAb0+4HzTcIYcjfMsQjfALqolun1y0UfY3S+UK4hxgNi3U8oiwI3qYYvBwo4LPs1sDtJ/fbL5q58epJ2uVZytR48NJNqc2WMKT3mMcbxsjsgzEz0nC0O2WyVty43m3AKscmsmw864bDzst9N3/ys/J+XjLacGNHhM0VaanNIjFAwP9cvfwqDEj0BoXBkunYr2H8ugByxGggxlKnsBzVKBI3KTwR76ktbxiQINhqZRYA+hfeyYPp8wPgS6ag3b3LZSQDhwazYLVcBjyLXWKvhQ84nhPD/VmV6QkmIk9jKs8fB7XNVzee3fxTzxt+/L+OSfg0dGe3w8jBK6NqopaigokA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e7f1e9-0efd-4a33-38a9-08d59dafecc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:56.0668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 2bc4298f59d2f15175bb568e2d356b5912d0cdd9 ]

When Synaptics protocol is disabled, we still need to try and detect the
hardware, so we can switch to SMBus device if SMbus is detected, or we know
that it is Synaptics device and reset it properly for the bare PS/2
protocol.

Fixes: c378b5119eb0 ("Input: psmouse - factor out common protocol probing c=
ode")
Reported-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/mouse/psmouse-base.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmou=
se-base.c
index 6a5649e52eed..8ac9e03c05b4 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -975,6 +975,21 @@ static void psmouse_apply_defaults(struct psmouse *psm=
ouse)
 	psmouse->pt_deactivate =3D NULL;
 }
=20
+static bool psmouse_do_detect(int (*detect)(struct psmouse *, bool),
+			      struct psmouse *psmouse, bool allow_passthrough,
+			      bool set_properties)
+{
+	if (psmouse->ps2dev.serio->id.type =3D=3D SERIO_PS_PSTHRU &&
+	    !allow_passthrough) {
+		return false;
+	}
+
+	if (set_properties)
+		psmouse_apply_defaults(psmouse);
+
+	return detect(psmouse, set_properties) =3D=3D 0;
+}
+
 static bool psmouse_try_protocol(struct psmouse *psmouse,
 				 enum psmouse_type type,
 				 unsigned int *max_proto,
@@ -986,15 +1001,8 @@ static bool psmouse_try_protocol(struct psmouse *psmo=
use,
 	if (!proto)
 		return false;
=20
-	if (psmouse->ps2dev.serio->id.type =3D=3D SERIO_PS_PSTHRU &&
-	    !proto->try_passthru) {
-		return false;
-	}
-
-	if (set_properties)
-		psmouse_apply_defaults(psmouse);
-
-	if (proto->detect(psmouse, set_properties) !=3D 0)
+	if (!psmouse_do_detect(proto->detect, psmouse, proto->try_passthru,
+			       set_properties))
 		return false;
=20
 	if (set_properties && proto->init && init_allowed) {
@@ -1027,8 +1035,8 @@ static int psmouse_extensions(struct psmouse *psmouse=
,
 	 * Always check for focaltech, this is safe as it uses pnp-id
 	 * matching.
 	 */
-	if (psmouse_try_protocol(psmouse, PSMOUSE_FOCALTECH,
-				 &max_proto, set_properties, false)) {
+	if (psmouse_do_detect(focaltech_detect,
+			      psmouse, false, set_properties)) {
 		if (max_proto > PSMOUSE_IMEX &&
 		    IS_ENABLED(CONFIG_MOUSE_PS2_FOCALTECH) &&
 		    (!set_properties || focaltech_init(psmouse) =3D=3D 0)) {
@@ -1074,8 +1082,8 @@ static int psmouse_extensions(struct psmouse *psmouse=
,
 	 * probing for IntelliMouse.
 	 */
 	if (max_proto > PSMOUSE_PS2 &&
-	    psmouse_try_protocol(psmouse, PSMOUSE_SYNAPTICS, &max_proto,
-				 set_properties, false)) {
+	    psmouse_do_detect(synaptics_detect,
+			      psmouse, false, set_properties)) {
 		synaptics_hardware =3D true;
=20
 		if (max_proto > PSMOUSE_IMEX) {
--=20
2.15.1
