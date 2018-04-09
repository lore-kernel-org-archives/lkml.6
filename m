Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233979-2-6649647150368874283
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233979; b=ZTB1kUJOk0Iyv2VPRwvkZHjnubn++rIUaFooT3DUVRMj/wZyZM
    FX36k5mWCOcQ4yjHBx+wkFxk3kSqCXIMceVWrR5nAn2dS+kRDglBEpXKAav272ZZ
    0+ARjBD1fzixqaEFLFin7so6FTbttyCS+YJjr9jVPat495AUg4gxBdw/Zd7LziNO
    1ANPCpFhI//+M0VXeyfEc4l5AXOrRfOTrfsNVLOvdBZ67ryGlTKupnHbQH2rELmt
    IFhgrjBB6d+9na4hVkttzT2yPFzOP/L22P0sxhCxygwhEYOsmlFVq/efPqk4A3w0
    Jgwk3toEoN95B21D48U7FferRp6Dv7iSmdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233979; bh=kgC9c5RX2/
    JGT9GMqAVb6hnpjWzsykCdhxXnzHM3DOs=; b=cXLAGYI1atFxVdQ9BmJUr0yrYF
    gdRkgujteQ3cr1Oh8uf2MeePxXjplakWTMVqXghAdX5gFzpap1Yt0QvrxccC1fA0
    4gs/LLHd0EZf3eT/ax+K7ivcQccRf4oWieuD7+u4am5Bx73+l3t2940NR4N3wUNi
    3pAIfe99UORqIQvBuXrPykDlaIa7WnN4yP/rq6RznCb6n6huvQKeT7GjRBGuOgKF
    AixTvbkWmsR7cFUkJC6oKaMGhUbmTBZ31e1gyBXFN0tc4qzctxA7CEPMMrvWuEWy
    0zpclqwGl3FklEVn4bN6cY6TYIN6wLu5XpeP1JtBT7iWb+DBxQpt4sN5p1uw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nOImUMh8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nOImUMh8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKfK/keeqObMBtAykhznvySao9mSLEtVqI52bcC5RxQFaPPt4Nuc6WmyqxYUg96KHg8pXyecD3c6P1EWK/2jtKPuLPI3weZYTaJ4RPR+Ft0Vg2Y93wli
    kA3Pdxx8zdWn6Nyt6SVCt262TqGLaxaKShxEMspKesqomL+3qejosbnRhMJ1B06o9h/eL+cRdzRQCUgLHVGBrEc5F2BtWTrbDn25upf/Vn9abrGCOECcQeC3
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=U1dBML2taTuOmboFKOwA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932168AbeDIAc4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:56 -0400
Received: from mail-by2nam01on0100.outbound.protection.outlook.com ([104.47.34.100]:61248
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932160AbeDIAcy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 219/293] Input: psmouse - fix Synaptics
 detection when protocol is disabled
Thread-Topic: [PATCH AUTOSEL for 4.9 219/293] Input: psmouse - fix Synaptics
 detection when protocol is disabled
Thread-Index: AQHTz5lMMi/2AmdbsUG41q6YFQs5AQ==
Date: Mon, 9 Apr 2018 00:25:45 +0000
Message-ID: <20180409002239.163177-219-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:RAlG2Ump7bYemDbzjJRQmUl852vtWFN7hVIV+9nAeL7NDBWmnZHossu++iBuDGcL7mp5WkH3bJX5EweGZtyEp2ldtqVjcTcgIEx7gD7H00FCT9rYfeXJKnd9UdXErb+FRJwb1lMG5DznB5ry2Yi4LsI3Mvi4iIhtIUb7RGTh0xRd5p2qhMnHqr/PdZOZfaihOilu69bClIXc8s4S5OIrqvx+COmy+OXHVI+pGXaccPfk6DlkC+lnnbABPFMzVDCy;20:FnYBYbWJEgwIVL0yMHJbKz0ukaTvnQMmEJ4sJAF1btQDGuQTbB2nBPB4TGF6ENcWrLFXa5oQVSUBc25HOjPSmvE6j23ebXMqzn3KNxbEj3mF0LGKGKFv7iKUgF9HgOcIdL3pBO7YLVr9FU06U4zyWrcRoZEB62VLxiYlEsDnVDM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2538aad6-41a7-458d-1f12-08d59db16d54
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0998C7A3D0BE62512A488903FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(59450400001)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(39060400002)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(575784001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: urgBb7znhTGbzXD0zLC4Jvu1RT01DDmGrYKSrqKXB+OXFoeah7JGbhFws4Hj32RH8EPzltl50o2xUCZgEUvRY4fqkHz15+hUMj7oVipTXMEcss/tQE4BCmvaNjh5zgdzhLQXotFWKc0B928mlGeUNEPMO+0xTUuFEg+UsAt0e4KeMOHZKqumuXz+SRKOB5kf6jKB18hC0frUfpiJLG6IQVcmOEcfHRsMXSE8+W6yu9ZOpM6FggiBP98mqmsmyY4WHM8DP1HuHd3QfNWzEvJ3kfHfdtGReK3HKQBzlP53IA4qdMeNEjsZX070p3V9wdxfTf0Ou29J4xsBzT/OtX0lrIX0Oo1H5Xx8M+KrOylNl7gVqscz4Wzbalc6aSfjNRZPah4gJve6Fc43nO51zbbRzsW/Drn0Cvkhiatbf0SKDgw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2538aad6-41a7-458d-1f12-08d59db16d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:45.3160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
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
index bee267424972..5cbf17aa8443 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -937,6 +937,21 @@ static void psmouse_apply_defaults(struct psmouse *psm=
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
@@ -948,15 +963,8 @@ static bool psmouse_try_protocol(struct psmouse *psmou=
se,
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
@@ -988,8 +996,8 @@ static int psmouse_extensions(struct psmouse *psmouse,
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
@@ -1035,8 +1043,8 @@ static int psmouse_extensions(struct psmouse *psmouse=
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
