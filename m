Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZqIWIBWPrUAri42MBjbP5c8laMBuSosAByo4f+zodd+nzYqJoFxBS+z+kt0rf+3S/jlEPou
ARC-Seal: i=1; a=rsa-sha256; t=1525834558; cv=none;
        d=google.com; s=arc-20160816;
        b=EYKW/FxC/3J6rn5UDINPlT52IGQ5S6PRcopohnW/5pz1gcopUJ+4niLxTtzoPwb5iO
         e0di3R+5N6yKZJJDmvDYoxBQZ9kVgqz7kdSo0iLoS0mVRU6IUtIgCmBlIGAFPiBcvDB7
         xX1zlypjzdyc3bLW9KSJgKdbRh9dcPkXYK5dbnaxjzinvFCFHJ6pWeGch53k1ToU+67V
         tyAUc8DnivlWKoZJ6Q8wn3vaOnvltHI8repiCXgaLaJLdyxI9ZlSf3IWdJehjSa6liZ6
         vrvYtxsM/z/mdj+F29V+Unw23MD1BCUg526B5EWfJsdweBZXs8rmTWnmJRaerxSqY5Mx
         TxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=FqIhCFaR5sG+0kCwi3PUem+EpKes3FVW9VB/pWuQ5AM=;
        b=FVredhv3QZsqk4fxdMLOL9dXECz4LA800ie09cXwjiQe6DJVBFpgTc9u2Dlkt34jSk
         FSQ00UxaAp8kO8qqr0On3590e5Ruklwqw96u1sukjpSS2/4zt+Qh8DC5XtYry4teKiiK
         ko+l7IKi+joVX3FCVVJyWaeuK0FjE9azyJwH0FrGtOrMPm3FZrsMfReRsDS0Tm8GFFyY
         xK3jnSg2QIi5pERjw1WjrtZR0PSe68tYXcD1bAb9nI3xEBxQe7GjLEhnHUiHunwgHvYq
         T/wIhZZZrELoFwRn42WHcUGzSeJSBXnC5E/4ebJgQoW33ZjhGkKRu2Fi0eV84geI76SZ
         O0dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CwvQC5WL;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=EapZkN7h;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CwvQC5WL;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=EapZkN7h;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29FFD60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 10/24] ASoC: qdsp6: qdafe: Add SLIMBus port Support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-11-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <448ccddb-b28d-65c9-f502-755b3403f72a@codeaurora.org>
Date: Tue, 8 May 2018 19:55:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-11-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263619730953069?=
X-GMAIL-MSGID: =?utf-8?q?1599953497449167536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to 6 SLIMBus AFE ports, which are used as
> backend dais.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6afe.c | 129 +++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6afe.h |  14 +++++
>   2 files changed, 143 insertions(+)
>
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
