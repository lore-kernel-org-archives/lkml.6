Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FCDC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC71620855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hs7ueTzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC71620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeIBRYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:34 -0400
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:53408
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728146AbeIBRYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaQqtBveHKs11hQ7gIgRfbecdPpUpn7BukjMXSs4coI=;
 b=Hs7ueTzchli+Po5+fAyEcn4qgwnR2ay8+HsTIEG7hJXiW2nmDXXHNoa5TyDpbHcxLTQfdRaaYiQd8YlNleZFX2V3URKMvHjCikdpBhGIEBylkmfJwhJyO7WC3pJ2dslCtEC+xNT93hZ8lUyskmI7i59jEcFvlkMPm/FTEheWkI8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 81/89] ALSA: asihpi: Fix PCM format notations
Thread-Topic: [PATCH AUTOSEL 4.14 81/89] ALSA: asihpi: Fix PCM format
 notations
Thread-Index: AQHUQr3yAyxHCcem/0+lAsR6LiwzfQ==
Date:   Sun, 2 Sep 2018 13:07:48 +0000
Message-ID: <20180902064918.183387-81-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:cV/aNJFwj9G95nPIbx4+5F/q6dPX2F/97+DbF4UiXYgu9HTERiYrAeSBvc3jLgDeLdm4VIkGpj782AuhI+nYvoWgfX9vk+txwkF732mAVovZKpqu1Omwo7vyltGhdb0gIOuigNHNVzXOVweDap86eMFitSVpACWvAtXqv8csz6h4G+WSOpN5hNKj4vZlLf1Uj/dfrzvs4kedDSTfGpvFZ9xVVhpBmfeRnjW0phs+MoGTNEB+3lbBXrDc175+WAVR6LQNdcl4Kojj6NuaPtWJCGf7+wKxvCBRYcqH5N1WVck7CW2yy4oqoNTtFjZX8Ws9apFfNaaJS9R2X5R6x/tKihouPvr6OkLVnQcPmBuQjG7LrnY4aUGs9vtbERIoRFbzr/1FcPsUVpTYoF5AdKJPw7iysvzQiTquu+21ifc/YOzuIFZbuyGnosVtGm3jNG7gN1BqSj+sBJUdMAvGHI2S0w==;5:RDnIHbL8UMBPZcEACESxP8axBJJoEV38OMBTXf3pCZkO7hppaiGzhkUk/hiTWO98jMp8XuvPNhs7oW5f1SM/84ZAMph6CIojMMXtaYL44KQWeMRcOfVb73AtRxJTvXxVl1hzRWuIYTQcahoUwbA9ZBT+/wLFVzWmN/MDBAPBb34=;7:Uxanv0zBaP5ZtnsWSXauIQtZ2pes0AqE7bbV55yFefRjHtaUQPl8kfepsZPYC0VuvIBSuAEO4QGZt5LSGtd+lKLNJCluNRNilQq9RktplaL2KYv4TV8yMLCKHrRn8/hc3Fv5SFiiK741AmRxBQiILN3OLMwCYz8l1F3fjRFLCBFrBHIOvQNYWFoapgOqabjjcBUBc2PL0wI3zJe9Dea17SNXduOLuwSjd51ABTnde9Liw1HHD6doHdEy48xH0FlJ
x-ms-office365-filtering-correlation-id: 1a2f7c10-45de-4d3e-ab45-08d610d53785
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB046962D58ED0A107E5E61A70FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(575784001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FEDCagZRsw+GJYqmW9S6UTP7hisdMJsFqXJ6lY2vRyVQXR4st3vxxEYVfL/CkBHIPJru8p3iHhEVOWy1/DY6dcHZHBGMyO90FLlRfDXwpcFQoFnZE5C30JW3iIclw8PhUphZiXC14qJZzLBfa7hu+OdrIY3zB9WUu+vwbJ74MNpvhTaK1yH6uXFKgsyMokZHI4nOPESyE/awFpegeozL19VUrsKxT5YWJ7zS50IeGyo/ahFS81XrmXSIOlcgMjCkcD9G0qNVaxn/hh0lHYySzWmNcqaIpG1Vm3QPSxX/bbT+54Z7Nq6kTCGHSvaW2BTUTSdA+Iz9KjrqEacusqpnzicRTyCCXcBpbIEDyOuLmEY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2f7c10-45de-4d3e-ab45-08d610d53785
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:48.5845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit a91a0e774984aa57090c39dc3269a812417737ed ]

asihpi driver treats -1 as an own invalid PCM format, but this needs
a proper cast with __force prefix since PCM format type is __bitwise.
Define a constant with the proper type and use it allover.

This fixes sparse warnings like:
  sound/pci/asihpi/asihpi.c:315:9: warning: incorrect type in initializer (=
different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/asihpi/asihpi.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 70d023a85bf5..b86b0b5c00df 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -311,27 +311,29 @@ static void print_hwparams(struct snd_pcm_substream *=
substream,
 		snd_pcm_format_width(params_format(p)) / 8);
 }
=20
+#define INVALID_FORMAT	(__force snd_pcm_format_t)(-1)
+
 static snd_pcm_format_t hpi_to_alsa_formats[] =3D {
-	-1,			/* INVALID */
+	INVALID_FORMAT,		/* INVALID */
 	SNDRV_PCM_FORMAT_U8,	/* HPI_FORMAT_PCM8_UNSIGNED        1 */
 	SNDRV_PCM_FORMAT_S16,	/* HPI_FORMAT_PCM16_SIGNED         2 */
-	-1,			/* HPI_FORMAT_MPEG_L1              3 */
+	INVALID_FORMAT,		/* HPI_FORMAT_MPEG_L1              3 */
 	SNDRV_PCM_FORMAT_MPEG,	/* HPI_FORMAT_MPEG_L2              4 */
 	SNDRV_PCM_FORMAT_MPEG,	/* HPI_FORMAT_MPEG_L3              5 */
-	-1,			/* HPI_FORMAT_DOLBY_AC2            6 */
-	-1,			/* HPI_FORMAT_DOLBY_AC3            7 */
+	INVALID_FORMAT,		/* HPI_FORMAT_DOLBY_AC2            6 */
+	INVALID_FORMAT,		/* HPI_FORMAT_DOLBY_AC3            7 */
 	SNDRV_PCM_FORMAT_S16_BE,/* HPI_FORMAT_PCM16_BIGENDIAN      8 */
-	-1,			/* HPI_FORMAT_AA_TAGIT1_HITS       9 */
-	-1,			/* HPI_FORMAT_AA_TAGIT1_INSERTS   10 */
+	INVALID_FORMAT,		/* HPI_FORMAT_AA_TAGIT1_HITS       9 */
+	INVALID_FORMAT,		/* HPI_FORMAT_AA_TAGIT1_INSERTS   10 */
 	SNDRV_PCM_FORMAT_S32,	/* HPI_FORMAT_PCM32_SIGNED        11 */
-	-1,			/* HPI_FORMAT_RAW_BITSTREAM       12 */
-	-1,			/* HPI_FORMAT_AA_TAGIT1_HITS_EX1  13 */
+	INVALID_FORMAT,		/* HPI_FORMAT_RAW_BITSTREAM       12 */
+	INVALID_FORMAT,		/* HPI_FORMAT_AA_TAGIT1_HITS_EX1  13 */
 	SNDRV_PCM_FORMAT_FLOAT,	/* HPI_FORMAT_PCM32_FLOAT         14 */
 #if 1
 	/* ALSA can't handle 3 byte sample size together with power-of-2
 	 *  constraint on buffer_bytes, so disable this format
 	 */
-	-1
+	INVALID_FORMAT
 #else
 	/* SNDRV_PCM_FORMAT_S24_3LE */ /* HPI_FORMAT_PCM24_SIGNED 15 */
 #endif
@@ -1026,7 +1028,7 @@ static u64 snd_card_asihpi_playback_formats(struct sn=
d_card_asihpi *asihpi,
 					format, sample_rate, 128000, 0);
 		if (!err)
 			err =3D hpi_outstream_query_format(h_stream, &hpi_format);
-		if (!err && (hpi_to_alsa_formats[format] !=3D -1))
+		if (!err && (hpi_to_alsa_formats[format] !=3D INVALID_FORMAT))
 			formats |=3D pcm_format_to_bits(hpi_to_alsa_formats[format]);
 	}
 	return formats;
@@ -1209,7 +1211,7 @@ static u64 snd_card_asihpi_capture_formats(struct snd=
_card_asihpi *asihpi,
 					format, sample_rate, 128000, 0);
 		if (!err)
 			err =3D hpi_instream_query_format(h_stream, &hpi_format);
-		if (!err && (hpi_to_alsa_formats[format] !=3D -1))
+		if (!err && (hpi_to_alsa_formats[format] !=3D INVALID_FORMAT))
 			formats |=3D pcm_format_to_bits(hpi_to_alsa_formats[format]);
 	}
 	return formats;
--=20
2.17.1
