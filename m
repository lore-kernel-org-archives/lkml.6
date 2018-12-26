Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4DAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130BE217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gog4IIvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeLZHQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 02:16:07 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45864 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeLZHQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 02:16:06 -0500
Received: by mail-ua1-f66.google.com with SMTP id e16so4866287uam.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2O9hX9b9nm9cQ4y9bjmpNajXobKjDtuuPLeJ2WCKc9o=;
        b=Gog4IIvd613rZXhLUeNGzItforUNz1nbrGDX6UufiHRIInkCWJJMOorEhtUDtlM8jz
         +QEwEJ1Ytmb9k7HKQ7Qd/BzAeENWvCvN6UpX/qslaFOiDoq38u/tOuswcAD7GUCv5CFv
         a16OPmpr4QtqKaIJhNlsu+stqVt8Xoca81n7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2O9hX9b9nm9cQ4y9bjmpNajXobKjDtuuPLeJ2WCKc9o=;
        b=SBuQFCVMZ/T4ySK4AaEmE5xfObQkwPXNXLsBYQxoFvincyipiWNhn/72proBIzYVGT
         wW4UwjFPY4y2fX+gcVsyIXroIV3vr5PCIm5SD+OC9Ke/1Mcd9d1u2QOeTLqiq5TqASLZ
         S1JKOqwNzJHzidD4EWNaoIaoYNpXMYTsjN/N5eY2p/V5i3OzwPje6+PyXC6PqCF2xXSX
         SXIg/agtNSdaF2TkSHob6ToZySMhb0BCKWWGU+mat/iMcQ3Mh8WNhhZhnALFHX9jpFjH
         xD+iok7muGraJJH+5DknHTQQKRLFAkB3m/EnktjhxLUalMTO6cgduZFKlNWhfqUMh/qB
         qe9A==
X-Gm-Message-State: AJcUukcUxqWs3Dh4J63gFfdk9jtU1rKqc60Nxf14EARrm3YOiJujVK0S
        6eRRR5ec7Wbo8gFn3Klqp8vciit+lWpkSJBcNzvaK4aY82KCzQ==
X-Google-Smtp-Source: ALg8bN5QhkZCNUyKHXGAxvIQE3p9Zctg2S+41gkikyQf5foJmKBq85cxRPanpOkvO4IR9FlvXT2lB0N9h1K4ZOSZ6Mk=
X-Received: by 2002:ab0:164a:: with SMTP id l10mr7345105uae.48.1545808564240;
 Tue, 25 Dec 2018 23:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20181224083724.75618-1-cychiang@chromium.org> <20181224083724.75618-3-cychiang@chromium.org>
 <CABXOdTduL2EESno58M6AXVhZcw09598F_9APmmErNYG4hXgyXw@mail.gmail.com>
In-Reply-To: <CABXOdTduL2EESno58M6AXVhZcw09598F_9APmmErNYG4hXgyXw@mail.gmail.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 26 Dec 2018 15:15:37 +0800
Message-ID: <CAFv8NwJT3V80wERg=-hGq_ZGRDDxc9fx3trpn+V7Zxhnq8E_Kw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ASoC: cros_ec_codec: Add codec driver for Cros EC
To:     Guenter Roeck <groeck@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,
  Thanks a lot for reviewing the patch on holidays.

On Mon, Dec 24, 2018 at 10:48 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Mon, Dec 24, 2018 at 12:45 AM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >
> > Add a codec driver to control ChromeOS EC codec.
> >
> > Use EC Host command to enable/disable I2S recording and control other
> > configurations.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  Addressed Enric's comments.
> >
> >  Changes in v2:
> >  - Many style fixes. Passed checkpatch.pl --strict.
> >  - Use ChromeOS naming.
> >  - Remove license boilerplate.
> >  - Use u8 instead of uint8_t.
> >  - Remove useless debug messages.
> >  - Remove useless remove ops.
> >  - Remove -EPROBE_DEFER in probe.
> >
> >  MAINTAINERS                      |   2 +
> >  sound/soc/codecs/Kconfig         |   8 +
> >  sound/soc/codecs/Makefile        |   2 +
> >  sound/soc/codecs/cros_ec_codec.c | 458 +++++++++++++++++++++++++++++++
> >  sound/soc/codecs/cros_ec_codec.h |  21 ++
> >  5 files changed, 491 insertions(+)
> >  create mode 100644 sound/soc/codecs/cros_ec_codec.c
> >  create mode 100644 sound/soc/codecs/cros_ec_codec.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 05e1922624e58..d66f80f3252d7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3638,8 +3638,10 @@ F:       drivers/platform/chrome/
> >
> >  CHROMEOS EC CODEC DRIVER
> >  M:     Cheng-Yi Chiang <cychiang@chromium.org>
> > +R:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >  S:     Maintained
> >  F:     Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> > +F:     sound/soc/codecs/cros_ec_codec.*
> >
> >  CIRRUS LOGIC AUDIO CODEC DRIVERS
> >  M:     Brian Austin <brian.austin@cirrus.com>
> > diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> > index 87cb9c51e6f5a..0b36428159b71 100644
> > --- a/sound/soc/codecs/Kconfig
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -50,6 +50,7 @@ config SND_SOC_ALL_CODECS
> >         select SND_SOC_BT_SCO
> >         select SND_SOC_BD28623
> >         select SND_SOC_CQ0093VC
> > +       select SND_SOC_CROS_EC_CODEC
> >         select SND_SOC_CS35L32 if I2C
> >         select SND_SOC_CS35L33 if I2C
> >         select SND_SOC_CS35L34 if I2C
> > @@ -457,6 +458,13 @@ config SND_SOC_CPCAP
> >  config SND_SOC_CQ0093VC
> >         tristate
> >
> > +config SND_SOC_CROS_EC_CODEC
> > +       tristate "codec driver for ChromeOS EC"
> > +       depends on MFD_CROS_EC
> > +       help
> > +         If you say yes here you will get support for the
> > +         ChromeOS Embedded Controller's Audio Codec.
> > +
> >  config SND_SOC_CS35L32
> >         tristate "Cirrus Logic CS35L32 CODEC"
> >         depends on I2C
> > diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> > index 9bb3346fab2fe..3cfd8f5f61705 100644
> > --- a/sound/soc/codecs/Makefile
> > +++ b/sound/soc/codecs/Makefile
> > @@ -42,6 +42,7 @@ snd-soc-bd28623-objs := bd28623.o
> >  snd-soc-bt-sco-objs := bt-sco.o
> >  snd-soc-cpcap-objs := cpcap.o
> >  snd-soc-cq93vc-objs := cq93vc.o
> > +snd-soc-cros-ec-codec-objs := cros_ec_codec.o
> >  snd-soc-cs35l32-objs := cs35l32.o
> >  snd-soc-cs35l33-objs := cs35l33.o
> >  snd-soc-cs35l34-objs := cs35l34.o
> > @@ -310,6 +311,7 @@ obj-$(CONFIG_SND_SOC_BD28623)       += snd-soc-bd28623.o
> >  obj-$(CONFIG_SND_SOC_BT_SCO)   += snd-soc-bt-sco.o
> >  obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
> >  obj-$(CONFIG_SND_SOC_CPCAP)    += snd-soc-cpcap.o
> > +obj-$(CONFIG_SND_SOC_CROS_EC_CODEC)    += snd-soc-cros-ec-codec.o
> >  obj-$(CONFIG_SND_SOC_CS35L32)  += snd-soc-cs35l32.o
> >  obj-$(CONFIG_SND_SOC_CS35L33)  += snd-soc-cs35l33.o
> >  obj-$(CONFIG_SND_SOC_CS35L34)  += snd-soc-cs35l34.o
> > diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> > new file mode 100644
> > index 0000000000000..39e61bf46b5c0
> > --- /dev/null
> > +++ b/sound/soc/codecs/cros_ec_codec.c
> > @@ -0,0 +1,458 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for ChromeOS Embedded Controller codec.
> > + *
> > + * This driver uses the cros-ec interface to communicate with the ChromeOS
> > + * EC for audio function.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/cros_ec.h>
> > +#include <linux/mfd/cros_ec_commands.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <sound/pcm.h>
> > +#include <sound/pcm_params.h>
> > +#include <sound/soc.h>
> > +#include <sound/tlv.h>
> > +
> > +#include "cros_ec_codec.h"
> > +
> > +#define MAX_GAIN 43
> > +
> > +#define DRV_NAME "cros-ec-codec"
> > +
> > +static const DECLARE_TLV_DB_SCALE(ec_mic_gain_tlv, 0, 100, 0);
> > +/*
> > + * Wrapper for EC command.
> > + */
> > +static int ec_command(struct snd_soc_component *component, int version,
> > +                     int command, u8 *outdata, int outsize,
> > +                     u8 *indata, int insize)
> > +{
> > +       struct cros_ec_codec_data *codec_data =
> > +               snd_soc_component_get_drvdata(component);
> > +       struct cros_ec_device *ec_device = codec_data->ec_device;
> > +       struct cros_ec_command *msg;
> > +       int ret;
> > +
> > +       msg = kzalloc(sizeof(*msg) + max(insize, outsize), GFP_KERNEL);
> > +       if (!msg)
> > +               return -ENOMEM;
> > +
> > +       msg->version = version;
> > +       msg->command = command;
> > +       msg->outsize = outsize;
> > +       msg->insize = insize;
> > +
> > +       if (outsize)
> > +               memcpy(msg->data, outdata, outsize);
> > +
> > +       ret = cros_ec_cmd_xfer_status(ec_device, msg);
> > +       if (ret > 0 && insize)
> > +               memcpy(indata, msg->data, insize);
> > +
> > +       kfree(msg);
> > +       return ret;
> > +}
> > +
> > +static int set_i2s_config(struct snd_soc_component *component,
> > +                         enum ec_i2s_config i2s_config)
> > +{
> > +       struct ec_param_codec_i2s param;
> > +       int ret;
> > +
> > +       dev_dbg(component->dev, "%s set I2S format to %u\n", __func__,
> > +               i2s_config);
> > +
> > +       param.cmd = EC_CODEC_I2S_SET_CONFIG;
> > +       param.i2s_config = i2s_config;
> > +
> > +       ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
> > +                        (u8 *)&param, sizeof(param),
> > +                        NULL, 0);
> > +       if (ret < 0) {
> > +               dev_err(component->dev,
> > +                       "set I2S format to %u command returned %d\n",
> > +                       i2s_config, ret);
> > +               return -EINVAL;
>
> Overriding error codes is discouraged. You'll probably get a warning
> from a static analyzer for this.
>

Fixed here and many other places in v3.
Could you please suggest a static analyzer ?
I tried smatch ( https://repo.or.cz/smatch.git ) but it could not find
this kind of issue.

> > +       }
> > +       return 0;
> > +}
> > +
> > +static int cros_ec_i2s_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> > +{
> > +       struct snd_soc_component *component = dai->component;
> > +       enum ec_i2s_config i2s_config;
> > +
> > +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > +       case SND_SOC_DAIFMT_CBS_CFS:
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> > +       case SND_SOC_DAIFMT_NB_NF:
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +       case SND_SOC_DAIFMT_I2S:
> > +               i2s_config = EC_DAI_FMT_I2S;
> > +               break;
> > +
> > +       case SND_SOC_DAIFMT_RIGHT_J:
> > +               i2s_config = EC_DAI_FMT_RIGHT_J;
> > +               break;
> > +
> > +       case SND_SOC_DAIFMT_LEFT_J:
> > +               i2s_config = EC_DAI_FMT_LEFT_J;
> > +               break;
> > +
> > +       case SND_SOC_DAIFMT_DSP_A:
> > +               i2s_config = EC_DAI_FMT_PCM_A;
> > +               break;
> > +
> > +       case SND_SOC_DAIFMT_DSP_B:
> > +               i2s_config = EC_DAI_FMT_PCM_B;
> > +               break;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       set_i2s_config(component, i2s_config);
> > +
> > +       return 0;
> > +}
> > +
> > +static int set_i2s_sample_depth(struct snd_soc_component *component,
> > +                               enum ec_sample_depth_value depth)
> > +{
> > +       struct ec_param_codec_i2s param;
> > +       int ret;
> > +
> > +       dev_dbg(component->dev, "%s set depth to %u\n", __func__, depth);
> > +
> > +       param.cmd = EC_CODEC_SET_SAMPLE_DEPTH;
> > +       param.depth = depth;
> > +
> > +       ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
> > +                        (u8 *)&param, sizeof(param),
> > +                        NULL, 0);
> > +       if (ret < 0) {
> > +               dev_err(component->dev, "I2S sample depth %u returned %d\n",
> > +                       depth, ret);
>
> Is all that error noise common in ASoC drivers ? If it can result in
> log spam, I would recommend against it.
>
This is useful for debugging when EC does not handle the request correctly.
Usually this will not happen so it will not spam the log.

> > +               return -EINVAL;
>
> Same as above and everywhere else.
>

Fixed in v3.

> > +       }
> > +       return 0;
> > +}
> > +
> > +static int set_bclk(struct snd_soc_component *component, uint32_t bclk)
> > +{
> > +       struct ec_param_codec_i2s param;
> > +       int ret;
> > +
> > +       dev_dbg(component->dev, "%s set i2s bclk to %u\n", __func__, bclk);
> > +
> > +       param.cmd = EC_CODEC_I2S_SET_BCLK;
> > +       param.bclk = bclk;
> > +
> > +       ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
> > +                        (u8 *)&param, sizeof(param),
> > +                        NULL, 0);
> > +       if (ret < 0) {
> > +               dev_err(component->dev, "I2S set bclk %u command returned %d\n",
> > +                       bclk, ret);
> > +               return -EINVAL;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int cros_ec_i2s_hw_params(struct snd_pcm_substream *substream,
> > +                                struct snd_pcm_hw_params *params,
> > +                                struct snd_soc_dai *dai)
> > +{
> > +       struct snd_soc_component *component = dai->component;
> > +       int frame_size;
> > +       unsigned int rate, bclk;
> > +       int ret;
> > +
> > +       frame_size = snd_soc_params_to_frame_size(params);
> > +       if (frame_size < 0) {
> > +               dev_err(component->dev, "Unsupported frame size: %d\n",
> > +                       frame_size);
> > +               return -EINVAL;
> > +       }
> > +
> > +       rate = params_rate(params);
> > +       if (rate != 48000) {
> > +               dev_err(component->dev, "Unsupported rate\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       switch (params_format(params)) {
> > +       case SNDRV_PCM_FORMAT_S16_LE:
> > +               ret = set_i2s_sample_depth(component, EC_CODEC_SAMPLE_DEPTH_16);
> > +               break;
> > +       case SNDRV_PCM_FORMAT_S24_LE:
> > +               ret = set_i2s_sample_depth(component, EC_CODEC_SAMPLE_DEPTH_24);
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (ret)
> > +               return ret;
> > +
> > +       bclk = snd_soc_params_to_bclk(params);
> > +       ret = set_bclk(component, bclk);
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct snd_soc_dai_ops cros_ec_i2s_dai_ops = {
> > +       .hw_params = cros_ec_i2s_hw_params,
> > +       .set_fmt = cros_ec_i2s_set_dai_fmt,
> > +};
> > +
> > +struct snd_soc_dai_driver cros_ec_dai[] = {
> > +       {
> > +               .name = "cros_ec_codec I2S",
> > +               .id = 0,
> > +               .capture = {
> > +                       .stream_name = "I2S Capture",
> > +                       .channels_min = 2,
> > +                       .channels_max = 2,
> > +                       .rates = SNDRV_PCM_RATE_48000,
> > +                       .formats = SNDRV_PCM_FMTBIT_S16_LE |
> > +                                  SNDRV_PCM_FMTBIT_S24_LE,
> > +               },
> > +               .ops = &cros_ec_i2s_dai_ops,
> > +       }
> > +};
> > +
> > +static int get_ec_mic_gain(struct snd_soc_component *component,
> > +                          u8 *left, u8 *right)
> > +{
> > +       struct ec_param_codec_i2s param;
> > +       struct ec_response_codec_gain resp;
> > +       int ret;
> > +
> > +       param.cmd = EC_CODEC_GET_GAIN;
> > +
> > +       ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
> > +                        (u8 *)&param, sizeof(param),
> > +                        (u8 *)&resp, sizeof(resp));
> > +       if (ret < 0) {
> > +               dev_err(component->dev, "I2S get gain command returned %d\n",
> > +                       ret);
> > +               return -EINVAL;
> > +       }
> > +
> > +       *left = resp.left;
> > +       *right = resp.right;
> > +
> > +       dev_dbg(component->dev, "%s get mic gain %u, %u\n", __func__,
> > +               *left, *right);
> > +
> > +       return 0;
> > +}
> > +
> > +static int mic_gain_get(struct snd_kcontrol *kcontrol,
> > +                       struct snd_ctl_elem_value *ucontrol)
> > +{
> > +       struct snd_soc_component *component =
> > +               snd_soc_kcontrol_component(kcontrol);
> > +       u8 left, right;
> > +       int ret;
> > +
> > +       ret = get_ec_mic_gain(component, &left, &right);
> > +
> An empty line before checking return codes used to result in a
> checkpatch warning. Even if that is not so anymore, I would suggest to
> remove such empty lines as unnecessary.
>

Fixed in v3.

> > +       if (ret)
> > +               return ret;
> > +
> > +       ucontrol->value.integer.value[0] = left;
> > +       ucontrol->value.integer.value[1] = right;
> > +
> > +       return 0;
> > +}
> > +
> > +static int set_ec_mic_gain(struct snd_soc_component *component,
> > +                          u8 left, u8 right)
> > +{
> > +       struct ec_param_codec_i2s param;
> > +       int ret;
> > +
> > +       dev_dbg(component->dev, "%s set mic gain to %u, %u\n",
> > +               __func__, left, right);
> > +
> > +       param.cmd = EC_CODEC_SET_GAIN;
> > +       param.gain.left = left;
> > +       param.gain.right = right;
> > +
> > +       ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
> > +                        (u8 *)&param, sizeof(param),
> > +                        NULL, 0);
> > +       if (ret < 0) {
> > +               dev_err(component->dev, "I2S set gain command returned %d\n",
> > +                       ret);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int mic_gain_put(struct snd_kcontrol *kcontrol,
> > +                       struct snd_ctl_elem_value *ucontrol)
> > +{
> > +       struct snd_soc_component *component =
> > +               snd_soc_kcontrol_component(kcontrol);
> > +       int left = ucontrol->value.integer.value[0];
> > +       int right = ucontrol->value.integer.value[1];
> > +       int ret;
> > +
> > +       if (left > MAX_GAIN || right > MAX_GAIN)
> > +               return -EINVAL;
> > +
> > +       ret = set_ec_mic_gain(component, (u8)left, (u8)right);
> > +
> > +       if (ret)
> > +               return ret;
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct snd_kcontrol_new cros_ec_snd_controls[] = {
> > +       SOC_DOUBLE_EXT_TLV("EC Mic Gain", SND_SOC_NOPM, SND_SOC_NOPM, 0, 43, 0,
> > +                          mic_gain_get, mic_gain_put, ec_mic_gain_tlv)
> > +};
> > +
> > +static int enable_i2s(struct snd_soc_component *component, int enable)
> > +{
> > +       struct ec_param_codec_i2s param;
> > +       int ret;
> > +
> > +       dev_dbg(component->dev, "%s set i2s to %u\n", __func__, enable);
> > +
> > +       param.cmd = EC_CODEC_I2S_ENABLE;
> > +       param.i2s_enable = enable;
> > +
> > +       ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
> > +                        (u8 *)&param, sizeof(param),
> > +                        NULL, 0);
> > +       if (ret < 0) {
> > +               dev_err(component->dev, "I2S enable %d command returned %d\n",
> > +                       enable, ret);
> > +               return -EINVAL;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int cros_ec_i2s_enable_event(struct snd_soc_dapm_widget *w,
> > +                                   struct snd_kcontrol *kcontrol, int event)
> > +{
> > +       struct snd_soc_component *component =
> > +               snd_soc_dapm_to_component(w->dapm);
> > +
> > +       switch (event) {
> > +       case SND_SOC_DAPM_PRE_PMU:
> > +               dev_dbg(component->dev,
> > +                       "%s got SND_SOC_DAPM_PRE_PMU event\n", __func__);
> > +               return enable_i2s(component, 1);
> > +
> > +       case SND_SOC_DAPM_PRE_PMD:
> > +               dev_dbg(component->dev,
> > +                       "%s got SND_SOC_DAPM_PRE_PMD event\n", __func__);
> > +               return enable_i2s(component, 0);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * The goal of this DAPM route is to turn on/off I2S using EC
> > + * host command when capture stream is started/stopped.
> > + */
> > +static const struct snd_soc_dapm_widget cros_ec_dapm_widgets[] = {
> > +       SND_SOC_DAPM_INPUT("DMIC"),
> > +
> > +       /*
> > +        * Control EC to enable/disable I2S.
> > +        */
> > +       SND_SOC_DAPM_SUPPLY("I2S Enable", SND_SOC_NOPM,
> > +                           0, 0, cros_ec_i2s_enable_event,
> > +                           SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
> > +
> > +       SND_SOC_DAPM_AIF_OUT("I2STX", "I2S Capture", 0, SND_SOC_NOPM, 0, 0),
> > +};
> > +
> > +static const struct snd_soc_dapm_route cros_ec_dapm_routes[] = {
> > +       { "I2STX", NULL, "DMIC" },
> > +       { "I2STX", NULL, "I2S Enable" },
> > +};
> > +
> > +static const struct snd_soc_component_driver cros_ec_component_driver = {
> > +       .controls               = cros_ec_snd_controls,
> > +       .num_controls           = ARRAY_SIZE(cros_ec_snd_controls),
> > +       .dapm_widgets           = cros_ec_dapm_widgets,
> > +       .num_dapm_widgets       = ARRAY_SIZE(cros_ec_dapm_widgets),
> > +       .dapm_routes            = cros_ec_dapm_routes,
> > +       .num_dapm_routes        = ARRAY_SIZE(cros_ec_dapm_routes),
> > +};
> > +
> > +/*
> > + * Platform device and platform driver fro cros-ec-codec.
> > + */
> > +static int cros_ec_codec_platform_probe(struct platform_device *pd)
> > +{
> > +       struct device *dev = &pd->dev;
> > +       struct cros_ec_device *ec_device = dev_get_drvdata(pd->dev.parent);
> > +       struct cros_ec_codec_data *codec_data;
> > +       int rc;
> > +
> > +       codec_data = devm_kzalloc(dev, sizeof(struct cros_ec_codec_data),
> > +                                 GFP_KERNEL);
> > +       if (!codec_data)
> > +               return -ENOMEM;
> > +
> > +       codec_data->dev = dev;
> > +       codec_data->ec_device = ec_device;
> > +
> > +       platform_set_drvdata(pd, codec_data);
> > +
> > +       rc = snd_soc_register_component(dev, &cros_ec_component_driver,
> > +                                       cros_ec_dai, ARRAY_SIZE(cros_ec_dai));
> > +
> > +       dev_dbg(dev, "%s done\n", __func__);
> > +
> > +       return 0;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id cros_ec_codec_of_match[] = {
> > +       { .compatible = "google,cros-ec-codec" },
> > +       {},
> > +};
> > +MODULE_DEVICE_TABLE(of, cros_ec_codec_of_match);
> > +#endif
> > +
> > +static struct platform_driver cros_ec_codec_platform_driver = {
> > +       .driver = {
> > +               .name = DRV_NAME,
> > +               .of_match_table = of_match_ptr(cros_ec_codec_of_match),
> > +       },
> > +       .probe = cros_ec_codec_platform_probe,
> > +};
> > +
> > +module_platform_driver(cros_ec_codec_platform_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("ChromeOS EC codec driver");
> > +MODULE_AUTHOR("Cheng-Yi Chiang <cychiang@chromium.org>");
> > +MODULE_ALIAS("platform:" DRV_NAME);
> > diff --git a/sound/soc/codecs/cros_ec_codec.h b/sound/soc/codecs/cros_ec_codec.h
> > new file mode 100644
> > index 0000000000000..3c566079f4ee2
> > --- /dev/null
> > +++ b/sound/soc/codecs/cros_ec_codec.h
>
> I don't see the point of this include file. The data structure it
> defines is only used in a single source file, and may as well be
> defined there. I would suggest to do that unless it is common practice
> in ASoC drivers.
>

Yes you are right. Removed in v3.

> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * ChromeOS EC Codec
> > + */
> > +
> > +#ifndef __CROS_EC_CODEC_H
> > +#define __CROS_EC_CODEC_H
> > +
> > +/**
> > + * struct cros_ec_codec_data - ChromeOS EC codec driver data.
> > + * @dev:         Device structure used in sysfs.
> > + * @ec_device:   cros_ec_device structure to talk to the physical device.
> > + * @component:   Pointer to the component.
> > + */
> > +struct cros_ec_codec_data {
> > +       struct device *dev;
> > +       struct cros_ec_device *ec_device;
> > +       struct snd_soc_component *component;
> > +};
> > +
> > +#endif  /* __CROS_EC_CODEC_H */
> > --
> > 2.20.1.415.g653613c723-goog
> >
