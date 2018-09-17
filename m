Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A76ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6641214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FbVGX7QJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6641214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbeIQI2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:07 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:22121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729476AbeIQI2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUeOSGerKGTlpEu3taAcTmL04E7xwzGlJ5J9/fYzarA=;
 b=FbVGX7QJ2tzgQiePktQECOaFBdQGPHgQSUOhUo3gnRuMg5z3pi5qvZlRFC0BStLix/yK/dD6cSwEHSyLyFNx4Wf4TACFoA6F0H9C0IWleNOsSWgsxsEjZW/lrKGpT0eYzqCasgibZIQ14W2SNo2XmqdgLBSccsUxrJoB3M5G4S0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 114/136] ASoC: Intel: bytcr_rt5640: Fix Acer
 Iconia 8 over-current detect threshold
Thread-Topic: [PATCH AUTOSEL 4.18 114/136] ASoC: Intel: bytcr_rt5640: Fix Acer
 Iconia 8 over-current detect threshold
Thread-Index: AQHUTjK3SmkbmVwuwkOPrHePhOZ6mA==
Date:   Mon, 17 Sep 2018 03:01:23 +0000
Message-ID: <20180917030006.245495-114-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:CN9oVobUgiJ1u2jKFVPNGU7Rl/4CPdc25aN9t5Ny0C1cStsxWvHiuOZhbTEc2Xh9CsSO4UvG76vJFOs/EU2IkC0MyzCFs00o3VsxcExaSFyXs97otgGyUX1on+kgZAyRaEraq4MCm1E1EI2C4/8zAQocG6HLcdXyZxTsHdawgbP2eLHbbmwFXn1kKC4Dvo4mPvSG2/kQISfOppeMu6aYBLjdmTaESvtUUi4QSPip/GLOO1Lv6YtgmKQ02idx/ew8mV0zykW1lnpFFxEbsMEeCoFVoI6pM3NsdLSBcHat6TJ+BzVgAWWaBjycVyFE1EzoZqV7gL6eGzfkyLBZ1ZjDzDLlZ/zySLVSVrETfNDfHvTRrinbFEhJNZN5SA3Wfwxpe3TMpI/Cq+PfbUXZUm2YpZpW4T5w7kV1OEcB4Bu+UXbS6c2Oebm/KXv/CvunMDe0lxpD26mC+e82gd8HU8XcrQ==;5:gudIsppqvVj+fRWy30XR8PZzQlejYwAf+mxInqPoFzbf2EDdPolgYLkwU8LWAXhgnG1SXLnJPiBpAoftS6Cqh2HlbrwUWox4hfP99Uoluf4F6zUTFi7WpjA+uyNkOhpHTByQ/a9+dXkSECfm6LPQ9QEv2N/inBETd+1ZLDgSpD8=;7:QT4X9xM3OEdiwQ9BoNKI4jj8w9y7t3MNPfa53ZUobY7+hyYmYCKycG89FDkGmKyYH4rp23XCvqMsOnB+pUF0QOaSeb2v+eIketKCMq2L5ivz8Bqq2gMNgJcMmKiuSW5R6L17D99so/0/BBln2uXUmB6LvlipVgxXr5TSVCY5geHpFOpff2BWXfaR96X9zWxXQ+Zr1/tY4Mt6oYK4YXJVqKmoXxgrJHusDH3GiTQdaY3H3pji/F0nDYV2/n24V3Xo
x-ms-office365-filtering-correlation-id: 47f41d4d-263e-467a-20fa-08d61c4a0b71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB0168A79AFCEF486F9BE0E98FFB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(575784001)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(14444005)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: er1U2heszfmEu77dB2wJEpHQeKpqtohq3wsBXEsiSPKMIiLYmt53za/OjGEyMp9FOhN63A81MgV3bysPcQTIBIX/O7DO34Gp8Zx70oeTvl7MRAcGth7Kl4qMHs61Dk2RJ8RG+iluvMtNk4JuL9qeDfC55+rZRuEjI5cZGUC3p7qFrK6bV0Al3VBjTRyP1S375LfvPbKEetJXRzd+hqzeNTOxn4Ks1XquFw2vBX0AXt3ebSHxCe9zt9mlH46kjHvDQxJuUCOOfbN269zP1J7d6X1zjwt6+gYpIyPaSlO1PaDy1vhOsRLEWEtKkLAQTXb/JQa3ZBfeKx4TcHAtgE+7C0PVznIg63KLKw5zOr3Oqfw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f41d4d-263e-467a-20fa-08d61c4a0b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:23.8541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f12a0a3c4cc6f594d7c2ea361f2396ae5c518d2c ]

Change the over-current detect threshold on the Acer Iconia 8 from
2000ua to 1500uA, this fixes headset button presses not being detected.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards=
/bytcr_rt5640.c
index 33065ba294a9..d2c9d7865bde 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -404,7 +404,7 @@ static const struct dmi_system_id byt_rt5640_quirk_tabl=
e[] =3D {
 		},
 		.driver_data =3D (void *)(BYT_RT5640_DMIC1_MAP |
 					BYT_RT5640_JD_SRC_JD1_IN4P |
-					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_TH_1500UA |
 					BYT_RT5640_OVCD_SF_0P75 |
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
--=20
2.17.1
