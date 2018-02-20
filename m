Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbeBTRDm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:03:42 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34859 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbeBTRDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:03:41 -0500
X-Google-Smtp-Source: AH8x224K44joSwD2JTxQhTAdpbfwq7KJ1Ud4sciZZVeW8zb4JyLS6CPdouZwNKgFLW7FZXn4qHYgXg==
Subject: Re: [PATCH v2 1/2] ASoC: topology: Add defines for
 snd_soc_tplg_hw_config.clock_gated
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <458b66ab-da0a-8063-6555-13fb152c83a4@sakamocchi.jp>
 <20180219203636.3692-1-k.marinushkin@gmail.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <8b752929-1e20-b654-514a-fccec1f9fe5c@gmail.com>
Date: Tue, 20 Feb 2018 18:03:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180219203636.3692-1-k.marinushkin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/18 21:36, Kirill Marinushkin wrote:
> In kernel `soc-dai.h`, DAI clock gating is defined as following:
>
> ~~~~
> \#define SND_SOC_DAIFMT_CONT		(1 << 4) /* continuous clock */
> \#define SND_SOC_DAIFMT_GATED		(0 << 4) /* clock is gated */
> ~~~~
>
> The corresponding field of struct snd_soc_tplg_hw_config cannot be used as
> bool values due to the inverted logic. Therefore this commit adds the
> defines for this field.
>
> snd_soc_tplg_hw_config.clock_gated = 0 => no effect
> snd_soc_tplg_hw_config.clock_gated = 1 => SND_SOC_DAIFMT_GATED
> snd_soc_tplg_hw_config.clock_gated = 2 => SND_SOC_DAIFMT_CONT
>
> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/uapi/sound/asoc.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
> index 69c37ecbff7e..86d0599a6f13 100644
> --- a/include/uapi/sound/asoc.h
> +++ b/include/uapi/sound/asoc.h
> @@ -139,6 +139,11 @@
>  #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
>  #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
>  
> +/* DAI clock gating */
> +#define SND_SOC_TPLG_DAI_CLK_GATE_UNDEFINED	0
> +#define SND_SOC_TPLG_DAI_CLK_GATE_GATED	1
> +#define SND_SOC_TPLG_DAI_CLK_GATE_CONT		2
> +
>  /* DAI physical PCM data formats.
>   * Add new formats to the end of the list.
>   */
> @@ -312,7 +317,7 @@ struct snd_soc_tplg_hw_config {
>  	__le32 size;            /* in bytes of this structure */
>  	__le32 id;		/* unique ID - - used to match */
>  	__le32 fmt;		/* SND_SOC_DAI_FORMAT_ format value */
> -	__u8 clock_gated;	/* 1 if clock can be gated to save power */
> +	__u8 clock_gated;	/* SND_SOC_TPLG_DAI_CLK_GATE_ value */
>  	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
>  	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
>  	__u8 bclk_master;	/* 1 for master of BCLK, 0 for slave */

This patch is part 1 of 2. I failed to send both of them as a single patch series.
I will resend them properly in a new thread.

Best Regards,
Kirill
