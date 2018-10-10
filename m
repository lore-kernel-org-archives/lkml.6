Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA171C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B83E2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="Kr+OJo+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B83E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJKGul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:50:41 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:40256
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbeJKGuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnTQ2GMlW0+q5W2FhsM+HN7aKZYJvA/Mypk4k28XZrU=;
 b=Kr+OJo+I7uFVCEYP9E3bIxC4ezXc+FQBG6aU9MCVyOYlCTDK4gEEfzdRDkofXrFmrGzhjT2CcTOzEKho+uaYIeABPYh2icUsb6lwFO54BBdrMPdho7nQ9JkPd+QSIhV9LyjOKOQrLAnRMvPN6UR1qWxk3crtK4K+eYZ+ljyd7Ks=
Received: from BY2PR1101MB1126.namprd11.prod.outlook.com (10.164.166.136) by
 BY2PR1101MB1110.namprd11.prod.outlook.com (10.164.166.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.22; Wed, 10 Oct 2018 23:26:14 +0000
Received: from BY2PR1101MB1126.namprd11.prod.outlook.com
 ([fe80::fd98:861a:f053:9930]) by BY2PR1101MB1126.namprd11.prod.outlook.com
 ([fe80::fd98:861a:f053:9930%2]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 23:26:14 +0000
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
Subject: [PATCH 3/4] ASoC: max98373: Sort max98373_bde_gain_tlv in reverse
 order
Thread-Topic: [PATCH 3/4] ASoC: max98373: Sort max98373_bde_gain_tlv in
 reverse order
Thread-Index: AQHUYPCiJHis+hD/J0KkFkH+Pfr3bw==
Date:   Wed, 10 Oct 2018 23:26:13 +0000
Message-ID: <20181010232222.52340-3-ryans.lee@maximintegrated.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR1101MB1110;6:5TQXexFUaFdIpOsN3RGmOi0zkQ9SQjlAO4Jt9ON/SYAFQ7VvZo6aIVEMcZevRe+dT+OHFHzNWZJ/HRTDoNAb4a3XBBT0IjKC5cWXxtQ9oqkXB8Q/CzsXrMQEEAtnTTJMdXd0E1XmANymF5JX0xgWj9RcOeEaS3u/cIslqLp/csPrXwy3oA+osjAeeG465lyFSg8MS0l3U4c7nzNsQBvtEhDCDA6gx5ul0ZCX/y0+whAypQrKKOk5QjNZH0q/GVCEgnX0XohKGmRJ6gv8s1oAByRMX55KWNv90/u6BI86Cu+Vp53nL9s1ec5bFDhigRXMvG9dEAirtbopGi968T8JtGTKY3Ez0RPPZPjKaJNbtPl7VFow4DOKbA5c1x9fhpNrz/G9RTZ3wOmDB/w3reZ+uuy0dS6hdT0cArIiKFoVCqHkHzd7GxKxQE8OdJZSW8uvDAhsInwFdJKqXYUM4ujKEDxEL4eqQYpM+dk1BG0gS0k=;5:fSnlG+rY5xX6IFO2bdexzl4Bl9mSyFJuyJZ2wvUbA41PHycJKPKK6OrrGP7BVSHMsCMYWfiMlCAYKBYtnaUkWRvo9MCaIS9VGv5388twE9K4Xe1o7weIoEw+DZnu+DkIdgJYBkrDN0JYenV/dvP+IDVSOmRQLcJlUR79pMBE27A=;7:jzC4Us0wuSKswPkQG3rtGRtZSdSkIUznDjXpHr2oZNfIQzeVnJ6cgTk+Gj7KcNFzf6x8mPm+1r+DDsIOOruleFWxbEdaf+vodz8nmgMfdtFCNWeSERQcv30aGjvcUzMJF/Gsz8uXfMFzP94bemNLqB+bi3ctAenZ2fGrL8Q8uue1VwlfrL0UZZewfsmaFRZPSsl9dasqefpOZ+w41G0aLoV20BmpEUR1ubxK/G2BKpITrsE70YrQq/lbUohfJpYh
x-ms-office365-filtering-correlation-id: e653c74b-2a10-43f8-0ff6-08d62f07c4eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR1101MB1110;
x-ms-traffictypediagnostic: BY2PR1101MB1110:
x-microsoft-antispam-prvs: <BY2PR1101MB11109BD4E908C4EA385585FEE7E00@BY2PR1101MB1110.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(108721460000369);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR1101MB1110;BCL:0;PCL:0;RULEID:;SRVR:BY2PR1101MB1110;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(316002)(6512007)(71190400001)(99286004)(105586002)(446003)(1076002)(6116002)(3846002)(11346002)(36756003)(53936002)(26005)(14454004)(102836004)(8676002)(110136005)(186003)(6436002)(66066001)(25786009)(81166006)(106356001)(68736007)(6486002)(81156014)(8936002)(2616005)(476003)(15760500003)(6506007)(5660300001)(7736002)(478600001)(76176011)(305945005)(72206003)(2900100001)(256004)(386003)(39060400002)(486006)(4326008)(2501003)(2906002)(14444005)(97736004)(71200400001)(86362001)(5250100002)(52116002)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR1101MB1110;H:BY2PR1101MB1126.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: 5J+kFGXoBNfzB/eJy1OScCTQGSR2v33nlE36eM1aRFGfGBUd4q9MFder/E8m+WSQWnmoyWAStlvxEqourB6lFzsnBYZjgj28442SmW2fwlVnSWGdVtQ5ujKm1e7QE+y84yBDL0vbzR7JEW1w74294e6fL48WlFbPIxPSHE/9yMYnfpO5a3odGu8/HIWTxC8zLdRqPuYGT2tMx3pXCqDNcsvKWXCMULA6kiRNJ4mxT32fuH7sVkD77CK4nfgegKJgO3mNOJq5ARjSqyC4LZ6xqMEJXjsCUIrSu80HE6lxt4F20WRlzI7WiAOM938JCDJcRANzenmss0IIvuBvHfd/zXYFgFrco0OnjKLUMYy/odo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e653c74b-2a10-43f8-0ff6-08d62f07c4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 23:26:13.9564
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
 Changes : Sort 'max98373_bde_gain_tlv' in reverse order.
           Fixed wrong use case of 'TLV_DB_SCALE_ITEM' - TLV_DB_SCALE_ITEM(=
min, step, mute)
		   Max value was set in min field and negative value was set in step fiel=
d before.

 sound/soc/codecs/max98373.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 1f5887b..e9c082c 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -482,7 +482,7 @@ static const DECLARE_TLV_DB_RANGE(max98373_limiter_thre=
sh_tlv,
 );
=20
 static const DECLARE_TLV_DB_RANGE(max98373_bde_gain_tlv,
-	0, 60, TLV_DB_SCALE_ITEM(0, -25, 0),
+	0, 60, TLV_DB_SCALE_ITEM(-1500, 25, 0),
 );
=20
 static bool max98373_readable_register(struct device *dev, unsigned int re=
g)
@@ -653,21 +653,21 @@ SOC_SINGLE("BDE Hold Time", MAX98373_R2090_BDE_LVL_HO=
LD, 0, 0xFF, 0),
 SOC_SINGLE("BDE Attack Rate", MAX98373_R2091_BDE_GAIN_ATK_REL_RATE, 4, 0xF=
, 0),
 SOC_SINGLE("BDE Release Rate", MAX98373_R2091_BDE_GAIN_ATK_REL_RATE, 0, 0x=
F, 0),
 SOC_SINGLE_TLV("BDE LVL1 Clip Thresh Volume", MAX98373_R20A9_BDE_L1_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Clip Thresh Volume", MAX98373_R20AC_BDE_L2_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL3 Clip Thresh Volume", MAX98373_R20AF_BDE_L3_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL4 Clip Thresh Volume", MAX98373_R20B2_BDE_L4_CFG_2,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL1 Clip Reduction Volume", MAX98373_R20AA_BDE_L1_CFG=
_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Clip Reduction Volume", MAX98373_R20AD_BDE_L2_CFG=
_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL3 Clip Reduction Volume", MAX98373_R20B0_BDE_L3_CFG=
_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL4 Clip Reduction Volume", MAX98373_R20B3_BDE_L4_CFG=
_3,
-	0, 0x3C, 0, max98373_bde_gain_tlv),
+	0, 0x3C, 1, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL1 Limiter Thresh Volume", MAX98373_R20A8_BDE_L1_CFG=
_1,
 	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Limiter Thresh Volume", MAX98373_R20AB_BDE_L2_CFG=
_1,
--=20
2.7.4

