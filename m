Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4B3C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D51520652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SSrRuiK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D51520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeIBRca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:30 -0400
Received: from mail-by2nam03on0116.outbound.protection.outlook.com ([104.47.42.116]:39210
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729229AbeIBRc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMFwXJLoOr8iVBdY1wP2q9pCHckwopq4rZ8ucoBlbK4=;
 b=SSrRuiK6NsHM+weOwoVZ0Ry850nV1OKqYf7RFl+Lh0SF8jGXi2syWjAWbqMpWGVfeaYVf+IBAdmLW8gU5ELBivTGP8ato6zO6qCUp8ESt2qprUWCZExIQHih8x3ypCXP0+SElEmwkqmQprbl5uorPQ8cX8a4//he5w0Y3shTVTA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:16:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 40/47] ALSA: asihpi: Fix PCM format notations
Thread-Topic: [PATCH AUTOSEL 4.4 40/47] ALSA: asihpi: Fix PCM format notations
Thread-Index: AQHUQr8n96AaEW5LCkG6I6c1oWlFCQ==
Date:   Sun, 2 Sep 2018 13:16:27 +0000
Message-ID: <20180902131533.184092-40-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:tu2fDelcmCPuqtEEB+qw13HD/Xwj0xt0y7BqqyvfZ7lmwYYV3H5byPY8nOsLcrETbwL+YWzdHPc/CTurYDNSnsP8eFhgG+jUmQGwzTmEiR9f5I7HvvDlcqX+elLIrD+aVVjHhkcOpMl4AmT1CueO1XKca9ywy+cSEKCWl4Lj6FVYvlQzMWEie/X28tjfgO3JYAGjvbvEOTIgh80imiluk9qxm7W0g+ogWUvbr/TXi8v66llaYDsfN6MhqmPyPI2B3Tvf6tek8WuALqTzjqhLpbnHcFQOpQeLOWZXcaYyii+7sIKJyzJrbgFWMbCp/EY1Of6Qh0/H8+lxyZdUuU+a6l6wGxVzjQGMoTfA+NovfB6sO5cQiCPy3+oM7mHOnrtRNDskNRJQzS3Mnn8OkWz4L92Wd+nThPOS2ox+esk+v5ptwi9ToDyGlBhUdlrV9APB9CANe2F9apQxQBJnalsP9w==;5:Vqx1WBQqUVxYQX1q/bz19bZea58VGHI1v+c8tOFL5JhM7SEOIU1d/YlpC4VtyOUrLyO7r2lWm5HSA4o3njaBiEuZwqEBrjPm0r4oaVbHGk1xcMuzKiXS+kzH5E2FKabYX1Hw0OqYx6Ob7zw+CMH+r55yF4ygt4oQhKJeZGZahHw=;7:zLCU3IhqstxuHMg1Xt/OcYm7XzPqlfzPmBGGHaD7yet9hly0j9eYW7Hrl7w8ykS4BQIE8B/k8UhUWQJoO/WDm4ED25o0/v4ADgaHjky339a7Y59BEkXF0nQTzZlB8qeBos0WHKGZh6l+UR1xmhKfAg6icxCpNI4zN4vPf9p2Y7Zy2pBJbM9uj4eKgNLZoa2teX6nuHz1fxBR5Xj17tXJOyFSfPhHjlv+IlkSvm/RXIVtYbrWv3PCib3fNj+qVlpz
x-ms-office365-filtering-correlation-id: 8fc24993-d641-4043-a143-08d610d64cb0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167804BC6E7BC4862757001FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(575784001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ACHSNaLXdmzUTW4F/anxDfvUi73HutmJpSo0RwTCDkEWrKdRi63mKjI4A6pPbOnnIgqEFbJgcJ1OEGQNC/VzLpZTVbBxNz2DI6HFco/+viakh+nzolnq1SRDUc7nUuTgJzkGtl84OmrxzP27IdQ8yGHB5NrXldHjy9l16n0ghqEiUDHD3O9w89b5HZW1HPen83kZFBF2QWgTqma5w+3nkq+V2Y2rrBMPchDFrCJCh29pDZaDuQhsGtHv86Z3VzG7cOJ50NJDI3f/uKlT4bSJ6vIuzPsCZT9zYZOF5cLacvhnXmqoqrRjy1B/JOQG+gh86AIvkZ1yN9tXuy5uGjr71MUpSRnIzepBXRrZc39BmCA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc24993-d641-4043-a143-08d610d64cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:27.2288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index 1039eccbb895..50f4185b2bd1 100644
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
@@ -1030,7 +1032,7 @@ static u64 snd_card_asihpi_playback_formats(struct sn=
d_card_asihpi *asihpi,
 					format, sample_rate, 128000, 0);
 		if (!err)
 			err =3D hpi_outstream_query_format(h_stream, &hpi_format);
-		if (!err && (hpi_to_alsa_formats[format] !=3D -1))
+		if (!err && (hpi_to_alsa_formats[format] !=3D INVALID_FORMAT))
 			formats |=3D pcm_format_to_bits(hpi_to_alsa_formats[format]);
 	}
 	return formats;
@@ -1213,7 +1215,7 @@ static u64 snd_card_asihpi_capture_formats(struct snd=
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
