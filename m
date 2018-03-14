Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521036933; cv=none;
        d=google.com; s=arc-20160816;
        b=nGt+UKCgn75gSnto0E1PDGs7sj16/6m2VHjkg25oCVvbzsNRJJsN5lPtv6HbJakWMl
         XN6AGNPNWUXn1VbSxo2BOkQE9YVWliZZ13L/2Fr3RHQ4y/5qDNhiU7fBCUOqamCdclyC
         /rJW2oeqqs/VHzrf7K9z8GJO5PdEpaiFew+HNrFqLq7lcAs1lLQGP19BVipEHqZ7xHXU
         XEbQx3S25CLpDa/BtrFcjZ+KA6D59XuxwvSjhvUqKrL2hC99flv5GXURPH8KoIturlx6
         u6OHTWX9ylGJnZx8ROm7EWvZBz2pBLNTHWqNuxL0WkNPbBWYHsyJVQGa5hE8aEPGmV7i
         Nklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=lleZMFppeO1xLC/4H8zlAdg3T5bIRwYPMvklpmNtGcg=;
        b=rzfB0jVuBXZ5VseW2wmJ147MTNntoUnLFZ5tq/P8Q0aqCpPEz+dqPTEa1Pl2/dU+2Y
         G4+obQhZr3H0vT1Xi7NNm5NqSSXN0p8kldVfMRUIWy4TIrN8o0cnnEHQzsHSOUzbIYvZ
         RgXWhBl/nXykx2Wjc3NFWfU6juHJtWBOcsGCui0WMqml3DhMtsrpZe6hAlIQ7IZTSGwt
         awm+eOOhhMxNG8LvqpqUO5moSV8b5zdpFAP0TgdVyvn1ePT4LtNF6dYzhNYt9NKqBLHk
         LwEzb+FbE1fdlJ4MUUT07pD+vlxC5lSKSHN3tyW2NNdMIfaw/XqAwSJVmDDBULMjNzQw
         Ohlw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EzrZv5vt;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EzrZv5vt;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtfK4kzxSikLcHY5gZLCdYPeHgNfmOY5s1IS5TAQKRU6jwhhGZ2qJqP1p9QRJCLbYiIIVgf7w==
Subject: Re: [alsa-devel] [PATCH v4 02/24] soc: qcom: Add APR bus driver
To: Rohit Kumar <rohitkr@codeaurora.org>, andy.gross@linaro.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
 gregkh@linuxfoundation.org, plai@codeaurora.org, lgirdwood@gmail.com,
 tiwai@suse.com, david.brown@linaro.org,
 linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com,
 linux-kernel@vger.kernel.org
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-3-srinivas.kandagatla@linaro.org>
 <d9e92aeb-8d74-554e-4390-4117571806a9@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b2b24ce9-2923-2dd5-f569-fbad80f3f706@linaro.org>
Date: Wed, 14 Mar 2018 14:15:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <d9e92aeb-8d74-554e-4390-4117571806a9@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515904810713812?=
X-GMAIL-MSGID: =?utf-8?q?1594922823923035972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 14/03/18 14:12, Rohit Kumar wrote:
> 
> 
> On 3/10/2018 7:54 AM, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
> [..]
>> +struct bus_type aprbus_type = {
>> +    .name        = "aprbus",
>> +    .match        = apr_device_match,
>> +    .probe        = apr_device_probe,
>> +    .remove        = apr_device_remove,
>> +    .force_dma    = true,
> 
> There is no need of force_dma now as machine driver is not child of apr. 
> Please remove it.

Thanks Rohit, Will remove it.


>> +};
>> +EXPORT_SYMBOL_GPL(aprbus_type);
>> +
>>
> 
