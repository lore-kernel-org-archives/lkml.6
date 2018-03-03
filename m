Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116558-2-9394940858473871281
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116557; b=LHwaK0xfPRUVyNNJoA2C6l7sZFSzTgOgObuJABVf07BM1Yi
    MVClDeYO+1rjoqZR4G0JvoI/E/m/RZzSLznWsYj0ZbOeWXbfPD54QI+MqksjhIIv
    zN377Eeq6zLa7KbSR4vwOBqWGSmdmDIvqLOMdpX1/TfAHvd7e+JeHUaHVzPNKOij
    yNO+aeHCTbJu4LR+9OzlyD/zHPhS1XdqkEDmvCbBjwfRitM+Yr2BwALXu8S5u1RX
    UxRY9nlzACVlfAo4DfODqdAotaxQOUcLrSgiDcgVmNiYe8uHZnCF8uEVbNusqnDP
    DOLR7BmQx+cvHB7Eayt8RboMd3o4dE868f+fGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116557; bh=4vG1x8
    QF49hs3tNfJ1ZDsGMnhCqE1AeG3bLMgcIfLb8=; b=DClTNCf+rq4t7D4rrEpxw3
    wEszcteSNJmWipG2ZwDTH8ZMUm9lKaVksG6gWsyu6QGfZimFUGTMoOi0UnrBsue2
    sR2I8CxsA2l4wY4O+/hrTVZal/lRvLBDk0dTrquEfu0LcamJordLUJrws8+HShY5
    Hd3LzHWTkyf5Qvn140BvnmB0puB8jQxCwrntFGMkV3sbDPco52wU9MWqETzD803m
    fzZRqh/xr78tK2tn7/+U781YD+kzkyILdQdqSMeYgnoDqljzMablrqV8QClPSwor
    jhx4whJ03vHbfDas50mR9sGXZmj2JG3lSOT0IqYeeIJU6YlwxG1iFNybNgC02AtQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VZGquvQP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VZGquvQP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbeCCWeQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:16 -0500
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:59936
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934178AbeCCWeN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 116/219] ALSA: firewire-digi00x: add support
 for console models of Digi00x series
Thread-Topic: [PATCH AUTOSEL for 4.9 116/219] ALSA: firewire-digi00x: add
 support for console models of Digi00x series
Thread-Index: AQHTsz8IcCh0DoC3V0iRMi7QqJ1qow==
Date: Sat, 3 Mar 2018 22:29:03 +0000
Message-ID: <20180303222716.26640-116-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:7fjM0uerErnRTKH8VfHI7LCSDCi5mkLaVfhhKDR6aAgpXWb4SIWi8NW7m3z5i6mUQckODI2ZJiFXr1qHFmjtQG/bgdKAt65UKOp2i4I3n7qIYFI9pAdl8/5wMiIfJWiinSN2gOiYIV9yDUmcQdPlKHoK1fKjgfDOpJj/ZD0g3LpzPe/SKz0N/c7pMJGBRs72z8wzNslktfmrABWOUnlLcQJHoOSADhIq59tRk52kl+UqTrKzeU0EufjAgBeYknD9
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37184616-529f-430e-afa3-08d58156e142
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1068BF80D6FAE8E7DD4EFE13FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(575784001)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: h35in+DwF2Z02G9c2DsrT2Qp8b0oUkxz05JjzrpfMli7UgXnz6fLn1PsvvsSvGNVyezj8mLk1j/8a+V1auVHlvVZdktV/MYyJIpKMmqKwMk1/rovubYkU8FsRRBtA924Wyr2ra01pkv0x8TNk8quzBZLTfLJbnw2cEJmL2Z4Abg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37184616-529f-430e-afa3-08d58156e142
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:03.4632
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

[ Upstream commit 13e005f9f933a35b5e55c9d36f151efe2a8383ec ]

Digi00x series includes two types of unit; rack and console. As long as
reading information on config rom of Digi 002 console, 'MODEL_ID' field
has a different value from the one on Digi 002 rack.

We've already got a test report from users with Digi 003 rack. We can
assume that console type and rack type has different value in the field.

This commit adds a device entry for console type. For following commits,
this commit also adds a member to 'struct snd_digi00x' to identify console
type.

$ cd linux-firewire-utils/src
$ python2 ./crpp < /sys/bus/firewire/devices/fw1/config_rom
               ROM header and bus information block
               ------------------------------------------------------------=
-----
400  0404f9d0  bus_info_length 4, crc_length 4, crc 63952
404  31333934  bus_name "1394"
408  60647002  irmc 0, cmc 1, isc 1, bmc 0, cyc_clk_acc 100, max_rec 7 (256=
)
40c  00a07e00  company_id 00a07e     |
410  00a30000  device_id 0000a30000  | EUI-64 00a07e0000a30000

               root directory
               ------------------------------------------------------------=
-----
414  00058a39  directory_length 5, crc 35385
418  0c0043a0  node capabilities
41c  04000001  hardware version
420  0300a07e  vendor
424  81000007  --> descriptor leaf at 440
428  d1000001  --> unit directory at 42c

               unit directory at 42c
               ------------------------------------------------------------=
-----
42c  00046674  directory_length 4, crc 26228
430  120000a3  specifier id
434  13000001  version
438  17000001  model
43c  81000007  --> descriptor leaf at 458

               descriptor leaf at 440
               ------------------------------------------------------------=
-----
440  00055913  leaf_length 5, crc 22803
444  000050f2  descriptor_type 00, specifier_ID 50f2
448  80000000
44c  44696769
450  64657369
454  676e0000

               descriptor leaf at 458
               ------------------------------------------------------------=
-----
458  0004a6fd  leaf_length 4, crc 42749
45c  00000000  textual descriptor
460  00000000  minimal ASCII
464  44696769  "Digi"
468  20303032  " 002"

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/firewire/digi00x/digi00x.c | 13 +++++++++++--
 sound/firewire/digi00x/digi00x.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi=
00x.c
index cc4776c6ded3..1f5e1d23f31a 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -13,7 +13,8 @@ MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>=
");
 MODULE_LICENSE("GPL v2");
=20
 #define VENDOR_DIGIDESIGN	0x00a07e
-#define MODEL_DIGI00X		0x000002
+#define MODEL_CONSOLE		0x000001
+#define MODEL_RACK		0x000002
=20
 static int name_card(struct snd_dg00x *dg00x)
 {
@@ -129,6 +130,8 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	spin_lock_init(&dg00x->lock);
 	init_waitqueue_head(&dg00x->hwdep_wait);
=20
+	dg00x->is_console =3D entry->model_id =3D=3D MODEL_CONSOLE;
+
 	/* Allocate and register this sound card later. */
 	INIT_DEFERRABLE_WORK(&dg00x->dwork, do_registration);
 	snd_fw_schedule_registration(unit, &dg00x->dwork);
@@ -183,7 +186,13 @@ static const struct ieee1394_device_id snd_dg00x_id_ta=
ble[] =3D {
 		.match_flags =3D IEEE1394_MATCH_VENDOR_ID |
 			       IEEE1394_MATCH_MODEL_ID,
 		.vendor_id =3D VENDOR_DIGIDESIGN,
-		.model_id =3D MODEL_DIGI00X,
+		.model_id =3D MODEL_CONSOLE,
+	},
+	{
+		.match_flags =3D IEEE1394_MATCH_VENDOR_ID |
+			       IEEE1394_MATCH_MODEL_ID,
+		.vendor_id =3D VENDOR_DIGIDESIGN,
+		.model_id =3D MODEL_RACK,
 	},
 	{}
 };
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi=
00x.h
index 2cd465c0caae..43bcb0ce69c0 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -60,6 +60,7 @@ struct snd_dg00x {
 	/* For asynchronous MIDI controls. */
 	struct snd_rawmidi_substream *in_control;
 	struct snd_fw_async_midi_port out_control;
+	bool is_console;
 };
=20
 #define DG00X_ADDR_BASE		0xffffe0000000ull
--=20
2.14.1
