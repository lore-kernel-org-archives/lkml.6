Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117110-5-5762857620586991794
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
    t=1520117110; b=N+w2cPqLlZ8MOItbWfx9q46HHt0xg9SUFreBZqhQsi3DDk0
    ytsLjHgTLN4Jg+y8U0XziI5vCUyadlnlSGDF7/oXrkURQ63VCFJ0vhTAPI62Jo7l
    s8mQC+PeatnnqYbBuJ5vNI9lrI/3hYCytjSfEinmvJM2UAhrGC5ZO1K/xBNhuJqJ
    A/wOtmi+QZZrul+n0dbKoUQ+UqhiJ3QPMnH1qvQl5gvuFm0MvOLbTcZkWZIjq4Ic
    Zz38BWrTRiNwrKfFLM/jxvF/suIZN1ecJZ/uiRXGhNXGdgTVTDXljycR9DvopYA/
    y6zulUiEqEMVsJSFugRC9V++flEMhLc7XNhh9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117110; bh=1nIYWm
    abiuvQCHKwXYCBd+B9rhrhFhZ6OuR35tLh6nQ=; b=YRVhAanr30Gwpkh8Szp+Y3
    se62saf/zj/o9Kvxb3DB9KQD2I6hL4Z8Y42XH71IeJWQlexCBmwvQk/0Trx4ndL7
    Z78qFf2cfrG10Gl8kANMpwwJtmEHzeiJjhnj8k97JH6PEKgNRxDM5FPCFAQ/qmU5
    6W0sTFVP13FuQiZRO42cQO1hYe9usENh22lifx1Joo9+Sc/rqNjc30mvJ0U7h2KB
    +VmRZC2hR4ybcOjE7qwI4QLPKV//ew6URNFi1L9uxYtAJYb661niIcXZGonujCs/
    fXbHsQzIWDF1JiMLzeCTnQ8Bt2RZvzbS64LChclnfpjmS8uJKBplfIR1zw7oA+gw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b5JZnvNF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b5JZnvNF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933295AbeCCWob (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:44:31 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:59904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935589AbeCCWmA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:42:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 54/63] ASoC: tlv320aic31xx: Handle inverted
 BCLK in non-DSP modes
Thread-Topic: [PATCH AUTOSEL for 3.18 54/63] ASoC: tlv320aic31xx: Handle
 inverted BCLK in non-DSP modes
Thread-Index: AQHTsz+vNE3yUguHQUOIIjZQUB8slQ==
Date: Sat, 3 Mar 2018 22:33:42 +0000
Message-ID: <20180303223228.27323-54-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:LVNO7p5aRZc0mssBllVw8m13ELa4/YCHUxMB/89f07Hy7wqC/kckXH3H3qDIDaphIoLlUJm2Aqno1l96iPkOkApSVDKEFhc4Ka1W6a5OAwmuiz4v3TX50rxfhcIkhIbPgNuKLEhg0/yRBwb9/M9WjxQpqGMKh27oWIqkRY9fuDg7d8Y6pe22jN6yh9joVBWAzmjSkHfy3mtarRkBCA8HoW+uL9wc7dZ0YEm5VvfkbFT+nEF83M2U5s4MhuXvXkFZ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8acb6d4a-cfb7-4bdc-6316-08d58157f88a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB10180F623A9F34C298196228FBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(5660300001)(8676002)(6512007)(2950100002)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(575784001)(86362001)(102836004)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: PvdfxjuDWOLz2jdAXIPZCsycSJ88zRGDtb2CO2LccsRhSN94kQur8c7XL6g/S48KbxLtdHaKczAo5tLvW17935ggvuGqfn2nkMjaptZ4yztDWC4zt2TFl3BqBdz6lH/ZzBHr5tqUX1VZzozkHLRgOzk1AO6r4pJ64+CZqJcHdkU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acb6d4a-cfb7-4bdc-6316-08d58157f88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:42.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
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
index 93de5dd0a7b9..fbeb34e87032 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -845,6 +845,18 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *cod=
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
@@ -852,16 +864,12 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *co=
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
