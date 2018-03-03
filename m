Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119707-2-718050695870649484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119707; b=eF8BWGberFd98l4MGCBZ/TjXiSGiiJIsBkgR7C9fhFpnWcK
    uk4/10IRaouHuz2ZQLmAUNnTDFTyEoSO1DvaBjP5WkAemWcCF60UpkrNSct8icQJ
    Hqt/zCtZoSBEGOKIjrYf8dLHULVREF6wnf0toXtLAN0LfY8da+1NEXXXbkqzp69g
    0oZ83CZN6KHkeR1kEZbAL4MX8OEgcmHYhqJOuPzqXHj/WLmOVMzXWKVVEN/sakJE
    xPHKFl8LGBWBhHGEQCDldugAac2uWj4X0ov7T9J95YTqZyM3yqTpwtSQwwTOVQCJ
    vWYqHpmYXikjr3EWmefXrcjs5Bi+FhL1he1VyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119707; bh=g/MRVW
    ok/v5hognfOM7Omj1auMzds5SFLruDmu3Q0wQ=; b=IQ50Ov4d/eguGv1+EHOigX
    t5+HSIWJbFaQCDCCT8Phc0YsYs7dLipLEdAgcXFPK3LHeovJgKksMtau8vfK4wxK
    1cbMVTPjLOs9OUUwzIz39Dgo3rVWlb54vhO0ZZII2T6w0n7F/aJVJdsbZFaT7aJn
    SHOaEhY1ICbOVgbsYwb1zx1GhW3BYpeGjQa5W0kWmESCyJIJhzzVR8GKs+m0RuOs
    k8RiBdgUT1zZbzX1elUHCiWiHnIWR/GzKaN6lDzp/ZSwkHL4vov8hWexHAb6nZcP
    ovWSQpsjt9MJUACU4/rG3+Y5x6MLWdTBUxwnsCz0cQaS2gyHl1fEC1dsnZ2Qsjmg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O68F56oP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O68F56oP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934611AbeCCWgz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:36:55 -0500
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:41088
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934633AbeCCWgv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 190/219] ASoC: tlv320aic31xx: Handle inverted
 BCLK in non-DSP modes
Thread-Topic: [PATCH AUTOSEL for 4.9 190/219] ASoC: tlv320aic31xx: Handle
 inverted BCLK in non-DSP modes
Thread-Index: AQHTsz8ieLQuJxz8vUy7le716As+3Q==
Date: Sat, 3 Mar 2018 22:29:47 +0000
Message-ID: <20180303222716.26640-190-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:I7VTjzeULbzCVAJm4fFA7BygGlxlnpGoCyzi+HZLRU8VuykpuU47SNTLvKqpveTxKbwbku710Pl2mO4jlTf3oK6b9t3OS3SPKw3QZ32nNLkitRG9WL6C6kTMW0A2JdUMSJFJMkfhvfMEu+bG0wmteVcC8cWUrgpWz6M5mZ2cEuWGX57dib+0exW8023PEAnr/2TFMRlxe7s19UQwMWY0Jn9NkBw4qhCDaSBB/I9Vp7vb5mRzzJ5NdTItJI4MOGv4
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b9e627c-4c8e-4cb6-e5e9-08d581573ded
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10202BE87D3CDE737386FC61FBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: y1xirg8NLLjLHW1Oc7SU0mDK+s6VicUcXckBo+BPiXhq46E0G/8SZNaw8Bm6E0XjQG30P/DJLAt8gq7D1ZircqJU0gVGAC1N8lCC/tgU/FB9rOelBpH7PfPqXORx3LPndBiPrwa54iBU/g6TZV1er5E/CnCceXKF/JMaWfLJLVw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9e627c-4c8e-4cb6-e5e9-08d581573ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:47.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Andrew F. Davis" <afd@ti.com>

[ Upstream commit dcb407b257af06fa58b0544ec01ec9e0d3927e02 ]

Currently BCLK inverting is only handled when the DAI format is
DSP, but the BCLK may be inverted in any supported mode. Without
this using this CODEC in any other mode than DSP with the BCLK
inverted leads to bad sampling timing and very poor audio quality.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic3=
1xx.c
index be1a64bfd320..16b0e600ed4c 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -924,6 +924,18 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *cod=
ec_dai,
 		return -EINVAL;
 	}
=20
+	/* signal polarity */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		iface_reg2 |=3D AIC31XX_BCLKINV_MASK;
+		break;
+	default:
+		dev_err(codec->dev, "Invalid DAI clock signal polarity\n");
+		return -EINVAL;
+	}
+
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -931,16 +943,12 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *co=
dec_dai,
 	case SND_SOC_DAIFMT_DSP_A:
 		dsp_a_val =3D 0x1;
 	case SND_SOC_DAIFMT_DSP_B:
-		/* NOTE: BCLKINV bit value 1 equas NB and 0 equals IB */
-		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-		case SND_SOC_DAIFMT_NB_NF:
-			iface_reg2 |=3D AIC31XX_BCLKINV_MASK;
-			break;
-		case SND_SOC_DAIFMT_IB_NF:
-			break;
-		default:
-			return -EINVAL;
-		}
+		/*
+		 * NOTE: This CODEC samples on the falling edge of BCLK in
+		 * DSP mode, this is inverted compared to what most DAIs
+		 * expect, so we invert for this mode
+		 */
+		iface_reg2 ^=3D AIC31XX_BCLKINV_MASK;
 		iface_reg1 |=3D (AIC31XX_DSP_MODE <<
 			       AIC31XX_IFACE1_DATATYPE_SHIFT);
 		break;
--=20
2.14.1
