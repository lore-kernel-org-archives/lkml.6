Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZoPj7oOu/JydQJmyjVEiVckpVxcc/3qy8hSb0YWd+mZmnDfI76VxnNAAjbl1GR65ufnOtCC
ARC-Seal: i=1; a=rsa-sha256; t=1525859836; cv=none;
        d=google.com; s=arc-20160816;
        b=WWb/xTDZfe6a1vC0cZHMBPDX4CVZOyrJHB5C/bt074YRSVynvi3ysEKSYjaXfbxKoE
         lLQ+N7CCqjSBH+VMK78nQ5To6ClS39x43tfSRX8kDGBrOXrelD7Vkcitx3kMB+/EOQgC
         n1liCOGmbeIPDAN353DSFiXrpMdHs+o4a361Uq+SsbyNzZYUrPL3mdbDIiB3r+0du03k
         jTUs2/Ahm58YHgBdmBwCogAyOfCEfpX0iC6tRgWaqlfJYpGawaX7QzdbxxxKGdit+cSg
         vq0xrxV6l3GOfHVkIh9NaOD5cRwbau1+LU0S9SUz2zcAc5Z40GZWm6eao7Ph/ht40r2C
         carg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=FKEtRkyybX3i36+C7YAZf3W2s9G10EHl6jWC2phYRCA=;
        b=IU7d6ZE1wbXeI1b7P8keOyruVhGxzHezsvbmj3OyXU+2i/7i+Z/AqVDXzaVW3V/dED
         qIr4wd64wyv+DV6otnnnY0NY8hqkKZ03M5jAxxzxT9E/7Y783aZIb1cmRN39nVvYLcqd
         7dMAj0dcQhsUWJOztkbj3HqInJM2kyJtA5EmR1H8UjozVSc7qLZWjs2gSrPMgg24W1wB
         RLVpSTob8m2Ezh9Rml39JRNeC2ICqTydQYmRFKtv83TX4SU7D7S9eOs5LeOd70ahjXPy
         yX7C5BJ+jbNtGwRjTQKaaujX3uuR34GPql6IUjZNgwy0rVKtNSKhub9bNH7wwtx3E0Yx
         12PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YOz4KSw2;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hBNalF0c;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YOz4KSw2;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hBNalF0c;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3944360132
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 21/24] ASoC: qdsp6: q6asm: Add q6asm dai driver
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-22-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <d4972fcf-c513-83db-4770-8009b5ab6d76@codeaurora.org>
Date: Wed, 9 May 2018 02:57:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-22-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263636336203429?=
X-GMAIL-MSGID: =?utf-8?q?1599980004089329874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to q6asm dai driver which configures Q6ASM streams
> to pass pcm data.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig           |   4 +
>   sound/soc/qcom/qdsp6/Makefile    |   1 +
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 628 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 633 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6asm-dai.c
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
