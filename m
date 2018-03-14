Return-Path: <rohitkr@codeaurora.org>
X-Google-Smtp-Source: AG47ELv81QXvr4Ar8YMvfL2nVUllAM/6k8dPuxpSr9aJzXWdN62ZsxlP3KDevuNggQawmaSPb1XJ
ARC-Seal: i=1; a=rsa-sha256; t=1521036742; cv=none;
        d=google.com; s=arc-20160816;
        b=cftBWaYZnnNjCY5tKFYHhglD238KebAS0CAx3Cq7GGImTSLXSP9Q/3dhJUtUy0yMKx
         QMsA8KdxatcSw+dnx2Q53sTBl7G/bWNOwVaFIG3C1VrruagReEotRXKEr75hte2OCLm6
         rIM0p1DGnU6Tqm8aWxUhyu8q2AtGW3N8NhHEl55gYcIoVgWHne/NXEVBmw82OeCVv+9H
         Q2aih5Zp1iJyhIz4d2uCwCtQougXIxYu4Ya8YH8bsVwvVubMmEB6Scwtf+WDY1+sDZhU
         jvnYtQLmvAm8j1xyRyCHr8+gk1QaLv3jrVTopK3ROgEzlWt5NbJ4lOIgpZ3w997w6ZR7
         5ZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=FlH5mrLfJ28L0hxVVBvZJ4nWag40rXDmIfo4rNgP2wg=;
        b=ahOHvvxlTra1I2k9qAIdLBBECzdLBKOSw6tOKkdrRTYXTzVrd+huK3Psi9G3Rd+VNG
         YsFTSVcY/eDOJ1pgvj6IcK5OPmVc0nvozQfZZou89098P98Z7L8hpIrbI8IXfdxr3ODp
         xDFMx2gBP+pN45UnH+tQHD7r8oQznAJF1nHT3FKtZ2m6eVHXQttja9W+4DQvr3Ks5D/3
         0Dvbp7MM4SOxd6rdifV50v8H0fkT9YZY5TqHBC3KVLVG0srYe0V6rmHlFv0oTVSsIS3n
         hRtL41utaqS2PCT00MbGYeZSQkW2youxpMODr78k5BYBfJWcUDd2pzvK1rJHgyjrGjsZ
         E6iA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=c555XgZQ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=fmqJ9Tv9;
       spf=pass (google.com: domain of rohitkr@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=rohitkr@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=c555XgZQ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=fmqJ9Tv9;
       spf=pass (google.com: domain of rohitkr@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=rohitkr@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CD9D60592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v4 02/24] soc: qcom: Add APR bus driver
To: srinivas.kandagatla@linaro.org, andy.gross@linaro.org,
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
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <d9e92aeb-8d74-554e-4390-4117571806a9@codeaurora.org>
Date: Wed, 14 Mar 2018 19:42:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310022456.26739-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515904810713812?=
X-GMAIL-MSGID: =?utf-8?q?1594922623769846359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/10/2018 7:54 AM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
[..]
> +struct bus_type aprbus_type = {
> +	.name		= "aprbus",
> +	.match		= apr_device_match,
> +	.probe		= apr_device_probe,
> +	.remove		= apr_device_remove,
> +	.force_dma	= true,

There is no need of force_dma now as machine driver is not child of apr. 
Please remove it.
> +};
> +EXPORT_SYMBOL_GPL(aprbus_type);
> +
>
