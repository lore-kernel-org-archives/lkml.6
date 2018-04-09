Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246977-2-8472170094449080022
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
    1523246976; b=C2vrSgy6kvKfnbXzjsqIs4fSS8WJ59gIU/3afIvUP2PlZif+Pg
    LBOE3RoA04QWaulWVPk7rrb2wMTQaSLREOTEAwWQR7VWuAEA7/UAUt5qaM4dDEzt
    6X3uCk67iamdjBgFMq1Nznnf4LoDC3DQIim8HK8a7yd2w/aCi7sG9FF40K6OemqO
    wzJoKsBoOSQ8phf9piET5SXeXMFizGxtvEWIX3O1Md+YeA0HleRIl+et37bsY1tf
    3d8Ur4XBCUHCMgQB/VDVy/V/IJCfBKvLuy7pkb5eTfHYh+CNLo9RNU5HMI5uX1qK
    QjtMMmasAoTR02qI6wSRWXVIPIqn/OYDin4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246976; bh=ov7i5M7KW4
    Po0Ci3WBv4x4o4ezVtx1SgIxXaQtz9zQw=; b=t4HxXeAPF1E0ojyYTSN/U3Ey1d
    DW3x4I9+SiT4G6CI+0Cg1UlrsUoy5nAPd11AHBw9WMOFM4ZuukPVCpbcrHUdu6zf
    ATI+K1W/+bxKuHw1Abt91K5HlvQ9V9ZhFgSJejGXmTQU5JRZzRm26tT89+PocoZH
    9/sarviyvIkYDLImWe6zffJ8tcWKextdzlk7Kweykb/iIfh3i02pIgm+DFtyZVx8
    9Wcf4v3l2wHK6K4kJWOS0X4brgJZvBNLBPx3EGnOhvW9XmikaMRCKcqo7Xrnj5xc
    Ae8ogq2n7TwDta4NMjs5eQHCaFj1BfH2yXxExo4fS6ZWUMAlh4Q50VvlhWwA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k0eNBbK3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k0eNBbK3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHJb/HchH1DuC3SNydgmWlgZwi/zzfUtkvSnFrIzi7u7pjs32+AKSDsZs+eRDYR9M4aoyG1yTbzKtTpnQrpS3+ezMUqjdz4d64oxI0imCNX9emrBSJzQ
    hQtFlvLGmh4YgEDZKa+DfSWiDwVZXxE8L917TrNsLIeS+OFJvn51wDqxb3cNk2RW04d/N5sljzWxM7PQaoJHyfV9rofoc1Ri6ktU8J84Hk5bC8VAFYrCjws2
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=U1dBML2taTuOmboFKOwA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeDIEId (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:08:33 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:48974
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753062AbeDIARI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 022/189] Input: psmouse - fix Synaptics
 detection when protocol is disabled
Thread-Topic: [PATCH AUTOSEL for 4.15 022/189] Input: psmouse - fix Synaptics
 detection when protocol is disabled
Thread-Index: AQHTz5gVVSFn6Oet/Uy8rTmzwT/49Q==
Date: Mon, 9 Apr 2018 00:17:03 +0000
Message-ID: <20180409001637.162453-22-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:A0tl0+aXuHSEAYBCAAbloyZHkUdnxy0SQopdVg3YBc/lXufulM7L9ZvwYc50OTK0srMcDCSshi0rXE/TgsnoyUimwkwPXXF2OZJ/nmZceubJvtPAe/p76jeFHFSHP2Ndt31psEyRqJo3TOKd91f3fBysI0+IDtEKv8YX0PJtJqhQUtkAaUmLtO4YsCwte8LCc/wSBfDypJ4NtXGfbBm33sW+RboK10kIhdltYs8R+093PFNZ5SFttu9KabROWsZK;20:TihgRiFvLGTuWmq33wBLzoo/bhrQMuoJE+Tsn1/mYXP7HRy+Nbd0n9XUvg7QzF5mQaa5g9ao1XmEMpUVsHVq7zBo4ehcQv2Id/JmvYx/AzMtIe9zpZo+gNtChgLjrUN1h1eWmyVsCpYOkwMKHZQYuuc99EK8l+VWm9cUxXelNxo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2cac6dff-9bb2-470e-10c5-08d59daf3851
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11279E0FE36255A57FDCE110FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(575784001)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(39060400002)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XPuxTALreogYztTkqZSWKwqz1rXutaT0yvgpvMeENtYtrQWGAhwB0mfGoIM2Bg1iiL4YwhM0aovgQSIceoLwVzkkYqxOQoWLkNgxgaRSGnGlBTrrIQandxS/FYK4aIFxoar1ls17yDxeMoBJWsnQ5dsQl5Rr38rS1OVYeF2FArlbmk08/L6zvlhgOup3ABlJzon7TH3da7Pa9ondZWuQyt8kx2y6vPe9QNeum28CjR8RPGo4H3FDBCbgwlOxI3jOki370S8j2xZNQFei2A9vLvoPx9cTQ3WKSZiaCdiVQz8HlmaVbWewlpSeJe14KLgKc7t7PH7/EKSEEJmbdq7DQWpwzl80YGbi9F5mNSr0jxLk1AllV1fYvDAZQEbAHqBgWxZuc7Ng4iJ4CApE53SVTha43eg9R5ADuJ27Bq7e2Bk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cac6dff-9bb2-470e-10c5-08d59daf3851
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:03.0905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
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
