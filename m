Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZrv/rrd+I4G0a9BV5NjMic7EIdOSgtqcxAtoihLNk+R3FbS0cGZbW9j3/XWJU0/hVkdx9Ov
ARC-Seal: i=1; a=rsa-sha256; t=1525854850; cv=none;
        d=google.com; s=arc-20160816;
        b=oivIx3DalDOQuNrgxxrIQwj9gDBmmmP1WO07OapP4BONQO3tCsYV7KNy43dKT6LSZR
         JLSahLie9v7CbF/rX33pqXDgAELH7sAsg012Y+Djbm8EeXFsAb1B+Da6FsIlXSvXBN4G
         w2qtUg0ThIvvqEYyFX+urNdpLY9I0k1t0WeBo0wh+WqvMICHZZlgh9TRypa+xRGFHumv
         1r4r/yHtJJ+wEoAHjQQj7pmyNPzDD9egFj1CfkLBn3Bw2G2WIYoizWwjXq66AGfYBl7u
         Z4eL0ysRk3aH/1lYo2kP2H1sVg0wvT1yyJQTaeCiEfbGxWihVVH8kAJurZsTabM7sTjE
         nShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=GRcZHNL85oCJZSMvpEu9RJ0KHiOzXjI2mD5n/vMtOpk=;
        b=imOrK3g/fTBW3mAojCFZmOjcJzVRu9RvIBpVQdHJTNW1vTVmTeGdG/xnx9FJnzRp03
         3/3iLl242lDC5uZ4aBO3MaKMHbHykGrqpuyJNK/XcB1fktyPTFxoNc+SBYCf1AhRcIfI
         o8+oAQDTfPfmHnOPTv+QLDecbhy2x4wnf+ExjHUROddQjCFOiHNI8WRRm+1swkaL64oJ
         eMQbhtXnBAdoRL1FQbCP16iCDtMIBdSWlMZig6HNqFri4xCul3XTHhmZ92WHixFshFn5
         iT32GqOmTtCxIONcuY8pVbF3kokBcSD3bD0crmLc+LNm+vDHjucviK7usHyiFBsdVYA9
         0z5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=azM6B3kF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RMoHX4zQ;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=azM6B3kF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RMoHX4zQ;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F6A66081B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 19/24] ASoC: qdsp6: q6routing: Add support to MI2S
 Mixers
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-20-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <a54f3aba-5a8a-5a69-2cbd-98244f4f7ed1@codeaurora.org>
Date: Wed, 9 May 2018 01:34:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-20-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263632939958453?=
X-GMAIL-MSGID: =?utf-8?q?1599974775508816012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch add support to MI2S mixers required to select path between
> ASM stream and AFE ports.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6routing.c | 329 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 329 insertions(+)
>
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
