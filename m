Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B78C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1BD21B68
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="gtKg6Lga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405523AbfBOJ6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:58:38 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.5]:49048 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbfBOJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:58:37 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-central-1.aws.symcld.net id 1D/5D-12121-A4D866C5; Fri, 15 Feb 2019 09:58:34 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUxTVxjHe3pfemXc7drCeMbAD01mFuztwL3
  kBJdo9mHeJTNZtsxkjmy7wKXtUi7dbZvVLS4UwSCErAbQrWoQYzCWaLXhA6tkI2UfxM0JFcQp
  KIW6xJq6TQksy2Dr7VG3fbn5nef/y3Oec3IuR5lbTaWcEvApmiq7rWwB7XzB+LL4RldDTeW96
  Wp8sXXEhA/Onmfw1GTCiHtTaRYHv+pjcGYsjvDyVLsRX4kfYfH++JcMPrtyGuHrHcdNeGwpzm
  4rlM4+aGGltuQqKx1unqSlb8JzJqn1+ywjxSL7Wenb7AArLf94gJaiQ9O09CC24a2CXYxLrW0
  KfMQ4pw9Pmjw/Px3446ckakYhSwcq4GghSkHzzQWjvjALPUaYmttrIotFBDOhu0wHWsexAobu
  C/OszkWCDc5lVvJMCd/RcOuGX2eL8C5k17oQcXbC8IFZivBmuJVI0jrTwnOQCGfzdV6Q4VSsO
  9/HLFRDaK4nz+uELRDuzeR9JJTDUnCQInuVwPV0n1FnEAQ4MXKZIlwMdxbXGOIrMN5yDZG6DS
  7NpB+yFQauhRnC5ZDs68zVuRzvgLnWN/XzgjCLoHfiJkPqNjgSfY3oGE50ttHEaefhdHyMJo4
  HhkK7iFMGh/7Ux9SdcQai/asmcq46+O3oJRORNkCkK/Ww0QQF86OjbAhVhP9zNsI2OHb+Pkt4
  Ewz036XC+ftaD+Nfp+ljiI4gXKu5HE5fo+xyi1WVlWJV1Yui/rXLn4myXfGLdYrq0+RcaJc/9
  dq9uxvr3PV2VfHFUO5F1n9ieGIYhU46EugZzmgt5r8INtSYn6xtqt/tlL3ODzW/W/EmUBnHWY
  E/05nL1muKQwk0uNy5Z/0oBq7QWsT/qse81yM3el0OEl1EIjd6PHWUMtNqk6qUlvCULgm65PS
  rj1s8+jmSqLzUwiODwWAu9Chao8v3/zyDSjhktfARvUuhS/U93imTG8KYG+J2Ub0+hE/+Nypt
  Rs8XP3uyJtVecdUfOjgYu6xcbVGzHzC3f3ll39Sh1/cstN/o6V7asbCwNbhZ497+eGZs+/ttt
  t/Xtu602N/hJ2rOzA/trWbt96N4JPJqyjo4ZDiVvtcVtC3eaQislO2Rtl95bwQv7+ufdVzQ/i
  57St3415Z+sWh120ue4U3qD9NO8XMr7XXKVRWU5pX/ATpL924XBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-43.tower-223.messagelabs.com!1550224713!1220862!1
X-Originating-IP: [104.47.2.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21221 invoked from network); 15 Feb 2019 09:58:33 -0000
Received: from mail-db5eur01lp2053.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.53)
  by server-43.tower-223.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 15 Feb 2019 09:58:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDbD8LZYGnf8G8iYT6OgrB3Eaz67HhRYrGWDntO0j8Y=;
 b=gtKg6LgaZqu580gtJRlA0qxUeUAxzOXM8OOlR78DAp+mEaNwhJjJdZ3FJODCunP1/tf+ylZy+lhDgcn8bGWkVjLOTkhWiqyt+k/2ifLr/DoEhcr+BIgmIrOJtkxR2PdMFiQBwwDXry1OHN/1XgXHrE7Zo7Bq2UcZdDm/PA2NujU=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1123.EURPRD10.PROD.OUTLOOK.COM (10.169.155.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 09:58:32 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10f2:a1bd:4f0d:f118]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10f2:a1bd:4f0d:f118%8]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 09:58:32 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: AMD: Configure master codec on all playback/capture
 cases
Thread-Topic: [PATCH] ASoC: AMD: Configure master codec on all
 playback/capture cases
Thread-Index: AQHUxPzxizQmdrGlv0Oz0EPwJ2D5p6Xglsig
Date:   Fri, 15 Feb 2019 09:58:32 +0000
Message-ID: <AM5PR1001MB0994E7CBCAF8345EEEAC787E80600@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190215070539.22150-1-akshu.agrawal@amd.com>
In-Reply-To: <20190215070539.22150-1-akshu.agrawal@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d343dae5-b721-4cdc-0546-08d6932c24da
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1123;
x-ms-traffictypediagnostic: AM5PR1001MB1123:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM5PR1001MB1123;23:Mf0vrtqqpmUfA1l7yp7af3iJkcs1FfAPUg8blKJ?=
 =?us-ascii?Q?IXNOXQeJ+sNmiPDOcpdI0ypMG4W874a6oUODlCosrIgELMQvM2W9xjKGRIih?=
 =?us-ascii?Q?iCfqYqa3AuinNFzXsMJitjkRaA2PYiJBiV4pE1IJ30+olJ+dwCF4sryj6zD+?=
 =?us-ascii?Q?YyjkPusipIQ0Nlb6no4fsbwEXNBSyUDty8Z1Yuw31SlAjIfrzEknjkE2VUm8?=
 =?us-ascii?Q?VGxTMINUwE9rAzRCV7mO5P3JWkf8Mg3bTUMSom60EM85zXU7mvX1e9zwQcMQ?=
 =?us-ascii?Q?pGXSzX+c0lYpFfSfbar+RRnZTfn7TS+6/Y8nsfA6OeEtfxr/0T9AVphFR8Ry?=
 =?us-ascii?Q?o/nEgrEkelBpzrK6CbGpRGqs2ktTKoUneJl1ymxUDYGIX+t/w4KHaqNcdJpI?=
 =?us-ascii?Q?2VIuwi3tP/e03mHf/Ze84uodfPxUAPbS1mR6cPWrzJDDnKk0WRcxb7o3a+ba?=
 =?us-ascii?Q?Ny1bTyiJ77dX0d/OVr8WDr69PS7lkVuZGkICkr49oiDnh5tA52+GtDvmzHdC?=
 =?us-ascii?Q?qXbrgBDv2WYTcP/4jvVucufOS3uiIP7LpxFXl93qcz3G1xkIGbotsHzI8t+1?=
 =?us-ascii?Q?0CvnjRCVVQ9YK5Iw2ChMcoi4/K9To6b2QnXGleyumXG/MpxeefrGhkGPTndM?=
 =?us-ascii?Q?BiGXIfvCSZ/3ZryHQMacek7HMi8LO3tdRaU9SMDl+qLFRgVOcRoPmXIHUtp4?=
 =?us-ascii?Q?8GaiFHd6/9RCLUu8YMH7B5ALDm6uopXEZ+wRGX8pcmYwMcBHlJKJ2BaWrGtG?=
 =?us-ascii?Q?xNl2iHoDWG5pC87NhGxMsCJc9UfOq92tE0oa+f4WWQ8VcGWxqslEmrHO3bSE?=
 =?us-ascii?Q?UPbxmB6jdaqCuBwfENzprbzT4qHZ9zsj1HL/hWByxpd/xfj2BdmEI6JF/22f?=
 =?us-ascii?Q?61jpE6Bjo+h2z1LjvLM1PAYRRjeHMdTRbacLzo6SCr52pID1+8zhpeqBbdXM?=
 =?us-ascii?Q?crYhqG9sdfefvVAey+sn3BqNlWtjV5+rSrwKu3FsCambcwIu3+wRdpcMY5kE?=
 =?us-ascii?Q?g3kmUY8fIIgduHU91e5xB7UJRvOV8GYVyYYvQHjI4HJPxJ3lwTXMu/04PoyP?=
 =?us-ascii?Q?PUQpC1YjOrs981yG84N94eocPGsGGFxFRERdTKD9eqh1o9+a9MtpoBpS7BMl?=
 =?us-ascii?Q?Nq5e5RZhKz2yBDkgqQel/6TKLovIsFCo5zuMFD6PnQcZvR0/xpFJa8e9yOIK?=
 =?us-ascii?Q?SLCz0wwUf0NI7ecJrrLvTr0ltfzDASpR1XDuPom/wWnajgQlWDpDX332XBw?=
 =?us-ascii?Q?=3D=3D?=
x-microsoft-antispam-prvs: <AM5PR1001MB11232AD6ED998C5F5476D009A7600@AM5PR1001MB1123.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39850400004)(199004)(189003)(7416002)(3846002)(106356001)(105586002)(81166006)(8936002)(33656002)(81156014)(74316002)(305945005)(229853002)(7736002)(8676002)(6116002)(68736007)(6916009)(256004)(2906002)(97736004)(66066001)(55016002)(9686003)(6436002)(186003)(6246003)(6506007)(316002)(53546011)(26005)(99286004)(54906003)(7696005)(71190400001)(71200400001)(102836004)(76176011)(14454004)(478600001)(72206003)(4326008)(53936002)(25786009)(86362001)(446003)(476003)(11346002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1123;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X4aAnv4+M4cDEk4dxi7SgtkPI1rmMMHyBdRn097tqkLaCtMVrDzTRlbg2RnsjbG1rozI6MteQJOWfF6IwwvM3TLUpb0NWQai2rDfG+/ZJEWRu4LKWceHSb8pGTWVRNRy+zfsoe65/LtER1H0ElnDUdcg6wBkzi0mLr92IMMS08Pmyin1zZL3XUCzUBqd1S9uhF6UiL2vZl7vFe7OEzTMEwJXq2BU7SE5sh3r53Ek2RVgkVR/bHpDLWS4Yt7I+cizy2xCU/NRO5H8iVCv/Zt9eVjuES96b0ILMjLvGMiknHWEVNGGpW+w051DX8fZaWxkWeaU1QEs2i0Hzs2+m+HstKEllqV9b7dHljUyBRCZ/qDwBdWZaJwPHI9fyc98A3KngYreLZvGOf7l0B0umlwKR+hyB94UtWo72IKsem4VOuE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d343dae5-b721-4cdc-0546-08d6932c24da
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 09:58:32.4104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 February 2019 07:06, Akshu Agrawal wrote:

> In the system design da7219 is the master codec and clocks are generated =
by it.
> Bclk is to be generated at the required rate for other codecs used when
> da7219 is acting only as clock master. For this call hw_params of da7219 =
during
> playback/capture on non da7219 codecs.
>=20
> Being able to set bclk at lower rate also fixes noise issue observed on s=
ome
> dmics.
>=20
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/amd/acp-da7219-max98357a.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-
> da7219-max98357a.c
> index a5daad973ce5..ad327415290a 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -45,6 +45,7 @@
>  #define CZ_PLAT_CLK 48000000
>  #define DUAL_CHANNEL		2
>=20
> +static struct snd_soc_dai *codec_dai;
>  static struct snd_soc_jack cz_jack;
>  static struct clk *da7219_dai_clk;
>  extern int bt_uart_enable;
> @@ -53,8 +54,10 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *=
rtd)
> {
>  	int ret;
>  	struct snd_soc_card *card =3D rtd->card;
> -	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> -	struct snd_soc_component *component =3D codec_dai->component;
> +	struct snd_soc_component *component;
> +
> +	codec_dai =3D rtd->codec_dai;
> +	component =3D codec_dai->component;
>=20
>  	dev_info(rtd->dev, "codec dai name =3D %s\n", codec_dai->name);
>=20
> @@ -255,6 +258,16 @@ static void cz_dmic_shutdown(struct
> snd_pcm_substream *substream)
>  	da7219_clk_disable();
>  }
>=20
> +static static int cz_da7219_hw_params(struct snd_pcm_substream *substrea=
m,
> +				    struct snd_pcm_hw_params *params) {
> +	/* da7219 Codec is clock master so setup as per the needs */
> +	if (codec_dai->driver->ops->hw_params)
> +		return codec_dai->driver->ops->hw_params(substream, params,
> +							 codec_dai);
> +	return 0;
> +}
> +
>  static const struct snd_soc_ops cz_da7219_play_ops =3D {
>  	.startup =3D cz_da7219_play_startup,
>  	.shutdown =3D cz_da7219_shutdown,
> @@ -268,16 +281,19 @@ static const struct snd_soc_ops cz_da7219_cap_ops =
=3D {
> static const struct snd_soc_ops cz_max_play_ops =3D {
>  	.startup =3D cz_max_startup,
>  	.shutdown =3D cz_max_shutdown,
> +	.hw_params =3D cz_da7219_hw_params,
>  };
>=20
>  static const struct snd_soc_ops cz_dmic0_cap_ops =3D {
>  	.startup =3D cz_dmic0_startup,
>  	.shutdown =3D cz_dmic_shutdown,
> +	.hw_params =3D cz_da7219_hw_params,
>  };
>=20
>  static const struct snd_soc_ops cz_dmic1_cap_ops =3D {
>  	.startup =3D cz_dmic1_startup,
>  	.shutdown =3D cz_dmic_shutdown,
> +	.hw_params =3D cz_da7219_hw_params,
>  };
>=20
>  static struct snd_soc_dai_link cz_dai_7219_98357[] =3D {
> --
> 2.17.1

