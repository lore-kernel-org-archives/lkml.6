Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489931-2-6894958357921928529
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489931; b=n4n59VlM8naF30u96qqkNp2/NGVNkpAG8nEpG1an3fPisOk
    FVfGM+mrINLEX6u3bHuFyMR/ad71MLDK/aloABAjRiL2ke4Omym7gLaS/LUXz1OF
    tfJKOIq4p1qMbJEEoAxAQBV/7QU5td4w4VypxBufO7rQAFnYKYvJE6yM1+OSKo0k
    u8aEk9mjsuv3tCe482uKFe3xTxLURDAcGWQ763RnetD3gglWyLqDc6oQ36BJA3k5
    1/KUVE5c5+wHrZ3YRDNkUoKVAvdM0drd+VCW1IrDgFn9s+8znRwXZAj3cP82So7a
    gBoSqHPYmvXgv4fSywPhjKyP+YwXFonnfVsk1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489931; bh=mprOHp
    6bzgB6BF81p/UMnwzq5mxhHhHM0l8P5ZdVztA=; b=qV8y4uZOp9tSwpokyF1E2t
    76nzrZ1IAxP9/ohVr6YIqygLnmAk+GUrGv6G7uUmhH9IGw0E5lhsn3gqjfKumU+w
    /zQjnW+ItD26d4icMvJxehBJRlWQzpOK+LXzKKhS3o7iq2w9NgXZMhub7uM/VcHN
    KFc9JN84lhuMoAkj19flc2o9m9/KiQ5GRqouy4tYgUUfalLcpamQRJ8jNCT8hs72
    ciY5NfKYncFfJpExxIefxLGEyRwYLZcwlIJ/tRLd0VEad6A7I43hIkiXHXE/07xs
    0lfrV0HVpV7g/mG0Kz/uU3SqrpK2p46ziF9czi/veVBifaTntbDS7WcStPi2+Eyg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b0mf6PDX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b0mf6PDX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964869AbeCHGSg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:18:36 -0500
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:45238
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965611AbeCHFBC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mikhail Paulyshka <me@mixaill.tk>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 060/190] ALSA: hda - Fix headset microphone
 detection for ASUS N551 and N751
Thread-Topic: [PATCH AUTOSEL for 4.9 060/190] ALSA: hda - Fix headset
 microphone detection for ASUS N551 and N751
Thread-Index: AQHTtpo2c4n7OVOiuEucBJU6B/dCRw==
Date: Thu, 8 Mar 2018 04:59:18 +0000
Message-ID: <20180308045810.8041-60-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:Fq8NJ+eBEpWBwn/TsUbvecRqMjzDztEnWa/s74/uKcnQOu5i6kn975PPQtarNJPBrHYvxgU8KMahvg5aDRO35pSeoplm/AjLjQiScDooIFyKgaswJ2Lep0U7o/9YNJdE9TdHuvLiQw3ocsE45SR/JNa/8rOj8eGw79jTnu6jYGo4CLKGFP+bpnwCbywY2kGELdXpgg5O9/kJDn6qihNYXP9Aaa+cyLNjPQNJ7pv/GKmmi9ScVuUjxKv8qIfrsg2B;20:ZX/djNgkAbBIYmu1Yf4vVh/MpPOWpf80pc+K2UxxSfGNqXqbn8G2BeNmcEzrLjxnOM2OGzj8vGp/a2Uwt1nXtO2TLidoUFP7UY9e63fHCvZcA4bVRX4JB8aRe994fSwQI996mYfOr2rI3dXRet+ZZ+3//S5TYL+THV3N8/OSrVI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 857faa8f-a2a5-4f7c-af59-08d584b18f52
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11092964EB34EAEC7C1B6EE3FBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6306002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(575784001)(4326008)(59450400001)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(966005)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ZBaNrxElHsUmEvIum0fS4oTvUOZEQR0fErfsw7TseH2ZtRy9SjtX3qdp5uVPMy+4pVatRNOpDqK5bhPefzz1/PpeOPsDSxCzlIk4y1Tmh3pmwKaA/Bt5Od4VVUjuMBka+/ZJXeY/8r6aLGFYCGBC0+oRN83BWd0DNLWJB9ZlcsyU9BuSygw4YqefYjZNNhgix5IefVxRmRtuEN46IQg4VwEkTxsroehUHWPiMA14z5bnyEAz2FX5MiN4UtXIgKg9hlJBsJLxGxG1i4Bp+JBxdqqS/KziIyMX3QHUq1vJP5fgKUs7aGkG4eAo3P/ol5CDnQvNrtoGhmhxmmijqCcVKA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857faa8f-a2a5-4f7c-af59-08d584b18f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:18.2818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
index 89c166b97e81..bfdc0a7f1376 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6761,6 +6761,7 @@ enum {
 	ALC668_FIXUP_DELL_DISABLE_AAMIX,
 	ALC668_FIXUP_DELL_XPS13,
 	ALC662_FIXUP_ASUS_Nx50,
+	ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	ALC668_FIXUP_ASUS_Nx51,
 	ALC891_FIXUP_HEADSET_MODE,
 	ALC891_FIXUP_DELL_MIC_NO_PRESENCE,
@@ -7012,14 +7013,21 @@ static const struct hda_fixup alc662_fixups[] =3D {
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
 	[ALC891_FIXUP_HEADSET_MODE] =3D {
 		.type =3D HDA_FIXUP_FUNC,
--=20
2.14.1
