Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120639-2-476032761312810601
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
    t=1520120638; b=Vo/edez+hsh0C21wYAM8B/yTSEETOsejMWVZvytjCK1UXPd
    VE6PehdJCGaQjwB+VKOV61gIfRgqYSew0rKbXlzV1uzw6UalyDV/Zlld3u3YtQ5R
    07spRA+HM14fjhHML+wQsGrVxbOo7uxd4GbX0J+rmYM0Q2Sehw/1LhnOi6se2Exw
    J6vac/ch3gW7wsbAqJBoGnkLhyv9TzZ5ujX8Bu/XflcqcBgO/z6E4OB9n+pnYQQ7
    291NYd174bg1gOSDCYRsxZMbwvi1pg3b7dUlP1YPH2YCwMWY+JtgD2I5O7+qe28h
    Ra7+JEKtEYtCWnT2CU9ZiC42g72DUYu3+WsY5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120638; bh=YkFo7h
    J5rXC2P4dHTXeGKCvZXRxXMF/gV+0l7JODyw0=; b=LrUjqbeiLQtmZLQjHWsMk0
    u0eH+IS6iKRFc+bKbItBFjqayfThZFQDPxvf0EOxTANwM/eRCqjygMJX59zConVr
    zoRyBc5zvXB02eH1XZzx/qpGNBwrpXliG5K4OK3Qh8em9A7bEcmKOl4+5cTgg6zz
    Ket0h0bgIMWCOrUY05pbvpJgBFBJgrWJhrXAA7cC/VscXcjzPDyOqoxjPxrxQgt4
    AVtbgGbdfH1PF4ujOl0SKlQHuNiqJReLq+YzjvCAv6/Knm8601ln0qTExIRABEs0
    KS54hdBwRYw7J4OOMNMzNRCqT4IVY2E/3RN0cuEXFGfK+sOO28Ki0hRV8qjdwIPg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X2nCEW9l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X2nCEW9l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933459AbeCCWei (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:38 -0500
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:51939
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934179AbeCCWeN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 117/219] ALSA: firewire-digi00x: handle all
 MIDI messages on streaming packets
Thread-Topic: [PATCH AUTOSEL for 4.9 117/219] ALSA: firewire-digi00x: handle
 all MIDI messages on streaming packets
Thread-Index: AQHTsz8Js6e3gLL3rUKrv3k4mxfRrw==
Date: Sat, 3 Mar 2018 22:29:04 +0000
Message-ID: <20180303222716.26640-117-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;6:0VbRfAc1w8/BV9oJW2WcQR8rW110aDw1Bi4zkbY4KDxbuGzTFY1/kI0/5avXcWzOqcF+zZ79gV0LizYsoPV8TuMlU1bsIfCtvRtgF6IBH0RAhtD9SLeea2ZwClSG39IM9GConMtKaXgSDgnj6b47+q+cameXi+Xn3nt10xFSwQqpzgNNPEDomNVjIHacwoWez0xghJABt1lM/eSgB07BxK1I87QCSx0yDmbROx8QeGW8jC0R2uG9k9dNS5F76IIfCe8wCg6A4ak+ptsUi8lvBTqqsOXqBp7k0cGwYnzLmclymuvLBCMuvlODcNvHhuYoeyguwX78cw+jtTb4mUB98Do4wElzTy5FQqXtD7XRulBZjeGxb4qn87ymqaMzUESS;5:Od+NXXAYqAWofXdYjGfqV8s1UsNIb9S6UJMDx5LKS/nesRw3pi75wnXY/4lXYVp4x+0bAUSyCcKSHUiG7X0rOZGnt41C8xu42yhBznHiEk1OSSmYw/V37xXoh53qxnlqF6FfDsthR2Uuy8OF5iUJFXKisLnlVeX9ZHr3iQPcA3I=;24:ufz+IM3TgdhYyiwcGew5AradtwMdtpzXUzFl8enRMmlpKa7mD9yVu+Y+w2IjHuTivUNlCUPtHup1fFmqy7Wsv7WtOK6hYfgKmzJL7lqHxqE=;7:GxfArBrMvFGnPWBBqqMuBXBIQgcn4qAMUULG7RofnpmTP9l224Br0TD9fCa2tqRoVUe9K9DF6e5+vC8MRM2YOqwRv535ITrVIW6iqmye1rlEyRj1gIjFsKCDlD5jbyWpaf5Lnc7IIvh3X1EUCyNERqCDblV+HbWtBh3qMuwrQ3RUnoVL0deij8pRt7sCmoWWBEvpPXTVpE3ruXJ5n/ReSMlwvvPY44iCt18V+leScxCxakJh4phutOvWJF+/4gVa
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71abf8c2-3b8d-47da-5dc6-08d58156e191
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106832853A49314DD5861BCDFBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(15650500001)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(575784001)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: pYD/ZlrYAex5Ng2DAMb9mT2E52KSh2ietXVa+25qI+i//drcHC4X/e3/JSupxithW9msbaPk3CS4lr7Fb/Ddff08c6hMdnE4o6k3uwuWMwCKVhBsnryisPAecKrPF3UQ8oUMngXsShepkIuqtwaHCuDA7oeOLoPOGDq42knj1Ns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71abf8c2-3b8d-47da-5dc6-08d58156e191
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:04.0882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
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
index b3cffd01a19f..a4688545339c 100644
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
