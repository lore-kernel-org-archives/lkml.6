Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525859014; cv=none;
        d=google.com; s=arc-20160816;
        b=LRzza/uYaHt30xmtHtHfLGjh3VC7WcS31L3UfXJ8holarY0N6sZtnUF/4XtiHufqzF
         rXMx+HS3QUXda1zekZoRk1z2UaEcv8jiVz0nPlviCWPkdIF/o1qG8wicJiKwLI9xjkEb
         F8A8sGn5Nj96Bx0IlcnwqUozymhpAKkDRlmu+K/BpKnn22FEJ8147ijRByyGVEunL3mU
         tdRe5ru8rGJ3S/9GatFL21ShG3/6saC34cC36RASkBBD1EZHQMah0k5KmlM/qWFiE2XJ
         oUVrtre9cdVJ0p4ca1lmDMyogVxNiNLQGpAxtYH4+/6NAS5cNU1n6f8LARCThMi4273e
         BiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=ZyrJcHQimgVBKkzNG5OhffzuvxkH3qXUshw6dAeI9lw=;
        b=gT4VMeTbDEFOh5AjP0OqwkCflmvR2y76m4I0vRTMNjSdBr1Yc7/jm2Q9lkyywj8RWZ
         aC05b5cgpM2BbFY6TovqXQ4gZ2YdEWOBGZ+Y4xCWxQpljIty59rPJ0LkC/KGASwwldxp
         Ga0C+kL3VCYh9PIDU91MVoCcj0AZ6afHAgsCDblX782U6EjT+oEKrbs8WAAU3SUsWHul
         b/MZOhqfgMslM0iCMJlFP0tTaNbp2l42TFNm9pE9br+yQFN9CPWzgQ3GVUmZ+5jGi1Lz
         9zwfbCULi6WoyZvuJ+qIC9skZCrhUdVKif4J46yZJlfaG2bykUNySLXYUcciXPsqlSxs
         ucDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=h6ncWz5u;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=h6ncWz5u;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrZNO+rt1hV9e8B3W4oSVVSuzZ2IJ2Fbm2IT8nVwMQc1Foh93uqdRHPyi89DwqZhuclV+dBCQ==
Subject: Re: [PATCH v7 20/24] ASoC: qdsp6: q6afe: Add q6afe dai driver
To: Banajit Goswami <bgoswami@codeaurora.org>, andy.gross@linaro.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-21-srinivas.kandagatla@linaro.org>
 <22a39a17-36ef-3e94-e91b-11d303559ae4@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <28faf045-a053-0918-70d3-1ef6fcdb13b8@linaro.org>
Date: Wed, 9 May 2018 10:43:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <22a39a17-36ef-3e94-e91b-11d303559ae4@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263634618005779?=
X-GMAIL-MSGID: =?utf-8?q?1599979141085446745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 09/05/18 10:42, Banajit Goswami wrote:
>> +
>> +static int msm_dai_q6_dai_probe(struct snd_soc_dai *dai)
>> +{
>> +    struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
>> +    struct snd_soc_dapm_context *dapm;
>> +    struct q6afe_port *port;
>> +
>> +    dapm = snd_soc_component_get_dapm(dai->component);
> dapm unused here?
> 
I already removed this in v8.

thanks,
srini

> LGTM otherwise.
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
> 
> -- 
