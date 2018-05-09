Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZp/vjBF1rRnL4vCI0jjR8Q8o0Iod50pkYmm3cw/JR3Xzo68vkwLxkBKA7lZAe1+Nmazf/Ol
ARC-Seal: i=1; a=rsa-sha256; t=1525833651; cv=none;
        d=google.com; s=arc-20160816;
        b=HzxH308ySYmJYMkmDZIh/nxNUjnf3fSLHCQZx2acjlK4JZni6xImP+mPkfPsA39Tn6
         0NdJVS72rQiHdLTHVGqKqzGKiJprY+KHp3i5gqDSNyJ1JA78mTS9bO28uDHqfdJGSu2a
         kN8zq/PKATSHHI9EvlrHXbGh5ry7O7X0ad6hlWO8A0PlcW5Tvzr2LBK1WT2oMA4BxT4u
         hY0ee9XWlIKfZSrUOIsWmUlIvdp/HFxx24fedcP0VDQX4d+xpdB2jOGaDtos7fbX9Prd
         UMUZ7e1swAejtk1c3uNmx1MjR0kMWzBHMl3UZrN9hbjcngQQnf3YUmXrEyogZu8KHsn7
         PrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=lHtItlKduzdg9hVNPY2+3AxbFO2L5zPMMKyIuCW9Lcs=;
        b=zKEniZMJYeJBiOxxM4OMlpQ6jhGrqdUnvZ+dQeJW1HrcfQucJ+8NjQFS225NfA5iSg
         G8FzwUrUE+UGH6UFHiIQp2NG1l5IPTJoZ5m4hoZXbxYtrVmUF+vX5k/5k36+lXxPeg/f
         p6NHQCIlSR3XpSsx1n64vzhv5Y4ndLQs0A95Kr/+D/VtDKulSLvv8b3h7sKsNUid4mFI
         sVzJ57lnECjbWTPgZ8P3rrPbwXha1ziivVCte2Bq9s7QlyOE4NTvoGGyOSrs456qYuSI
         unMAcCH/B/yHVLLScSLNNM7+wX+Bpk+MWomCf4twuWTzPxsXePDY0brVSVRm5hrxRrIb
         0J8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eOh+pTMe;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UI7TfJzt;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eOh+pTMe;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UI7TfJzt;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCEE060767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 09/24] ASoC: qdsp6: q6afe: Add q6afe driver
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-10-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <d7aed12f-78d4-8528-bfab-3fc87a94e557@codeaurora.org>
Date: Tue, 8 May 2018 19:40:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-10-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263617301455375?=
X-GMAIL-MSGID: =?utf-8?q?1599952546383120577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to Q6AFE (Audio Front End) module on Q6DSP.
>
> AFE module sits right at the other end of cpu where the codec/audio
> devices are connected.
>
> AFE provides abstraced interfaces to both hardware and virtual devices.
> Each AFE tx/rx port can be configured to connect to one of the hardware
> devices like codec, hdmi, slimbus, i2s and so on. AFE services include
> starting, stopping, and if needed, any configurations of the ports.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig        |   4 +
>   sound/soc/qcom/qdsp6/Makefile |   1 +
>   sound/soc/qcom/qdsp6/q6afe.c  | 536 ++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6afe.h  |  35 +++
>   4 files changed, 576 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6afe.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6afe.h
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
