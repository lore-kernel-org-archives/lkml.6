Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB15C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762932086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4zZiR2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762932086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeGLMMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:12:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44137 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeGLMMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:12:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so21441576wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WbfoM9Wtqb7II+21WAV5NS0AbyYbyHDbc/gH5JvIMGU=;
        b=d4zZiR2IOIuctXSRHytD/t+PphEWmFO65sfDYKAdBoF2ORhmhu0TTeZvQcsF4QZOw5
         PBdDY9FedyL5/mIVWFVzcUznBd9woTjTGWjtWAbPZdoZ/mG4GdGekOguXjGhW0ofxjsY
         kUps1syfEEvAm6vsIfwbI1Jj9qbh0Ih0L5JKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WbfoM9Wtqb7II+21WAV5NS0AbyYbyHDbc/gH5JvIMGU=;
        b=QbZRpiA5MB0e7Rgjb41ylz6MbUihzdScYvDjrEFemB3PqLN+Lb0jT/b+/iECcSHep4
         /Ihx4sUmhwxLaBVkbmSMMWEF9U+SvFrwKt5mpdKEtj0N9NjK6Qk3d+9KK3k8hz6g758W
         z6p59xbB7KaqoRamLVdhDlGZNA+7lElOF/66RQiwNVvAjW4esg1RuNUphGq+Smmz+kWy
         mu+OCYr00KxHBZGwNqLEVqnaetdiQgwkXMjo5A52RYRGXs6MwaGluwXlD07iYNm7HiwT
         ULz5sRawnqQrRS36fR8Xh1ISIfWI/tC9qcyP5BLkppR/ujwr/zkyg0bngpoqRU46eFJ2
         03IQ==
X-Gm-Message-State: AOUpUlEFAANd+VoLXJPC64qHaL4Tn2rZZQ4YGhS+yJiqMJUoewqxtn7N
        6hiBjdT4Pc/t21XYJNSr2+GwO0GgzGU=
X-Google-Smtp-Source: AAOMgpfKaDQf/hV/XcRN76JzUbJEgv5dysuXFtDVgFTkODv9GL/TW59AiYLxpkxhK7jvFo6sRW69IQ==
X-Received: by 2002:adf:c4f0:: with SMTP id o45-v6mr1525030wrf.173.1531396976867;
        Thu, 12 Jul 2018 05:02:56 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id r7-v6sm19909408wrn.83.2018.07.12.05.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 05:02:56 -0700 (PDT)
Subject: Re: [PATCH] ASoC: core: add support to card re-bind/unbind using
 component framework
To:     Vinod <vkoul@kernel.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org
References: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
 <20180712105910.GU3219@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c4eae2f4-8094-bf09-abed-bfd7a0428f34@linaro.org>
Date:   Thu, 12 Jul 2018 13:02:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180712105910.GU3219@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod for taking look at this!

On 12/07/18 11:59, Vinod wrote:
> On 11-07-18, 09:43, Srinivas Kandagatla wrote:
>> This patch aims at add achieving dynamic behaviour of audio card when
>> the dependent components disappear and reappear.
>>
>> With this patch the card is removed if any of the dependent component
>> is removed and card is added back if the dependent component comes back.
>> All this is done using component framework and matching based on
>> component name.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Looks fine mostly, some nitpicks below:
> 
>> ---
>>
>> During discussion regarding card re-binding when components unregister
>> and register back at https://lkml.org/lkml/2018/7/9/785 it was suggested
>> that component framework can be added into core to provide this feature.
>>
>> With this new changes the card will re-bind once the dependent component
>> re-registers after unregistering. This works based on the match done
>> from component name using component framework.
>>
>> I have tested this patch with qdsp start-stop usecase for more than 10000
>> times in loop on Qcom platforms.
>>
>> I will send qdsp side cleanup patches once I get some feedback on this patch.
>>
>>
>>   include/sound/soc.h  |  5 ++++
>>   sound/soc/soc-core.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++----
>>   2 files changed, 70 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>> index 870ba6b64817..b94149d29c0d 100644
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -17,6 +17,7 @@
>>   #include <linux/workqueue.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>> +#include <linux/component.h>
>>   #include <linux/regmap.h>
>>   #include <linux/log2.h>
>>   #include <sound/core.h>
>> @@ -1088,6 +1089,10 @@ struct snd_soc_card {
>>   
>>   	struct work_struct deferred_resume_work;
>>   
>> +	/* component framework related */
>> +	bool components_added;
>> +	struct component_match *match;
>> +
>>   	/* lists of probed devices belonging to this card */
>>   	struct list_head component_dev_list;
>>   
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index 6d33634b934b..377ed8e67686 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -279,11 +279,31 @@ static inline void snd_soc_debugfs_exit(void)
>>   
>>   #endif
>>   
>> +static int snd_soc_card_comp_compare(struct device *dev, void *data)
> 
> Why not make last arg as name and avoid void *
> 

I can rename argument "data" to "name", but I can not change the 
prototype of the compare callback expected by component framework.

>> +{
>> +	struct snd_soc_component *component = NULL;
>> +	struct snd_soc_component *t;
> 
> why do you need two variables for this

We need two because one is iterator and other is find.

if we use just one we will endup with valid iterator item which may not 
have matched dev.

Or I can re-organize/simplify the code like this:

static int snd_soc_card_comp_compare(struct device *dev, void *name)
{
         struct snd_soc_component *t;

         lockdep_assert_held(&client_mutex);
         list_for_each_entry(t, &component_list, list) {
                 if (dev == t->dev) {
                         if (!strcmp(t->name, name))
                                 return 1;
                 }
         }

         return 0;
}

>> +
>> +	lockdep_assert_held(&client_mutex);
>> +	list_for_each_entry(t, &component_list, list) {
>> +		if (dev == t->dev) {
>> +			component = t;
> 
> you can skip this line and use t in below code.
> 
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (component && !strcmp(component->name, data))
> 


> strncmp?

AFAIU, strcmp should be safe here as component->name is 
generated/sanitized by core and would be of max len of NAME_SIZE.
core uses strcmp in may places. Any particular reason you want me to 
move to strncmp?
> 
