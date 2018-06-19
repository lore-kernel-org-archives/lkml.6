Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D67C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DADE2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eIkEKXnR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HiT1SBiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DADE2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966457AbeFSN6e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:58:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42730 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966136AbeFSN6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:58:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9FFB660B13; Tue, 19 Jun 2018 13:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529416711;
        bh=XcwfC480j49ex7gGOktTDrRoeTg+m3tF5D3pcjzVzOc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=eIkEKXnRO7HeTZXZZoAAhZb+GjVS5ss/3uw5lpMMPgtpi0qZ+hjd/45Y/zKpQcZgC
         jFlr7aOv0mX6Sf7oub1Y8sDMTSi2T447nerCciGCETNrA/PLdlt6Sur8DyuvWiwCaQ
         iohvGsdSJ1y2NwVtb7mQRxB5XguCdVpwnie3+mUc=
Received: from [10.204.110.13] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0F6860714;
        Tue, 19 Jun 2018 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529416710;
        bh=XcwfC480j49ex7gGOktTDrRoeTg+m3tF5D3pcjzVzOc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=HiT1SBiAEDWGupLwvbYjeupZqyUF39GRz2oWlQcZLmR/f4mXrtsX1w5jtel3f6lQs
         1kAUoosu8gjMsBRopcNlKydQKLHjxflX69RzZl8vrou13y/gMEf5Ky0OZf8MI8QNna
         phFJELHCxSxHstCKMFzcYrJ5H0hRWdL51l4QTbRo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0F6860714
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH] ASoC: qcom: add sdm845 sound card support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
 <f3f677bf-d0b5-baab-cf7c-4a7d7588259b@linaro.org>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <b616b2e7-234b-1ca3-1821-40637f3945ab@codeaurora.org>
Date:   Tue, 19 Jun 2018 19:28:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f3f677bf-d0b5-baab-cf7c-4a7d7588259b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Srinivas for reviewing.


On 6/19/2018 2:16 PM, Srinivas Kandagatla wrote:
> Thanks Rohit for the patch!
>
> On 18/06/18 12:16, Rohit kumar wrote:
>> This patch adds sdm845 audio machine driver support.
>>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,sdm845.txt      |  87 ++++
>>   sound/soc/qcom/Kconfig                             |   9 +
>>   sound/soc/qcom/Makefile                            |   2 +
>>   sound/soc/qcom/sdm845.c                            | 539 
>> +++++++++++++++++++++
>>   4 files changed, 637 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/sound/qcom,sdm845.txt
>
> Split the bindings into a separate patch!

Sure, will do it in next spin.
>
>>   create mode 100644 sound/soc/qcom/sdm845.c
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt 
>> b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
>> new file mode 100644
>> index 0000000..fc0e98c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
>> @@ -0,0 +1,87 @@
>> +* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
>> +
>> +This binding describes the SDM845 sound card, which uses qdsp for 
>> audio.
>>
[..]
>> +
>> +- codec:
>> +    Usage: required
>> +    Value type: <subnode>
>> +    Definition: codec dai sub-node
>> +
>> +- platform:
>> +    Usage: opional
>
> Optional

okay
>> +    Value type: <subnode>
>> +    Definition: platform dai sub-node
>> +
>> +- sound-dai:
>> +    Usage: required
>> +    Value type: <phandle>
>> +    Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
>> +
>> +Example:
>> +
>> +audio {
>> +    compatible = "qcom,sdm845-sndcard";
>> +    qcom,model = "sdm845-snd-card";
>> +    pinctrl-names = "pri_active", "pri_sleep";
>> +    pinctrl-0 = <&pri_mi2s_active &pri_mi2s_ws_active>;
>> +    pinctrl-1 = <&pri_mi2s_sleep &pri_mi2s_ws_sleep>;
>> +
>> +    qcom,audio-routing = "PRI_MI2S_RX Audio Mixer", "Pri-mi2s-gpio";
>> +
>> +    cdc-vdd-supply = <&pm8998_l14>;
>> +
>> +    fe@1 {
> Lets not use fe or be reference here, its just a link.
okay

>
>> +        link-name = "MultiMedia1";
>> +        cpu {
>> +            sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
>> +        };
>> +        platform {
>> +            sound-dai = <&q6asmdai>;
>> +        };
> asmdai has sound-cell specifier as 1, so this will dtc will throw 
> warning for this.
>
> have a look at how 8996 is done.

ok, sure
>
>> +    };
>> +
>> +    be@1 {
>>
[..]
>> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
>> index 206945b..ac9609e 100644
>> --- a/sound/soc/qcom/Makefile
>> +++ b/sound/soc/qcom/Makefile
>> @@ -14,10 +14,12 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += 
>> snd-soc-lpass-apq8016.o
>>   snd-soc-storm-objs := storm.o
>>   snd-soc-apq8016-sbc-objs := apq8016_sbc.o
>>   snd-soc-apq8096-objs := apq8096.o
>> +snd-soc-sdm845-objs := sdm845.o
>>     obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
>>   obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
>>   obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
>> ++obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o
>
> ?? looks like typo here.
>
Right. Will update.
>
>>     #DSP lib
>>   obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
>> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
>> new file mode 100644
>> index 0000000..70d2611
>> --- /dev/null
>> +++ b/sound/soc/qcom/sdm845.c
>> @@ -0,0 +1,539 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/component.h>
[..]
>> +}
>> +
>> +static int sdm845_snd_startup(struct snd_pcm_substream *substream)
>> +{
>> +    unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +    struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +
>> +    pr_debug("%s: dai_id: 0x%x\n", __func__, cpu_dai->id);
>> +    switch (cpu_dai->id) {
>> +    case PRIMARY_MI2S_RX:
>> +    case PRIMARY_MI2S_TX:
>> +        mutex_lock(&pri_mi2s_res_lock);
>
> Mutex and atomic variables looks redundant here.
> Can you explain why do you need both?
Right. Only mutex is required here. I will make count as non-atomic.

>
> ...
>> +
>> +static int sdm845_sbc_parse_of(struct snd_soc_card *card)
>> +{
>> +    struct device *dev = card->dev;
>> +    struct snd_soc_dai_link *link;
>> +    struct device_node *np, *codec, *platform, *cpu, *node;
>> +    int ret, num_links;
>> +    struct sdm845_snd_data *data;
>> +
>> +    ret = snd_soc_of_parse_card_name(card, "qcom,model");
>> +    if (ret) {
>> +        dev_err(dev, "Error parsing card name: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    node = dev->of_node;
>> +
>> +    /* DAPM routes */
>> +    if (of_property_read_bool(node, "qcom,audio-routing")) {
>> +        ret = snd_soc_of_parse_audio_routing(card,
>> +                    "qcom,audio-routing");
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    /* Populate links */
>> +    num_links = of_get_child_count(node);
>> +
>> +    dev_info(dev, "Found %d child audio dai links..\n", num_links);
>
> Looks unnessary!

Ok . Will remove it in next patchset.
>
>> +
>> +        link->platform_of_node = of_parse_phandle(platform,
>> +                "sound-dai", 0);
>> +        if (!link->platform_of_node) {
>> +            dev_err(card->dev, "error getting platform phandle\n");
>> +            ret = -EINVAL;
>> +            goto fail;
>> +        }
>> +
>> +        ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
>> +        if (ret) {
>> +            dev_err(card->dev, "error getting cpu dai name\n");
>> +            goto fail;
>> +        }
>> +
>> +        if (codec) {
>> +            ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
>> +            if (ret < 0) {
>> +                dev_err(card->dev, "error getting codec dai name\n");
>> +                goto fail;
>> +            }
>> +            link->no_pcm = 1;
>> +            link->ignore_suspend = 1;
>> +            link->ignore_pmdown_time = 1;
>> +            link->ops = &sdm845_be_ops;
>> +            link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
>> +        } else {
>> +            link->dynamic = 1;
>> +            link->codec_dai_name = "snd-soc-dummy-dai";
>> +            link->codec_name = "snd-soc-dummy";
>> +        }
>> +
>
> You could optimize this code, have a look at apq8096.c which does 
> exactly same thing.
>

Okay. will check and update.
> ...
>> +
>> +static void sdm845_unbind(struct device *dev)
>> +{
>> +    struct snd_soc_card *card = dev_get_drvdata(dev);
>> +    struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
>> +
>> +    mutex_destroy(&pri_mi2s_res_lock);
>> +    mutex_destroy(&quat_tdm_res_lock);
>> +    if (data->vdd_supply)
>> +        regulator_put(data->vdd_supply);
>> +    component_unbind_all(dev, card);
>> +    snd_soc_unregister_card(card);
>> +    kfree(data);
>> +    kfree(card);
>> +}
>> +
>> +static const struct component_master_ops sdm845_ops = {
>> +    .bind = sdm845_bind,
>> +    .unbind = sdm845_unbind,
>> +};
>> +
>> +static int sdm845_runtime_resume(struct device *dev)
>> +{
>> +    struct snd_soc_card *card = dev_get_drvdata(dev);
>> +    struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
>> +
>> +    if (!data->vdd_supply) {
>> +        dev_dbg(dev, "no supplies defined\n");
>> +        return 0;
>> +    }
>> +
>> +    if (regulator_enable(data->vdd_supply))
>> +        dev_err(dev, "Enable regulator supply failed\n");
>> +
>> +    return 0;
>> +}
>> +
>> +static struct platform_driver sdm845_snd_driver = {
>> +    .probe = sdm845_snd_platform_probe,
>> +    .remove = sdm845_snd_platform_remove,
>> +    .driver = {
>> +        .name = "msm-snd-sdm845",
>> +        .pm = &sdm845_pm_ops,
>> +        .owner = THIS_MODULE,
> not necessary!

Okay. Will remove it.
>> +        .of_match_table = of_match_ptr(sdm845_snd_device_id),
>> +    },
>> +};
>> +module_platform_driver(sdm845_snd_driver);
>> +
>> +MODULE_DESCRIPTION("sdm845 ASoC Machine Driver");
>> +MODULE_LICENSE("GPL v2");
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Regards,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

