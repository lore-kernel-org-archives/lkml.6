Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD92C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C246D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IoGc4bnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C246D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbeIGFSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:52 -0400
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:60384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728827AbeIGFSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6A5mE1qeiSKUHgv4ox9tjNzwLAs+0hUfzO8DhZ2GhY=;
 b=IoGc4bnq7c3pnUHY4ky83yLIHLUpm4rfxpS4hFu5H7E0U9kfOGIc3YoikMSD0Umuack3wZAVE5YBWnnOeOkf1oKgRW+Rl/G82/smyQa/z62LtcVoECyGYj8SF8F2rCqXlGkRdvbQFKuGgx7wq/k5fNKqCTwxI1U32hkmNPkTcRU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 03/43] ALSA: msnd: Fix the default sample sizes
Thread-Topic: [PATCH AUTOSEL 4.9 03/43] ALSA: msnd: Fix the default sample
 sizes
Thread-Index: AQHURkMTazzjS4wUdEGY3i1PJ5Y+Mg==
Date:   Fri, 7 Sep 2018 00:38:21 +0000
Message-ID: <20180907003816.57852-3-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:H17LyvSCdQi1mta4s3KAT3TgmYprFCfpXqfGoRkGupy/Qxb0JrxWbE2i/nWLxdU9Z5NRhKMbfLZwvKE7x9AVf7iRRr8DcAltYRCyiHipXpkj7/kIqF0y6kWsm5kGo8yIim8BWSvH6vVXvFzOS5uckV46e9qz+wV5HzjxUP1LLIaTs6xh4QxiGRHtfBgld7bxZPoYolRiXM0ggaFoJjlVmJpJMogCeX3xf/pbtV/vJj3SfJX9AVd6lBezQyjnqkq0vKf4uMMJMb7VbxMzvKXnvC3A6TFry28jXcI+2dl3DcnzmHbp9H+u1Cqy2W25aZhqpcvTXokXkfqGP0Akgu2u4RyNxh0sjrCTUJN6wGDC9KXegB5vT+FyJ3YKeSwhF5ft900QB7gHa+C4H90EabW/GO/WJaLuIhW1eAWSZWSGME+WfmCGCnI63XdE/695/JPdXb0W9gRLL91H9ktPR3vJIA==;5:0Qtg+XPL5UX2W106dHMgNDH84Tlwg+ngbtslnKBYphWl4/7gXEm+qfwgQ7JZcq5XMJ2N5mZp1yNohoDRWy2iQgjfaZVhHC6EQqQKJUmkefDgDe9y4XMAr6mcUuh6O22X4xjxy8a5jaikiTKQMTSUmN+sJ/8VRInjzAZt+VzaBpY=;7:yyNhuXoCdYUMt/7q7df20g/Avt1A5Z5dz7Vgm1mIj9YgHMmVXHdF0LEkBSgL/NXCcs8sW049stv4Ef/5bboVe8ER45WdC4YdTCyJC0uM4uM4ZCwWuUjoO2/XVsntr8LRBnnX4Nv8H1yVrwWawvoF/6lGf6jvxxEc7ERNsC2amuJt9++aGeRyfzS7dgAdjxJkJS9qnrAejUW/ebsxw1TsV+JuN3+tHc0j2dVtppss1Nq2k6nehPp2M2yC3o1ULWEC
x-ms-office365-filtering-correlation-id: c488f54b-935e-4304-17f7-08d6145a724b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08554B2B94CBBD13CFE5425DFB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CZw46tQeZZnT4SAS2fngUtZebYMKbqyxJnjlbPk4i2tNe9XUwOMmdgHATJwKgTkHyK3fg95HFTzSYdlqll/FZ3ymgg1lNxSDp2X+u2Pu0OmiU6VH4cPEvW6NG/4RTIXEPxYNkppquHWFxpEZCnkDhvd8uZlV6o+Ko6el+p8rE/UQFhbzVJTSk6Cm3SupXF/NaOXk/AkWCoxLXujYkTQFF2tB0VMIzcNHAxzRLsi27YV9PfcyhoqGHGZrTmWWGqPzsG2qEk9VVKSctokmZekoS8SCNWnecqNc46BLTmopvavikHcCC8GEHTLGiCMo3KL1IgyTvxFn8JuHgJ09Yrz0x6pMo5d63/bdk2TAeHDJWXM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c488f54b-935e-4304-17f7-08d6145a724b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:21.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7c500f9ea139d0c9b80fdea5a9c911db3166ea54 ]

The default sample sizes set by msnd driver are bogus; it sets ALSA
PCM format, not the actual bit width.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/isa/msnd/msnd_pinnacle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.=
c
index a31ea6c22d19..2d7379dec1f0 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -82,10 +82,10 @@
=20
 static void set_default_audio_parameters(struct snd_msnd *chip)
 {
-	chip->play_sample_size =3D DEFSAMPLESIZE;
+	chip->play_sample_size =3D snd_pcm_format_width(DEFSAMPLESIZE);
 	chip->play_sample_rate =3D DEFSAMPLERATE;
 	chip->play_channels =3D DEFCHANNELS;
-	chip->capture_sample_size =3D DEFSAMPLESIZE;
+	chip->capture_sample_size =3D snd_pcm_format_width(DEFSAMPLESIZE);
 	chip->capture_sample_rate =3D DEFSAMPLERATE;
 	chip->capture_channels =3D DEFCHANNELS;
 }
--=20
2.17.1
