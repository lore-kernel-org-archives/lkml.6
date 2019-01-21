Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27009C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F5620989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXlmhV6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfAUS2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:28:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46275 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfAUS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:28:03 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so24531592qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1TkwEiURk/99xzr1TBV8DYx2um933Qkdx6Es5eYkRs=;
        b=jXlmhV6mpGjK8ZoOYC1ULREOKogm8qHo7V2PSaEWBeUFZObuJmbvmWuj+V3CcVtk19
         DkIcxl4mWZB9eoST9ZDzuc5pyW74PSgEXtj3xMMmx0E0W0QbRLjp6mYNQuVcTZb9oKr/
         tilmQCSFcPYIKJN9CvSBgHTrMks8p11d2tKubATw2vBE5An8SndEMxtktfCugBFRPDeG
         Mpu8bjVJx0IUTMDTHF3AVdGgqY510XfMIdQXIIBV+RQopF9f47YA08TO0FigNdz5UNif
         42DebPAOilBUKJ06lNFrmK5EFig0KuvgDAq5dhOENBFkENmvdMQe/4H+jzzIAmTCbLWD
         osZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1TkwEiURk/99xzr1TBV8DYx2um933Qkdx6Es5eYkRs=;
        b=drM6Ft4fkdz7Vxlgf6bX2kvAtk7sdN3oyRzTuOY8svG8iMWgyeiOUWztPjsOKQLN16
         Vy6IlDAExVRIOdbW+JKVU1MhxgN0pOCrN/5WjFc/HTIARzJMN6wzxz/Oe/jmas/7w8Lg
         n/YIJb1MWOdWVhs8iF9E3oHG/LpcTUZZFMJvfhUqSSK+LqcSQVzHbFiVTFjqKaeaArN0
         rJlJfBxvj65zC+t5qYU87Yaq1UvziumTMBfO45cc5lkmRAxfnwyYlNEvxot7gLFBXVRg
         TQpRFYOFwODlLy3tmjarIwUXNwVE43cmPBPNJiK927eMSvnPk2LAoox+fdRI9Bi/Xs9e
         YBbg==
X-Gm-Message-State: AJcUukfwhJnHXZgP9WJFNKJlLSGdanWc+zb6hy13r7L8Jl09Pc/aIltt
        fRKDb+BvY04hxdLOR5SuA5WbKAzCqeyoiS3rnIo=
X-Google-Smtp-Source: ALg8bN4kskCENJwwXKBKFB24sMJveG+3AtvqT7/db0mk3aeBZNThoxzsaMmVtVqldqUg8pOvkt/vxhv71RiJvAYAGJI=
X-Received: by 2002:ac8:7153:: with SMTP id h19mr26618908qtp.92.1548095281557;
 Mon, 21 Jan 2019 10:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20190119113332.249720-1-cychiang@chromium.org> <20190119113332.249720-2-cychiang@chromium.org>
In-Reply-To: <20190119113332.249720-2-cychiang@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 21 Jan 2019 19:27:50 +0100
Message-ID: <CAFqH_528-BrDL0WSbijecTHV=tTJBQcae1bCx3SBdC=9F56quw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v4 2/2] ASoC: cros_ec_codec: Add codec driver
 for Cros EC
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>, dgreid@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Missatge de Cheng-Yi Chiang <cychiang@chromium.org> del dia ds., 19 de
gen. 2019 a les 12:34:

>
> Add a codec driver to control ChromeOS EC codec.
>
> Use EC Host command to enable/disable I2S recording and control other
> configurations.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  Changes in v4:
>
> - Fix Kconfig that SND_SOC_CROS_EC_CODEC should depend on MFD_CROS_EC.
> - Remove usage of MAX_GAIN.
> - Add max-dmic-gain device property.
> - Read max-dmic-gain property and add mixer control in component probe.
> - Rename cros_ec_dapm_widgets to cros_ec_codec_dapm_widgets for consistency.
> - Fix missing return code in cros_ec_codec_platform_probe.
> - Rename set_bclk to set_i2s_bclk.
> - Add ec_command_get_gain for EC subcommand EC_CODEC_GET_GAIN, which
>   is the only subcommand that needs response.
> - Add ec_command_no_resp as a simplified version of ec_command for EC commands
>   that do not need response.
> - Simplify all static functions that uses ec_command_no_resp. Return return code
>   directly without logging.
> - Remove useless frame_size in cros_ec_i2s_hw_params.
> - Remove error messages in cros_ec_i2s_hw_params for consistency.
> - Remove error messages in get_ec_mic_gain.
>
>
>  MAINTAINERS                      |   1 +
>  sound/soc/codecs/Kconfig         |   8 +
>  sound/soc/codecs/Makefile        |   2 +
>  sound/soc/codecs/cros_ec_codec.c | 441 +++++++++++++++++++++++++++++++
>  4 files changed, 452 insertions(+)
>  create mode 100644 sound/soc/codecs/cros_ec_codec.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5678e4041e9..e5696ab5d10a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3694,6 +3694,7 @@ S:        Maintained
>  R:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
>  R:     Guenter Roeck <groeck@chromium.org>
>  F:     Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> +F:     sound/soc/codecs/cros_ec_codec.*
>
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:     Brian Austin <brian.austin@cirrus.com>
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 71e6e123a115..d1ef359b47bd 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -50,6 +50,7 @@ config SND_SOC_ALL_CODECS
>         select SND_SOC_BT_SCO
>         select SND_SOC_BD28623
>         select SND_SOC_CQ0093VC
> +       select SND_SOC_CROS_EC_CODEC if MFD_CROS_EC
>         select SND_SOC_CS35L32 if I2C
>         select SND_SOC_CS35L33 if I2C
>         select SND_SOC_CS35L34 if I2C
> @@ -457,6 +458,13 @@ config SND_SOC_CPCAP
>  config SND_SOC_CQ0093VC
>         tristate
>
> +config SND_SOC_CROS_EC_CODEC
> +       tristate "codec driver for ChromeOS EC"
> +       depends on MFD_CROS_EC
> +       help
> +         If you say yes here you will get support for the
> +         ChromeOS Embedded Controller's Audio Codec.
> +
>  config SND_SOC_CS35L32
>         tristate "Cirrus Logic CS35L32 CODEC"
>         depends on I2C
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 9bb3346fab2f..3cfd8f5f6170 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -42,6 +42,7 @@ snd-soc-bd28623-objs := bd28623.o
>  snd-soc-bt-sco-objs := bt-sco.o
>  snd-soc-cpcap-objs := cpcap.o
>  snd-soc-cq93vc-objs := cq93vc.o
> +snd-soc-cros-ec-codec-objs := cros_ec_codec.o
>  snd-soc-cs35l32-objs := cs35l32.o
>  snd-soc-cs35l33-objs := cs35l33.o
>  snd-soc-cs35l34-objs := cs35l34.o
> @@ -310,6 +311,7 @@ obj-$(CONFIG_SND_SOC_BD28623)       += snd-soc-bd28623.o
>  obj-$(CONFIG_SND_SOC_BT_SCO)   += snd-soc-bt-sco.o
>  obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
>  obj-$(CONFIG_SND_SOC_CPCAP)    += snd-soc-cpcap.o
> +obj-$(CONFIG_SND_SOC_CROS_EC_CODEC)    += snd-soc-cros-ec-codec.o
>  obj-$(CONFIG_SND_SOC_CS35L32)  += snd-soc-cs35l32.o
>  obj-$(CONFIG_SND_SOC_CS35L33)  += snd-soc-cs35l33.o
>  obj-$(CONFIG_SND_SOC_CS35L34)  += snd-soc-cs35l34.o
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> new file mode 100644
> index 000000000000..b14100b6a939
> --- /dev/null
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -0,0 +1,441 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for ChromeOS Embedded Controller codec.
> + *
> + * This driver uses the cros-ec interface to communicate with the ChromeOS
> + * EC for audio function.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>
> +
> +#define DRV_NAME "cros-ec-codec"
> +
> +/**
> + * struct cros_ec_codec_data - ChromeOS EC codec driver data.
> + * @dev:               Device structure used in sysfs.
> + * @ec_device:         cros_ec_device structure to talk to the physical device.
> + * @component:         Pointer to the component.
> + * @max_dmic_gain:     Maximum gain in dB supported by EC codec.
> + */
> +struct cros_ec_codec_data {
> +       struct device *dev;
> +       struct cros_ec_device *ec_device;
> +       struct snd_soc_component *component;
> +       unsigned int max_dmic_gain;
> +};
> +
> +static const DECLARE_TLV_DB_SCALE(ec_mic_gain_tlv, 0, 100, 0);
> +
> +static int ec_command_get_gain(struct snd_soc_component *component,
> +                              struct ec_param_codec_i2s *param,
> +                              struct ec_response_codec_gain *resp)
> +{
> +       struct cros_ec_codec_data *codec_data =
> +               snd_soc_component_get_drvdata(component);
> +       struct cros_ec_device *ec_device = codec_data->ec_device;
> +       u8 buffer[sizeof(struct cros_ec_command) +
> +                 max(sizeof(struct ec_param_codec_i2s),
> +                     sizeof(struct ec_response_codec_gain))];
> +       struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
> +       int ret;
> +
> +       msg->version = 0;
> +       msg->command = EC_CMD_CODEC_I2S;
> +       msg->outsize = sizeof(struct ec_param_codec_i2s);
> +       msg->insize = sizeof(struct ec_response_codec_gain);
> +
> +       memcpy(msg->data, param, msg->outsize);
> +
> +       ret = cros_ec_cmd_xfer_status(ec_device, msg);
> +       if (ret > 0)
> +               memcpy(resp, msg->data, msg->insize);
> +
> +       return ret;
> +}
> +
> +/*
> + * Wrapper for EC command without response.
> + */
> +static int ec_command_no_resp(struct snd_soc_component *component,
> +                             struct ec_param_codec_i2s *param)
> +{
> +       struct cros_ec_codec_data *codec_data =
> +               snd_soc_component_get_drvdata(component);
> +       struct cros_ec_device *ec_device = codec_data->ec_device;
> +       u8 buffer[sizeof(struct cros_ec_command) +
> +                 sizeof(struct ec_param_codec_i2s)];
> +       struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
> +
> +       msg->version = 0;
> +       msg->command = EC_CMD_CODEC_I2S;
> +       msg->outsize = sizeof(struct ec_param_codec_i2s);
> +       msg->insize = 0;
> +
> +       memcpy(msg->data, param, msg->outsize);
> +
> +       return cros_ec_cmd_xfer_status(ec_device, msg);
> +}
> +
> +static int set_i2s_config(struct snd_soc_component *component,
> +                         enum ec_i2s_config i2s_config)
> +{
> +       struct ec_param_codec_i2s param;
> +
> +       dev_dbg(component->dev, "%s set I2S format to %u\n", __func__,
> +               i2s_config);
> +
> +       param.cmd = EC_CODEC_I2S_SET_CONFIG;
> +       param.i2s_config = i2s_config;
> +
> +       return ec_command_no_resp(component, &param);
> +}
> +
> +static int cros_ec_i2s_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +       struct snd_soc_component *component = dai->component;
> +       enum ec_i2s_config i2s_config;
> +
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBS_CFS:
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +       case SND_SOC_DAIFMT_NB_NF:
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +       case SND_SOC_DAIFMT_I2S:
> +               i2s_config = EC_DAI_FMT_I2S;
> +               break;
> +
> +       case SND_SOC_DAIFMT_RIGHT_J:
> +               i2s_config = EC_DAI_FMT_RIGHT_J;
> +               break;
> +
> +       case SND_SOC_DAIFMT_LEFT_J:
> +               i2s_config = EC_DAI_FMT_LEFT_J;
> +               break;
> +
> +       case SND_SOC_DAIFMT_DSP_A:
> +               i2s_config = EC_DAI_FMT_PCM_A;
> +               break;
> +
> +       case SND_SOC_DAIFMT_DSP_B:
> +               i2s_config = EC_DAI_FMT_PCM_B;
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return set_i2s_config(component, i2s_config);
> +}
> +
> +static int set_i2s_sample_depth(struct snd_soc_component *component,
> +                               enum ec_sample_depth_value depth)
> +{
> +       struct ec_param_codec_i2s param;
> +
> +       dev_dbg(component->dev, "%s set depth to %u\n", __func__, depth);
> +
> +       param.cmd = EC_CODEC_SET_SAMPLE_DEPTH;
> +       param.depth = depth;
> +
> +       return ec_command_no_resp(component, &param);
> +}
> +
> +static int set_i2s_bclk(struct snd_soc_component *component, uint32_t bclk)
> +{
> +       struct ec_param_codec_i2s param;
> +
> +       dev_dbg(component->dev, "%s set i2s bclk to %u\n", __func__, bclk);
> +
> +       param.cmd = EC_CODEC_I2S_SET_BCLK;
> +       param.bclk = bclk;
> +
> +       return ec_command_no_resp(component, &param);
> +}
> +
> +static int cros_ec_i2s_hw_params(struct snd_pcm_substream *substream,
> +                                struct snd_pcm_hw_params *params,
> +                                struct snd_soc_dai *dai)
> +{
> +       struct snd_soc_component *component = dai->component;
> +       unsigned int rate, bclk;
> +       int ret;
> +
> +       rate = params_rate(params);
> +       if (rate != 48000)
> +               return -EINVAL;
> +
> +       switch (params_format(params)) {
> +       case SNDRV_PCM_FORMAT_S16_LE:
> +               ret = set_i2s_sample_depth(component, EC_CODEC_SAMPLE_DEPTH_16);
> +               break;
> +       case SNDRV_PCM_FORMAT_S24_LE:
> +               ret = set_i2s_sample_depth(component, EC_CODEC_SAMPLE_DEPTH_24);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       if (ret < 0)
> +               return ret;
> +
> +       bclk = snd_soc_params_to_bclk(params);
> +       return set_i2s_bclk(component, bclk);
> +}
> +
> +static const struct snd_soc_dai_ops cros_ec_i2s_dai_ops = {
> +       .hw_params = cros_ec_i2s_hw_params,
> +       .set_fmt = cros_ec_i2s_set_dai_fmt,
> +};
> +
> +struct snd_soc_dai_driver cros_ec_dai[] = {
> +       {
> +               .name = "cros_ec_codec I2S",
> +               .id = 0,
> +               .capture = {
> +                       .stream_name = "I2S Capture",
> +                       .channels_min = 2,
> +                       .channels_max = 2,
> +                       .rates = SNDRV_PCM_RATE_48000,
> +                       .formats = SNDRV_PCM_FMTBIT_S16_LE |
> +                                  SNDRV_PCM_FMTBIT_S24_LE,
> +               },
> +               .ops = &cros_ec_i2s_dai_ops,
> +       }
> +};
> +
> +static int get_ec_mic_gain(struct snd_soc_component *component,
> +                          u8 *left, u8 *right)
> +{
> +       struct ec_param_codec_i2s param;
> +       struct ec_response_codec_gain resp;
> +       int ret;
> +
> +       param.cmd = EC_CODEC_GET_GAIN;
> +
> +       ret = ec_command_get_gain(component, &param, &resp);
> +       if (ret < 0)
> +               return ret;
> +
> +       *left = resp.left;
> +       *right = resp.right;
> +
> +       return 0;
> +}
> +
> +static int mic_gain_get(struct snd_kcontrol *kcontrol,
> +                       struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_soc_component *component =
> +               snd_soc_kcontrol_component(kcontrol);
> +       u8 left, right;
> +       int ret;
> +
> +       ret = get_ec_mic_gain(component, &left, &right);
> +       if (ret)
> +               return ret;
> +
> +       ucontrol->value.integer.value[0] = left;
> +       ucontrol->value.integer.value[1] = right;
> +
> +       return 0;
> +}
> +
> +static int set_ec_mic_gain(struct snd_soc_component *component,
> +                          u8 left, u8 right)
> +{
> +       struct ec_param_codec_i2s param;
> +
> +       dev_dbg(component->dev, "%s set mic gain to %u, %u\n",
> +               __func__, left, right);
> +
> +       param.cmd = EC_CODEC_SET_GAIN;
> +       param.gain.left = left;
> +       param.gain.right = right;
> +
> +       return ec_command_no_resp(component, &param);
> +}
> +
> +static int mic_gain_put(struct snd_kcontrol *kcontrol,
> +                       struct snd_ctl_elem_value *ucontrol)
> +{
> +       struct snd_soc_component *component =
> +               snd_soc_kcontrol_component(kcontrol);
> +       struct cros_ec_codec_data *codec_data =
> +               snd_soc_component_get_drvdata(component);
> +       int left = ucontrol->value.integer.value[0];
> +       int right = ucontrol->value.integer.value[1];
> +       unsigned int max_dmic_gain = codec_data->max_dmic_gain;
> +
> +       if (left > max_dmic_gain || right > max_dmic_gain)
> +               return -EINVAL;
> +
> +       return set_ec_mic_gain(component, (u8)left, (u8)right);
> +}
> +
> +static struct snd_kcontrol_new mic_gain_control =
> +       SOC_DOUBLE_EXT_TLV("EC Mic Gain", SND_SOC_NOPM, SND_SOC_NOPM, 0, 0, 0,
> +                          mic_gain_get, mic_gain_put, ec_mic_gain_tlv);
> +
> +static int enable_i2s(struct snd_soc_component *component, int enable)
> +{
> +       struct ec_param_codec_i2s param;
> +
> +       dev_dbg(component->dev, "%s set i2s to %u\n", __func__, enable);
> +
> +       param.cmd = EC_CODEC_I2S_ENABLE;
> +       param.i2s_enable = enable;
> +
> +       return ec_command_no_resp(component, &param);
> +}
> +
> +static int cros_ec_i2s_enable_event(struct snd_soc_dapm_widget *w,
> +                                   struct snd_kcontrol *kcontrol, int event)
> +{
> +       struct snd_soc_component *component =
> +               snd_soc_dapm_to_component(w->dapm);
> +
> +       switch (event) {
> +       case SND_SOC_DAPM_PRE_PMU:
> +               dev_dbg(component->dev,
> +                       "%s got SND_SOC_DAPM_PRE_PMU event\n", __func__);
> +               return enable_i2s(component, 1);
> +
> +       case SND_SOC_DAPM_PRE_PMD:
> +               dev_dbg(component->dev,
> +                       "%s got SND_SOC_DAPM_PRE_PMD event\n", __func__);
> +               return enable_i2s(component, 0);
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * The goal of this DAPM route is to turn on/off I2S using EC
> + * host command when capture stream is started/stopped.
> + */
> +static const struct snd_soc_dapm_widget cros_ec_codec_dapm_widgets[] = {
> +       SND_SOC_DAPM_INPUT("DMIC"),
> +
> +       /*
> +        * Control EC to enable/disable I2S.
> +        */
> +       SND_SOC_DAPM_SUPPLY("I2S Enable", SND_SOC_NOPM,
> +                           0, 0, cros_ec_i2s_enable_event,
> +                           SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
> +
> +       SND_SOC_DAPM_AIF_OUT("I2STX", "I2S Capture", 0, SND_SOC_NOPM, 0, 0),
> +};
> +
> +static const struct snd_soc_dapm_route cros_ec_codec_dapm_routes[] = {
> +       { "I2STX", NULL, "DMIC" },
> +       { "I2STX", NULL, "I2S Enable" },
> +};
> +
> +/*
> + * Read maximum gain from device property and set it to mixer control.
> + */
> +static int cros_ec_set_gain_range(struct device *dev)
> +{
> +       struct soc_mixer_control *control;
> +       struct cros_ec_codec_data *codec_data = dev_get_drvdata(dev);
> +       int rc;
> +
> +       rc = device_property_read_u32(dev, "max-dmic-gain",
> +                                     &codec_data->max_dmic_gain);
> +       if (rc)
> +               return rc;
> +
> +       control = (struct soc_mixer_control *)
> +                               mic_gain_control.private_value;
> +       control->max = codec_data->max_dmic_gain;
> +       control->platform_max = codec_data->max_dmic_gain;
> +
> +       return 0;
> +}
> +
> +static int cros_ec_codec_probe(struct snd_soc_component *component)
> +{
> +       int rc;
> +
> +       struct cros_ec_codec_data *codec_data =
> +               snd_soc_component_get_drvdata(component);
> +
> +       rc = cros_ec_set_gain_range(codec_data->dev);
> +       if (rc)
> +               return rc;
> +
> +       return snd_soc_add_component_controls(component, &mic_gain_control, 1);
> +}
> +
> +static const struct snd_soc_component_driver cros_ec_component_driver = {
> +       .probe                  = cros_ec_codec_probe,
> +       .dapm_widgets           = cros_ec_codec_dapm_widgets,
> +       .num_dapm_widgets       = ARRAY_SIZE(cros_ec_codec_dapm_widgets),
> +       .dapm_routes            = cros_ec_codec_dapm_routes,
> +       .num_dapm_routes        = ARRAY_SIZE(cros_ec_codec_dapm_routes),
> +};
> +
> +/*
> + * Platform device and platform driver fro cros-ec-codec.
> + */
> +static int cros_ec_codec_platform_probe(struct platform_device *pd)
> +{
> +       struct device *dev = &pd->dev;
> +       struct cros_ec_device *ec_device = dev_get_drvdata(pd->dev.parent);
> +       struct cros_ec_codec_data *codec_data;
> +
> +       codec_data = devm_kzalloc(dev, sizeof(struct cros_ec_codec_data),
> +                                 GFP_KERNEL);
> +       if (!codec_data)
> +               return -ENOMEM;
> +
> +       codec_data->dev = dev;
> +       codec_data->ec_device = ec_device;
> +
> +       platform_set_drvdata(pd, codec_data);
> +
> +       return snd_soc_register_component(dev, &cros_ec_component_driver,
> +                                         cros_ec_dai, ARRAY_SIZE(cros_ec_dai));
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id cros_ec_codec_of_match[] = {
> +       { .compatible = "google,cros-ec-codec" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, cros_ec_codec_of_match);
> +#endif
> +
> +static struct platform_driver cros_ec_codec_platform_driver = {
> +       .driver = {
> +               .name = DRV_NAME,
> +               .of_match_table = of_match_ptr(cros_ec_codec_of_match),
> +       },
> +       .probe = cros_ec_codec_platform_probe,
> +};
> +
> +module_platform_driver(cros_ec_codec_platform_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS EC codec driver");
> +MODULE_AUTHOR("Cheng-Yi Chiang <cychiang@chromium.org>");
> +MODULE_ALIAS("platform:" DRV_NAME);
> --
> 2.20.1.321.g9e740568ce-goog
>

For the ChromeOS EC related stuff:

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
