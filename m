Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeENUG4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:06:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38347 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeENUGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:06:52 -0400
X-Google-Smtp-Source: AB8JxZrGhzJHQCLh667IAuXSdjciykYrOaRhm/k0gsEYnghvlDORWcnUke5Z9FMF49m6Q76WqsoSYA==
Subject: Re: [PATCH v5 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, mark.rutland@arm.com,
        pavel@ucw.cz, afd@ti.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180510174717.26540-1-dmurphy@ti.com>
 <20180510174717.26540-2-dmurphy@ti.com>
 <41267191-1308-6b9b-78fa-2893a525b49a@gmail.com>
 <17630aca-1225-df61-7a5d-a921ecd9c78c@ti.com>
 <86c2bc2f-e622-9447-e4bb-b4ee37e2d44a@ti.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <f7a98b66-977a-887c-d31a-ed908c9d1409@gmail.com>
Date: Mon, 14 May 2018 22:05:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86c2bc2f-e622-9447-e4bb-b4ee37e2d44a@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 05/14/2018 09:40 PM, Dan Murphy wrote:
> Jacek
> 
> On 05/11/2018 06:56 AM, Dan Murphy wrote:
> <snip>
> 
>>>> +    }
>>>> +
>>>> +    if (led->strobe_node) {
>>>> +        ret = of_property_read_string(led->strobe_node, "label", &name);
>>>> +        if (!ret)
>>>> +            snprintf(led->strobe, sizeof(led->strobe),
>>>> +                "%s:%s", led->strobe_node->name, name);
>>>> +        else
>>>> +            snprintf(led->strobe, sizeof(led->strobe),
>>>> +                "%s::strobe", led->strobe_node->name);
>>>> +
>>>> +        ret = of_property_read_u32(led->strobe_node,
>>>> +                    "flash-max-microamp",
>>>> +                    &led->strobe_current_max);
>>>> +        if (ret < 0) {
>>>> +            led->strobe_current_max = LM3601X_MIN_STROBE_I_MA;
>>>> +            dev_warn(&led->client->dev,
>>>> +                 "flash-max-microamp DT property missing\n");
>>>> +        }
>>>> +
>>>> +        ret = of_property_read_u32(led->strobe_node,
>>>> +                    "flash-max-timeout-us",
>>>> +                    &led->max_strobe_timeout);
>>>> +        if (ret < 0) {
>>>> +            led->max_strobe_timeout = strobe_timeouts[0].reg_val;
>>>> +            dev_warn(&led->client->dev,
>>>> +                 "flash-max-timeout-us DT property missing\n");
>>>> +        }
>>>
>>> Common LED bindings state that flash-max-microamp and
>>> flash-max-timeout-us properties are mandatory.
>>
>> OK.
> 
> OK I looked at the max776973 driver and well if the flash-max-microamp and
> flash-max-timeout-us nodes are missing it sets a default value for each if the
> node is not present.

Ah, yes, this driver was being introduced as the first LED flash class 
driver and we were being iteratively adjusting LED common bindings
according to the new findings, so some details could have been left
out of sync.

> So should we remove this code from the Max77693 driver too and fail probe as being asked
> in this driver?

Yes, that would match what the bindings require.

-- 
Best regards,
Jacek Anaszewski
