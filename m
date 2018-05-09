Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZrnT729fjzS2Di6ccnxytbu4Hm4iDtyHLnlfDKcl9oxZLKSG+osNTES/0Bdc+iSRl0BCfHm
ARC-Seal: i=1; a=rsa-sha256; t=1525854235; cv=none;
        d=google.com; s=arc-20160816;
        b=DQ9hsCyJKArNpx8zBswQkdEIfFhGXrdEYM3GpbU6IYdXjr++CpmtOujBVVjknRGUii
         I4ASY7o57MUtCR/MXMQdAPG6gEv8T9U7ZSErlqodxnFzw+rxW/k0gZ9SlxWOK1TjFNEU
         EY1wpSnYfKcJpeg/xk4bC1dXt1aTvuBh0JwhX3VC8MnDuesTcGtWQDJZ/0e6xjupyg2I
         am6sRKgWeUnV3pBMDOrmcGMm//1IGMgzZI7wtyVuezkD1m+dd/ay6X40+VfqHa6UPHFE
         3fwOvfqKVn0ut6nJtjkghjjGCl0GTktceYNsa/3kz8lzgZYtGKF0Tml+26fZZ/jaECaW
         EjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=d7pOADsEBU2oEv873pEckCGyZI5BPjrCpKrA59XwAl4=;
        b=aSVHvJohvapl0kdyVD9FnPYTrzOu1/sQ4efnFtwP9xi9HSwe4RF2cPmXVOLNHpV5gt
         1b4Xz1wMcx3KKE0I8VQlIlptWORHKk7tv/X35WYAiwHYt6pWX+XOaZtxHbKQBUocraK7
         qkW2TMO2QV81wHNro2th30WXX6FuEG956JlvBOd1x/DEGVc+Zz/hErIbUnWtiIR/cl0n
         3eT1A5L5CwTpe481qAIMUCgQnRQI2J60EnxS9peEDkD3T8i09h+nKqfyb2CNrbvwuX/m
         EQ9e5BZyDDmMY/V4OMU8IAkAtsCF6pG+Ku6hPkFY/Q4M9tQKaBucReehy+XWUbyk/0eQ
         GY5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=KpGahyH4;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NgBZRuvm;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=KpGahyH4;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NgBZRuvm;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90C3260881
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 15/24] ASoC: qdsp6: q6asm: Add support to memory map
 and unmap
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-16-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <39933a04-7249-24ec-9ece-c3edd82e7d6c@codeaurora.org>
Date: Wed, 9 May 2018 01:23:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-16-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263627067359123?=
X-GMAIL-MSGID: =?utf-8?q?1599974130955883529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to memory map and unmap regions commands in
> q6asm module.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6asm.c | 349 +++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6asm.h |   5 +
>   2 files changed, 354 insertions(+)
>
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index c9526d2e59d2..5a573e927a5e 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -18,10 +18,45 @@
>   #include "q6dsp-errno.h"
>   #include "q6dsp-common.h"
<snip>
> +
> +/**
> + * q6asm_map_memory_regions() - map memory regions in the dsp.
> + *
> + * @dir: direction of audio stream
> + * @ac: audio client instanace
> + * @phys: physcial address that needs mapping.
> + * @period_sz: audio period size
> + * @periods: number of periods
> + *
> + * Return: Will be an negative value on failure or zero on success
> + */
> +int q6asm_map_memory_regions(unsigned int dir, struct audio_client *ac,
> +			     phys_addr_t phys,
> +			     size_t period_sz, unsigned int periods)
> +{
> +	struct audio_buffer *buf;
> +	unsigned long flags;
> +	int cnt;
> +	int rc;
> +
> +	spin_lock_irqsave(&ac->buf_lock, flags);
> +	if (ac->port[dir].buf) {
> +		dev_err(ac->dev, "Buffer already allocated\n");
> +		spin_unlock_irqrestore(&ac->buf_lock, flags);
> +		return 0;
> +	}
> +
> +	buf = kzalloc(((sizeof(struct audio_buffer)) * periods), GFP_ATOMIC);
> +	if (!buf) {
> +		spin_unlock_irqrestore(&ac->buf_lock, flags);
> +		return -ENOMEM;
> +	}
> +
> +
Remove extra blank line.

Otherwise LGTM.
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
