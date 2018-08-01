Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0103C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6748420841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jDOReknl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lrfXYPvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6748420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbeHAIQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:16:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41418 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387419AbeHAIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:16:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D0ADE60AD8; Wed,  1 Aug 2018 06:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533105138;
        bh=Fho2GsYXQPDPLQBI/qGpkix/Ww5FVgKGbYXjMi1eMOw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jDOReknlxofPt1+A/pCeAwvFz8Hoqlaqlo8QKPNqXgdS6Rc8qLe0+maUR9hC85D3B
         RLN0QX2MO9go/KKqnPfnUDX0xdf/kg1j5WDTH3oAUaQuDN3eAP5SDaeeSDVmGl16QU
         FB7rTm4mgBa/znAB0wnmJ+y/X3N33JCw0/3jZd44=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C92C9602D7;
        Wed,  1 Aug 2018 06:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533105137;
        bh=Fho2GsYXQPDPLQBI/qGpkix/Ww5FVgKGbYXjMi1eMOw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lrfXYPvy9FMU2+txlAk9cJnnlRId/0YTaqPMxtsrZuFjaO4Ueihg6mmIpOSfaTPis
         0molYLKnmxpzukucS51wzD70r20S5dmF4GurDeQyujSW2E2jyiksz3gQ2H0d9xOEm0
         OYCVlSNiBiZl073aQUTBmPjX038JX6YMCMR9YS80=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C92C9602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v4 4/4] ASoC: qcom: add sdm845 sound card support
To:     Takashi Iwai <tiwai@suse.de>, kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, alsa-devel@alsa-project.org,
        mark.rutland@arm.com, bgoswami@codeaurora.org, plai@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org, perex@perex.cz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532945454-10437-5-git-send-email-rohitkr@codeaurora.org>
 <201808011127.1snVqYkN%fengguang.wu@intel.com> <s5hy3dqzo51.wl-tiwai@suse.de>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <f0f0554c-b2e4-783d-df1e-335ab8d81c11@codeaurora.org>
Date:   Wed, 1 Aug 2018 12:02:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <s5hy3dqzo51.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/1/2018 10:20 AM, Takashi Iwai wrote:
> On Wed, 01 Aug 2018 05:46:48 +0200,
> kbuild test robot wrote:
>> Hi Rohit,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on asoc/for-next]
>> [also build test WARNING on next-20180731]
>> [cannot apply to v4.18-rc7]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Rohit-kumar/Add-support-for-audio-on-SDM845-SoC/20180801-082203
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
>> reproduce:
>>          # apt-get install sparse
>>          make ARCH=x86_64 allmodconfig
>>          make C=1 CF=-D__CHECK_ENDIAN__
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>>> sound/soc/qcom/sdm845.c:193:27: sparse: incorrect type in argument 2 (different base types) @@    expected unsigned int [unsigned] val @@    got restricted snd_unsigned int [unsigned] val @@
>>     sound/soc/qcom/sdm845.c:193:27:    expected unsigned int [unsigned] val
>>     sound/soc/qcom/sdm845.c:193:27:    got restricted snd_pcm_format_t [usertype] <noident>
>>
>> vim +193 sound/soc/qcom/sdm845.c
>>
>>     181	
>>     182	static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
>>     183					struct snd_pcm_hw_params *params)
>>     184	{
>>     185		struct snd_interval *rate = hw_param_interval(params,
>>     186						SNDRV_PCM_HW_PARAM_RATE);
>>     187		struct snd_interval *channels = hw_param_interval(params,
>>     188						SNDRV_PCM_HW_PARAM_CHANNELS);
>>     189		struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
>>     190	
>>     191		rate->min = rate->max = DEFAULT_SAMPLE_RATE_48K;
>>     192		channels->min = channels->max = 2;
>>   > 193		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S16_LE);
> FYI, we have introduced a new helper, snd_mask_set_format(), just for
> avoiding this sparse warning.  It's already in Mark's for-next tree.
Thanks Takashi for API suggestion. I will update in next spin.
>
> thanks,
>
> Takashi

