Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97ECC2BC8C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A9A20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hde64YUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A9A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeIGFOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:18 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:4506
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728091AbeIGFOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2nLBP4opMy1O5sJ/NV5pxkvJ8oVgGDcyqNU3r8a/UM=;
 b=hde64YUvrk8+8PiGBT1gHaj6+UoW3GuJDj3PftTrGAnjI+TYIXQaknOzD/FDQ9N4Qqpk7Qzah0aQpXMsH+VoAJgXD77WB+dPPfnsnJKTZ1jvaEQLnWMeG41pUXNSfRW3MFd3L5JUd8FstHtbWbkXvulKI6DazRNVVhWERHyrXOI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:35:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:35:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 08/88] ALSA: msnd: Fix the default sample sizes
Thread-Topic: [PATCH AUTOSEL 4.18 08/88] ALSA: msnd: Fix the default sample
 sizes
Thread-Index: AQHURkK/+gUcndfg+Ui0/3AkPdw4LA==
Date:   Fri, 7 Sep 2018 00:35:58 +0000
Message-ID: <20180907003547.57567-8-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:kcirMZn5wbTD1dFOwhdMXJVMmg0OQJWDbCn03Y4icY3xqDDIWlB9Y9X889K0JDDj5rpdPJU1VcPH3w4lTZIHRD4Jj10pg0w22pLTfLwEprM78ZPG8arCx5QqxsRf6zzKO73dnLtnxr3+LyHenBY0LfZLPvcao9rH2rphl/BFtMXRHgpFCQWmAcUvmwLak4uSXCAJ682nJE10BYjzx86UWDL/PrFhDWoPmJNKjDgfDFxNBUVBnFIqrudbofi1zLfUxdSoeEixXl7cbJllfldPihvLDsbCUpEZE/pXi1MlIw8m8WFuGT9fe7OGs7ZL40wvNv9jXBbNON8rvjwtlHEibe3mLW55uIeX/DLObaQOwVXTNHJS0WVoQHtJ06OrIDHIXa1jOD7AFjNKSYDHDwmVd+6n/H+ivyjbzTFhYzHlDeZJ4L2mbAkHbxe3BH5mbN1l+PKIsG5GxqZMwRvY4bgUMw==;5:d08yQKVZKuDyzLbwi1gtD1ImCQh8vnZvglFjBeh44HTSBvgve7UUNIAkfNlza7rfxMYMDBvck4Je1DjQGL9M8WSI2cmsfMXmhFVyusaOXP4MLV2wBcdSGNHyGpm5enezw0iKx1QCb918O8POzcC1suG7tLzzF5zuV2EfPAqtZwc=;7:XpHGI5YasWvyOwuCY4+uIFl5vbPjwXb7zva7dwMR9EcOpuB8lQbX1c/wMtksd/vFagOweQdmmaIRpzMslS/AOvta6rqlBo4X8nLn3wcxC/reve46XeHdh0q3jZlcdh+vRGrF7S0tmE1LybceRGBhVCqzSRDF8UIJw+ft7GupV8Nxa+pBDgHBTrz2uGqgQoG0tj/gcv2cLJwuYhcUBRwBUP6oKcjilR2GmetwPIcM+SvuSg9b8B9rckBW1wjg4FkI
x-ms-office365-filtering-correlation-id: ca8bc496-2ecf-4c21-fa7b-08d61459e1a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773000FF4AC55FD9D2F3E4BFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Jrfpw8PIrg2QBPvQkH9B8NeWnx4tdLajA/ZrZOoi35NZDxyx6oybtzCzp6uUHXe/kbIaJe1ES0IRmWMTIbakXCXzx2hf1/c8xtGZ3epYzZq3pfFB6u94tgOZhmSbdhT3tbjQ7LNY31BGts0cWRjv+/GnwyV3I7oxjuD4MPp88w+wQLXQN6eVmV7mqBJ7o/KTGEIxBMB83dIEoUjo69RqWVh9NhZZrKUmTCCAeFYjRNG4ypb9QWoOK6Yil8A8SS2yPKzW3MGApFuLc7tegSuKykd7VQtutHntwQvgM7LHo+BV0a1arm4N9bTZlMQreYUAu+0YKxpdoA3ePJb/lKPF5frf7annknXhalA3+KTZHVY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8bc496-2ecf-4c21-fa7b-08d61459e1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:35:58.8351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
index 6c584d9b6c42..a19f802b2071 100644
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
