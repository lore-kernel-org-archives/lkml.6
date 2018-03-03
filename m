Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118664-2-16162806591539689043
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118663; b=wH3YNMn0zukvHqYzneMRxeReKObmTRZcS9DWArPr0ee1S79
    LYYoZNHuZIzAyoibSTfYXHDLaHzNjBZuTBobn2P+beedyN/04ZZcmxxuX/Rww1pE
    XN2LbwhGlTauiTbozm7yB1rliFOaRrOclUvJOtPbdTLDSfWbeiehC1r6hQoiYT8U
    JOpo/oPg3o219dvCVqzFfloqKhxB1FBEmTKHLReX/Cbo29+7p6WgwdqWySaK5n0N
    dv2nl0RKnZQD8D6+dNcEQ+3kcHK5O1pMBWPnuTVPJT1ILjFclXW3BnJIjjZkUM++
    Hy2GqvluRte1an5Xh2JxTnON05glSRzCvcsMY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118663; bh=yoPASs
    UQm32GijiwuUOHnC8Ar/Wz1Xmgzqh2Q3+NCVk=; b=HxWWDMlWYcmvTnz3boVCMZ
    8v9CsIGGm8+PUgwJWJdIedNYDtqIRgpHJNeICyPzh3odPOVf32epLn/uA9bUbMXD
    jHvvcv/IW6m4VJfDhjKF3jgSxx2Bohhwf02/GvH2R3uFM9PE8WEbMdjHenvvM2u4
    KLtehnYMp2Vdzfv93cQhYiZrl8PEK1xsKd3UEzcX7FbUWH+f5Uj43NK1Ht+J1JmD
    mZZjE5G/FOD4TCoNHN2q3SedS5JwqEJiQBDIY+jrh/Y3hp2z0fz3p+3+Bt46uYG5
    KVt1AfejcVMELFIHqisHFjvz1OxJxzWicQ/kWLTD+wPatnluJxrebX7afF7OjDbQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rc5xM/A7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rc5xM/A7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934082AbeCCXKK (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:10:10 -0500
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:14523
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935095AbeCCWj0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 057/115] ALSA: firewire-digi00x: handle all
 MIDI messages on streaming packets
Thread-Topic: [PATCH AUTOSEL for 4.4 057/115] ALSA: firewire-digi00x: handle
 all MIDI messages on streaming packets
Thread-Index: AQHTsz9bi2lWEq40S0S4w51p9Hvo0A==
Date: Sat, 3 Mar 2018 22:31:21 +0000
Message-ID: <20180303223010.27106-57-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;6:WE5hxGk3N9stgc43SU1hT12UXRYlIcBNsLWLcnDaoNWCk5orIEbtIAKRzGlcjvcS0stFRU+6X0z+2t6CQK01Nfz7bVr19xuujLHK/+8wyPQScXWzD6rt3vgg6CGcl/doqJXjNm2RanIEtMz/wT8GnoQrdXeAnC/eNGklvjueNKJyJ/YSqJ6zjg5t70I0LSiLtaN3YgcPiAuokRGfcNur3CXHREQtErkLAzoBO8r5s5Jt/uTvRxJDWn8BT4jcDusGRgmGXHd4SYbPw3c8LMWLwIVmhoz95Q7s/LYfzCbcEHa65vf87DenhfC8GuW1YLzDunndwK8YKfT+oGRO2mA4PlId5eVduh3C8L2DrHIzaS/CiS8w0l8rqUQUPZUNqN+W;5:rUw3lx8+MIYxkoQvfjptJPVxNjqJn8XxxASblts4IoBWqll6X7SzG5nXxhRUzcjHvBj/hjHjqlbH1crdbYAM1buC1nP74ax3xbCT6KUk1qEcmAcS5aKkN/Cy9kBjgPvdfbnM/edNyG2zGUwlJbQwMubd0vLcM41uofHCYew+Pw4=;24:kLSOBKWg9PdlokC+RaY/rRZ+nS5j1UGrjj09pTSnWzfuxXaCVLMpfrWpMZrLbs4CkKJ0zd3FW0GzHf6i+4UmutIdak9YDp3wdl/VtNbn89g=;7:sdHKZQaV655wibj/tmpalfJR7BRBszXw2AmKVDRXNDwL+65L/iD07T1eNYcsWNJEpu03jwxcj6jmPdy1YOc3ozMAp0YyfADgE1mGgV1xmaNX8Y9eJ3AZh3GMJwVb6kb7P0lWs0lrAgAOb2hQAJiJ7iPuD5Ze2HukP4ygavqaalbpT1h/q6uzMSS1XUG8Hc9OCAiEYps0+QpZmgyCcCo1Vumw0qrh03bWx5gPO79L69kuh415vCB1eTFNAKLkHOWB
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11a327c8-4d57-40b8-ba28-08d581579acf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB11139A2F0B8C1DD704404FBCFBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(575784001)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(59450400001)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(15650500001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: yfm+sWp2hGe7fkq7tgyUV6My5c+4/clNWdpXEhFeYHqeMji8dODoZTOdm63VsAdW3gKttdbgfkjWszeXAK2e9LGZnY624SliBQ5GQhPSMT18HUkiMlhIpNFyp20DYoD5FBNKIIPAXCgU7V5YBccWLSi44XbWkBUd6LJio0yeiZA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a327c8-4d57-40b8-ba28-08d581579acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:21.9946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit 8820a4cf0cb4cd5c6540a9a18b2cedbdfd5a6891 ]

At a commit 9dc5d31cdceb ("ALSA: firewire-digi00x: handle MIDI messages in
isochronous packets"), a functionality to handle MIDI messages on
isochronous packet was supported. But this includes some of my
misunderstanding. This commit is to fix them.

For digi00x series, first data channel of data blocks in rx/tx packet
includes MIDI messages. The data channel has 0x80 in 8 bit of its MSB,
however it's against IEC 61883-6. Unique data format is applied:
 - Upper 4 bits of LSB represent port number.
  - 0x0: port 1.
  - 0x2: port 2.
  - 0xe: console port.
 - Lower 4 bits of LSB represent the number of included MIDI message bytes;
   0x0/0x1/0x2.
 - Two bytes of middle of this data channel have MIDI bytes.

Especially, MIDI messages from/to console surface are also transferred by
isochronous packets, as well as physical MIDI ports.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/firewire/digi00x/amdtp-dot.c | 55 +++++++++++++++++++++++++---------=
----
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/am=
dtp-dot.c
index b02a5e8cad44..30e4925bf6b0 100644
--- a/sound/firewire/digi00x/amdtp-dot.c
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -28,6 +28,9 @@
  */
 #define MAX_MIDI_RX_BLOCKS	8
=20
+/* 3 =3D MAX(DOT_MIDI_IN_PORTS, DOT_MIDI_OUT_PORTS) + 1. */
+#define MAX_MIDI_PORTS		3
+
 /*
  * The double-oh-three algorithm was discovered by Robin Gareus and Damien
  * Zammit in 2012, with reverse-engineering for Digi 003 Rack.
@@ -42,10 +45,8 @@ struct amdtp_dot {
 	unsigned int pcm_channels;
 	struct dot_state state;
=20
-	unsigned int midi_ports;
-	/* 2 =3D MAX(DOT_MIDI_IN_PORTS, DOT_MIDI_OUT_PORTS) */
-	struct snd_rawmidi_substream *midi[2];
-	int midi_fifo_used[2];
+	struct snd_rawmidi_substream *midi[MAX_MIDI_PORTS];
+	int midi_fifo_used[MAX_MIDI_PORTS];
 	int midi_fifo_limit;
=20
 	void (*transfer_samples)(struct amdtp_stream *s,
@@ -124,8 +125,8 @@ int amdtp_dot_set_parameters(struct amdtp_stream *s, un=
signed int rate,
 		return -EBUSY;
=20
 	/*
-	 * A first data channel is for MIDI conformant data channel, the rest is
-	 * Multi Bit Linear Audio data channel.
+	 * A first data channel is for MIDI messages, the rest is Multi Bit
+	 * Linear Audio data channel.
 	 */
 	err =3D amdtp_stream_set_parameters(s, rate, pcm_channels + 1);
 	if (err < 0)
@@ -135,11 +136,6 @@ int amdtp_dot_set_parameters(struct amdtp_stream *s, u=
nsigned int rate,
=20
 	p->pcm_channels =3D pcm_channels;
=20
-	if (s->direction =3D=3D AMDTP_IN_STREAM)
-		p->midi_ports =3D DOT_MIDI_IN_PORTS;
-	else
-		p->midi_ports =3D DOT_MIDI_OUT_PORTS;
-
 	/*
 	 * We do not know the actual MIDI FIFO size of most devices.  Just
 	 * assume two bytes, i.e., one byte can be received over the bus while
@@ -281,13 +277,25 @@ static void write_midi_messages(struct amdtp_stream *=
s, __be32 *buffer,
 		b =3D (u8 *)&buffer[0];
=20
 		len =3D 0;
-		if (port < p->midi_ports &&
+		if (port < MAX_MIDI_PORTS &&
 		    midi_ratelimit_per_packet(s, port) &&
 		    p->midi[port] !=3D NULL)
 			len =3D snd_rawmidi_transmit(p->midi[port], b + 1, 2);
=20
 		if (len > 0) {
-			b[3] =3D (0x10 << port) | len;
+			/*
+			 * Upper 4 bits of LSB represent port number.
+			 * - 0000b: physical MIDI port 1.
+			 * - 0010b: physical MIDI port 2.
+			 * - 1110b: console MIDI port.
+			 */
+			if (port =3D=3D 2)
+				b[3] =3D 0xe0;
+			else if (port =3D=3D 1)
+				b[3] =3D 0x20;
+			else
+				b[3] =3D 0x00;
+			b[3] |=3D len;
 			midi_use_bytes(s, port, len);
 		} else {
 			b[1] =3D 0;
@@ -309,11 +317,22 @@ static void read_midi_messages(struct amdtp_stream *s=
, __be32 *buffer,
=20
 	for (f =3D 0; f < data_blocks; f++) {
 		b =3D (u8 *)&buffer[0];
-		port =3D b[3] >> 4;
-		len =3D b[3] & 0x0f;
=20
-		if (port < p->midi_ports && p->midi[port] && len > 0)
-			snd_rawmidi_receive(p->midi[port], b + 1, len);
+		len =3D b[3] & 0x0f;
+		if (len > 0) {
+			/*
+			 * Upper 4 bits of LSB represent port number.
+			 * - 0000b: physical MIDI port 1. Use port 0.
+			 * - 1110b: console MIDI port. Use port 2.
+			 */
+			if (b[3] >> 4 > 0)
+				port =3D 2;
+			else
+				port =3D 0;
+
+			if (port < MAX_MIDI_PORTS && p->midi[port])
+				snd_rawmidi_receive(p->midi[port], b + 1, len);
+		}
=20
 		buffer +=3D s->data_block_quadlets;
 	}
@@ -364,7 +383,7 @@ void amdtp_dot_midi_trigger(struct amdtp_stream *s, uns=
igned int port,
 {
 	struct amdtp_dot *p =3D s->protocol;
=20
-	if (port < p->midi_ports)
+	if (port < MAX_MIDI_PORTS)
 		ACCESS_ONCE(p->midi[port]) =3D midi;
 }
=20
--=20
2.14.1
