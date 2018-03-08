Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487498-2-16704373132129118571
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciifr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487497; b=PqF/plIL08Etg+Vlgu39+P5UsEFJNkIjFyp1He4mTBvMKqW
    c8ZYe3u47N9UOZMbP+N6c+ykMfsH4c1Y+ONoXZ2GKFiF+A2zSQUpjf9VAMC1dZZm
    gU6ojil9HW5F7A7XQfcEvF3TIOeEENB2XODpRTDYoG4iorm6QgsETxiVNI5/w0bg
    MRKnVC/VHJa7Wp2XofzdK6uUB5LAaEUMTOuQMTiratjYYea8eWJY8WoJm+MYPO1O
    MGsa78gcDkCHPcF7x8czyVOvLEDeTTcejhNxxGuha36BFYOeTlZKzJfU3vY7Se4S
    TsxdNyXYVMrKf84+JDZcM2Arf/LIM87l0MC104g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487497; bh=kqpjid
    m31l8O0x+/80JmniqDrmMBXNyNJnid1a1GA78=; b=XeyFwWEVCh+lA8eCRbQ/5g
    Onhub9yHMFFOfAa0dY3mO0vsJAkgAwny2yts5Q3UkIWJfOgSa4Cm8wvE+X6WuK7E
    kHJK5dvxE1r9Rf5j9asYI/gP+a9xkuEoqgAAQvvAOkmjLP92EnGn1sHPKIfVdYiY
    c2aRp0lpzf9V+Ajj4Aw7ecZLMNPT/JFV+X9AZy17/xcg0ViTCmEmjqOI87/4pEHq
    BkMH9J7tiC/E32e34PYoxwXIDAfGqVDS0ITLGn6nN5DaQbDsM+rkBekxMaivnTCj
    KoreiFEWKYniRiI/g/iAOyUVGOfp2LTPGLuBAp/oKKmwe3XIBnvlYVpJJ56Ojq2A
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CO5qzn9n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CO5qzn9n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966484AbeCHFiB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:38:01 -0500
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:7384
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966285AbeCHFFx (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mikhail Paulyshka <me@mixaill.tk>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 035/101] ALSA: hda - Fix headset microphone
 detection for ASUS N551 and N751
Thread-Topic: [PATCH AUTOSEL for 4.4 035/101] ALSA: hda - Fix headset
 microphone detection for ASUS N551 and N751
Thread-Index: AQHTtpqKyQuqlpfS8EeRzysuyPWkCA==
Date: Thu, 8 Mar 2018 05:01:39 +0000
Message-ID: <20180308050023.8548-35-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:5zz59hSbYH1ilSEajkFniD0EC/tmsdsYArYBXcs732U9zbInPLeLxYzJ/M+02oXBRT9OB7QcFbo3YaHvxsDjHp2S8LXuxnJn/1SAZtgI2lbUzONQ3JPuD3MVpbN5AiNbEzPjb6BAF3V3ODMx2VfUdWhkGu2veo4gfgXlalgORWZvwegwTfW0NWlJ8v2U3YsLohC2erzUeU9dARIcXOM96pyDxzPe8HBh6NE8RLnt951dqkyB5OqFuyxyDB7BocJe;20:c0T2TQXI8Gn50gx9OCfSk6zWE2WEytKUMs4P03C8c7gnB0qMJBmu6RvMAe+zHbJK4FR79apwDgtZnMaDElTJZcZIksqywXrOTg9xkNv/KjLhD9iCNBb/NHHzK+1v+fattvHrRfb9lmWA9lWY0lH6+xghBD01ReBMpUqix18YrWs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8108f6a5-3f8a-4e81-43fe-08d584b24261
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046A0574EF7130A0A7DE123FBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(6306002)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(966005)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(59450400001)(76176011)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: kwG0OGcPo7Dp/XRN6XCun+qkQiPq2nQjELUWSmds1Myo8GrWPmYXrf315MY03GFf7rMaPB21hgeZ2bAXL8Lhm9GeqAXvFblYYez4VYEuHEr4uku7wFYk8FnyhNdiolGtGo59lh41yoFStt0yCP82yVX4DN9wowSwy9S4SeDyfdasFpaNMJ55lHMdicUljrYX75P8S1zHXn5wrF5SJQwFtO4EJJvkJxhTRBLhST46C1vcUCT3svjQWlB2byMiR3K/iBjit/0ddbN+b9MD8jJtTFQ3IIB3K6YNIB1qNFnUUvPUGNSv+JtMEAjJuHKKHWIdEHrAtNOn9HpRbU24PjybHw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8108f6a5-3f8a-4e81-43fe-08d584b24261
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:39.1625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mikhail Paulyshka <me@mixaill.tk>

[ Upstream commit fc7438b1eb12b6c93d7b7a62423779eb5dfc673c ]

Headset microphone does not work out of the box on ASUS Nx51
laptops. This patch fixes it.

Patch tested on Asus N551 laptop. Asus N751 part is not tested, but
according to [1] this laptop uses the same audiosystem.

1. https://bugzilla.kernel.org/show_bug.cgi?id=3D117781

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D195437
Signed-off-by: Mikhail Paulyshka <me@mixaill.tk>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b302d056e5d3..777db644e735 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6701,6 +6701,7 @@ enum {
 	ALC668_FIXUP_DELL_DISABLE_AAMIX,
 	ALC668_FIXUP_DELL_XPS13,
 	ALC662_FIXUP_ASUS_Nx50,
+	ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	ALC668_FIXUP_ASUS_Nx51,
 };
=20
@@ -6948,14 +6949,21 @@ static const struct hda_fixup alc662_fixups[] =3D {
 		.chained =3D true,
 		.chain_id =3D ALC662_FIXUP_BASS_1A
 	},
+	[ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE] =3D {
+		.type =3D HDA_FIXUP_FUNC,
+		.v.func =3D alc_fixup_headset_mode_alc668,
+		.chain_id =3D ALC662_FIXUP_BASS_CHMAP
+	},
 	[ALC668_FIXUP_ASUS_Nx51] =3D {
 		.type =3D HDA_FIXUP_PINS,
 		.v.pins =3D (const struct hda_pintbl[]) {
-			{0x1a, 0x90170151}, /* bass speaker */
+			{ 0x19, 0x03a1913d }, /* use as headphone mic, without its own jack det=
ect */
+			{ 0x1a, 0x90170151 }, /* bass speaker */
+			{ 0x1b, 0x03a1113c }, /* use as headset mic, without its own jack detec=
t */
 			{}
 		},
 		.chained =3D true,
-		.chain_id =3D ALC662_FIXUP_BASS_CHMAP,
+		.chain_id =3D ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	},
 };
=20
--=20
2.14.1
