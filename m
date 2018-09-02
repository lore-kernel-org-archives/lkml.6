Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E943C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4B32077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DCbbh7pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4B32077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbeIBRhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:37:36 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729273AbeIBRbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVYm8u0Fgh1tjObBI4lMGKhl7HRYTsR4/Piftie6WZY=;
 b=DCbbh7pabuaO1mmrN4iTnRl5QQZu8Av6bhRp2mcewF6DVE0PYXs67DxuqviQzlW+o/NwbsjN4EdUIgzgC+HqdgUzQVbX3yQQUl8n68KSv3x2GX+5ENfONA3OxXxmdWdyjjmsxrWcR81dBeLaVaigrV/nvXW0SbyvOweqLrcD9M4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 54/62] ALSA: asihpi: Fix PCM format notations
Thread-Topic: [PATCH AUTOSEL 4.9 54/62] ALSA: asihpi: Fix PCM format notations
Thread-Index: AQHUQr75YjhhMNg9vkSS8pPTGEyIGw==
Date:   Sun, 2 Sep 2018 13:15:09 +0000
Message-ID: <20180902131411.183978-44-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:a6KsDWQtBcn6LZhmgijbKmtiwC3PrJzsS3t9aJ7CbiohIpiuBC/mVCQ19/9zjZBH43+gFZwwMjQUb4pOc3NJXajRLOEVYrz2BckPO+YOxt4oJLmZfLKVCaZXm9qNjXVneawVfmRw/CJI//3uI2vyegcL59W1fLWjNH4IyIngtc7AAO/HOPKc4kev4fR0XL2LUF2/yzKSmhtPIOmVsXzDa0BXxD1R87IdG2Q2z4Y6Ki5OKv/TC6WV44DUSWkCfJ0VM0aapXwVGMoGHGCoS7twiZQ85sb+c3BrHnaFTLHv/Q29gxwHEfRK77kIk7wQRVpw/s6Hp2lRLlv0ajiTmdIfvrxJiqG0182uuC8i4B6knuBqqZA0saDOpqwa81p/z3uC1j9ofwgzYaejwB5O0UfYR7rRACajy6Q+bQ/5NN+HYcZHCoLQoreE4Q1gANeQiM663Az1AcXL4wZCbv89W9vUjg==;5:OMNleAKKzCzxapqAdXIXqVdRGDT/TcRI4ad+CxTBnx9/WFTifFlM3F/PS3IEwC5+KzKQHQC7L6wAINa5/1OKClynkzLPZwjGyUfk+7FnVxrIHcmAr5/VpmGUc2vqZ/BEMie2DEK3OkcG3xg15obVpwRIK77cS7F68peDv6aZ9rU=;7:P28oSLMw9PdEnpzu95j/M4bSWpKvDVAoi/8MWXBalPyZl0yZ3jMn5TOW99qCWawototTMcQSGBQTpKBUN1FIRyHcxL2jasYjqLUhNHT0OcPt4hC6Z6gVL/ONTyPn9assHWGBbs3KSylsDqxWgjUMFOXpX5QgDX57GOeve0fFhWw5EYHLWJaqN/tSi82iyyzTux7pC2gSKomUW4o6y4mihwg4q/V7yWHuyfE2ujW5klV5bj1UhD6gFNdUhcJhdFhT
x-ms-office365-filtering-correlation-id: e313aecc-9ce7-48c7-14b6-08d610d62952
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018458386A5957A2DC954AAFFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(575784001)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CHWApHxI6wd/s5D99nl631uqmPJJKcrvRnWUYsawZ8FEyhRz0/jky6FjKIoSPe/pfBKgp/gD3d3o2VUggSrU0nIUcoxVQkZRycoYt1axIOTxx2DTknWEaYn6D+ayN2aa/inyrexZUh03/mw/EMe19/tgooWiopS5b0zrDsXsbm3Boo1DVmZ6UqvgS1tCURdPFrpljwvjpbW8KcvhbpFkzGA/SbzRz4ehO+hluFigmoBbAleVyak1fk6l2/HGWcYxSsuOjrxFy6KkzMygGlwqxxLxVBaqcIMt3dDSdrt6URJzYVIOVK4X99FuFO4AZBJw+Qb8oBT3eNblXOntkS6rWPXyF0SVMJsvxwhfPkTEv4Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e313aecc-9ce7-48c7-14b6-08d610d62952
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:09.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index 976a3d23557e..532063aa5d22 100644
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
