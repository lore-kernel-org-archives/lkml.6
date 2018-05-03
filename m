Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZoO3KKeJsf4K/4MY0riGGypv8ofjJKB6yYQhV+YjoUpTeb+amYaHIsS8LK0Q8FTaCKq4Vqz
ARC-Seal: i=1; a=rsa-sha256; t=1525390215; cv=none;
        d=google.com; s=arc-20160816;
        b=bckEIu/WqnVnYFLw8f2YBc2YAQeECd/FuzcN5ACmUFYN38l1ee65s8y3e+WOnPZjhI
         PrOmfttfkbnabvJ87PJET3jWDG3guJvjF68UJC424BT7erwPyV7Dyd1HuPZvxVJZq62k
         Hept5npjhPuZH3i+fzEitaFNtqGPIfKzSA1LBN679QzKy1d6MwnqMDPh73+1EgwZc1Ir
         94//FO8bROYlw8cmJi2lmoyTmJTyNO5tDzIBFPlzNxEFJROiysk+dzt18ptVZa6te4N0
         EKg7JomIBhQcg8jASV9Dm3PMMijxlL/k+R63906ulaje4zaQOgouHodFn/ZG4uKAEgGI
         iysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=AuuOscYajJVbBXr1sjysMkHFtsjy7SERxHB6xm/4CRw=;
        b=Mj7TnQVFlwgngu8LT9N0TtwmKiPsxhtk7t6dnYaVm/1G8bnMJNCJ5QCxj3lLP6JAOD
         VJsHImIVFDrVDj0jnInylJE/uRXr/PAi5tR08lmj8MoQCXxzDi4rfBKkcGl3sVrVjTP8
         3hdg9ORYBrmLBDHHJXXg2UUtr9ilCncoKkpZG1pSwQ5EfFTJ4cO7p9W/vHRYomXc/ojb
         oI4qZnZTJrLW9EgVgTF15mC6BR99lc/ik/J/OI+tPNY67lMcrG2IhLdOLDh72lIcEDOc
         AHtNuOozaAg6arqs9wVuUpTDV9ZDRAxbwC5DxH0/XG56ERZpfYpwNrnvffWxNHczxu4G
         B7OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eDlY5cLc;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=iowJgBGT;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eDlY5cLc;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=iowJgBGT;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EBAF60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v7 01/24] soc: qcom dt-bindings: Add APR bus
 bindings
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org,
 tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org,
 linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com,
 linux-kernel@vger.kernel.org
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-2-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <80b45848-2426-1280-c388-b79cbfec8cef@codeaurora.org>
Date: Thu, 3 May 2018 16:30:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263606124901883?=
X-GMAIL-MSGID: =?utf-8?q?1599487570272147799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/1/2018 5:07 AM, Srinivas Kandagatla wrote:
> This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
> bus driver. This bus is used for communicating with DSP which provides
> audio and various other services to cpu.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 84 ++++++++++++++++++++++
>   include/dt-bindings/soc/qcom,apr.h                 | 28 ++++++++
>   2 files changed, 112 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>   create mode 100644 include/dt-bindings/soc/qcom,apr.h
>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
