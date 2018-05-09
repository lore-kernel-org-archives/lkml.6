Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525860217; cv=none;
        d=google.com; s=arc-20160816;
        b=y/cOneqiXsCxbVJqeX+SiNODXNwRt+Cz1CDB4sBHfcKUgMjZ3+6dy2pOKipjBQrmZ2
         xeGiG55Cwx2xAJ7DMx5wXyTtmF+I1vYRTLMPzRqdqNsxXEOqzOuPvsr1Pe0LFlLENiT+
         +0HJevH6uumuSLqOjnorK/vKHnYfFc6iA/Gy0D6RpIsdYj0HC4uqiWM7S7cjkmbSiQTk
         FsEeqsYt5269iyxGNWQ8AHBRhaxAAhx+17cujNpBdEx6TyaIXlvwT5x0sdbyXMxh3wnz
         foY7S3Y0XU2nhRUam39Ji3NwGlptJVC+1eu78VtSmRNl2yhC8u3etrwO0O/TrsgXpI+H
         O2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=m5WnKlBvBMkKbl/JefTgHzaGCk5Z2FtrWL5MajVUavk=;
        b=Xf1ZbUk/vLJmI+tpSM3FUGyRceJcCB4zea/k3V+WyjRNL0wSPMfHmnPLz0cfpKmfVE
         lABudL2Vbrw1D634q580JOOQpgVHyMOHgE7JvpIbXHndGmH9rOcn3/6wpmRxiWzq6rCI
         0mbfrNOPT9dkcfTIQ0WNPqXgvioAh/rbS3nuvBOs0JPrpim8qyWpfzDhGzwvnjR55e1i
         M/GIF+Eu69PDqWKP/INvaeX5y7dfYrpRDFOJ8lkMlVOeVsABvE2P7K2rCO+ywWDsBJxb
         oyPP5GFSreaMnDvPlcHWj9ux5uSLy6A8HFRXRIs8qkroACTpZaB1+0k1PRl2MYCu0c9u
         7how==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=c9MCTJyG;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=c9MCTJyG;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZop8q+R0MxrumFh00zdbr9VvCMO0kAvNKoRTWLn+C0TtEAM2UcQiQR8gOE8gI2HrPAAtjy9iQ==
Subject: Re: [PATCH v7 23/24] ASoC: qcom: apq8096: Add db820c machine driver
To: Banajit Goswami <bgoswami@codeaurora.org>, andy.gross@linaro.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-24-srinivas.kandagatla@linaro.org>
 <c52fc35d-95a6-6675-6c6e-32a0d5f486d4@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0db86f6a-76cb-22a5-eed9-98b2134dcb8b@linaro.org>
Date: Wed, 9 May 2018 11:03:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <c52fc35d-95a6-6675-6c6e-32a0d5f486d4@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263638421096230?=
X-GMAIL-MSGID: =?utf-8?q?1599980403563082056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for the review Banajit.

On 09/05/18 10:15, Banajit Goswami wrote:
> 
> On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
>> This patch adds support to DB820c machine driver.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/Kconfig   |   9 ++
>>   sound/soc/qcom/Makefile  |   2 +
>>   sound/soc/qcom/apq8096.c | 238 
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 249 insertions(+)
>> +    link = card->dai_link;
>> +
>> +    for_each_child_of_node(node, np) {
>> +        cpu = of_get_child_by_name(np, "cpu");
>> +        platform = of_get_child_by_name(np, "platform");
>> +        codec = of_get_child_by_name(np, "codec");
>> +
>> +        if (!cpu) {
>> +            dev_err(dev, "Can't find cpu DT node\n");
> clean up missing to kfree(card->dai_link)?
Yep, I will fix error path in next version.
> 
>> +            return -EINVAL;
>> +        }
>> +
>> +                return ret;
>> +            }
>> +            link->no_pcm = 1;
>> +            link->ignore_suspend = 1;
> ignore_suspend will also need to be set for FE DAIs?
> 
Okay!
>> +            link->ignore_pmdown_time = 1;
>> +            link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
>> +        } else {
>> +            link->platform_of_node = link->cpu_of_node;
>> +            link->codec_dai_name = "snd-soc-dummy-dai";
>> +            link->codec_name = "snd-soc-dummy";
>> +            link->dynamic = 1;
>> +        }

>> +

>> +
>> +static void apq8096_unbind(struct device *dev)
>> +{
>> +    struct snd_soc_card *card = dev_get_drvdata(dev);
>> +
>> +    component_unbind_all(dev, card);
>> +    snd_soc_unregister_card(card);
> Should sound card not be unregistered first, before calling 
> component_unbind_all()?
Yep, I will give that a go.

thanks,
srini

> 
