Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BEFC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6842082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6842082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLDVQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:16:19 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.68]:16557 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbeLDVQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:16:18 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-west-1.aws.symcld.net id F8/59-08991-B9EE60C5; Tue, 04 Dec 2018 21:16:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUxTVxjHOffenl4I110L2mcVWKgGo3Jry6d
  rYhaSJUsTM3CZH9Ro9FautElbam9rKyazEklGcdky0SmoRSV8qG9YlTfRKBoQI2ILgm8oaOMG
  THzB+JLNZb3c4rZvv3P+//zOc5JzaFLzCuto0e8R3U7BrsdplHWpiufqJvE64+XdGv7Grg41v
  +/hBRU/EO0k+L2jcczv3B9S8W8HfiD4/vaDmK9q/0nFN707iQpTzU1TFdhcGfuIzXWBKGVuqx
  1WmyPhKmy+9LwRm0+fu0OZpyI5K+m1KpvTUubfqLLW9A9RrrZB5D/72yQOoJ4mFERpNMWeJmF
  41yQpLzTsHgIOnajAyuIJgvc1fxFBlEpjloc910ewzJlsPpwZfzddItkICZPN7UgOMtjvoDf2
  UaWUVsFYaw+hcAGcCrWqZabYBRC9fYcKIppmWAEC3VuVwwIIeqdOkXInlf0a9v16hZIZsdnwZ
  ufx6X2S1cL9eGjaCSwLDR19pMJzYOzp3yqlL0JPxV2k7OdD71A8ybkwHJjpZ0MsVD19f2DvYW
  iL9CWl30Bb9VFCCR4ieH1mQD1jOj8xmjTx0FBdSSm8HG6NtCTZBYPRP5OiHAj/OEoposckBId
  +T4qyoPPDY1IJ6jC0dNSrf0Zc7X+up3A+1F94jRVeAo1HJkiZGXY29ByIU/WICiPe4raVWj0O
  wWbnTEYjZzIVcKZlyzhTgdEglHMWg+jlfKLk4UwGwScZpG2OTfYSg1P0RFDi+ZW4uv2tqC9Y2
  ok+pwn9HKYpD6/TzLKUlWyzCpJ1g9trF6VOlEXTemAuPU9ks91iqejfbLMn3vBMDHS6PpMZn0
  jEjOQSHJKtVIluII5uvlm1n9RQzjKnqNMy92UHK5esXucnxcxPiKFsXQaDUlJSNOku0e2wef6
  fjyMtjfQZDJX4MJp0m9Pz6aTxxBBEYgj7OUIewiP8G+kCKAueXav8oraiMOfo+YtSTeoOJjfu
  amyp896K5r+0pK0aOfyia71voVHXXZT3KrC969uuYw8OPJqX+dkf21fYtrxHR77PXTpYOPeXD
  bvn3/2yaJYzw7umcsFEsdaxJG+1r/9Z881wIFZUHC72+8SvFj5dFDreUK5tHctOu5pST5SveL
  JcT0lWwbSYdEvCP0A73BcEBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-8.tower-288.messagelabs.com!1543958170!3579653!1
X-Originating-IP: [104.47.5.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 555 invoked from network); 4 Dec 2018 21:16:11 -0000
Received: from mail-he1eur02lp2056.outbound.protection.outlook.com (HELO EUR02-HE1-obe.outbound.protection.outlook.com) (104.47.5.56)
  by server-8.tower-288.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 4 Dec 2018 21:16:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oevzzvz9U6zdgAREqfXNNxVuHoKkLuyeBK/tH3biPBE=;
 b=c53TZ/mVozJOuF+bOtqyCPT1HlCEG/EOGeGtEgDHbTrB/RW+CFUMEMlBWdH7YnpkmI9BCewehThrrEa2jhLq8lmVX+0GEhC1KPYPCPq1h7D+oVrNQwWCnuhi3cxUu8GgW5QEORDY/bv+GI7QFL785PB+GSCsYyMxJTMPzOtB3Zs=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1153.EURPRD10.PROD.OUTLOOK.COM (10.169.155.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 21:16:05 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40df:60cd:e157:799f]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40df:60cd:e157:799f%4]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 21:16:05 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ASoC: DA7219: Implement error check on reg read and
 write
Thread-Topic: [PATCH 2/2] ASoC: DA7219: Implement error check on reg read and
 write
Thread-Index: AQHUjABowaj+jjA230WGxrwkJwNq9aVvFN8g
Date:   Tue, 4 Dec 2018 21:16:05 +0000
Message-ID: <AM5PR1001MB099412DDC3B33069BCFDC38B80AF0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <1543948103-20752-1-git-send-email-akshu.agrawal@amd.com>
 <1543948103-20752-2-git-send-email-akshu.agrawal@amd.com>
In-Reply-To: <1543948103-20752-2-git-send-email-akshu.agrawal@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.80]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR1001MB1153;6:VNgltlTOfcMmpDur4r+ADn/USrQTtpYxsLe9UpNZYcywDW9z8JMKe22tJ1X4kfdtfgLx2f2W2fezgaXBCYFRM/WCZsXtI5eFk3KBQDGnOT4DcaYS13HbTp7XgFtJnO2P8hK5mqpWjoyDpbqcAhLEW+7lwC30EOBYuXWqWS6ITH989nRfXgIGT873AuqbQ50ivuG/qsqDONuYpzb3fGSc7igY9kTj1Zar+AtUgJ5mejnReHoKSr7GR+GWdu2ZLEoD4XDkAtogj1PBTxxqogebw2hLUZ1up8SVJTAz3ISMVem5HDvzIV9To4GE8TKjvxEoxOm3wa3YCzfBYq6QP/le6uM+qWCbaUhZm0fHc+pwUuIHOAcnmS13MqBfLzoC9BiHTOqY2yr+5Xb214fIfdlJ6yxh+4Qp6QyfEi15C+OoRJnR5PfC8wEKquekbzqGRFL8hCVhP5mHVuZz8RykETS3+g==;5:BwTN9Tub5orGDd206Y3By4vU/gy59wS2H7Y7b0tjDNDwxDeM9iZovOweh6AJWAS6cPxVZ3fNys1fAwS8GDV7pqV822p1MEjcKhV45M3tWyqr2d1w1dZCVeoFv9Djnr9zNh30X8MEiJ4PrpxzyXzcEc52MtpWXFcQ+GDGnPZBvaw=;7:GspKgoVv5yhiOfDTScb2KbHb98plhajQ8tNNYGu2ZqrCdylPuTQNu6CEC26DxGtQDIuKvgXwiX6SQqmHJtwefz/Ch0V1bRdVEA6jBbVGekd4GOpM5c24MUuW2pB+abu/5Fh/Ujw99DqOmzgdKMc02g==
x-ms-office365-filtering-correlation-id: eeba32ce-0182-450f-9542-08d65a2db3d5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1153;
x-ms-traffictypediagnostic: AM5PR1001MB1153:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c,ExtAddr
x-microsoft-antispam-prvs: <AM5PR1001MB115309113C74E981DA3F695BA7AF0@AM5PR1001MB1153.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(3231455)(999002)(944501512)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM5PR1001MB1153;BCL:0;PCL:0;RULEID:;SRVR:AM5PR1001MB1153;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(136003)(376002)(396003)(199004)(189003)(25786009)(478600001)(53546011)(102836004)(486006)(72206003)(446003)(105586002)(54906003)(74316002)(106356001)(11346002)(476003)(5660300001)(305945005)(186003)(7696005)(7736002)(6916009)(68736007)(66066001)(26005)(6506007)(55236004)(76176011)(99286004)(3846002)(39060400002)(2906002)(229853002)(316002)(53946003)(14454004)(71200400001)(9686003)(6246003)(55016002)(6116002)(6436002)(71190400001)(4326008)(53936002)(33656002)(8936002)(551934003)(86362001)(256004)(81166006)(81156014)(97736004)(8676002)(14444005)(4744004)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1153;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZmihmhsTi6vETu+vpaMWQVSNLx/PEDDWwC8jfdXSo7sZn7NtqznwH+AlFtK2GD+9Hw+1OJ4htuRtS4q3FXvkTgWkygxUQR3secnWX9eXKxMBrlvjaNnsmHLfwU1oOhAyQAuXLS6Psuj0irQELk9fNSxTCq1GUcZQAlktokKCrPRrESCiaB512j2pnqG3CiAXClzXT9PMiVtTSUiJ4vsrwIjUzwap35yVfT3meX7cnbXs4PN3JnghEphgNatXcnCeTmDhL0+e+/qYHlP9mrV/M6KDxhxyUNXm8t7rJV3QZ7dhhyO/41Pn5nbAh7x2/LbqcHC9kyhgkOFziUjauDiEvApCBuDzmYHNL6tezHLuLK0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeba32ce-0182-450f-9542-08d65a2db3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 21:16:05.4769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 December 2018 18:36, Akshu Agrawal wrote:

> Failed i2c transaction can lead to failure in reg read or write.
> Need to have error check for each read write operation.
>

I'm not really clear what this gains you. If I2C is broken this won't solve
anything, and you have far deeper problems. Seems to me like a lot of code =
which
adds almost nothing.
=20
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>  sound/soc/codecs/da7219.c | 323 +++++++++++++++++++++++++++++++++++-
> ----------
>  sound/soc/codecs/da7219.h |   2 +-
>  2 files changed, 247 insertions(+), 78 deletions(-)
>=20
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c index
> e46e9f4..6757129 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -312,69 +312,103 @@ static int da7219_enum_locked_put(struct
> snd_kcontrol *kcontrol,  }
>=20
>  /* ALC */
> -static void da7219_alc_calib(struct snd_soc_component *component)
> +static int da7219_alc_calib(struct snd_soc_component *component)
>  {
> -	u8 mic_ctrl, mixin_ctrl, adc_ctrl, calib_ctrl;
> +	int mic_ctrl, mixin_ctrl, adc_ctrl, calib_ctrl;
> +	int ret;
>=20
>  	/* Save current state of mic control register */
>  	mic_ctrl =3D snd_soc_component_read32(component,
> DA7219_MIC_1_CTRL);
> +	if (mic_ctrl < 0)
> +		return mic_ctrl;
>=20
>  	/* Save current state of input mixer control register */
>  	mixin_ctrl =3D snd_soc_component_read32(component,
> DA7219_MIXIN_L_CTRL);
> +	if (mixin_ctrl < 0)
> +		return mixin_ctrl;
>=20
>  	/* Save current state of input ADC control register */
>  	adc_ctrl =3D snd_soc_component_read32(component,
> DA7219_ADC_L_CTRL);
> +	if (adc_ctrl < 0)
> +		return adc_ctrl;
>=20
>  	/* Enable then Mute MIC PGAs */
> -	snd_soc_component_update_bits(component, DA7219_MIC_1_CTRL,
> DA7219_MIC_1_AMP_EN_MASK,
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_MIC_1_CTRL,
> +			    DA7219_MIC_1_AMP_EN_MASK,
>  			    DA7219_MIC_1_AMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_MIC_1_CTRL,
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_MIC_1_CTRL,
>  			    DA7219_MIC_1_AMP_MUTE_EN_MASK,
>  			    DA7219_MIC_1_AMP_MUTE_EN_MASK);
> +	if (ret < 0)
> +		return ret;
>=20
>  	/* Enable input mixers unmuted */
> -	snd_soc_component_update_bits(component, DA7219_MIXIN_L_CTRL,
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_MIXIN_L_CTRL,
>  			    DA7219_MIXIN_L_AMP_EN_MASK |
>  			    DA7219_MIXIN_L_AMP_MUTE_EN_MASK,
>  			    DA7219_MIXIN_L_AMP_EN_MASK);
> +	if (ret < 0)
> +		return ret;
>=20
>  	/* Enable input filters unmuted */
> -	snd_soc_component_update_bits(component, DA7219_ADC_L_CTRL,
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_ADC_L_CTRL,
>  			    DA7219_ADC_L_MUTE_EN_MASK |
> DA7219_ADC_L_EN_MASK,
>  			    DA7219_ADC_L_EN_MASK);
> +	if (ret < 0)
> +		return ret;
>=20
>  	/* Perform auto calibration */
> -	snd_soc_component_update_bits(component, DA7219_ALC_CTRL1,
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_ALC_CTRL1,
>  			    DA7219_ALC_AUTO_CALIB_EN_MASK,
>  			    DA7219_ALC_AUTO_CALIB_EN_MASK);
> +	if (ret < 0)
> +		return ret;
>  	do {
>  		calib_ctrl =3D snd_soc_component_read32(component,
> DA7219_ALC_CTRL1);
> +		if (calib_ctrl < 0)
> +			return calib_ctrl;
>  	} while (calib_ctrl & DA7219_ALC_AUTO_CALIB_EN_MASK);
>=20
>  	/* If auto calibration fails, disable DC offset, hybrid ALC */
>  	if (calib_ctrl & DA7219_ALC_CALIB_OVERFLOW_MASK) {
>  		dev_warn(component->dev,
>  			 "ALC auto calibration failed with overflow\n");
> -		snd_soc_component_update_bits(component,
> DA7219_ALC_CTRL1,
> +		ret =3D snd_soc_component_update_bits(component,
> DA7219_ALC_CTRL1,
>  				    DA7219_ALC_OFFSET_EN_MASK |
>  				    DA7219_ALC_SYNC_MODE_MASK, 0);
> +		if (ret < 0)
> +			return ret;
>  	} else {
>  		/* Enable DC offset cancellation, hybrid mode */
> -		snd_soc_component_update_bits(component,
> DA7219_ALC_CTRL1,
> +		ret =3D snd_soc_component_update_bits(component,
> DA7219_ALC_CTRL1,
>  				    DA7219_ALC_OFFSET_EN_MASK |
>  				    DA7219_ALC_SYNC_MODE_MASK,
>  				    DA7219_ALC_OFFSET_EN_MASK |
>  				    DA7219_ALC_SYNC_MODE_MASK);
> +		if (ret < 0)
> +			return ret;
>  	}
>=20
>  	/* Restore input filter control register to original state */
> -	snd_soc_component_write(component, DA7219_ADC_L_CTRL, adc_ctrl);
> +	ret =3D snd_soc_component_write(component, DA7219_ADC_L_CTRL,
> adc_ctrl);
> +	if (ret < 0)
> +		return ret;
>=20
>  	/* Restore input mixer control registers to original state */
> -	snd_soc_component_write(component, DA7219_MIXIN_L_CTRL,
> mixin_ctrl);
> +	ret =3D snd_soc_component_write(component, DA7219_MIXIN_L_CTRL,
> +				mixin_ctrl);
> +	if (ret < 0)
> +		return ret;
>=20
>  	/* Restore MIC control registers to original states */
> -	snd_soc_component_write(component, DA7219_MIC_1_CTRL, mic_ctrl);
> +	ret =3D snd_soc_component_write(component, DA7219_MIC_1_CTRL,
> mic_ctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
>  }
>=20
>  static int da7219_mixin_gain_put(struct snd_kcontrol *kcontrol, @@ -391,=
7
> +425,7 @@ static int da7219_mixin_gain_put(struct snd_kcontrol *kcontrol,
>  	 * make sure calibrated offsets are updated.
>  	 */
>  	if ((ret =3D=3D 1) && (da7219->alc_en))
> -		da7219_alc_calib(component);
> +		ret =3D da7219_alc_calib(component);
>=20
>  	return ret;
>  }
> @@ -401,11 +435,14 @@ static int da7219_alc_sw_put(struct snd_kcontrol
> *kcontrol,  {
>  	struct snd_soc_component *component =3D
> snd_soc_kcontrol_component(kcontrol);
>  	struct da7219_priv *da7219 =3D
> snd_soc_component_get_drvdata(component);
> +	int ret;
>=20
>=20
>  	/* Force ALC offset calibration if enabling ALC */
>  	if ((ucontrol->value.integer.value[0]) && (!da7219->alc_en)) {
> -		da7219_alc_calib(component);
> +		ret =3D da7219_alc_calib(component);
> +		if (ret < 0)
> +			return ret;
>  		da7219->alc_en =3D true;
>  	} else {
>  		da7219->alc_en =3D false;
> @@ -813,16 +850,20 @@ static int da7219_dai_event(struct
> snd_soc_dapm_widget *w,
>  					return ret;
>  				}
>  			} else {
> -				snd_soc_component_update_bits(component,
> +				ret =3D
> snd_soc_component_update_bits(component,
>=20
> DA7219_DAI_CLK_MODE,
>=20
> DA7219_DAI_CLK_EN_MASK,
>=20
> DA7219_DAI_CLK_EN_MASK);
> +				if (ret < 0)
> +					return ret;
>  			}
>  		}
>=20
>  		/* PC synchronised to DAI */
> -		snd_soc_component_update_bits(component,
> DA7219_PC_COUNT,
> +		ret =3D snd_soc_component_update_bits(component,
> DA7219_PC_COUNT,
>  				    DA7219_PC_FREERUN_MASK, 0);
> +		if (ret < 0)
> +			return ret;
>=20
>  		/* Slave mode, if SRM not enabled no need for status checks */
>  		pll_ctrl =3D snd_soc_component_read32(component,
> DA7219_PLL_CTRL); @@ -846,19 +887,23 @@ static int da7219_dai_event(struc=
t
> snd_soc_dapm_widget *w,
>  		return 0;
>  	case SND_SOC_DAPM_POST_PMD:
>  		/* PC free-running */
> -		snd_soc_component_update_bits(component,
> DA7219_PC_COUNT,
> +		ret =3D snd_soc_component_update_bits(component,
> DA7219_PC_COUNT,
>  				    DA7219_PC_FREERUN_MASK,
>  				    DA7219_PC_FREERUN_MASK);
> +		if (ret < 0)
> +			return ret;
>=20
>  		/* Disable DAI clks if in master mode */
>  		if (da7219->master) {
>  			if (da7219->dai_clks)
>  				clk_disable_unprepare(da7219->dai_clks);
>  			else
> -				snd_soc_component_update_bits(component,
> +				ret =3D
> snd_soc_component_update_bits(component,
>=20
> DA7219_DAI_CLK_MODE,
>=20
> DA7219_DAI_CLK_EN_MASK,
>  							      0);
> +				if (ret < 0)
> +					return ret;
>  		}
>=20
>  		return 0;
> @@ -887,6 +932,7 @@ static int da7219_mixout_event(struct
> snd_soc_dapm_widget *w,  {
>  	struct snd_soc_component *component =3D
> snd_soc_dapm_to_component(w->dapm);
>  	u8 hp_ctrl, min_gain_mask;
> +	int ret;
>=20
>  	switch (w->reg) {
>  	case DA7219_MIXOUT_L_CTRL:
> @@ -904,15 +950,20 @@ static int da7219_mixout_event(struct
> snd_soc_dapm_widget *w,
>  	switch (event) {
>  	case SND_SOC_DAPM_PRE_PMD:
>  		/* Enable minimum gain on HP to avoid pops */
> -		snd_soc_component_update_bits(component, hp_ctrl,
> min_gain_mask,
> -				    min_gain_mask);
> +		ret =3D snd_soc_component_update_bits(component, hp_ctrl,
> +				    min_gain_mask, min_gain_mask);
> +		if (ret < 0)
> +			return ret;
>=20
>  		msleep(DA7219_MIN_GAIN_DELAY);
>=20
>  		break;
>  	case SND_SOC_DAPM_POST_PMU:
>  		/* Remove minimum gain on HP */
> -		snd_soc_component_update_bits(component, hp_ctrl,
> min_gain_mask, 0);
> +		ret =3D snd_soc_component_update_bits(component, hp_ctrl,
> +				    min_gain_mask, 0);
> +		if (ret < 0)
> +			return ret;
>=20
>  		break;
>  	}
> @@ -925,21 +976,29 @@ static int da7219_gain_ramp_event(struct
> snd_soc_dapm_widget *w,  {
>  	struct snd_soc_component *component =3D
> snd_soc_dapm_to_component(w->dapm);
>  	struct da7219_priv *da7219 =3D
> snd_soc_component_get_drvdata(component);
> +	int ret;
>=20
>  	switch (event) {
>  	case SND_SOC_DAPM_PRE_PMU:
>  	case SND_SOC_DAPM_PRE_PMD:
>  		/* Ensure nominal gain ramping for DAPM sequence */
> -		da7219->gain_ramp_ctrl =3D
> -			snd_soc_component_read32(component,
> DA7219_GAIN_RAMP_CTRL);
> -		snd_soc_component_write(component,
> DA7219_GAIN_RAMP_CTRL,
> -			      DA7219_GAIN_RAMP_RATE_NOMINAL);
> +		da7219->gain_ramp_ctrl =3D
> snd_soc_component_read32(component,
> +						DA7219_GAIN_RAMP_CTRL);
> +		if (da7219->gain_ramp_ctrl < 0)
> +			return da7219->gain_ramp_ctrl;
> +		 ret =3D snd_soc_component_write(component,
> +				DA7219_GAIN_RAMP_CTRL,
> +				DA7219_GAIN_RAMP_RATE_NOMINAL);
> +		if (ret < 0)
> +			return ret;
>  		break;
>  	case SND_SOC_DAPM_POST_PMU:
>  	case SND_SOC_DAPM_POST_PMD:
>  		/* Restore previous gain ramp settings */
> -		snd_soc_component_write(component,
> DA7219_GAIN_RAMP_CTRL,
> +		ret =3D snd_soc_component_write(component,
> DA7219_GAIN_RAMP_CTRL,
>  			      da7219->gain_ramp_ctrl);
> +		if (ret < 0)
> +			return ret;
>  		break;
>  	}
>=20
> @@ -1177,13 +1236,17 @@ static int da7219_set_dai_sysclk(struct snd_soc_d=
ai
> *codec_dai,
>=20
>  	switch (clk_id) {
>  	case DA7219_CLKSRC_MCLK_SQR:
> -		snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
> +		ret =3D snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
>  				    DA7219_PLL_MCLK_SQR_EN_MASK,
>  				    DA7219_PLL_MCLK_SQR_EN_MASK);
> +		if (ret < 0)
> +			return ret;
>  		break;
>  	case DA7219_CLKSRC_MCLK:
> -		snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
> +		ret =3D snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
>  				    DA7219_PLL_MCLK_SQR_EN_MASK, 0);
> +		if (ret < 0)
> +			return ret;
>  		break;
>  	default:
>  		dev_err(codec_dai->dev, "Unknown clock source %d\n", clk_id);
> @@ -1219,6 +1282,7 @@ int da7219_set_pll(struct snd_soc_component
> *component, int source, unsigned int
>  	u8 pll_frac_top, pll_frac_bot, pll_integer;
>  	u32 freq_ref;
>  	u64 frac_div;
> +	int ret;
>=20
>  	/* Verify 2MHz - 54MHz MCLK provided, and set input divider */
>  	if (da7219->mclk_rate < 2000000) {
> @@ -1252,9 +1316,11 @@ int da7219_set_pll(struct snd_soc_component
> *component, int source, unsigned int
>  	switch (source) {
>  	case DA7219_SYSCLK_MCLK:
>  		pll_ctrl |=3D DA7219_PLL_MODE_BYPASS;
> -		snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
> +		ret =3D snd_soc_component_update_bits(component,
> DA7219_PLL_CTRL,
>  				    DA7219_PLL_INDIV_MASK |
>  				    DA7219_PLL_MODE_MASK, pll_ctrl);
> +		if (ret < 0)
> +			return ret;
>  		return 0;
>  	case DA7219_SYSCLK_PLL:
>  		pll_ctrl |=3D DA7219_PLL_MODE_NORMAL;
> @@ -1275,12 +1341,23 @@ int da7219_set_pll(struct snd_soc_component
> *component, int source, unsigned int
>  	pll_frac_bot =3D (frac_div) & DA7219_BYTE_MASK;
>=20
>  	/* Write PLL config & dividers */
> -	snd_soc_component_write(component, DA7219_PLL_FRAC_TOP,
> pll_frac_top);
> -	snd_soc_component_write(component, DA7219_PLL_FRAC_BOT,
> pll_frac_bot);
> -	snd_soc_component_write(component, DA7219_PLL_INTEGER,
> pll_integer);
> -	snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
> +	ret =3D snd_soc_component_write(component, DA7219_PLL_FRAC_TOP,
> +				pll_frac_top);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D snd_soc_component_write(component, DA7219_PLL_FRAC_BOT,
> +				pll_frac_bot);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D snd_soc_component_write(component, DA7219_PLL_INTEGER,
> +				pll_integer);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
>  			    DA7219_PLL_INDIV_MASK |
> DA7219_PLL_MODE_MASK,
>  			    pll_ctrl);
> +	if (ret < 0)
> +		return ret;
>=20
>  	return 0;
>  }
> @@ -1304,6 +1381,7 @@ static int da7219_set_dai_fmt(struct snd_soc_dai
> *codec_dai, unsigned int fmt)
>  	struct snd_soc_component *component =3D codec_dai->component;
>  	struct da7219_priv *da7219 =3D
> snd_soc_component_get_drvdata(component);
>  	u8 dai_clk_mode =3D 0, dai_ctrl =3D 0;
> +	int ret;
>=20
>  	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>  	case SND_SOC_DAIFMT_CBM_CFM:
> @@ -1379,12 +1457,16 @@ static int da7219_set_dai_fmt(struct snd_soc_dai
> *codec_dai, unsigned int fmt)
>  	/* By default 64 BCLKs per WCLK is supported */
>  	dai_clk_mode |=3D DA7219_DAI_BCLKS_PER_WCLK_64;
>=20
> -	snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
>  			    DA7219_DAI_BCLKS_PER_WCLK_MASK |
>  			    DA7219_DAI_CLK_POL_MASK |
> DA7219_DAI_WCLK_POL_MASK,
>  			    dai_clk_mode);
> -	snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
> DA7219_DAI_FORMAT_MASK,
> -			    dai_ctrl);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
> +			    DA7219_DAI_FORMAT_MASK, dai_ctrl);
> +	if (ret < 0)
> +		return ret;
>=20
>  	return 0;
>  }
> @@ -1398,15 +1480,22 @@ static int da7219_set_dai_tdm_slot(struct
> snd_soc_dai *dai,
>  	u8 dai_bclks_per_wclk;
>  	u16 offset;
>  	u32 frame_size;
> +	int ret;
>=20
>  	/* No channels enabled so disable TDM, revert to 64-bit frames */
>  	if (!tx_mask) {
> -		snd_soc_component_update_bits(component,
> DA7219_DAI_TDM_CTRL,
> +		ret =3D snd_soc_component_update_bits(component,
> +				    DA7219_DAI_TDM_CTRL,
>  				    DA7219_DAI_TDM_CH_EN_MASK |
>  				    DA7219_DAI_TDM_MODE_EN_MASK, 0);
> -		snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
> +		if (ret < 0)
> +			return ret;
> +		ret =3D snd_soc_component_update_bits(component,
> +				    DA7219_DAI_CLK_MODE,
>  				    DA7219_DAI_BCLKS_PER_WCLK_MASK,
>  				    DA7219_DAI_BCLKS_PER_WCLK_64);
> +		if (ret < 0)
> +			return ret;
>  		return 0;
>  	}
>=20
> @@ -1444,19 +1533,25 @@ static int da7219_set_dai_tdm_slot(struct
> snd_soc_dai *dai,
>  		return -EINVAL;
>  	}
>=20
> -	snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
>  			    DA7219_DAI_BCLKS_PER_WCLK_MASK,
>  			    dai_bclks_per_wclk);
> +	if (ret < 0)
> +		return ret;
>=20
>  	offset =3D cpu_to_le16(rx_mask);
> -	regmap_bulk_write(da7219->regmap, DA7219_DAI_OFFSET_LOWER,
> +	ret =3D regmap_bulk_write(da7219->regmap,
> DA7219_DAI_OFFSET_LOWER,
>  			  &offset, sizeof(offset));
> +	if (ret < 0)
> +		return ret;
>=20
> -	snd_soc_component_update_bits(component, DA7219_DAI_TDM_CTRL,
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_DAI_TDM_CTRL,
>  			    DA7219_DAI_TDM_CH_EN_MASK |
>  			    DA7219_DAI_TDM_MODE_EN_MASK,
>  			    (tx_mask << DA7219_DAI_TDM_CH_EN_SHIFT) |
>  			    DA7219_DAI_TDM_MODE_EN_MASK);
> +	if (ret < 0)
> +		return ret;
>=20
>  	return 0;
>  }
> @@ -1468,6 +1563,7 @@ static int da7219_hw_params(struct
> snd_pcm_substream *substream,
>  	struct snd_soc_component *component =3D dai->component;
>  	u8 dai_ctrl =3D 0, fs;
>  	unsigned int channels;
> +	int ret;
>=20
>  	switch (params_width(params)) {
>  	case 16:
> @@ -1533,11 +1629,15 @@ static int da7219_hw_params(struct
> snd_pcm_substream *substream,
>  		return -EINVAL;
>  	}
>=20
> -	snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
> +	ret =3D snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
>  			    DA7219_DAI_WORD_LENGTH_MASK |
>  			    DA7219_DAI_CH_NUM_MASK,
>  			    dai_ctrl);
> -	snd_soc_component_write(component, DA7219_SR, fs);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D snd_soc_component_write(component, DA7219_SR, fs);
> +	if (ret < 0)
> +		return ret;
>=20
>  	return 0;
>  }
> @@ -1692,9 +1792,12 @@ static int da7219_set_bias_level(struct
> snd_soc_component *component,
>  	case SND_SOC_BIAS_STANDBY:
>  		if (snd_soc_component_get_bias_level(component) =3D=3D
> SND_SOC_BIAS_OFF)
>  			/* Master bias */
> -			snd_soc_component_update_bits(component,
> DA7219_REFERENCES,
> +			ret =3D snd_soc_component_update_bits(component,
> +					    DA7219_REFERENCES,
>  					    DA7219_BIAS_EN_MASK,
>  					    DA7219_BIAS_EN_MASK);
> +			if (ret < 0)
> +				return ret;
>=20
>  		if (snd_soc_component_get_bias_level(component) =3D=3D
> SND_SOC_BIAS_PREPARE) {
>  			/* Remove MCLK */
> @@ -1705,8 +1808,11 @@ static int da7219_set_bias_level(struct
> snd_soc_component *component,
>  	case SND_SOC_BIAS_OFF:
>  		/* Only disable master bias if we're not a wake-up source */
>  		if (!da7219->wakeup_source)
> -			snd_soc_component_update_bits(component,
> DA7219_REFERENCES,
> +			ret =3D snd_soc_component_update_bits(component,
> +					    DA7219_REFERENCES,
>  					    DA7219_BIAS_EN_MASK, 0);
> +			if (ret < 0)
> +				return ret;
>=20
>  		break;
>  	}
> @@ -1754,10 +1860,16 @@ static int da7219_handle_supplies(struct
> snd_soc_component *component)
>  	}
>=20
>  	/* Ensure device in active mode */
> -	snd_soc_component_write(component, DA7219_SYSTEM_ACTIVE,
> DA7219_SYSTEM_ACTIVE_MASK);
> +	ret =3D snd_soc_component_write(component, DA7219_SYSTEM_ACTIVE,
> +				DA7219_SYSTEM_ACTIVE_MASK);
> +	if (ret < 0)
> +		return ret;
>=20
>  	/* Update IO voltage level range */
> -	snd_soc_component_write(component, DA7219_IO_CTRL,
> io_voltage_lvl);
> +	ret =3D snd_soc_component_write(component, DA7219_IO_CTRL,
> +				io_voltage_lvl);
> +	if (ret < 0)
> +		return ret;
>=20
>  	return 0;
>  }
> @@ -1768,10 +1880,13 @@ static int da7219_dai_clks_prepare(struct clk_hw
> *hw)
>  	struct da7219_priv *da7219 =3D
>  		container_of(hw, struct da7219_priv, dai_clks_hw);
>  	struct snd_soc_component *component =3D da7219->aad->component;
> +	int ret;
>=20
> -	snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
>  				      DA7219_DAI_CLK_EN_MASK,
>  				      DA7219_DAI_CLK_EN_MASK);
> +	if (ret < 0)
> +		return ret;
>=20
>  	return 0;
>  }
> @@ -1781,9 +1896,12 @@ static void da7219_dai_clks_unprepare(struct clk_h=
w
> *hw)
>  	struct da7219_priv *da7219 =3D
>  		container_of(hw, struct da7219_priv, dai_clks_hw);
>  	struct snd_soc_component *component =3D da7219->aad->component;
> +	int ret;
>=20
> -	snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_DAI_CLK_MODE,
>  				      DA7219_DAI_CLK_EN_MASK, 0);
> +	if (ret < 0)
> +		dev_err(component->dev, "Failed to disable clk: %d\n", ret);
>  }
>=20
>  static int da7219_dai_clks_is_prepared(struct clk_hw *hw) @@ -1791,9 +19=
09,11
> @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
>  	struct da7219_priv *da7219 =3D
>  		container_of(hw, struct da7219_priv, dai_clks_hw);
>  	struct snd_soc_component *component =3D da7219->aad->component;
> -	u8 clk_reg;
> +	int clk_reg;
>=20
>  	clk_reg =3D snd_soc_component_read32(component,
> DA7219_DAI_CLK_MODE);
> +	if (clk_reg < 0)
> +		return clk_reg;
>=20
>  	return !!(clk_reg & DA7219_DAI_CLK_EN_MASK);  } @@ -1844,10
> +1964,11 @@ static void da7219_register_dai_clks(struct snd_soc_component
> *component)  static inline void da7219_register_dai_clks(struct
> snd_soc_component *component) {}  #endif /* CONFIG_COMMON_CLK */
>=20
> -static void da7219_handle_pdata(struct snd_soc_component *component)
> +static int da7219_handle_pdata(struct snd_soc_component *component)
>  {
>  	struct da7219_priv *da7219 =3D
> snd_soc_component_get_drvdata(component);
>  	struct da7219_pdata *pdata =3D da7219->pdata;
> +	int ret;
>=20
>  	if (pdata) {
>  		u8 micbias_lvl =3D 0;
> @@ -1869,7 +1990,10 @@ static void da7219_handle_pdata(struct
> snd_soc_component *component)
>  			break;
>  		}
>=20
> -		snd_soc_component_write(component, DA7219_MICBIAS_CTRL,
> micbias_lvl);
> +		ret =3D snd_soc_component_write(component,
> DA7219_MICBIAS_CTRL,
> +					micbias_lvl);
> +		if (ret < 0)
> +			return ret;
>=20
>  		/*
>  		 * Calculate delay required to compensate for DC offset in @@ -
> 1884,11 +2008,15 @@ static void da7219_handle_pdata(struct
> snd_soc_component *component)
>  		case DA7219_MIC_AMP_IN_SEL_DIFF:
>  		case DA7219_MIC_AMP_IN_SEL_SE_P:
>  		case DA7219_MIC_AMP_IN_SEL_SE_N:
> -			snd_soc_component_write(component,
> DA7219_MIC_1_SELECT,
> -				      pdata->mic_amp_in_sel);
> +			ret =3D snd_soc_component_write(component,
> +					DA7219_MIC_1_SELECT,
> +					pdata->mic_amp_in_sel);
> +			if (ret < 0)
> +				return ret;
>  			break;
>  		}
>  	}
> +	return 0;
>  }
>=20
>  static struct reg_sequence da7219_rev_aa_patch[] =3D { @@ -1934,7 +2062,=
9 @@
> static int da7219_probe(struct snd_soc_component *component)
>  	if (!da7219->pdata)
>  		da7219->pdata =3D da7219_fw_to_pdata(component);
>=20
> -	da7219_handle_pdata(component);
> +	ret =3D da7219_handle_pdata(component);
> +	if (ret < 0)
> +		return ret;
>=20
>  	/* Check if MCLK provided */
>  	da7219->mclk =3D devm_clk_get(component->dev, "mclk"); @@ -1948,36
> +2078,57 @@ static int da7219_probe(struct snd_soc_component *component)
>  	}
>=20
>  	/* Default PC counter to free-running */
> -	snd_soc_component_update_bits(component, DA7219_PC_COUNT,
> DA7219_PC_FREERUN_MASK,
> -			    DA7219_PC_FREERUN_MASK);
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_PC_COUNT,
> +			DA7219_PC_FREERUN_MASK,
> DA7219_PC_FREERUN_MASK);
> +	if (ret < 0)
> +		return ret;
>=20
>  	/* Default gain ramping */
> -	snd_soc_component_update_bits(component, DA7219_MIXIN_L_CTRL,
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_MIXIN_L_CTRL,
>  			    DA7219_MIXIN_L_AMP_RAMP_EN_MASK,
>  			    DA7219_MIXIN_L_AMP_RAMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_ADC_L_CTRL,
> DA7219_ADC_L_RAMP_EN_MASK,
> -			    DA7219_ADC_L_RAMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_DAC_L_CTRL,
> DA7219_DAC_L_RAMP_EN_MASK,
> -			    DA7219_DAC_L_RAMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_DAC_R_CTRL,
> DA7219_DAC_R_RAMP_EN_MASK,
> -			    DA7219_DAC_R_RAMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
> +	if (ret < 0)
> +		return ret;
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_ADC_L_CTRL,
> +			DA7219_ADC_L_RAMP_EN_MASK,
> DA7219_ADC_L_RAMP_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_DAC_L_CTRL,
> +			DA7219_DAC_L_RAMP_EN_MASK,
> DA7219_DAC_L_RAMP_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_DAC_R_CTRL,
> +			DA7219_DAC_R_RAMP_EN_MASK,
> DA7219_DAC_R_RAMP_EN_MASK);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_HP_L_CTRL,
>  			    DA7219_HP_L_AMP_RAMP_EN_MASK,
>  			    DA7219_HP_L_AMP_RAMP_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_HP_R_CTRL,
> +	if (ret < 0)
> +		return ret;
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_HP_R_CTRL,
>  			    DA7219_HP_R_AMP_RAMP_EN_MASK,
>  			    DA7219_HP_R_AMP_RAMP_EN_MASK);
> +	if (ret < 0)
> +		return ret;
>=20
>  	/* Default minimum gain on HP to avoid pops during DAPM sequencing
> */
> -	snd_soc_component_update_bits(component, DA7219_HP_L_CTRL,
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_HP_L_CTRL,
>  			    DA7219_HP_L_AMP_MIN_GAIN_EN_MASK,
>  			    DA7219_HP_L_AMP_MIN_GAIN_EN_MASK);
> -	snd_soc_component_update_bits(component, DA7219_HP_R_CTRL,
> +	if (ret < 0)
> +		return ret;
> +	ret =3D snd_soc_component_update_bits(component,
> DA7219_HP_R_CTRL,
>  			    DA7219_HP_R_AMP_MIN_GAIN_EN_MASK,
>  			    DA7219_HP_R_AMP_MIN_GAIN_EN_MASK);
> +	if (ret < 0)
> +		return ret;
>=20
>  	/* Default infinite tone gen, start/stop by Kcontrol */
> -	snd_soc_component_write(component, DA7219_TONE_GEN_CYCLES,
> DA7219_BEEP_CYCLES_MASK);
> +	ret =3D snd_soc_component_write(component,
> DA7219_TONE_GEN_CYCLES,
> +			DA7219_BEEP_CYCLES_MASK);
> +	if (ret < 0)
> +		return ret;
>=20
>  	/* Initialise AAD block */
>  	ret =3D da7219_aad_init(component);
> @@ -2221,16 +2372,28 @@ static int da7219_i2c_probe(struct i2c_client *i2=
c,
>  	regcache_cache_bypass(da7219->regmap, true);
>=20
>  	/* Disable audio paths if still active from previous start */
> -	regmap_read(da7219->regmap, DA7219_SYSTEM_ACTIVE,
> &system_active);
> +	ret =3D regmap_read(da7219->regmap, DA7219_SYSTEM_ACTIVE,
> &system_active);
> +	if (ret < 0)
> +		return ret;
>  	if (system_active) {
> -		regmap_write(da7219->regmap, DA7219_GAIN_RAMP_CTRL,
> +		ret =3D regmap_write(da7219->regmap,
> DA7219_GAIN_RAMP_CTRL,
>  			     DA7219_GAIN_RAMP_RATE_NOMINAL);
> -		regmap_write(da7219->regmap,
> DA7219_SYSTEM_MODES_INPUT, 0x00);
> -		regmap_write(da7219->regmap,
> DA7219_SYSTEM_MODES_OUTPUT, 0x01);
> +		if (ret < 0)
> +			return ret;
> +		ret =3D regmap_write(da7219->regmap,
> DA7219_SYSTEM_MODES_INPUT,
> +				0x00);
> +		if (ret < 0)
> +			return ret;
> +		ret =3D regmap_write(da7219->regmap,
> DA7219_SYSTEM_MODES_OUTPUT,
> +				0x01);
> +		if (ret < 0)
> +			return ret;
>=20
>  		for (i =3D 0; i < DA7219_SYS_STAT_CHECK_RETRIES; ++i) {
> -			regmap_read(da7219->regmap,
> DA7219_SYSTEM_STATUS,
> +			ret =3D regmap_read(da7219->regmap,
> DA7219_SYSTEM_STATUS,
>  				    &system_status);
> +			if (ret < 0)
> +				return ret;
>  			if (!system_status)
>  				break;
>=20
> @@ -2239,13 +2402,19 @@ static int da7219_i2c_probe(struct i2c_client *i2=
c,
>  	}
>=20
>  	/* Soft reset component */
> -	regmap_write_bits(da7219->regmap, DA7219_ACCDET_CONFIG_1,
> +	ret =3D regmap_write_bits(da7219->regmap, DA7219_ACCDET_CONFIG_1,
>  			  DA7219_ACCDET_EN_MASK, 0);
> -	regmap_write_bits(da7219->regmap, DA7219_CIF_CTRL,
> +	if (ret < 0)
> +		return ret;
> +	ret =3D regmap_write_bits(da7219->regmap, DA7219_CIF_CTRL,
>  			  DA7219_CIF_REG_SOFT_RESET_MASK,
>  			  DA7219_CIF_REG_SOFT_RESET_MASK);
> -	regmap_write_bits(da7219->regmap, DA7219_SYSTEM_ACTIVE,
> +	if (ret < 0)
> +		return ret;
> +	ret =3D regmap_write_bits(da7219->regmap, DA7219_SYSTEM_ACTIVE,
>  			  DA7219_SYSTEM_ACTIVE_MASK, 0);
> +	if (ret < 0)
> +		return ret;
>=20
>  	regcache_cache_bypass(da7219->regmap, false);
>=20
> diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h index
> 3a00686..0cf78a7 100644
> --- a/sound/soc/codecs/da7219.h
> +++ b/sound/soc/codecs/da7219.h
> @@ -832,7 +832,7 @@ struct da7219_priv {
>  	bool alc_en;
>  	bool micbias_on_event;
>  	unsigned int mic_pga_delay;
> -	u8 gain_ramp_ctrl;
> +	int gain_ramp_ctrl;
>  };
>=20
>  int da7219_set_pll(struct snd_soc_component *component, int source,
> unsigned int fout);
> --
> 1.9.1
