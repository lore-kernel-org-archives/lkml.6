Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821992085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="1jFGXWns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821992085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeJKGui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:50:38 -0400
Received: from mail-eopbgr720104.outbound.protection.outlook.com ([40.107.72.104]:58272
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbeJKGuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88PjDmSy5vl6FCmMfsX0WtbZ68xn1922PFkFWpJ5mdQ=;
 b=1jFGXWnsdPCX491Fj/MgJ6isCLN0e2sPjV/iviBn8ThP2Z3iBK7cmqOWsmgoZ4rR9ubmD6o4S2G5hiVOY8cMBheWIhxXHPCwzCkSrBo/gGR8yKOY4cIFJDPIRIPSGrJUWSgXV5CcRaGYbBCbh22E7vzPRCjH1/VmXZKT1wzvteU=
Received: from BY2PR1101MB1126.namprd11.prod.outlook.com (10.164.166.136) by
 BY2PR1101MB1110.namprd11.prod.outlook.com (10.164.166.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.22; Wed, 10 Oct 2018 23:26:11 +0000
Received: from BY2PR1101MB1126.namprd11.prod.outlook.com
 ([fe80::fd98:861a:f053:9930]) by BY2PR1101MB1126.namprd11.prod.outlook.com
 ([fe80::fd98:861a:f053:9930%2]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 23:26:11 +0000
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
Subject: [PATCH 2/4] ASoC: max98373: Sort BDE Limiter Thresh Volume in reverse
 order
Thread-Topic: [PATCH 2/4] ASoC: max98373: Sort BDE Limiter Thresh Volume in
 reverse order
Thread-Index: AQHUYPCgDDbjAo1Efk+WSzsvN2iz9Q==
Date:   Wed, 10 Oct 2018 23:26:10 +0000
Message-ID: <20181010232222.52340-2-ryans.lee@maximintegrated.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR1101MB1110;6:E+fMMYnXTMfmGp3bNY1TWcfnXKrei61tCSZ2PadmpJcl1ez4dD22VytzDnFDNHWhzMyNLuuPaMtlByMLQTt+b9YAvJnmtRQRk8MwvfSPFMjaqxcvGo1Lp16rGKv10BbnI+EZtMCfWrBtwDR9UZwa7R0tJroUj4Bd1PkqmcoWK15u7W6/BqHIhYT6lCx2M6Ywiot7q30JBLMqAg1CAyPiwzHq9TQ7V2CUMrc8ivZ1ll3QW8s2uvVWgQOTAsoY6EWfpo2L6yKvjTiFwgH44L95Piv0DAUF00hPSnIDeEhfVLzB8qgVrscbpc8asYLynij/QT9xqarGX0pq86oluQHBwioSnKUs81VnLHgRN3A45gRU4QRPFu905Mo/aII6e8+rEOETyXX1eZ6azqAYPcycjQrKJz3Wrng1RL9NWcg/tFM0h1+yBevRShHBp05rzW1INC4KRI5GxvAPOh7+DYjdjUZ40jy57OCr1c8Ekiichk8=;5:tyXnQNAvBu697dLnDdEq1mHgWBtgrnoW4qV0ibT83cDQ+PRAxqj9ddIVpsOo/CfLVdCQfREplhBAZ1TpB732sJexznL6Rpqdk4Z39TcyxiplV6CTyPzlDsgsntQAQXsocHB2U8BH3Je2mVc2QF2vfOO5p3hbwkU0BeVvUzCCZ4w=;7:2cn3lQZQmGgYaAT8ZPBvGhBsi1FC6tKaMoBUqcSMQ7ERYNKs1qSAox/vUL2lyqWJi0gCHW3icerZpAXqRRCHEQJEA/znIj8EB7utYXpnkEwOwrsCrIls9+YlpZBRCFJqoShMbryu9cQClka2fPCaRIRbLRMEKAzyq8ay1iaVvVbxLP+aeZx4UdorKTagceXIqMhHXM6y7c2gVbV4tPwNGg7/9pDnEaU/sCZuljIcbsj03w5hQSQtPRxFqzCTg+PV
x-ms-office365-filtering-correlation-id: bd56a433-430f-498d-6500-08d62f07c324
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR1101MB1110;
x-ms-traffictypediagnostic: BY2PR1101MB1110:
x-microsoft-antispam-prvs: <BY2PR1101MB11100DE2719EBA79F06F615BE7E00@BY2PR1101MB1110.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(108721460000369);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:BY2PR1101MB1110;BCL:0;PCL:0;RULEID:;SRVR:BY2PR1101MB1110;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(316002)(6512007)(71190400001)(99286004)(105586002)(446003)(1076002)(6116002)(3846002)(11346002)(36756003)(53936002)(26005)(14454004)(102836004)(8676002)(110136005)(186003)(6436002)(66066001)(25786009)(81166006)(106356001)(68736007)(6486002)(81156014)(8936002)(2616005)(476003)(6506007)(5660300001)(7736002)(478600001)(76176011)(305945005)(72206003)(2900100001)(256004)(386003)(39060400002)(486006)(4326008)(2501003)(2906002)(14444005)(97736004)(71200400001)(86362001)(5250100002)(52116002)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR1101MB1110;H:BY2PR1101MB1126.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: 9SfihfbKmKmz6rS4qNBdZzL8Nhr+skxWpiVzsPA/k5DmnS/xRD+kjJWhQn/f2yq4MDr3N+gbc5XqogZ6W/dE9sgkpsnC4j7fCUoda5fW3+dVlVyW70sjrRRT87iD4Ph4I/CKuZZx+5yt3IlEMKM1SU3tn3wJpVai3lRAyeur+3OU2LRsT7M+pzApzljVHNICPCEhOpSivEQs10XKXHOfj+eMw8Ci7xM/P+EyZNkWxxCeV2aMu12IR8ajEoywyc7JfBZ/FOVxUczFhdsyfe4FjziqjLan5tUmjTDiho5PQsuzOxYEyEzu3rJc9WWn6oqmNcGckBRzAlDnzEYVs9TEmO35RW+aSHVz6H1B9oN3mdM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd56a433-430f-498d-6500-08d62f07c324
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 23:26:10.9677
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
 Changes : Sort 'max98373_limiter_thresh_tlv' in reverse order.
           Fixed wrong use case of 'TLV_DB_SCALE_ITEM' - TLV_DB_SCALE_ITEM(=
min, step, mute)
		   Max value was set in min field and negative value was set in step fiel=
d before.

 sound/soc/codecs/max98373.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index bb5ef52..1f5887b 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -478,7 +478,7 @@ static const DECLARE_TLV_DB_RANGE(max98373_dht_rotation=
_point_tlv,
 	14, 15, TLV_DB_SCALE_ITEM(-2500, -500, 0),
 );
 static const DECLARE_TLV_DB_RANGE(max98373_limiter_thresh_tlv,
-	0, 15, TLV_DB_SCALE_ITEM(0, -100, 0),
+	0, 15, TLV_DB_SCALE_ITEM(-1500, 100, 0),
 );
=20
 static const DECLARE_TLV_DB_RANGE(max98373_bde_gain_tlv,
@@ -669,13 +669,13 @@ SOC_SINGLE_TLV("BDE LVL3 Clip Reduction Volume", MAX9=
8373_R20B0_BDE_L3_CFG_3,
 SOC_SINGLE_TLV("BDE LVL4 Clip Reduction Volume", MAX98373_R20B3_BDE_L4_CFG=
_3,
 	0, 0x3C, 0, max98373_bde_gain_tlv),
 SOC_SINGLE_TLV("BDE LVL1 Limiter Thresh Volume", MAX98373_R20A8_BDE_L1_CFG=
_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL2 Limiter Thresh Volume", MAX98373_R20AB_BDE_L2_CFG=
_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL3 Limiter Thresh Volume", MAX98373_R20AE_BDE_L3_CFG=
_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 SOC_SINGLE_TLV("BDE LVL4 Limiter Thresh Volume", MAX98373_R20B1_BDE_L4_CFG=
_1,
-	0, 0xF, 0, max98373_limiter_thresh_tlv),
+	0, 0xF, 1, max98373_limiter_thresh_tlv),
 /* Limiter */
 SOC_SINGLE("Limiter Switch", MAX98373_R20E2_LIMITER_EN,
 	MAX98373_LIMITER_EN_SHIFT, 1, 0),
--=20
2.7.4

