Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93762C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1EB20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJmwqlsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1EB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeKYUca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:32:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53486 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeKYUca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 15:32:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so12047663wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 01:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kxWIdzOrN2mS+J/MOhJOBcKJGnUiahJujLAroPpV2MY=;
        b=KJmwqlsNUcA/DaR9NEnhJi+oUube0lGh/YJHYnJmmfh8UgffijmvHsmnZN4DTaPqV1
         MWg+JtnmZuQIb8Ic0OhL69AA4hcsaTCbGmGn//wJTGcd34fDNA/6ZCdR24fyd4CIzVYs
         ZKNx+ywseV5wGS6M8D2nYjq2z6NIA8mn53nN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kxWIdzOrN2mS+J/MOhJOBcKJGnUiahJujLAroPpV2MY=;
        b=IjxWxPyDBB84Grfk36vICc22ywCRyf9yOMDGcg8m9iauQv1DmrmUpeu0IahOWTWDsV
         5oIxvJZGRO3vahEY8MvpemC6iKmhRaegWpW9DC2A+K0NmLY5w4U8jY53vhxxbfQNIOhs
         QIRoJNmngLZITtuXPeiurmaUoiUV26A3sdscv1jOCr0ZYPXOrP/n08qJKDRbTrizTYQl
         2im8uHd9RfJM6oWrVB4HqWtk3PXUbCJSUpNHqtQUDc4NFVTTLi/4cOmpyXMTL9PHeRXW
         8a0IGs0FcrSnf6/ibVRMJJfqCYITTOO3qjzzkO/MsSO8T1v/bBvpg5ZtaUTH/Wny74Ih
         Obsg==
X-Gm-Message-State: AA+aEWbrdrpZm62rfDr64rRdW4YxsXJBBIcVaF/BbWsAwfIbKFXdyAo/
        GyYZd3qMcykWknnGbMaKraJNQY4ZGjM=
X-Google-Smtp-Source: AJdET5dhfSbJPU44WkG2giaPce3e3StjAHsmX7PP7JdAIPbF+wrL8D0nWy6Q2odmBv4kb6YclagQdQ==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr19807624wmf.3.1543138906495;
        Sun, 25 Nov 2018 01:41:46 -0800 (PST)
Received: from [192.168.0.40] (85.64.136.77.rev.sfr.net. [77.136.64.85])
        by smtp.googlemail.com with ESMTPSA id h16sm6239850wrb.62.2018.11.25.01.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 01:41:45 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/integrator-ap: add missing
 of_node_put()
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20181122152331.25739-1-tiny.windzz@gmail.com>
 <CAEExFWt45G5hyAEZvaAW--ZANnTqmi7-i473jRfFLD0Wacp6-w@mail.gmail.com>
 <97b95b60-8420-bad9-4d2c-6baee749b90f@linaro.org>
 <CAEExFWsdEQCC--E5o5uKuT6nNK_TeqmVu-F1g7Bv_+FO7OkjjQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f36354fc-566a-a3f4-ff01-8aa99d5af753@linaro.org>
Date:   Sun, 25 Nov 2018 10:41:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWsdEQCC--E5o5uKuT6nNK_TeqmVu-F1g7Bv_+FO7OkjjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2018 05:25, Frank Lee wrote:
> On Sun, Nov 25, 2018 at 3:49 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 24/11/2018 15:58, Frank Lee wrote:
>>> On Thu, Nov 22, 2018 at 11:23 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>>>>
>>>> of_find_node_by_path() acquires a reference to the node
>>>> returned by it and that reference needs to be dropped by its caller.
>>>> integrator_ap_timer_init_of() doesn't do that, so fix it.
>>>>
>>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>>>> ---
>>>>  drivers/clocksource/timer-integrator-ap.c | 20 ++++++++++++++------
>>>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
>>>> index 76e526f58620..1f04069470bb 100644
>>>> --- a/drivers/clocksource/timer-integrator-ap.c
>>>> +++ b/drivers/clocksource/timer-integrator-ap.c
>>>> @@ -177,7 +177,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
>>>>  {
>>>>         const char *path;
>>>>         void __iomem *base;
>>>> -       int err;
>>>> +       int err,rc = 0;
>>>>         int irq;
>>>>         struct clk *clk;
>>>>         unsigned long rate;
>>>> @@ -210,26 +210,34 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
>>>>                                 "arm,timer-secondary", &path);
>>>>         if (err) {
>>>>                 pr_warn("Failed to read property\n");
>>>> -               return err;
>>>> +               rc = err;
>>>> +               goto out_put_pri_node;
>>>>         }
>>>>
>>>>
>>>>         sec_node = of_find_node_by_path(path);
>>>>
>>>> -       if (node == pri_node)
>>>> +       if (node == pri_node){
>>>>                 /* The primary timer lacks IRQ, use as clocksource */
>>>> -               return integrator_clocksource_init(rate, base);
>>>> +               rc = integrator_clocksource_init(rate, base);
>>>> +               goto out;
>>>> +       }
>>>>
>>>>         if (node == sec_node) {
>>>>                 /* The secondary timer will drive the clock event */
>>>>                 irq = irq_of_parse_and_map(node, 0);
>>>> -               return integrator_clockevent_init(rate, base, irq);
>>>> +               rc = integrator_clockevent_init(rate, base, irq);
>>>> +               goto out;
>>>>         }
>>>>
>>>>         pr_info("Timer @%p unused\n", base);
>>>>         clk_disable_unprepare(clk);
>>>> +out:
>>>> +       of_node_put(sec_node);
>>>> +out_put_pri_node:
>>>> +       of_node_put(pri_node);
>>>>
>>>> -       return 0;
>>>> +       return rc;
>>>>  }
>>>>
>>>>  TIMER_OF_DECLARE(integrator_ap_timer, "arm,integrator-timer",
>>>> --
>>>> 2.17.0
>>>>
>>> Hi Daniel：
>>>
>>> How about this?
>>
>> Hi,
>>
>> I think there is a simpler fix. The pri_node and the sec_node are used
>> as an identifier to compare against the current node, we can directly
>> drop the refcount after getting the node from path as it is not used as
>> pointer. In addition, a single variable is needed, so we end up with a
>> fix like that.
>>
>>         alias_node = of_find_node_by_path(path);
>>         of_node_put(alias_node);
>>         if (node == alias_node)
>>                 return integrator_clocksource_init(rate, base);
> 
> Daniel,
> 
> OK,I will simplify it like you said.Although I think of_node_put
> should be called
> after we don't use node.

Except I'm missing something, we don't use the alias_node at any time.
The node itself has already a refcount which gives us the guarantee it
is valid.

I agree it can appear a bit strange to put the node right after getting
it but in our case the alias_node is used as an ID, not a pointer, so it
is fine.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

