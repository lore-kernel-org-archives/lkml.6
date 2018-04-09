Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236343-2-7445497888118363742
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
    1523236342; b=MihTHztpjgVjRlkR//vi7QFOjQr96y5S1j5oLvIqcsOKWjntij
    1t21PqKf/YMLOv+wtRgkHkWvCahWO/7EFIjFjYGqBpQgFeKDolkV9o0B7JsFRye2
    pHFkTxUeogbUb12XP8yWxwOZHfWZlifWkB50yeWiNznLSck8gP4aGSYvwldfflS9
    OcQoP+0pHGfOQf00VmbK4HOzVURjXV0EnKXEFc3rGqM5pz1/0BM+H6twIN5YjUzs
    WXuUtNorWk1NWeKwcBed8Oysni3J5LcIlOADiuY03PZBp58k2wivPFs4d79JVPUd
    v1lYJrty5R7L5AXVhsdv7cwN8lluyOVyyUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236342; bh=jF9sPzO750
    84/hBSTa4R8vufVSKr6Nc7AIIrRBCN0I4=; b=aITf6NYjqBXhcWdCsIg3M/BO1g
    s0JPVKOFVW37bY8HeDX0ywhVDy/t8mwMmrHoYpIPQPZ4SW6vCYMV0wgQYr6e579X
    SQ/hH72rkp0sOQIGgRJbv1b57awJ4CIqugiuFhqVAjG/6WWkXmxSpAtBsPCtz6iF
    oahQgu5tnhvETAam1yKRegamGsNxg6T3A/B1I2TJoCJKNnel4je+v7liqJCLGSQm
    6bsUHy2ohHz2xeUdvOrIZLNA7Pj+chhVJ3tt8vOIOD1/h/xmWDh2kkBgoBcNPh4F
    Hn1rvVyThlFQCDJ4W2LL0fUO4JrW8R3q/EFy1+L9HMeOVxy6K5QEzntp4sMg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ie12zq1q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ie12zq1q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH/ZrTDwQqBo24VOxLXkhqoHHIubRza+r8WBGlqJaWvt3ms++hSSdl4reXiDa8mCI0p+n7M+c2hjpk70zTHQkJJy0BhOcs+EyDIEUytCM1QTw/FtzC74
    QK9x+sy1rh2ItAUG6+maUWvg+4HSpPRUxX0BW1FWbsUObOnscTTnqbXxSnN1oL64nNDRZcQMqdZKBPgWbSNShvG9AAmjHju0vfbeGqU9zWChOcPPv1z304WJ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=K6fn2rewBBjh1KMvdOcA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932456AbeDIBMF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:12:05 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932988AbeDIAil (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 130/162] HID: roccat: prevent an out of bounds
 read in kovaplus_profile_activated()
Thread-Topic: [PATCH AUTOSEL for 4.4 130/162] HID: roccat: prevent an out of
 bounds read in kovaplus_profile_activated()
Thread-Index: AQHTz5nQTGeadJEi1EyVaNIEkrG3rQ==
Date: Mon, 9 Apr 2018 00:29:26 +0000
Message-ID: <20180409002738.163941-130-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:VQ1BmcsuX26sO6FmA1ZAl/RmY2OSpTc0TYedjMsjcYqciPKspg76z7+csUdiOGAfvws0i8nraUHVm5VjICV2Isp1nxbMoL6VRXtcBMV3iJPLBKNTJdlwGeljgxcj9D06Imy/O4sVcCab/K0iS32/X8vscZz9v7mSQ12AyIHP3cerXBYuBEVSJAwek81CXKfUwGn0YV2jynK5avdAO6C7XVrswX7IIohGnV3v1OHCKab5CYzhLiWYZEp0qhAiUSCr;20:g0sGx8lmE4idE7VKQAmOI46fj3zyKWW1/3/I1j11h2wV66U8GAQS7jR4MJMeKaoEgjcRgdn/h091OEJrZft1ewGNj9w9SqlwpyhT0dmeC6sZvJDFYDBOdygplICnOU+cysybEr+XSbT2tzmtwH0ZxXSosmIRlPQASQfjVpb+MHQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 856fb413-bcc8-4b4b-8035-08d59db23b0b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095030EAB98F788890B71A7FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(575784001)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sXHfy1afSEdKqLsviOg03RbgntmU7f0aFYltk0l8lCxjmbVdVDOEpo118FULK5+sdwu2cvRvprPmW5LheOlu5bsKcGSiUg+QPLJqjR/BOK9XMURTydC60g1q4QiaQHNIiRoJrswDGvfX5V73+lajub45jHPczJzLkw9kfghWYK/CKfy7KLqOWe7qeFcjqAco3LQbEHnJv/vEQ1o7sE7bwi8+Sy0wai79JrHg1cLr0EbB5Hz3aM0ATD3B19btQs38sADD07JoMZGSCikkosADhSZfT5AP3NKiR1dRibwtGrdbtO9CDyiVevroL1Sw8fG/ZWx2mLnJhdC93JAsliTa+Z8DaHbVRU2rAWcJEqoOYhH/GbYcQ+70EyhcjyRbu5YSwslorPA794cuIOebzo83ABmEYkMQu6xU62CJ63yDe04=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856fb413-bcc8-4b4b-8035-08d59db23b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:26.8181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7ad81482cad67cbe1ec808490d1ddfc420c42008 ]

We get the "new_profile_index" value from the mouse device when we're
handling raw events.  Smatch taints it as untrusted data and complains
that we need a bounds check.  This seems like a reasonable warning
otherwise there is a small read beyond the end of the array.

Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Silvan Jegen <s.jegen@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hid/hid-roccat-kovaplus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kov=
aplus.c
index 966047711fbf..1073c0d1fae5 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -37,6 +37,8 @@ static uint kovaplus_convert_event_cpi(uint value)
 static void kovaplus_profile_activated(struct kovaplus_device *kovaplus,
 		uint new_profile_index)
 {
+	if (new_profile_index >=3D ARRAY_SIZE(kovaplus->profile_settings))
+		return;
 	kovaplus->actual_profile =3D new_profile_index;
 	kovaplus->actual_cpi =3D kovaplus->profile_settings[new_profile_index].cp=
i_startup_level;
 	kovaplus->actual_x_sensitivity =3D kovaplus->profile_settings[new_profile=
_index].sensitivity_x;
--=20
2.15.1
