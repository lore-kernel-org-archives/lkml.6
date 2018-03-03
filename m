Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124197-2-2768778332692455469
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
    t=1520124196; b=KJd6OT7Mwb2IJkE1rQ+hgyMDNSJb/9n4/RQWCgEIfK1ikAZ
    3Yu7Co8R/SZ23uTpq6NWE9sRQwpuH876iHzbqsVt6qVLytYWiOMgP/OEkSW/YlAF
    Y8Ozzx1VOZWDs+9wLl0uAC7YiQjEduQwcJWFdgZOAnjGaXPvUsygzBIHLK57xIHE
    7/4LTKxjhzGVsiAoYL0He5M4TW7xaINLeSv+KuP/CGWbkvsPUKC+C9cdPG9JFfU/
    eQhZ0EBZYau2M38W6pM+tiz/JAOOYwDDaysIWRp39oauMCcixC+vLnyVAKkXwAhM
    +C3wFDdZQhpnxh/bhEDuAJQrvbJYdvmy/hyCdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124196; bh=az6E6k
    4FMOYy54sp5wofDfx6kAw4nBOIOUsP1GcdQCo=; b=CtsiTGQ+C+gn+MpXnvmHYt
    9R6JEsnt/CcNWV/VdTJtNLU93D5LdTcm0rSdIIYnzyslX7TzfAICINk7uBmwScs/
    x7kG1kgk4VrhicAyH4hO2omElWY01Uv4vZnPnM9SZ3WvDWNDRQXBEDIbcAxY4Mnp
    aoJ5KPLLDnDXlsb6E+NcHMP8tLk9frdMVFRqqk0geB4qdKHrRbw4KWxRq6WTPLf0
    PoUzgkt99VjLRpeMKFlLSZBgEsVYj0nWixFR5TytE5sS5WZ/IiHQZKW872Az9P2P
    709hRwh9NTAdBTG9JSMzLyfr24V1Z7V5HGpP7NyejdN4+IqyrGrOQmuAMkvtW4GA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oAvFpSTh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oAvFpSTh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeCDAnN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:43:13 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:16768
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932578AbeCCW0K (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 043/102] ASoC: tlv320aic31xx: Handle inverted
 BCLK in non-DSP modes
Thread-Topic: [PATCH AUTOSEL for 4.15 043/102] ASoC: tlv320aic31xx: Handle
 inverted BCLK in non-DSP modes
Thread-Index: AQHTsz5oqHJB4n39A0Cnby2EjnEZKg==
Date: Sat, 3 Mar 2018 22:24:34 +0000
Message-ID: <20180303222318.26006-43-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;6:5VUvScLMSSj7+1OJNMmOye0Uo1Z4U/+EusCuMBWZO/atGYmJODe2RHjlnRNMW874Qm50QXwRAm5z6bDr1IW3PN87gPPtxHFM7xDeKqJzM+ab26tn9Ry4T2dxot7qn1arwmAC2cEnMFPEEV642CiFL/mxAvwZMPlzG7HzX3Xmduc+l0tjX06ezAc5HWNWqQZIwtBfaAS69gwb+Gxr2tp7LJnxPmGp+vUN5NgOmWVUb9ubCX6hfyBlDkJWGia2P36zTxJFB8Fvzf5igjQXpvBmNiT2imi5r4bgxvWUileY2cwrbyMPicnjK3eiwh7J2PjrFSQIAxp3FqwfZgWiJT28QD6CgYC2Li8gxQLYYsEBtIs2NvGgX+TvrbExWyOoZ3mX;5:o0Ymy1zghjEuLqOTJK16F+9/Q5EofWq5VGOzBmf8YiMLu6dislHE3LmtA7qC0VTGAhGwoXxGdl4IA9EpyqFlb3N5hgai9FXmsmtc+0G4EVNbNQN4f1Dku1wyKiK5hIxNZk7M32P6koLRt1JGtdktEFWTvuAzU02GetvAMIdGr50=;24:vFIh3GuvYXNKHdy4VQXf0zKWtFTe9Rev3OjKxFfeBi82FZ4hZpCkQPK7wyMGyYXQzOYHtq5vE2RIaTrF45Mc7uJkzyXxpQOhAwyllNq4bVE=;7:11i7guyc8dbuGjWqws8ap2HSUx+m6ZgOvPc/A/R4PDZ1/QtL/YVyB3jU+kutib18HS64S2byTHobPJ9Xb454K2vANf7CQ0NlIR6CY5Pqhvrn/cQJCPZNx8dj3dQmkELtBZid9FqAcFv/Iz5D77nt399lbCLxeznLWmt8buP61/Ch/HPReOCo77mYNenqIK2/H/7D58w+VxbXvwXGlCblzVilONAk8e8nte+0yjAMoUUzE4PrwKqhO3gZwDj+K4HU
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da3659b7-3db8-431e-8568-08d58155c07b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3535D51A4B626D073E207F5FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(8936002)(575784001)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: vglIveZA1d9NDheWgofZD3LuEFITsv7T2bnF1WtLHu3FJck6y/zRi66dUzagqyiHRvm2U0RSFZrVsZUxDHjiyaE9+yCpn8oP1DZih6V8jfAqSvk50w/PKjvHEMl2Vd2L8jInTHpiKNgsVDj2NhwDP4m7DxsVIDKwByCbvquR1zc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3659b7-3db8-431e-8568-08d58155c07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:34.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
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
index e2862372c26e..cc95c15ceceb 100644
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
 		dsp_a_val =3D 0x1; /* fall through */
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
