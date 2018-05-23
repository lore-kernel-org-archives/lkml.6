Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527099107; cv=none;
        d=google.com; s=arc-20160816;
        b=DzDfVCqf/QH8ixklyogMXiA+eZCF1iy7pOhZnqq8m3Br+D8xQsiNeQPFeH/0Zve/BW
         f93O4+TeKLVSQF1PkW5lSjICudciKbfZwjnONebUuJ2gvKIAMcsao/2FGLXEBRwOkJrZ
         OfLTdUlF5dKkymo6b93aqq9ynshDrEr0YJqqwz4EAshXjnFEGN5XgatBkTxqgh51h5zb
         4Mx3apSqw03NuHWuv9Xii1YLT7iA3B9fEsb4PVvgcRCzbiTXkpRD0z5iw0JLJh6SVylk
         BXs0We8/0SU8BIwvlOUgFummIrIMKcY/pbk7+jypRVOuxSiIT0t9m2XZ0rXC3MAymYsg
         3mqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=+s4iCRMbw+uhk+qJ12FYw2LJkuiL9qDz6pS+Y5eacTw=;
        b=wmZuQn2hZ0LNPEi8uQKart1SWZ+H6jBNP4xaK89zhNfhGICNdbq/pxkQmYv7VGFfYg
         z/Bvh2dXtDTyFNFzcDcieA1BUbiNVMIo0T53dP2r7CE7XQcOsASh4FsmivgqvwaUfpGC
         gqD73YPUBbO3l+fBtiKdEKy3c7HEJn0eeq/KMwOt0cXZjm1wUzdeY/jqp6n5dF2fPxTy
         JKndbj6agIMRLksNyHMH8nT4kWBBkmzVJ0kVXO1TGXEr+OTEorvhvDY7lCnTtFn7jNxQ
         rBwUZBzjKhTWJIaq7MxzZmGhYKnSWnZormmutgNowayea+kw979NO2ohIePU8YJb5W49
         vapQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Q1x8Hq/e;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Q1x8Hq/e;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZolF73UIyDidtQlSiK5v7EdGjBeoVaF6A069krRPCkgeJSdzwVrHgdAVwkkQ1zyz/thEHF7zA==
Subject: Re: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
To: Rob Herring <robh@kernel.org>
Cc: gregkh@linuxfoundation.org, kramasub@codeaurora.org, sdharia@quicinc.com,
 girishm@quicinc.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
 bgoswami@codeaurora.org, devicetree@vger.kernel.org, broonie@kernel.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
 <20180523164023.GA24671@rob-hp-laptop>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4b83b699-59ad-b177-f360-3e76ba847892@linaro.org>
Date: Wed, 23 May 2018 19:11:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180523164023.GA24671@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640408468818070?=
X-GMAIL-MSGID: =?utf-8?q?1601279473995559728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 23/05/18 17:40, Rob Herring wrote:
>> +
>> +- qcom,ngd-id
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: ngd instance id in the controller
> Why do you need this?
> 
Please ignore my comment from previous reply.

There are more than one instances of ngd in this slim controller.
We need this to make sure we are programming the correct one.

We also need this instance ID during powering it up using QMI.


thanks,
srini
