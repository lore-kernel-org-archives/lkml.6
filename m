Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A6ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD132082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzMmFWRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD132082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbeJYDqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:46:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45101 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYDqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:46:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so5827391ljc.12;
        Wed, 24 Oct 2018 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pwOaWq361y+BBOuEcV2WBGuL+YC+eKSUhwrvxmiJNy0=;
        b=MzMmFWRZz1pDcTbexFeCNy19R9HFjVIRjiYCQoMBR80S8EW4tuosCEqKUxADe6CAXN
         M++KMH1ML/czqziOCBk+N1jKWb223XWHMTN6rEwgFJGDjBhuOGjzRGXnJ4Qs2g4uPHvV
         +Hk/fNOkcyJhXXh1pieA2dye7wQsABB3D0df24BSSM6jSPNwkD7DY8/FGhx3bEoxhVSR
         A3hs7SY0YVNeCl0sLGs7xE07sa3DoWjHF5VKUskVFOJ6iDsCL+PZ98b5YnrPcIr2zRJb
         B6MjrePSUMFlQqIbl8uUNN9xbsMmp2MI0s7dVxDLOMV8d3G40rEAO73191rvtJln6YS1
         8dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pwOaWq361y+BBOuEcV2WBGuL+YC+eKSUhwrvxmiJNy0=;
        b=GX+jhhhEO/5f15A6atgnHXtIN9R/nbVb1JvhTnWst+w9CqGLp4OiYivhdfMExYouVT
         10JCMMtxyg1zLja80pz3ExcL2Xs7wj0zABb/LqxrQ6EbG/yDOHVtfuec3ecybEFA9zGJ
         tjxvoVjZpcnh4G7h3lndOu31Kc50Ri1iNSwOTugwJXlmevDPUnNWKrwQwgzkhZrLuGoC
         6POo/RNEwMHtmWnt/B3/nKvHuPBm4Hna+RNYYYWMGHMU2Jg7N6kTQ7b2+ZZRaCf8USYY
         YYCB6fv/yf/5nF2GmEY08uKDAql6I9PlPuqkNdYsr0TRIJvvUS1AoHjyRDb3Tki3Yms7
         cThw==
X-Gm-Message-State: AGRZ1gI6x24yovN4dVQr5Nu5e/x8J5Mvb0SrSM8xC7HbNBTntB0pB0QX
        8T/a5YYGo8RZ1WB1HlmvsEfFS+xe
X-Google-Smtp-Source: AJdET5eDGxpp+ayW9w+LsZ3NOa2J4oN6x/YnA2goAWQT7O1G1qON/pShdGoiJCZQWW6S2z1CaLonug==
X-Received: by 2002:a2e:98c2:: with SMTP id s2-v6mr2604953ljj.19.1540408649133;
        Wed, 24 Oct 2018 12:17:29 -0700 (PDT)
Received: from [192.168.1.18] (bgs214.neoplus.adsl.tpnet.pl. [83.28.82.214])
        by smtp.gmail.com with ESMTPSA id 134-v6sm867797lfz.76.2018.10.24.12.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 12:17:28 -0700 (PDT)
Subject: Re: [PATCH v15 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
 <d90397dd-429f-4f3f-307c-b69dccc360e0@gmail.com> <20181024083143.GA24165@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <bdadda71-f919-b6a6-4e1c-f87ed298b6b5@gmail.com>
Date:   Wed, 24 Oct 2018 21:17:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024083143.GA24165@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2018 10:31 AM, Pavel Machek wrote:
> Hi!
> 
>>> +
>>> +		The gradual dimming format of the software pattern values should be:
>>> +		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
>>> +		duration_3 ...". For example:
>>> +
>>> +		echo 0 1000 255 2000 > pattern
>>> +
>>> +		It will make the LED go gradually from zero-intensity to max (255)
>>> +		intensity in 1000 milliseconds, then back to zero intensity in 2000
>>> +		milliseconds:
>>> +
>>> +		LED brightness
>>> +		    ^
>>> +		255-|       / \            / \            /
>>> +		    |      /    \         /    \         /
>>> +		    |     /       \      /       \      /
>>> +		    |    /          \   /          \   /
>>> +		  0-|   /             \/             \/
>>> +		    +---0----1----2----3----4----5----6------------> time (s)
>>> +
> 
> Ok, so I got around to testing this.
> 
> echo "0 1000 10 2550 0 1000 0 100" > pattern
> 
> makes expected pattern [  .-xXx-.  ].
> 
> But when I do
> 
> echo "0 1000 10 2550 0 1000" > pattern
> 
> I only get expected pattern on the first iteration, then I get
> [    Xx-.   ].

This is because the tuples are processed in a loop, without
discerning between start and end of the sequence.

So this sequence ends up being squashed, because of the
comparison:

if (data->curr->brightness == data->next->brightness) {
	//step change od brightness
	...
	/* Skip the tuple with zero duration */

Here we actually only assume that this is zero duration since it
is not checked. Possibly needs fixing.

	pattern_trig_update_patterns(data);
	/* Select next tuple */
	pattern_trig_update_patterns(data);

In effect we have:

0 -> 10    // dimming
10 -> 0    // dimming
0 skipped  // step
10 -> 0    // dimming
0 skipped  // step
10 -> 0    // dimming
...

In order to get "rise - fall - rise - fall" sequence you need
only two tuples:

echo "0 1000 10 1000" > pattern

which will be processed as follows:

0 -> 10    // dimming
10 -> 0    // dimming
0 -> 10    // dimming
10 -> 0    // dimming
0 -> 10    // dimming
10 -> 0    // dimming

> I'm using led-controller:flash on nokia n900 (so everything in
> software).
> 
>> OK, let's abide by constant update interval for now.
>>
>> Thank you for your work on this patch set throughout
>> all these months. We will have -rc8, so one week of testing
>> before sending upstream should be enough.
>>
>> Patch set applied to the for-next branch of linux-leds.git.
> 
> Thanks!
> 									Pavel
> 

-- 
Best regards,
Jacek Anaszewski
