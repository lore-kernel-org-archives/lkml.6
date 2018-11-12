Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC43C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD6722504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx9ClFYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD6722504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbeKMBzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:55:20 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38398 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbeKMBzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:55:19 -0500
Received: by mail-lj1-f181.google.com with SMTP id q186-v6so8079846ljb.5;
        Mon, 12 Nov 2018 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ljUbpmfyasg70hjS9I9lQMW6bYKyulqTR3mNIXswgGo=;
        b=cx9ClFYSthTnwddNDWasdwdsxE73bQZep4WLqYSpeFo7Peu2FAIK5eNZhgELVxlP/C
         h+rRzxecz9KdLDTAqukjEHtkTNQTPpYAqN8HVwZOdDTwRI9f4P4G+wWi+9+iWTxuTenh
         5t1wRxTURmSltmpwRa9MkaDPTVkZq6wkscYY9yAAmwL3+BgyXwl6Fh1bBIhM4aiJ2UiR
         /8iB/92tST9pRwG70M7A3zcgHMUBwTmlloL2hKOU+5v/HACdC1tm/jZxtTf4R566krPl
         xj3VQhJpNHOsntcp9UlMv3rQbgj6uJVS5wD9On4zMCkq09GWMcRhvnE1zAmcXO5PusRi
         x0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ljUbpmfyasg70hjS9I9lQMW6bYKyulqTR3mNIXswgGo=;
        b=NLkWxJkFtlQE+3x/QKkCv/3u9SNr519T1KuA/HmgHTRWZRhOXtZTbt5D8LV84bIFNG
         nftltUHHY7t16ecF2eeYLUvjgqkem9B3eFbnRQmDAMUYlxDZWOsCR869y8iYgx5wLYQz
         LP4TwYJQRN1mwfDfEzy5KaEXZBZFLQFPcEUpKjPClY8YRXRxJNWDeL5aLDMO7+GxL6wO
         SToUC08ngUnMpFGSiw+xGNUcKrtyurEMZ/CNtUFd0XiBVwt7V7gysHcxYLHLgoBMdf4+
         OCWzWsuU9mKvlURPphIr6IKQ13DWE2+/6b4kpnl4tpRoLmuG9VlA5Z04MhjlKK5xPb/H
         FDew==
X-Gm-Message-State: AGRZ1gKyXaB9KnD7CXzY7c+mThGrB15Npu2Umuh3dYcsKwNWUpYmUb7I
        STVSHTeZZJJfwkeO9eTe59g=
X-Google-Smtp-Source: AJdET5fs3wt0Qs7JYt81Qf3/BTXGUL67AiLWqu03oCZB08agm37R9noIoYB3anM1FaX+kaKPHdvcew==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr1049361ljb.176.1542038486727;
        Mon, 12 Nov 2018 08:01:26 -0800 (PST)
Received: from [192.168.1.18] (bgt69.neoplus.adsl.tpnet.pl. [83.28.83.69])
        by smtp.gmail.com with ESMTPSA id l3-v6sm3138634ljg.21.2018.11.12.08.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:01:25 -0800 (PST)
Subject: Re: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
 <fb4139e2-53ae-0a02-df8d-2fe7c6d32194@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <81853cb3-2a0a-1685-14b9-d5e02b3f5843@gmail.com>
Date:   Mon, 12 Nov 2018 17:01:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fb4139e2-53ae-0a02-df8d-2fe7c6d32194@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vesa,

On 11/12/2018 01:25 AM, Vesa Jääskeläinen wrote:
> Hi Jacek,
> 
> On 07/11/2018 0.07, Jacek Anaszewski wrote:
>> Add common LED function definitions for use in Device Tree.
>> The function names were extracted from existing dts files
>> after eliminating oddities.
> 
> Is your intent here is to standardize the function definitions and to
> aid in that is to specify list of string defines?

The calls for LED names standardization emerged some time go, and this
is just a submission of the subject for a discussion.

> Without a meaning what all of those mean it does complete the original
> goal.
> 
> In your list there are many things that could easily have multiple
> meanings for different audiences.
> 
> Some examples:
> 
> #define LED_FUNCTION_2G "2g"
> - Does this mean that 2 metric grams has been detected in scale or
> cellular 2G connectivity?

Most probably the latter. Should we have the generic macro for it
is another question. Actually I found it in the leds-tlc591xx.txt
bindings. There are also "wlan_2g" occurrences in the armada385-linksys*
dts files.

> #define LED_FUNCTION_ALL "all"
> - This doesn't ring a bell to me what it could be in reality. All leds
> on doesn't sound right.

Yeah, I must admit I didn't spend too much time assessing how much
all of them make sense. I just wanted we had more complete picture
of what functions are pre-existing in the bindings and dts files.

> #define LED_FUNCTION_AUX "aux"
> - There can be many things aux and multiple aux things in one device.
> 
> #define LED_FUNCTION_HD "hd"
> - Is there a high definition video playing? Or audio? Or harddisk
> failure led?
> 
> You have already come up with long list of items. I am just wondering
> what is the logic in order to get to "common" list?
> 
> Can you just add custom items in device tree without being in the list?
> 
> Would it be better to start with a short simple list with meanings
> defined properly?

This seems to be the most reasonable approach. My first thought was
to provide function definitions for as many as possible from the
pre-existing ones, but it is not making too much sense as it tunes out.

> When do you then remove entries from the list? Let's say 3G networks are
> currently getting turned off world wide which kinda deprecates the term
> from definitions and probably should be then removed from the list (if
> it would be there).
> 
> Is there planned to be some auto connection from function to some other
> automated functionality? 

One proposition was to register the LED for a trigger events basing on
the function name, like e.g "heartbeat".

> Or why wouldn't the label keyword be enough as
> it seems to be exactly the same thing? (without the common list -- which
> could be implemented for label too if seen as a good thing)

LED_FUNCTION definitions are not meant to be limited for use only
with color:name scheme, if that's what you had on mind.

-- 
Best regards,
Jacek Anaszewski
