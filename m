Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A95EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79612083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jvI++mwG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b1o/BTZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79612083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966483AbeFSNvE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:51:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56386 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965731AbeFSNvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:51:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 25CD660B13; Tue, 19 Jun 2018 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529416262;
        bh=qCHiAxCeTfOYDtEuf9lpBAcw6dNrTcFSgRMZfQWHPWM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jvI++mwGsm09E+nbnAO1xuyoAQe69pEdcjMvX7uTW5Dae2jpXWHTTe7ndewK3hxGe
         4JYcs9EJkpE3tXZLEA0WGcC+j9m4uPBnJcoyMwRLM2YoEECclpVWyQjOsIQv1XUkGv
         /kX5Luj0oxzaoxNryMCFtwde+17aWslSz1S95a5k=
Received: from [10.204.110.13] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD283602B6;
        Tue, 19 Jun 2018 13:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529416261;
        bh=qCHiAxCeTfOYDtEuf9lpBAcw6dNrTcFSgRMZfQWHPWM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b1o/BTZteMI5QPq2JsPciyKDn2zcK9cCueycK8QUYpEzMdeJ++BIccLuLEIwMeiZm
         OBNvOw6qi2F7BmlqyGxS4c82HYIsjqJ/HpNhlafPRE391JgOzuztA2dpuESHFJ3A4/
         ZlEBPmrPUs1VGKAysH8DTw4d1WJBKqE5r/rPir34=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD283602B6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH] ASoC: qcom: add sdm845 sound card support
To:     Vinod <vkoul@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
 <20180619050527.GR25852@vkoul-mobl>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
Date:   Tue, 19 Jun 2018 19:20:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619050527.GR25852@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod for reviewing.


On 6/19/2018 10:35 AM, Vinod wrote:
> On 18-06-18, 16:46, Rohit kumar wrote:
>
>> +struct sdm845_snd_data {
>> +	struct snd_soc_card *card;
>> +	struct regulator *vdd_supply;
>> +	struct snd_soc_dai_link dai_link[];
>> +};
>> +
>> +static struct mutex pri_mi2s_res_lock;
>> +static struct mutex quat_tdm_res_lock;
> any reason why the locks can't be part of sdm845_snd_data?
> Also why do we need two locks ?
No specific reason, I will move it to sdm845_snd_data.
These locks are used to protect enable/disable of bit clocks. We have 
Primary MI2S RX/TX
and Quaternary TDM RX/TX interfaces. For primary mi2s rx/tx, we have 
single clock which is
synchronized with pri_mi2s_res_lock. For Quat TDM RX/TX, we are using 
quat_tdm_res_lock.
We need two locks as we are protecting two different resources.
>
>> +static atomic_t pri_mi2s_clk_count;
>> +static atomic_t quat_tdm_clk_count;
> Any specific reason for using atomic variables?
Nothing as such. As we are using mutex to synchronize, we can make it 
non- atomic.
Will do it in next-spin.
>
>> +static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
>> +
>> +static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
>> +					struct snd_pcm_hw_params *params)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +	int ret = 0;
>> +	int channels, slot_width;
>> +
>> +	channels = params_channels(params);
>> +	if (channels < 1 || channels > 8) {
> I though ch = 0 would be caught by framework and IIRC ASoC doesn't
> support more than 8 channels

OK. Will check and remove.
>> +		pr_err("%s: invalid param channels %d\n",
>> +				__func__, channels);
>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (params_format(params)) {
>> +	case SNDRV_PCM_FORMAT_S32_LE:
>> +	case SNDRV_PCM_FORMAT_S24_LE:
>> +	case SNDRV_PCM_FORMAT_S16_LE:
>> +		slot_width = 32;
>> +		break;
>> +	default:
>> +		pr_err("%s: invalid param format 0x%x\n",
>> +				__func__, params_format(params));
> why not use dev_err, bonus you get device name printer with the logs :)

Sure. Will change it.
>> +static int sdm845_snd_startup(struct snd_pcm_substream *substream)
>> +{
>> +	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +
>> +	pr_debug("%s: dai_id: 0x%x\n", __func__, cpu_dai->id);
> It is good for debug but not very useful here, so removing it would be
> good

OK
>> +	switch (cpu_dai->id) {
>> +	case PRIMARY_MI2S_RX:
>> +	case PRIMARY_MI2S_TX:
>> +		mutex_lock(&pri_mi2s_res_lock);
>> +		if (atomic_inc_return(&pri_mi2s_clk_count) == 1) {
>> +			snd_soc_dai_set_sysclk(cpu_dai,
>> +				Q6AFE_LPASS_CLK_ID_MCLK_1,
>> +				DEFAULT_MCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
>> +			snd_soc_dai_set_sysclk(cpu_dai,
>> +				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
>> +				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
>> +		}
>> +		mutex_unlock(&pri_mi2s_res_lock);
> why do we need locking here? Can you please explain that.
So, we can have two usecases: one with primary mi2s rx and other with 
primary mi2s tx.
Lock is required to increment  pri_mi2s_clk_count and enable clock so 
that disable of one
usecase does not disable the clock.
>
>> +		snd_soc_dai_set_fmt(cpu_dai, fmt);
>> +		break;
> empty line after break helps in readability

Sure. Will add that change.
>> +static int sdm845_sbc_parse_of(struct snd_soc_card *card)
>> +{
>> +	struct device *dev = card->dev;
>> +	struct snd_soc_dai_link *link;
>> +	struct device_node *np, *codec, *platform, *cpu, *node;
>> +	int ret, num_links;
>> +	struct sdm845_snd_data *data;
>> +
>> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
>> +	if (ret) {
>> +		dev_err(dev, "Error parsing card name: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	node = dev->of_node;
>> +
>> +	/* DAPM routes */
>> +	if (of_property_read_bool(node, "qcom,audio-routing")) {
>> +		ret = snd_soc_of_parse_audio_routing(card,
>> +					"qcom,audio-routing");
>> +		if (ret)
>> +			return ret;
>> +	}
> so if we dont find audio-routing, then? we seems to continue..
Right. Its not mandatory to have qcom,audio-routing in device tree.

Regards,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

