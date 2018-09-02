Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912D1C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40780204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LtJXLRrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40780204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeIBRVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:38 -0400
Received: from mail-eopbgr680092.outbound.protection.outlook.com ([40.107.68.92]:55808
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbeIBRVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RBUYRb+VSN5tCxbcGtS4YWIzgXmB6eIdxFkmAb6bzU=;
 b=LtJXLRrXCe6ajhdxj+YFknPymfsZkzyM7TLeYN9k2oxo0oS4wuCWEWlhzVDh2c05yiV1a4LM3gMWqzDOEi6XZiT4uUoYxX5FLFAJe16vwnz9tl5ufBYJLM5RZBQ3JNXvu0yDcZv7rhKMYmOZtLvjvjcindEsptyPCdEYYj/7lcs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:05:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 118/131] ALSA: asihpi: Fix PCM format notations
Thread-Topic: [PATCH AUTOSEL 4.18 118/131] ALSA: asihpi: Fix PCM format
 notations
Thread-Index: AQHUQr2fhx1/SCe4hk62NpebWNdQyw==
Date:   Sun, 2 Sep 2018 13:05:30 +0000
Message-ID: <20180902064601.183036-118-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:QtVwb+mx7aH+gtJB8Soha19SiUlsXDVBJs34Zj9kAEgbQASmWQlrwudsQOmxR8EiXFQXyROuc2eIuSR0GSesSHwMbqjWI/q3lN87dQU6/z+FoacVB0WO/PAfFA1TC1juZyLgFMtmYvUO2CN51kWX7vOUOi5zbh0zKxagZI/fKJktnRTOlRaEu65XAUTi1aqppWbnJWqa7frz+NBhdpw3GKcroDK7UA8TtHliyDOI1Yudag+8nwljj1Fysnm0H+PdeylTv/vQLDX40DNBqsCShOKr/PZybVLg1dei2cVr3SEdYp1pH7+kziJG6N/cR3JgrM0hgM6QVFormUD00/GxC5tDqkq61j2c9lRnJKhHBAc8ivgXTZ3Arr1IN3RROeeeAuw1smc8wXOvQX0zhon38+84KmMNDE8sjOuOSgg2YnuiUV9MX0UI69dbCiYiw1VP3bwjufJJQlv+ltjvcVuLLw==;5:LRy09WNkQfGbVoHK0CziXEsPUyNe7uy30V7vxZlgsYQVgin5X/FspoleKC4Buj66wrYRq55s4PEUo/3vt9EXtCaaWayNcBAg/9fsKsd/iep1GMPo9CUJAUweuFmxnRR7CK8h6tsORVFN3CyKowkpi1sGuIFb40XTdYi0U3UUrzM=;7:GWUzQU1k55Mg5q9t13StApP4sKja9Q+NDvGz5vRB8SzUELbHaA7JW8711XcHncWOJTnwsn2RFbv4Oa7zxE+KKwgktKTmMMZkD+hqWou0+nQAVX93miO3TiUr9az2h0Yn2eBLU9pUOax6D1B7gNsGsy40flWWHx7VpzIieMSd6N9wJdrf2TncVFnO33AqzgEM5I0K1rVPGes5JatqHK+30Ml2jTQsBjaN6VXFZ1E1M8lUv+Olbc2TQgtHjpJEPJWG
x-ms-office365-filtering-correlation-id: 44f90609-ecdc-4475-64a5-08d610d4c97b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062969B5379025AE0FDF0E69FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(575784001)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: lHJrtZTGHZ+3OhXW6muDfwnM2bly0QPqNExTr6KKvBmSK1oaXnODsmur6niur6UMQbyK2Kcr9jI9JpTqUPPpcx9bsQshptUYOSUE2Qurvd1l7a5LROHbhLMgnhN2CcDo4vDty/PhzDZpGGwraVpDAC+/BwZmvWli8J91s+p+11KMSwrGGcvaoJh1mGNRjQ3yPOPVexqvGuTnpSw+NzT7RxSzn0R4jkatPyfvvmwZDJz/d0AmaBGXf+bDCfU/rkTwl6dVQTWRhJSc0+nv0IswEnINgz+O+ufoEu199rsqF0yHmFzZSUac5i/0HIhDfnPSldKy5ei4bPEhO/UgoWB3agtVVzB24ir+CHoMvSiy0dA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f90609-ecdc-4475-64a5-08d610d4c97b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:30.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 64e0961f93ba..a31fe1550903 100644
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
@@ -1023,7 +1025,7 @@ static u64 snd_card_asihpi_playback_formats(struct sn=
d_card_asihpi *asihpi,
 					format, sample_rate, 128000, 0);
 		if (!err)
 			err =3D hpi_outstream_query_format(h_stream, &hpi_format);
-		if (!err && (hpi_to_alsa_formats[format] !=3D -1))
+		if (!err && (hpi_to_alsa_formats[format] !=3D INVALID_FORMAT))
 			formats |=3D pcm_format_to_bits(hpi_to_alsa_formats[format]);
 	}
 	return formats;
@@ -1205,7 +1207,7 @@ static u64 snd_card_asihpi_capture_formats(struct snd=
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
