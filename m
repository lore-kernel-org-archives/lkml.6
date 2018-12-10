Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A796DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F41A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F41A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeLJOoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:44:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:58845 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbeLJOoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:44:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 06:44:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,338,1539673200"; 
   d="scan'208";a="302576831"
Received: from jmendez-mobl1.amr.corp.intel.com (HELO [10.252.197.197]) ([10.252.197.197])
  by fmsmga005.fm.intel.com with ESMTP; 10 Dec 2018 06:44:01 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: kbl_da7219_max98927: fix the
 audio jack button remapping
To:     Zhuohao Lee <zhuohao@chromium.org>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Max Chang <changmax@chromium.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20181210043213.243881-1-zhuohao@chromium.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <83955ba8-93f3-26ec-bba6-adf09ba839da@linux.intel.com>
Date:   Mon, 10 Dec 2018 08:44:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210043213.243881-1-zhuohao@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/9/18 10:32 PM, Zhuohao Lee wrote:
>  From the da7219 spec, the button A, B, C and D are remapped to
> 0, 1, 2 and 3 respectively where button A is KEY_PLAYPAUSE,
> B is KEY_VOLUMEUP, C is KEY_VOLUMEDOWN and D is KEY_VOICECOMMAND.
>
> Signed-off-by: Zhuohao Lee <zhuohao@chromium.org>
> Signed-off-by: Max Chang  <changmax@chromium.org>

I guess this is the v2

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

As discussed in the v1 thread, we'll need to align other DA7219-based 
devices to use the same mapping.


> ---
>   sound/soc/intel/boards/kbl_da7219_max98927.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
> index 3fa1c3ca6d37..d3531f0eb357 100644
> --- a/sound/soc/intel/boards/kbl_da7219_max98927.c
> +++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
> @@ -262,9 +262,9 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
>   
>   	jack = &ctx->kabylake_headset;
>   	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> -	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> -	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> -	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
>   
>   	da7219_aad_jack_det(component, &ctx->kabylake_headset);
>   
