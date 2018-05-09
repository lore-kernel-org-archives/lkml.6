Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZr3wU7Sr5mmXPTo2+3AVDHtO+cBhm7LHKvvOZsrcg3ArsffCZHrzZiXyKfAfuA2t3rZHKPh
ARC-Seal: i=1; a=rsa-sha256; t=1525840193; cv=none;
        d=google.com; s=arc-20160816;
        b=XOAEKR9pA3BZugGnIogQxYJ0ThFh+ukvT9eVxIHJNbEk20tXhIITtOpQc37DnOIDAs
         mnobgBadH5lSjT2bo9dXqVjpN8M8kXxuS+iB+7fQE3Avd8ycoYJh/kJ5zIEwnAi4gK2M
         66XQnSjv+i1joASIf4ml+/UdnpRuE5543t/0NbnkjlkkMS0PHSicDkCAE5VTU7LUX2Ur
         v/sf3PdtVQWyZmQYeNJhG811ALdj/4OyHbvw2dtdiTwxkVP+7owxERXEnHBnwpo9WQ1w
         gqjYMAcBUyU9kOYiwZs2JZvBhasD6Ovvh97A4xMZc9OiW7Sd9WxdiK39XNNYskCD0Hqa
         ofSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Mx0VZMPSXFqaGJXhdzxjiBCQkvXKgQZm8M4pBV8wjKk=;
        b=0gOO/kusyvTMx4FvSLcPH6v9t3Xbqh6B6guan7Yitti21ozGqTlgkeKJv4RJDbNOaB
         4CmUuNDurEDWurJMIPfpOcvAo3dTX1uBTSSBqJQv0gHGOl1CBEYZXlwmzUZ0niO2tnPr
         OnOKjHuw0S58eNVDziJh6NaBAZIoNbETNg+1K80GuVWM8WbOmbJMtGkauTgYn6m0pAGJ
         i3RzV05rmQic2y46KbhQGs9s4K4pa0Erp3S5vVe3eA/eSPfRVAQyLUM2JD9Rjbjz5+dm
         o1IpLLKiYQIqU7Tlb/d8ch0MwpZGydAmptl70UwQgxwvvHtnOyjpYPmChJMJsYRsYQ4D
         AN4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=AgL1gdab;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZVZMq1dh;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=AgL1gdab;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZVZMq1dh;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91BE76022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 12/24] ASoC: qdsp6: q6afe: Add support to MI2S sysclks
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-13-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <5e4cd4a7-c375-4b92-f28b-f34900a828a8@codeaurora.org>
Date: Tue, 8 May 2018 21:29:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-13-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263622353025330?=
X-GMAIL-MSGID: =?utf-8?q?1599959406924610145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to LPASS Bit clock, LPASS Digital
> core clock and OSR clock. These clocks are required for both
> MI2S and PCM setup.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6afe.c | 171 +++++++++++++++++++++++++++++++++++++++++--
>   sound/soc/qcom/qdsp6/q6afe.h | 131 +++++++++++++++++++++++++++++++++
>   2 files changed, 295 insertions(+), 7 deletions(-)
>
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
