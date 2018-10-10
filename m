Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919572085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="RjMOmc1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919572085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJKGup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:50:45 -0400
Received: from mail-bn3nam01on0095.outbound.protection.outlook.com ([104.47.33.95]:22587
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726568AbeJKGuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRdr2VixlmG1onPiS/4hvFStareTWSqBrwB5WAW/crw=;
 b=RjMOmc1DkAEbPFHOoQ09ThSAeCbkZk+DngHo2E7DnMF6MlHcJY/ox4cvw/5ZO4IpApdWAMkj0f1+7ZgtvrRobPQI3mNXQJLivvGXXNFk6bwU+wwYZUlPagFVdRviBqumGIUzqNyMunfsfkbPsiWVerhxSJCkLRMZXJnMlDMkgnE=
Received: from BY2PR1101MB1126.namprd11.prod.outlook.com (10.164.166.136) by
 BY2PR1101MB1110.namprd11.prod.outlook.com (10.164.166.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.22; Wed, 10 Oct 2018 23:26:17 +0000
Received: from BY2PR1101MB1126.namprd11.prod.outlook.com
 ([fe80::fd98:861a:f053:9930]) by BY2PR1101MB1126.namprd11.prod.outlook.com
 ([fe80::fd98:861a:f053:9930%2]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 23:26:17 +0000
From:   Ryan Lee <RyanS.Lee@maximintegrated.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
Subject: [PATCH 4/4] ASoC: max98373: Sort DHT Rot Pnt Volume in reverse order
Thread-Topic: [PATCH 4/4] ASoC: max98373: Sort DHT Rot Pnt Volume in reverse
 order
Thread-Index: AQHUYPCkrKbNO5wpqESIHgUOxKsuUw==
Date:   Wed, 10 Oct 2018 23:26:17 +0000
Message-ID: <20181010232222.52340-4-ryans.lee@maximintegrated.com>
References: <20181010232222.52340-1-ryans.lee@maximintegrated.com>
In-Reply-To: <20181010232222.52340-1-ryans.lee@maximintegrated.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.56.39.241]
x-clientproxiedby: DM5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:3:23::18) To BY2PR1101MB1126.namprd11.prod.outlook.com
 (2a01:111:e400:5a72::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR1101MB1110;6:3isKuHHlZFl+0Czcup3NDS9EsNw/Gm/LiY830/WYyxStAAwdiOfHI/5w0Be+CiUQv7gOlm2he2ys8lGu//KU0J8rpBrEEcqJP9ToerO6ByPo6MdhEfuPwRT7GzWjFFItG5uzkLMmoFQhuhyQmPZFcXVZ7yenVNbtoF9CWdQ9HCzmeHLSKdYJQROYJvlFtWfGKBASzms9r/kjHDhu2pa/Y6exeOywZKr6pfz66OyMZzK4HGqJxBRG173FDoKDoij4D8z3R6rmvLyH6kmiMlLUbspIJr+hSfGzX5OvqDEeEUwJ2+6BOylufavTTYFOLwXhY7vRrHUdvqj++0ldQ62lwJNGThJtHL0CyTt57zmyqexXxcW2BoNOnNZfFENajHCTRYm4lKwjvL+XBGFo6B8awXhXo9oSUx5sU+HoF1dxCOVlwlENTXLCLe6Rq6XFlmgGc/CMJr3eyMlAbj4Wl3xSkhCgZOiR6DDFCvUDVfXU9p4=;5:EYSx6rrPcgdYQ9wOoSW5gu4ZxDPbNqsXAmbgYultI6FwvxIenO33r0QA9Sq8VnXt5Wfu3vsrEOeQjsU/ZFmztTMa6B6cLWr7XzdH0N9FTEiDseSwb3OaYyikJbD1yxH7E+7vHdwWty4dawohiteh4urZ0Fz+XXFIyPcs9Q2vegs=;7:+goTKmaqLeaeP4hC4o9cr99kHNOKqrpDikdifMBjBfnKcx4UbrMeYn5GvHmLSmgEzQfpNCGy4ROgJ24g8bh5laXYiukMgqWa4/saCKacc7ynvTsYmIVJ6LGiXEN3JoIzKoQ/sQdadnCpzctzAHm5vCMo6WlR2JZzPE0ltV9f3y1/5L+JEUSQ0x2lPXy5GEdrAqmJSSBQ1r+4fsqN0Ph+sT68r0mA0+H6VG/SX//a+eIpm+yhnqu4BWsPr0hfChsG
x-ms-office365-filtering-correlation-id: 31f3f312-0bbc-40b3-0bc7-08d62f07c70f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR1101MB1110;
x-ms-traffictypediagnostic: BY2PR1101MB1110:
x-microsoft-antispam-prvs: <BY2PR1101MB1110BFA5D825BF43F47D91EDE7E00@BY2PR1101MB1110.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(108721460000369);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR1101MB1110;BCL:0;PCL:0;RULEID:;SRVR:BY2PR1101MB1110;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(316002)(6512007)(71190400001)(99286004)(105586002)(446003)(1076002)(6116002)(3846002)(11346002)(36756003)(53936002)(26005)(14454004)(102836004)(8676002)(110136005)(186003)(6436002)(66066001)(25786009)(81166006)(106356001)(68736007)(6486002)(81156014)(8936002)(2616005)(476003)(6506007)(5660300001)(7736002)(478600001)(76176011)(305945005)(72206003)(2900100001)(256004)(386003)(39060400002)(486006)(4326008)(2501003)(2906002)(14444005)(97736004)(71200400001)(86362001)(5250100002)(52116002)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR1101MB1110;H:BY2PR1101MB1126.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: DTqY9ZT+5m5PccpFZgC0fTanQWKRpZcVycG0i0znspQ0NxT5xf/oVDJKNXCZAWohWfWA+w6b/fTxWtGkvtoUsk1EU07B/RBWczjZsvYva/5MCtIBPv0W7vz/ktn8TnKu+pOf3aYcpKQj2D1qO4dRqkNkcOhzfqe2LwsljSu1zuqrPifLarhT1nEb8FIvl0dThAtE3OnLq/nnOjk3vxKjI4NG9dqSIqrZFao6D4eRnp0QpliFjmzK72xUw6uxkDx06lgt7AsXGvBC7UFKRrEdm0cSg8U59P5X0r0lX3KCseK99spAAGTm/gjmhl6lzsrHbq48EddcVvEzREexkrkR3bXRGAjyDInQco9cyVKuAgo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f3f312-0bbc-40b3-0bc7-08d62f07c70f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 23:26:17.7198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR1101MB1110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 Changes : Sort 'max98373_dht_spkgain_min_tlv' in reverse order.
           Fixed wrong use case of 'TLV_DB_SCALE_ITEM' - TLV_DB_SCALE_ITEM(=
min, step, mute)
		   Max value was set in min field and negative value was set in step fiel=
d before.

 sound/soc/codecs/max98373.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index e9c082c..e75c212 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -470,12 +470,12 @@ static const DECLARE_TLV_DB_RANGE(max98373_dht_spkgai=
n_min_tlv,
 	0, 9, TLV_DB_SCALE_ITEM(800, 100, 0),
 );
 static const DECLARE_TLV_DB_RANGE(max98373_dht_rotation_point_tlv,
-	0, 1, TLV_DB_SCALE_ITEM(-50, -50, 0),
-	2, 7, TLV_DB_SCALE_ITEM(-200, -100, 0),
-	8, 9, TLV_DB_SCALE_ITEM(-1000, -200, 0),
-	10, 11, TLV_DB_SCALE_ITEM(-1500, -300, 0),
-	12, 13, TLV_DB_SCALE_ITEM(-2000, -200, 0),
-	14, 15, TLV_DB_SCALE_ITEM(-2500, -500, 0),
+	0, 1, TLV_DB_SCALE_ITEM(-3000, 500, 0),
+	2, 4, TLV_DB_SCALE_ITEM(-2200, 200, 0),
+	5, 6, TLV_DB_SCALE_ITEM(-1500, 300, 0),
+	7, 9, TLV_DB_SCALE_ITEM(-1000, 200, 0),
+	10, 13, TLV_DB_SCALE_ITEM(-500, 100, 0),
+	14, 15, TLV_DB_SCALE_ITEM(-100, 50, 0),
 );
 static const DECLARE_TLV_DB_RANGE(max98373_limiter_thresh_tlv,
 	0, 15, TLV_DB_SCALE_ITEM(-1500, 100, 0),
@@ -616,7 +616,7 @@ SOC_SINGLE("DHT Switch", MAX98373_R20D4_DHT_EN,
 SOC_SINGLE_TLV("DHT Min Volume", MAX98373_R20D1_DHT_CFG,
 	MAX98373_DHT_SPK_GAIN_MIN_SHIFT, 9, 0, max98373_dht_spkgain_min_tlv),
 SOC_SINGLE_TLV("DHT Rot Pnt Volume", MAX98373_R20D1_DHT_CFG,
-	MAX98373_DHT_ROT_PNT_SHIFT, 15, 0, max98373_dht_rotation_point_tlv),
+	MAX98373_DHT_ROT_PNT_SHIFT, 15, 1, max98373_dht_rotation_point_tlv),
 SOC_SINGLE_TLV("DHT Attack Step Volume", MAX98373_R20D2_DHT_ATTACK_CFG,
 	MAX98373_DHT_ATTACK_STEP_SHIFT, 4, 0, max98373_dht_step_size_tlv),
 SOC_SINGLE_TLV("DHT Release Step Volume", MAX98373_R20D3_DHT_RELEASE_CFG,
--=20
2.7.4

