Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZrdpXRMeWE8xlgVyS9itMraoa3iCooPRFgNYpZ0J/Q5r7A4zc5RNyklfVD/ubn3ZAFD3NXg
ARC-Seal: i=1; a=rsa-sha256; t=1525397713; cv=none;
        d=google.com; s=arc-20160816;
        b=nwBe2CEsk2WtrhOhSthIdv2Kh++WLbk4Zv2YPligyzd4BZLkdDNaCP/mipMLnZf1GA
         WA0QZIr5gCYXacI05AO6uDMfNHA4TcZiB+izJWDKPNedkHTsRb+Sk4tPNmnRTXfSCxau
         w1Au8Iesu/7e7qkThCpT/LfSKeY1Gjcm6oyTORHeyO88P0W8UW4eurMrXZ0jCUIVdNuL
         nJ3KiYtGr/0UM3aWT4njWUpkd6WZ41Kq81ma2j+3DrHF3rL2TLPet9MjeqyCIgX+3hKa
         72rfX2qWOx+UocqL0C8GFbzB02AjQHGjX7R+bW8BX5ECpHO1QoKqD+e3ue9Uf5Q1GPOQ
         2fkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Cv9VJDzyOIrvqFtgquiz18lwgT3zGVcW1Y63l0p9oeQ=;
        b=y0atxbiHQmxYL7Z/CbFD1QpimTIifhOKJ6V6RGnX3GJ/BrXL0PupRUMyyVyRahJht/
         b8qq43OyRd1cY9RbEZDMQLVsy23LptbWaKqtoPDUFl9Knu0JhqOvUaHIkm2ZYeF0Qv2u
         /vruG4u4+vDaYX7YQSTyZgX95v1n3jKII416dKdZxUKT9I8oUgyFpayqWcsIAmQkCI+F
         Jd5r6/eUYGn7SRPCNaFxvD6G7i0W6DJ6iTjRqgsEY007FhrIlyzZebI/bZsgdQC1E5j5
         0B0Oi2f2y1zbpaK/XeBRdM6hrsDkyyLeCxnIre8TYHZXjgtuH7+h82gSxCBn/afSez1P
         LbXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bDg3ApXJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G74zmIgK;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bDg3ApXJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G74zmIgK;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF09860588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 07/24] ASoC: qdsp6: q6common: Add qdsp6 helper
 functions
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-8-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <28f86f87-b28e-bec8-1a74-a218afeac0cc@codeaurora.org>
Date: Thu, 3 May 2018 18:35:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-8-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263614938700775?=
X-GMAIL-MSGID: =?utf-8?q?1599495433137303994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds some common helper functions like translating dsp error
> to linux error codes and channel mappings etc.
>
> These functions are used in all the following qdsp6 drivers.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig              | 13 ++++++++
>   sound/soc/qcom/Makefile             |  3 ++
>   sound/soc/qcom/qdsp6/Makefile       |  1 +
>   sound/soc/qcom/qdsp6/q6dsp-common.c | 66 +++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6dsp-common.h | 24 ++++++++++++++
>   sound/soc/qcom/qdsp6/q6dsp-errno.h  | 51 ++++++++++++++++++++++++++++
>   6 files changed, 158 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/Makefile
>   create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.h
>   create mode 100644 sound/soc/qcom/qdsp6/q6dsp-errno.h
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
