Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485886-2-18104980469589436810
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485885; b=dzZkUQOahM7kO82fBrh6BwyoszqCccXaL79eceWEdhX4176
    9VI0v//2GW7vz9G9wjxEbFoh01maDru20xJ2TtE5LYEEdu/vZrdZC4AgEv3LJPOn
    muGxFoSUhTRE46oM1dRmJTaPyUx+Ofeidi/OndGtk4jgUfpvF2hbV5Xnnzk+t1wV
    K5vuvtRyB/Ig9vrFpbyu/JYeU7Ny0CXbhbnBFpYMcQNGeamGEl+se1Gm2CGDY6+H
    nqGu7Q3yOWb4DglcnAAzdsFgF+MdE3Fwqf7rvvbVrH/Gag3krkdT32N9NF1K2tRX
    swAV3+p75SjpIZ67Jv+d/yd2m/artQGGDEy+jNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485885; bh=RW7IGk
    FqWNqY0RZGy1AkfeYynXVUHlnXLYokFhyvF4Q=; b=qkb3q3ULZ+iyp5iIhQMDYu
    BVyKsAB1wWAqmwOmJJ4e4H+80IOw5vQ92ufFJSSj0aRxIVM83hd4pHDOP4+HdFuF
    unHs7Zd+A7/U3WU1WqiW7o+jgxjfhaY5VYKCw8Nvq6RHyQ7E8MG6NBGIhVIYdqav
    ldYKcbBjZ6ZF7p4yaAhvJUz0JK4VCHiEvc5UBQGQKZ6Q6YKmWmQwnv/AJdWB2pWv
    GS4mKkUdbT/SQi9vH9tz5xnKb5uS7sMNE1BA1JAtxrhfJdRifviUsaq7ZctTLvIA
    UkRW/YLUO92HP4JxgsPT2bjFRDgVOeKEkm8fywrBmjN+b48ZJCb5oJKE8j0F1Zuw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TfqX3u2I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TfqX3u2I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966808AbeCHFIy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:08:54 -0500
Received: from mail-bn3nam01on0121.outbound.protection.outlook.com ([104.47.33.121]:48048
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966793AbeCHFIw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mikhail Paulyshka <me@mixaill.tk>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 23/53] ALSA: hda - Fix headset microphone
 detection for ASUS N551 and N751
Thread-Topic: [PATCH AUTOSEL for 3.18 23/53] ALSA: hda - Fix headset
 microphone detection for ASUS N551 and N751
Thread-Index: AQHTtprETcRtd8l/qkymo92PctFENg==
Date: Thu, 8 Mar 2018 05:03:16 +0000
Message-ID: <20180308050230.8876-23-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:hhblQC3L6WSx0iLoq0W21miQBNngexO3UEDXPhKJKhPt1H8iEtragUp0fZPJ3IBUWqGuqeyRnbWBsnh2rQO+xA25bSZzwxEx/S6tkfvcDpn4EfrXv6xMGG4xv3D1LNvk7tGYo8EphIr4wJXwS8zx/aikwJN0dXJoDk/dZNgDwHMPbi6H4RJjh3P6gs77ZKJoHujGrcQORju1CpBRMMgwn0h53PoFi9xRVDGCG+6RDFOz38kSgqK5JfkdPG4jO2Ak;20:k8njyvjn6NFKi4ckLoA7rEqfOTQHDJWAYzlCMhH/yxx0+XC5J1FBShl9zwgn8T8jcO5SgpbTf6DWl9v5l1XEx04E/+WsMiJzinpQKLMQ57SQ/rgZm5OHdJbYD5vc4MN+AckDQA6ipiQ5BtGE67F1ImCinSI81m2eKSP4P0Ikw/M=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92b3b50c-6d6e-49c5-d80d-08d584b2ad49
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08716AE12F4DD29595B5AE6BFBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(966005)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(6306002)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: OHwH9igzp+9YWaDKnigGYsC/UuebL5yE7wJReHqhLsbuu8RHb8qECQcf/gdOP2UiDS2NksGYKnSIJie+mNrGWaZK1fC4XS26tLbbXl7d5FOrJrAJC9yFLQv0Lg9k5WOhnwLf1ipgy3nb2gWNi96yApFqXvH0KNF2siURxQCzszrRYBhA+L2w4mAgAWyptZMUzi8Z1h0JbH+IVQXqYOF9EyJjhJa1gHFyQevGP18zNwfyFj7Cg/xtxy0G6wUI5dIHWHbFBuUf9SkT9plMWssTOpkw6J4g5EdfAXFORug7SA/FtP0ZSUiuyBRKPffZkFYJnSixquYWoBXzf/12JufWcg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b3b50c-6d6e-49c5-d80d-08d584b2ad49
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:16.9381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index d4de56cad5ac..fd3bbcf317ee 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6493,6 +6493,7 @@ enum {
 	ALC668_FIXUP_DELL_DISABLE_AAMIX,
 	ALC668_FIXUP_DELL_XPS13,
 	ALC662_FIXUP_ASUS_Nx50,
+	ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	ALC668_FIXUP_ASUS_Nx51,
 };
=20
@@ -6740,14 +6741,21 @@ static const struct hda_fixup alc662_fixups[] =3D {
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
