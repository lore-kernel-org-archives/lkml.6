Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C8FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7F620651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="s5dBniu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfAGN1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:27:07 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.5]:43604 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbfAGN1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:27:06 -0500
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-central-1.aws.symcld.net id FD/2F-19140-6A3533C5; Mon, 07 Jan 2019 13:27:02 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJsWRWlGSWpSXmKPExsWSoc9grbss2Dj
  GYMkUMYsrFw8xWUx9+ITN4tuVDiaLFWcnM1pc3jWHzaJzVz+rxa//z5gsNnxfy2jxcvMbJgdO
  jw2fm9g8ds66y+6xaVUnm8e8k4Ee+94uY/NYv+Uqi8fm09UenzfJBXBEsWbmJeVXJLBm7H42i
  6VgsWTFrLkPmBoYr4t2MXJxsAisZ5ZoPtPE2MXIySEkMIlJ4tBGbpCEkMBjRomlM7uZQRJsAh
  YSk088YAOxRQRqJR59OMEEUsQsMIlZ4uKPtUAJDg5hATuJScd5IGrsJU6s3scKYRtJ/J7XyQJ
  iswioSFx/fI0dxOYVSJTYd28LM8SydkaJqRPbwRKcAl4SGzacBmtgFJCV+NK4GuwIZgFxiVtP
  5jOB2BICAhJL9pxnhrBFJV4+/scKUZ8qcbLpBiNEXEfi7PUnULaSxLy5R6BsWYlL87sZQRZLC
  LSySyy+8YkJ5AEJAV+JB2+yIeJ3GCU+Nqxnhhm0/OYJqMUWEku6W1kgbBuJcw+2s0D0FkhcPm
  wP0fuQWaL19lWoZTISi+92Q/X+YJU4uiQKEtTJEh/mnmWfwKg7C8lvELaOxILdn9ggbG2JZQt
  fM88CB5igxMmZT1gWMLKsYrRMKspMzyjJTczM0TU0MNA1NDTWNdY1MjbWS6zSTdRLLdVNTs0r
  KUoEyuollhfrFVfmJuek6OWllmxiBKa7lELmlzsYvzenH2KU5GBSEuW1O2IUI8SXlJ9SmZFYn
  BFfVJqTWnyIUYaDQ0mCtyHIOEZIsCg1PbUiLTMHmHhh0hIcPEoivMIgad7igsTc4sx0iNQpRl
  2O451f5zALseTl56VKifNyAdO4kABIUUZpHtwIWBa4xCgrJczLyMDAIMRTkFqUm1mCKv+KUZy
  DUUmYtwlkFU9mXgncpldARzABHfGSxwDkiJJEhJRUA2OLQZ/Pbas2GYPLN6P2Fraoy+hvOGWt
  HN2rt2phoL8VH1eupXrz/YBe605JP/EmFcH37lt5/GT8NML3btl6YulDiw4dpQth8xXyZDNbL
  0QaPPad8WbOFPH4Cr1j75YX6649s1edx+jTa7MpBzQkbtVd1JDn3qk7j+3x4wuTjp27cTdLaZ
  FZsBJLcUaioRZzUXEiAKnWZfT9AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-12.tower-229.messagelabs.com!1546867621!3553958!1
X-Originating-IP: [104.47.0.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19690 invoked from network); 7 Jan 2019 13:27:02 -0000
Received: from mail-he1eur01lp2059.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) (104.47.0.59)
  by server-12.tower-229.messagelabs.com with AES256-SHA256 encrypted SMTP; 7 Jan 2019 13:27:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btP8ivoQrddU/1riV9i9ZpnP5egvcrUUErPShtumxJk=;
 b=s5dBniu35owA5V3ugho95nN0drfR5qosGBZUZVgtgm1GEDmoVcfRsYchzNl5mw0vCpWALpjwufXYmeuOiaz48e4GmnyQz5WUXK7Mo9lAVTWqgtA997qvJ3Y22WHh/NH6+ocZRZCpf2Mr8bIv/tORc8NsCiLlJdTOwnd0pjvK7yg=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB0996.EURPRD10.PROD.OUTLOOK.COM (10.169.154.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 13:27:00 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::64d6:5112:2b55:6a5f]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::64d6:5112:2b55:6a5f%10]) with mapi id 15.20.1495.005; Mon, 7 Jan 2019
 13:27:00 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "tiwai@suse.de" <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 18/21] ASoC: da7219: fix endianness issues
Thread-Topic: [PATCH 18/21] ASoC: da7219: fix endianness issues
Thread-Index: AQHUpJsEi1hQEv9icU6U9nIlbNpqxaWjz9/Q
Date:   Mon, 7 Jan 2019 13:27:00 +0000
Message-ID: <AM5PR1001MB09949C252D9A09501FEE516280890@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
 <20190105020249.8639-19-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20190105020249.8639-19-pierre-louis.bossart@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR1001MB0996;6:A7AFFs7h7VttjF/YYpxGcVoGgWBuBpjHTS1xA6ajkptJ8wNVu+gDUgjUkNGAHNr38bKx1dLhq6o6ReQ/mi/MKG1lQFcg/aMCgt5nrJ4lOY7zuJuSvKW6tZmuwVGztLscPd5f06i8OtkftG5Gos6JrtKg8Y3R5+LMsi7xiCIQBMlAcIUeicTeCTYyo/x1hUM4ET1rZflzRGzvHClg21DZsaAonW5N1qwdwNu/H9JGR7810cpC2usKwwwZj+C1VoJnYxLv4i6H6EtUysHC0tIkBArhZp2ajmz7O2bJYvb3yBeTSKSz90pGQh2ud6K2GJI0eHXR8ctCwX2yn0/ukNrlpjwhGGR5zvm86eXQOKAaTjxezX17eM00f3DANplx3cBpjObkP4uveTifATnembk1UOyjecXMPP7pE1r+bYfzRExv+buR9lZODnfw2ROyIZXlm6qpFX0YNZomY2IytDd8TA==;5:yKfQ6R6SaBxg6RsC82ZJpF+YDkwnSfIuqSbldVxUdYbxKGa+4uOvQ58Jsl8JBD7fNqg0O9rABjWErRWC0A/MSV84iypLn8V8nRhpWezW1TI7XeZCWBn8z0qrKHzPFGVh8iBjLn4sQA7NS3qJhm5IT2S+FEOgAFSqGAAJjV5w7tQemnEKNr4bi4U/Q0EeCH1fc0o0JZCyKjDca1tiKwdiuw==;7:v28SgCaOf4sVszA0i2XcLDsbAnaM5hkYEsir/gYZJTgxSqYhFpu6RoC6RXjWcJVtMCRwYRRD2QTPZfsJBSunkfUNNpy2hFZWM+5UPh00JnyFXBc2LBkh9gOfpp74+0zoAxzYYEuojxaoE7kagFBBeA==
x-ms-office365-filtering-correlation-id: 667606d8-f359-4d3a-d0fe-08d674a3cddc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB0996;
x-ms-traffictypediagnostic: AM5PR1001MB0996:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c,ExtAddr
x-microsoft-antispam-prvs: <AM5PR1001MB09969FC778A5E1D6DF0B99FCA7890@AM5PR1001MB0996.EURPRD10.PROD.OUTLOOK.COM>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(823302103)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM5PR1001MB0996;BCL:0;PCL:0;RULEID:;SRVR:AM5PR1001MB0996;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(136003)(346002)(366004)(199004)(189003)(229853002)(105586002)(71200400001)(14454004)(33656002)(72206003)(55016002)(9686003)(71190400001)(6436002)(106356001)(81166006)(55236004)(26005)(5660300001)(74316002)(305945005)(6506007)(478600001)(53546011)(110136005)(6246003)(7736002)(316002)(86362001)(4326008)(14444005)(76176011)(186003)(81156014)(102836004)(256004)(39060400002)(2501003)(8936002)(53936002)(68736007)(7696005)(446003)(99286004)(476003)(97736004)(2906002)(486006)(66066001)(8676002)(6116002)(25786009)(54906003)(3846002)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB0996;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zv8xerHZpkZhhbvdlSbrpylgphk7WlcNXN7PuoiJCL7q5VpMp6h6zJWL6rXyR0qfrlBkbfEJbj71+5ABPHiB4J2vAV+zxM+d64k9M57VFDWIWgeGVOjcFw5O9ZCd5uN4avmPnXCTbMO1IMc+w2NBjWxSsr+1ozoPVSplhB+QUIuQtIDFX8JiJCcX/hySRVvoXBkFjrQrIcbpgXSt8hwWqZsisJoaWJF8nV3iDrEgYkgOYEf+DXiXzZXUbBRA8x3bC+mAUPoazZ7Qelt2QkH3Ym0kkrMjEyPrVygDZnoHLlp6M7oRGhdyx/OpNuZdyNRT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667606d8-f359-4d3a-d0fe-08d674a3cddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 13:27:00.0905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB0996
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 January 2019 02:03, Pierre-Louis Bossart wrote:

> Reported by Sparse.
>=20
> da7219.c:440:44: warning: cast to restricted __le16
> da7219.c:461:13: warning: incorrect type in assignment (different base ty=
pes)
> da7219.c:461:13:    expected unsigned short [unsigned] [usertype] val
> da7219.c:461:13:    got restricted __le16 [usertype] <noident>
> da7219.c:1451:16: warning: incorrect type in assignment (different base t=
ypes)
> da7219.c:1451:16:    expected unsigned short [unsigned] [usertype] offset
> da7219.c:1451:16:    got restricted __le16 [usertype] <noident>
>=20
> da7219-aad.c:150:37: warning: incorrect type in assignment (different bas=
e types)
> da7219-aad.c:150:37:    expected unsigned short [unsigned] [usertype]
> tonegen_freq_hptest
> da7219-aad.c:150:37:    got restricted __le16 [usertype] <noident>
> da7219-aad.c:157:37: warning: incorrect type in assignment (different bas=
e types)
> da7219-aad.c:157:37:    expected unsigned short [unsigned] [usertype]
> tonegen_freq_hptest
> da7219-aad.c:157:37:    got restricted __le16 [usertype] <noident>
>=20
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com=
>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/codecs/da7219-aad.c | 2 +-
>  sound/soc/codecs/da7219.c     | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.=
c
> index 2c7d5088e6f2..e0964b20a389 100644
> --- a/sound/soc/codecs/da7219-aad.c
> +++ b/sound/soc/codecs/da7219-aad.c
> @@ -117,7 +117,7 @@ static void da7219_aad_hptest_work(struct work_struct
> *work)
>  	struct snd_soc_dapm_context *dapm =3D
> snd_soc_component_get_dapm(component);
>  	struct da7219_priv *da7219 =3D
> snd_soc_component_get_drvdata(component);
>=20
> -	u16 tonegen_freq_hptest;
> +	__le16 tonegen_freq_hptest;
>  	u8 pll_srm_sts, pll_ctrl, gain_ramp_ctrl, accdet_cfg8;
>  	int report =3D 0, ret =3D 0;
>=20
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c index
> e46e9f4bc994..ce165047b9f9 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -423,7 +423,7 @@ static int da7219_tonegen_freq_get(struct snd_kcontro=
l
> *kcontrol,
>  	struct soc_mixer_control *mixer_ctrl =3D
>  		(struct soc_mixer_control *) kcontrol->private_value;
>  	unsigned int reg =3D mixer_ctrl->reg;
> -	u16 val;
> +	__le16 val;
>  	int ret;
>=20
>  	mutex_lock(&da7219->ctrl_lock);
> @@ -450,7 +450,7 @@ static int da7219_tonegen_freq_put(struct snd_kcontro=
l
> *kcontrol,
>  	struct soc_mixer_control *mixer_ctrl =3D
>  		(struct soc_mixer_control *) kcontrol->private_value;
>  	unsigned int reg =3D mixer_ctrl->reg;
> -	u16 val;
> +	__le16 val;
>  	int ret;
>=20
>  	/*
> @@ -1396,7 +1396,7 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_d=
ai
> *dai,
>  	struct snd_soc_component *component =3D dai->component;
>  	struct da7219_priv *da7219 =3D
> snd_soc_component_get_drvdata(component);
>  	u8 dai_bclks_per_wclk;
> -	u16 offset;
> +	__le16 offset;
>  	u32 frame_size;
>=20
>  	/* No channels enabled so disable TDM, revert to 64-bit frames */
> --
> 2.17.1

