Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A67C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F6D20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 04:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaZzQrwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfAQEed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 23:34:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34540 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfAQEed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 23:34:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so4195266pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 20:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZRcdr8iHywwcaDfDerF1xNcUQGlpGRCJirIcjwwllXc=;
        b=RaZzQrwo2k0DXG8BWfE7tH82RmTfsEtL0rRX1xWUHB12RB5+0kxxnAYwH6pYkWRtjA
         jJiMeGjw2V+/ju0rep5WHQd9u7Ec/Gh9RG+tnyfGom6KJUjWDt9zjybV9b5jmzo9JzRY
         ueW6HCEF/czNi+BqCKRhXw1ywpqH8rueYi8quMicKZSkiWhlDoZjbPUN5Yqt7v2MzHl5
         /zwI/17CUtqxCFEm8/eMe8st6Nkovhp+b980oXL4PrdUqD/9uRewSEf5mduEyuVs7A3c
         mwK3DkMsm9ahNm5KpHANaKBlNXxyK6717jHbT4flACQSRK36/+VmMsOLwEOGYVFf0FXc
         ibWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZRcdr8iHywwcaDfDerF1xNcUQGlpGRCJirIcjwwllXc=;
        b=Csnn41drrZQPlTOGEqW2LQ6TpMRhBMUtrIm+I7vaPTekhLaZt43Ei+08f+8Xc6fVS4
         C6yLdiQmgKRmfHG2eDSborUJu+YggTQzEwEAJ18ryjjJ2u0CnM9dR8/Rl3nFUxyk6USz
         gQOgoLlMDL/E4sXOUiEAfhCTRyVFumRfOW5s+42L84zykN4Zh3Z6u4RdKooRPyqGgFq9
         P1ypes0jkPj4XlwalPtzy7WHrlXbaYCsGL4Co5bsT3HEUeTjzbamGYkPfKeDyH243+Ou
         4Mgfz5DHPUn2NEIIXZrHf4nda+vOi2pI3tWHKugf4ep8j77KAaqFkfxqsx2d08nln1fq
         zFLA==
X-Gm-Message-State: AJcUuken5cXEMgkTxQGXBVvoTALSXahsN64vqFmCncr7uuXBU1lcXWnN
        EC/dhhk9QLMkM8aUSAMIImZFMEzg
X-Google-Smtp-Source: ALg8bN7YhkVUXU9ll3FRlPWlkdwYGwBRldYY7Hd23luMuvaSn/jvPXjYE4v/Y5ic+nDcKnKdPRR3eA==
X-Received: by 2002:a62:2702:: with SMTP id n2mr13674740pfn.29.1547699671557;
        Wed, 16 Jan 2019 20:34:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w88sm678146pfk.11.2019.01.16.20.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 20:34:30 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH v3 3/3] ASoC: cros_ec_codec: Add codec driver
 for Cros EC
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
References: <20181226070317.72022-1-cychiang@chromium.org>
 <20181226070317.72022-3-cychiang@chromium.org>
 <20190116061802.GA31405@roeck-us.net>
 <CAFv8NwL9ZTd2C09FzrNHpBfVw2vKb4mdK8kKMV4a9F3t73N7+A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d4018991-e26e-4440-686c-920507b7d32e@roeck-us.net>
Date:   Wed, 16 Jan 2019 20:34:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFv8NwL9ZTd2C09FzrNHpBfVw2vKb4mdK8kKMV4a9F3t73N7+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 8:25 PM, Cheng-yi Chiang wrote:
> Hi Guenter,
> 
> Thanks for the review!
> 
> On Wed, Jan 16, 2019 at 2:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Wed, Dec 26, 2018 at 03:03:19PM +0800, Cheng-Yi Chiang wrote:
>>> Add a codec driver to control ChromeOS EC codec.
>>>
>>> Use EC Host command to enable/disable I2S recording and control other
>>> configurations.
>>>
>>> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
>>> ---
>>> Changes in v3:
>>> 1.remove cros_ec_codec.h.
>>> 2.Fix error code overriding in
>>>      set_i2s_config
>>>      set_i2s_sample_depth
>>>      set_bclk
>>>      get_ec_mic_gain
>>>      set_ec_mic_gain
>>>      enable_i2s
>>> 3.Fix missing return code in cros_ec_i2s_set_dai_fmt.
>>> 4.Simplify return code in cros_ec_i2s_hw_params and mic_gain_put.
>>> 5.Remove useless debug message in cros_ec_codec_platform_probe.
>>>
>>>   MAINTAINERS                      |   2 +
>>>   sound/soc/codecs/Kconfig         |   8 +
>>>   sound/soc/codecs/Makefile        |   2 +
>>>   sound/soc/codecs/cros_ec_codec.c | 454 +++++++++++++++++++++++++++++++
>>>   4 files changed, 466 insertions(+)
>>>   create mode 100644 sound/soc/codecs/cros_ec_codec.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 05e1922624e58..d66f80f3252d7 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -3638,8 +3638,10 @@ F:     drivers/platform/chrome/
>>>
>>>   CHROMEOS EC CODEC DRIVER
>>>   M:   Cheng-Yi Chiang <cychiang@chromium.org>
>>> +R:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>   S:   Maintained
>>>   F:   Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
>>> +F:   sound/soc/codecs/cros_ec_codec.*
>>>
>>>   CIRRUS LOGIC AUDIO CODEC DRIVERS
>>>   M:   Brian Austin <brian.austin@cirrus.com>
>>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>>> index 87cb9c51e6f5a..0b36428159b71 100644
>>> --- a/sound/soc/codecs/Kconfig
>>> +++ b/sound/soc/codecs/Kconfig
>>> @@ -50,6 +50,7 @@ config SND_SOC_ALL_CODECS
>>>        select SND_SOC_BT_SCO
>>>        select SND_SOC_BD28623
>>>        select SND_SOC_CQ0093VC
>>> +     select SND_SOC_CROS_EC_CODEC
>>
>> This unconditionally selects SND_SOC_CROS_EC_CODEC, but SND_SOC_CROS_EC_CODEC
>> depends on MFD_CROS_EC. This is missing an "if MFD_CROS_EC" qualifier.
>>
> Will fix in v4.
>>>        select SND_SOC_CS35L32 if I2C
>>>        select SND_SOC_CS35L33 if I2C
>>>        select SND_SOC_CS35L34 if I2C
>>> @@ -457,6 +458,13 @@ config SND_SOC_CPCAP
>>>   config SND_SOC_CQ0093VC
>>>        tristate
>>>
>>> +config SND_SOC_CROS_EC_CODEC
>>> +     tristate "codec driver for ChromeOS EC"
>>> +     depends on MFD_CROS_EC
>>> +     help
>>> +       If you say yes here you will get support for the
>>> +       ChromeOS Embedded Controller's Audio Codec.
>>> +
>>>   config SND_SOC_CS35L32
>>>        tristate "Cirrus Logic CS35L32 CODEC"
>>>        depends on I2C
>>> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
>>> index 9bb3346fab2fe..3cfd8f5f61705 100644
>>> --- a/sound/soc/codecs/Makefile
>>> +++ b/sound/soc/codecs/Makefile
>>> @@ -42,6 +42,7 @@ snd-soc-bd28623-objs := bd28623.o
>>>   snd-soc-bt-sco-objs := bt-sco.o
>>>   snd-soc-cpcap-objs := cpcap.o
>>>   snd-soc-cq93vc-objs := cq93vc.o
>>> +snd-soc-cros-ec-codec-objs := cros_ec_codec.o
>>>   snd-soc-cs35l32-objs := cs35l32.o
>>>   snd-soc-cs35l33-objs := cs35l33.o
>>>   snd-soc-cs35l34-objs := cs35l34.o
>>> @@ -310,6 +311,7 @@ obj-$(CONFIG_SND_SOC_BD28623)     += snd-soc-bd28623.o
>>>   obj-$(CONFIG_SND_SOC_BT_SCO) += snd-soc-bt-sco.o
>>>   obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
>>>   obj-$(CONFIG_SND_SOC_CPCAP)  += snd-soc-cpcap.o
>>> +obj-$(CONFIG_SND_SOC_CROS_EC_CODEC)  += snd-soc-cros-ec-codec.o
>>>   obj-$(CONFIG_SND_SOC_CS35L32)        += snd-soc-cs35l32.o
>>>   obj-$(CONFIG_SND_SOC_CS35L33)        += snd-soc-cs35l33.o
>>>   obj-$(CONFIG_SND_SOC_CS35L34)        += snd-soc-cs35l34.o
>>> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
>>> new file mode 100644
>>> index 0000000000000..85ea23f4b681c
>>> --- /dev/null
>>> +++ b/sound/soc/codecs/cros_ec_codec.c
>>> @@ -0,0 +1,454 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Driver for ChromeOS Embedded Controller codec.
>>> + *
>>> + * This driver uses the cros-ec interface to communicate with the ChromeOS
>>> + * EC for audio function.
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/device.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/mfd/cros_ec.h>
>>> +#include <linux/mfd/cros_ec_commands.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <sound/pcm.h>
>>> +#include <sound/pcm_params.h>
>>> +#include <sound/soc.h>
>>> +#include <sound/tlv.h>
>>> +
>>> +#define MAX_GAIN 43
>>
>> Is there some reason for this magic number ? What does it reflect ?
>>
> 
> This value is determined by the EC chip to represent the maximum gain
> in dB that EC codec can support.
> Since it might be different in the future for different EC chip, it
> needs to be adjustable.
> I plan to pass this value as "max-dmic-gain" from device property.
> This driver can lookup the property it its probe function, and modify
> the max value in mixer control for gain accordingly.
> I could not find similar use case in other codec driver but it should be doable.
> Please let me know if this is not encouraged.
> 

A brief comment such as "Maximum gain in dB supported by EC codec" might be useful.

Thanks,
Guenter

>>> +
>>> +#define DRV_NAME "cros-ec-codec"
>>> +
>>> +/**
>>> + * struct cros_ec_codec_data - ChromeOS EC codec driver data.
>>> + * @dev:         Device structure used in sysfs.
>>> + * @ec_device:   cros_ec_device structure to talk to the physical device.
>>> + * @component:   Pointer to the component.
>>> + */
>>> +struct cros_ec_codec_data {
>>> +     struct device *dev;
>>> +     struct cros_ec_device *ec_device;
>>> +     struct snd_soc_component *component;
>>> +};
>>> +
>>> +static const DECLARE_TLV_DB_SCALE(ec_mic_gain_tlv, 0, 100, 0);
>>> +/*
>>> + * Wrapper for EC command.
>>> + */
>>> +static int ec_command(struct snd_soc_component *component, int version,
>>> +                   int command, u8 *outdata, int outsize,
>>> +                   u8 *indata, int insize)
>>> +{
>>> +     struct cros_ec_codec_data *codec_data =
>>> +             snd_soc_component_get_drvdata(component);
>>> +     struct cros_ec_device *ec_device = codec_data->ec_device;
>>> +     struct cros_ec_command *msg;
>>> +     int ret;
>>> +
>>> +     msg = kzalloc(sizeof(*msg) + max(insize, outsize), GFP_KERNEL);
>>> +     if (!msg)
>>> +             return -ENOMEM;
>>
>> As far as I can see, the calling parameter is always "struct ec_param_codec_i2s".
>> With that in mind, this code seems unnecessarily complex. Is this code expected
>> to be called multiple times in parallel and requires multiple instances of
>> struct ec_param_codec_i2s to be allocated ? Even if so, why not just use
>> a local variable / array ?
>>
>> [ This makes me wonder how EC transfers are synchronized in
>>    cros_ec_cmd_xfer_status() and below. Does anyone know ? I don't immedately
>>    see it.
>> ]
> 
> I agree with you suggestion of using local variable.
> All the needed commands are subcommands in EC_CMD_CODEC_I2S command.
> So "struct ec_param_codec_i2s" is the only param that will be passed
> to ec_command function.
> This ec_command function can be greatly simplified.
> 
> As for multiple access to this ec_command function, I need to dig more into it.
> There are locks in stream and kcontrol to guard the access
> respectively, but I am not sure if stream and kcontrol will access
> this ec_command function at the same time.
> It should be safer to use local variable to hold this parameter.
> 
>>
>>> +
>>> +     msg->version = version;
>>> +     msg->command = command;
>>> +     msg->outsize = outsize;
>>> +     msg->insize = insize;
>>> +
>>> +     if (outsize)
>>> +             memcpy(msg->data, outdata, outsize);
>>> +
>>> +     ret = cros_ec_cmd_xfer_status(ec_device, msg);
>>> +     if (ret > 0 && insize)
>>> +             memcpy(indata, msg->data, insize);
>>> +
>>> +     kfree(msg);
>>> +     return ret;
>>
>> I know this is wide-spread in cros_ec drivers, but that doesn't make it better.
>> The positive return value isn't used anywhere. On top of that, the called low
>> level code already generates error messages. As a result, the code calling this
>> function is unnecessarily complex. If the function was to return 0 for success
>> and a negative error code otherwise, pret much all all callers could be
>> simplified to
>>
>>          return ec_command(...);
>>
> 
> My intention was to print some error message so I can identify the
> command that failed.
> cros_ec_cmd_xfer and cros_ec_cmd_xfer_status have messages for error,
> but not the command it tried to send.
> I can remove them since they cause unnecessary complexity.
> I guess I can still rely on error messages in upper layers to tell
> what command fails.
> Will follow your advice in v4.
> 
> Thanks again!
> 
> 
> 
>>> +}
>>> +
>>> +static int set_i2s_config(struct snd_soc_component *component,
>>> +                       enum ec_i2s_config i2s_config)
>>> +{
>>> +     struct ec_param_codec_i2s param;
>>> +     int ret;
>>> +
>>> +     dev_dbg(component->dev, "%s set I2S format to %u\n", __func__,
>>> +             i2s_config);
>>> +
>>> +     param.cmd = EC_CODEC_I2S_SET_CONFIG;
>>> +     param.i2s_config = i2s_config;
>>> +
>>> +     ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
>>> +                      (u8 *)&param, sizeof(param),
>>> +                      NULL, 0);
>>> +     if (ret < 0) {
>>> +             dev_err(component->dev,
>>> +                     "set I2S format to %u command returned %d\n",
>>> +                     i2s_config, ret);
>>> +             return ret;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +static int cros_ec_i2s_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>>> +{
>>> +     struct snd_soc_component *component = dai->component;
>>> +     enum ec_i2s_config i2s_config;
>>> +
>>> +     switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>>> +     case SND_SOC_DAIFMT_CBS_CFS:
>>> +             break;
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
>>> +     case SND_SOC_DAIFMT_NB_NF:
>>> +             break;
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>>> +     case SND_SOC_DAIFMT_I2S:
>>> +             i2s_config = EC_DAI_FMT_I2S;
>>> +             break;
>>> +
>>> +     case SND_SOC_DAIFMT_RIGHT_J:
>>> +             i2s_config = EC_DAI_FMT_RIGHT_J;
>>> +             break;
>>> +
>>> +     case SND_SOC_DAIFMT_LEFT_J:
>>> +             i2s_config = EC_DAI_FMT_LEFT_J;
>>> +             break;
>>> +
>>> +     case SND_SOC_DAIFMT_DSP_A:
>>> +             i2s_config = EC_DAI_FMT_PCM_A;
>>> +             break;
>>> +
>>> +     case SND_SOC_DAIFMT_DSP_B:
>>> +             i2s_config = EC_DAI_FMT_PCM_B;
>>> +             break;
>>> +
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     return set_i2s_config(component, i2s_config);
>>> +}
>>> +
>>> +static int set_i2s_sample_depth(struct snd_soc_component *component,
>>> +                             enum ec_sample_depth_value depth)
>>> +{
>>> +     struct ec_param_codec_i2s param;
>>> +     int ret;
>>> +
>>> +     dev_dbg(component->dev, "%s set depth to %u\n", __func__, depth);
>>> +
>>> +     param.cmd = EC_CODEC_SET_SAMPLE_DEPTH;
>>> +     param.depth = depth;
>>> +
>>> +     ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
>>> +                      (u8 *)&param, sizeof(param),
>>> +                      NULL, 0);
>>> +     if (ret < 0) {
>>> +             dev_err(component->dev, "I2S sample depth %u returned %d\n",
>>> +                     depth, ret);
>>> +             return ret;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +static int set_bclk(struct snd_soc_component *component, uint32_t bclk)
>>> +{
>>> +     struct ec_param_codec_i2s param;
>>> +     int ret;
>>> +
>>> +     dev_dbg(component->dev, "%s set i2s bclk to %u\n", __func__, bclk);
>>> +
>>> +     param.cmd = EC_CODEC_I2S_SET_BCLK;
>>> +     param.bclk = bclk;
>>> +
>>> +     ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
>>> +                      (u8 *)&param, sizeof(param),
>>> +                      NULL, 0);
>>> +     if (ret < 0) {
>>> +             dev_err(component->dev, "I2S set bclk %u command returned %d\n",
>>> +                     bclk, ret);
>>> +             return ret;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +static int cros_ec_i2s_hw_params(struct snd_pcm_substream *substream,
>>> +                              struct snd_pcm_hw_params *params,
>>> +                              struct snd_soc_dai *dai)
>>> +{
>>> +     struct snd_soc_component *component = dai->component;
>>> +     int frame_size;
>>> +     unsigned int rate, bclk;
>>> +     int ret;
>>> +
>>> +     frame_size = snd_soc_params_to_frame_size(params);
>>> +     if (frame_size < 0) {
>>> +             dev_err(component->dev, "Unsupported frame size: %d\n",
>>> +                     frame_size);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     rate = params_rate(params);
>>> +     if (rate != 48000) {
>>> +             dev_err(component->dev, "Unsupported rate\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     switch (params_format(params)) {
>>> +     case SNDRV_PCM_FORMAT_S16_LE:
>>> +             ret = set_i2s_sample_depth(component, EC_CODEC_SAMPLE_DEPTH_16);
>>> +             break;
>>> +     case SNDRV_PCM_FORMAT_S24_LE:
>>> +             ret = set_i2s_sample_depth(component, EC_CODEC_SAMPLE_DEPTH_24);
>>> +             break;
>>> +     default:
>>> +             return -EINVAL;
>>
>> There is quite some inconsistency in error messages. Is there some kind of
>> plan behind it ? Do the error mesages above add value, but an error message
>> here wouldn't ?
>>
>>> +     }
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     bclk = snd_soc_params_to_bclk(params);
>>> +     return set_bclk(component, bclk);
>>> +}
>>> +
>>> +static const struct snd_soc_dai_ops cros_ec_i2s_dai_ops = {
>>> +     .hw_params = cros_ec_i2s_hw_params,
>>> +     .set_fmt = cros_ec_i2s_set_dai_fmt,
>>> +};
>>> +
>>> +struct snd_soc_dai_driver cros_ec_dai[] = {
>>> +     {
>>> +             .name = "cros_ec_codec I2S",
>>> +             .id = 0,
>>> +             .capture = {
>>> +                     .stream_name = "I2S Capture",
>>> +                     .channels_min = 2,
>>> +                     .channels_max = 2,
>>> +                     .rates = SNDRV_PCM_RATE_48000,
>>> +                     .formats = SNDRV_PCM_FMTBIT_S16_LE |
>>> +                                SNDRV_PCM_FMTBIT_S24_LE,
>>> +             },
>>> +             .ops = &cros_ec_i2s_dai_ops,
>>> +     }
>>> +};
>>> +
>>> +static int get_ec_mic_gain(struct snd_soc_component *component,
>>> +                        u8 *left, u8 *right)
>>> +{
>>> +     struct ec_param_codec_i2s param;
>>> +     struct ec_response_codec_gain resp;
>>> +     int ret;
>>> +
>>> +     param.cmd = EC_CODEC_GET_GAIN;
>>> +
>>> +     ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
>>> +                      (u8 *)&param, sizeof(param),
>>> +                      (u8 *)&resp, sizeof(resp));
>>> +     if (ret < 0) {
>>> +             dev_err(component->dev, "I2S get gain command returned %d\n",
>>> +                     ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     *left = resp.left;
>>> +     *right = resp.right;
>>> +
>>> +     dev_dbg(component->dev, "%s get mic gain %u, %u\n", __func__,
>>> +             *left, *right);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int mic_gain_get(struct snd_kcontrol *kcontrol,
>>> +                     struct snd_ctl_elem_value *ucontrol)
>>> +{
>>> +     struct snd_soc_component *component =
>>> +             snd_soc_kcontrol_component(kcontrol);
>>> +     u8 left, right;
>>> +     int ret;
>>> +
>>> +     ret = get_ec_mic_gain(component, &left, &right);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ucontrol->value.integer.value[0] = left;
>>> +     ucontrol->value.integer.value[1] = right;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int set_ec_mic_gain(struct snd_soc_component *component,
>>> +                        u8 left, u8 right)
>>> +{
>>> +     struct ec_param_codec_i2s param;
>>> +     int ret;
>>> +
>>> +     dev_dbg(component->dev, "%s set mic gain to %u, %u\n",
>>> +             __func__, left, right);
>>> +
>>> +     param.cmd = EC_CODEC_SET_GAIN;
>>> +     param.gain.left = left;
>>> +     param.gain.right = right;
>>> +
>>> +     ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
>>> +                      (u8 *)&param, sizeof(param),
>>> +                      NULL, 0);
>>> +     if (ret < 0) {
>>> +             dev_err(component->dev, "I2S set gain command returned %d\n",
>>> +                     ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int mic_gain_put(struct snd_kcontrol *kcontrol,
>>> +                     struct snd_ctl_elem_value *ucontrol)
>>> +{
>>> +     struct snd_soc_component *component =
>>> +             snd_soc_kcontrol_component(kcontrol);
>>> +     int left = ucontrol->value.integer.value[0];
>>> +     int right = ucontrol->value.integer.value[1];
>>> +
>>> +     if (left > MAX_GAIN || right > MAX_GAIN)
>>> +             return -EINVAL;
>>> +
>>> +     return set_ec_mic_gain(component, (u8)left, (u8)right);
>>> +}
>>> +
>>> +static const struct snd_kcontrol_new cros_ec_snd_controls[] = {
>>> +     SOC_DOUBLE_EXT_TLV("EC Mic Gain", SND_SOC_NOPM, SND_SOC_NOPM, 0, 43, 0,
>>> +                        mic_gain_get, mic_gain_put, ec_mic_gain_tlv)
>>> +};
>>> +
>>> +static int enable_i2s(struct snd_soc_component *component, int enable)
>>> +{
>>> +     struct ec_param_codec_i2s param;
>>> +     int ret;
>>> +
>>> +     dev_dbg(component->dev, "%s set i2s to %u\n", __func__, enable);
>>> +
>>> +     param.cmd = EC_CODEC_I2S_ENABLE;
>>> +     param.i2s_enable = enable;
>>> +
>>> +     ret = ec_command(component, 0, EC_CMD_CODEC_I2S,
>>> +                      (u8 *)&param, sizeof(param),
>>> +                      NULL, 0);
>>> +     if (ret < 0) {
>>> +             dev_err(component->dev, "I2S enable %d command returned %d\n",
>>> +                     enable, ret);
>>> +             return ret;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +static int cros_ec_i2s_enable_event(struct snd_soc_dapm_widget *w,
>>> +                                 struct snd_kcontrol *kcontrol, int event)
>>> +{
>>> +     struct snd_soc_component *component =
>>> +             snd_soc_dapm_to_component(w->dapm);
>>> +
>>> +     switch (event) {
>>> +     case SND_SOC_DAPM_PRE_PMU:
>>> +             dev_dbg(component->dev,
>>> +                     "%s got SND_SOC_DAPM_PRE_PMU event\n", __func__);
>>> +             return enable_i2s(component, 1);
>>> +
>>> +     case SND_SOC_DAPM_PRE_PMD:
>>> +             dev_dbg(component->dev,
>>> +                     "%s got SND_SOC_DAPM_PRE_PMD event\n", __func__);
>>> +             return enable_i2s(component, 0);
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/*
>>> + * The goal of this DAPM route is to turn on/off I2S using EC
>>> + * host command when capture stream is started/stopped.
>>> + */
>>> +static const struct snd_soc_dapm_widget cros_ec_dapm_widgets[] = {
>>> +     SND_SOC_DAPM_INPUT("DMIC"),
>>> +
>>> +     /*
>>> +      * Control EC to enable/disable I2S.
>>> +      */
>>> +     SND_SOC_DAPM_SUPPLY("I2S Enable", SND_SOC_NOPM,
>>> +                         0, 0, cros_ec_i2s_enable_event,
>>> +                         SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
>>> +
>>> +     SND_SOC_DAPM_AIF_OUT("I2STX", "I2S Capture", 0, SND_SOC_NOPM, 0, 0),
>>> +};
>>> +
>>> +static const struct snd_soc_dapm_route cros_ec_dapm_routes[] = {
>>> +     { "I2STX", NULL, "DMIC" },
>>> +     { "I2STX", NULL, "I2S Enable" },
>>> +};
>>> +
>>> +static const struct snd_soc_component_driver cros_ec_component_driver = {
>>> +     .controls               = cros_ec_snd_controls,
>>> +     .num_controls           = ARRAY_SIZE(cros_ec_snd_controls),
>>> +     .dapm_widgets           = cros_ec_dapm_widgets,
>>> +     .num_dapm_widgets       = ARRAY_SIZE(cros_ec_dapm_widgets),
>>> +     .dapm_routes            = cros_ec_dapm_routes,
>>> +     .num_dapm_routes        = ARRAY_SIZE(cros_ec_dapm_routes),
>>> +};
>>> +
>>> +/*
>>> + * Platform device and platform driver fro cros-ec-codec.
>>> + */
>>> +static int cros_ec_codec_platform_probe(struct platform_device *pd)
>>> +{
>>> +     struct device *dev = &pd->dev;
>>> +     struct cros_ec_device *ec_device = dev_get_drvdata(pd->dev.parent);
>>> +     struct cros_ec_codec_data *codec_data;
>>> +     int rc;
>>> +
>>> +     codec_data = devm_kzalloc(dev, sizeof(struct cros_ec_codec_data),
>>> +                               GFP_KERNEL);
>>> +     if (!codec_data)
>>> +             return -ENOMEM;
>>> +
>>> +     codec_data->dev = dev;
>>> +     codec_data->ec_device = ec_device;
>>> +
>>> +     platform_set_drvdata(pd, codec_data);
>>> +
>>> +     rc = snd_soc_register_component(dev, &cros_ec_component_driver,
>>> +                                     cros_ec_dai, ARRAY_SIZE(cros_ec_dai));
>>> +
>>> +     return 0;
>>
>> Why ignore errors from snd_soc_register_component() ? Is this on purpose
>> or an oversight ?
>>
>>> +}
>>> +
>>> +#ifdef CONFIG_OF
>>> +static const struct of_device_id cros_ec_codec_of_match[] = {
>>> +     { .compatible = "google,cros-ec-codec" },
>>> +     {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, cros_ec_codec_of_match);
>>> +#endif
>>> +
>>> +static struct platform_driver cros_ec_codec_platform_driver = {
>>> +     .driver = {
>>> +             .name = DRV_NAME,
>>> +             .of_match_table = of_match_ptr(cros_ec_codec_of_match),
>>> +     },
>>> +     .probe = cros_ec_codec_platform_probe,
>>> +};
>>> +
>>> +module_platform_driver(cros_ec_codec_platform_driver);
>>
>> The "platform" in the various variable and function names don't really
>> add any value.
>>
>>> +
>>> +MODULE_LICENSE("GPL v2");
>>> +MODULE_DESCRIPTION("ChromeOS EC codec driver");
>>> +MODULE_AUTHOR("Cheng-Yi Chiang <cychiang@chromium.org>");
>>> +MODULE_ALIAS("platform:" DRV_NAME);
> 

