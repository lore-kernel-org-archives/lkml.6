Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7B5C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 12:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C819B214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 12:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0A8wGUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C819B214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeIWSXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 14:23:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41458 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeIWSXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 14:23:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id j15-v6so12895229wrt.8;
        Sun, 23 Sep 2018 05:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LDspJhMOAlGKyJ9NWxEIyCGnp1hXIbBRmHINJQZiN1Q=;
        b=N0A8wGUKBTyIJFR0hCPZvjpvZkHdAOJ8tOSK8qw4xFxiH3DvL0lH2iX92tYuPK4y/A
         KHAx9HyZbuOqWLtXpuDSozjKI+fA+JjTqepWbYFP/fuuF51ucCgJrw2kletteKsjmObD
         ZyZX6J39RzXmg7CoPPaJrKdVWGMFEmOhcArx4KxgUwzMUEFm9YxwbgB46+CfkDI/4dUj
         OIJrnYk55CnPCwvDNkB1ojbzI2YuKAtHiTDWgU69TDKvlHIiA56JiCuabRA2vR++YdNA
         kHDPIFhaMkhjGazRasuNmjiVmCqBVKnNI92mYybDVIQaEI7JPmSBrr2tW6LRaL9Klbau
         JY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LDspJhMOAlGKyJ9NWxEIyCGnp1hXIbBRmHINJQZiN1Q=;
        b=REHMiO5vn+qziOdthYJSjJiYNI8y81qy6coIvtXLXzW69UiYYTbiIvRAXdTQ5zVgIx
         2ORiuzctDW3wRql4RpH3E9zBFMlIPeGEUVm9PuhHuVvLIF34XQ/Yk4O5EgfdlK3VRJTS
         hvSUuyUKDUS8Alr8s0YJ7idGIMwlXZqmds3Xoz2p/bEpPwzXK278ipEHUKVewhwALB3y
         gecsdh3rISnC9vdmdt8enji2oU2VmnA1KQVNfMW3EOvOnFbAYyOWSn/n3eTyXYXOgI5o
         VCiitflAF3QbFXBMl4JvE3tvCv1baJCzeihI+XzeLlafv8/UTxavhKPvIgmeRsxHJyTi
         F/Qw==
X-Gm-Message-State: ABuFfoh7uKh5f0DHJrYKtIOhpqi7mmIM8R5U2UUov+/zBcimKhjdR3IF
        1OWN38yUjjktzHlTaB+d2vJTXJiu
X-Google-Smtp-Source: ACcGV62lNsNUS5zYVDgAE/u/nYgKNHkLzr6IQwCYNA3pll45yPVr9UtfuPxElcebEm8rXjWZFVzJEA==
X-Received: by 2002:a5d:554b:: with SMTP id g11-v6mr5137747wrw.228.1537705542529;
        Sun, 23 Sep 2018 05:25:42 -0700 (PDT)
Received: from [192.168.1.18] (bkw28.neoplus.adsl.tpnet.pl. [83.28.190.28])
        by smtp.gmail.com with ESMTPSA id l12-v6sm28236429wrv.29.2018.09.23.05.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 05:25:41 -0700 (PDT)
Subject: Re: [PATCH v12 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>, Baolin Wang <baolin.wang@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     rteysseyre@gmail.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
 <CAMz4kuJx9twJ=wM5qsucV3JH_VS-AC1aWMqpQOwAMkCuKBHLRg@mail.gmail.com>
 <324778a9-a32c-ae6e-337a-39845f214bfc@gmail.com> <20180921211758.GC18062@amd>
 <ccac8e5f-e122-9f7d-aa43-fa89c79cb1fe@gmail.com> <20180921221813.GA20355@amd>
 <20180922194451.GA27826@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <470f4037-b682-73f8-8063-b4d7a70e04bc@gmail.com>
Date:   Sun, 23 Sep 2018 14:25:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180922194451.GA27826@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/2018 09:44 PM, Pavel Machek wrote:
> On Sat 2018-09-22 00:18:13, Pavel Machek wrote:
>> On Sat 2018-09-22 00:11:29, Jacek Anaszewski wrote:
>>> On 09/21/2018 11:17 PM, Pavel Machek wrote:
>>>> On Fri 2018-09-21 22:59:40, Jacek Anaszewski wrote:
>>>>> Hi Baolin,
>>>>>
>>>>> On 09/21/2018 05:31 AM, Baolin Wang wrote:
>>>>>> Hi Jacek and Pavel,
>>>>>>
>>>>>> On 11 September 2018 at 10:47, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>>>>> This patch adds one new led trigger that LED device can configure
>>>>>>> the software or hardware pattern and trigger it.
>>>>>>>
>>>>>>> Consumers can write 'pattern' file to enable the software pattern
>>>>>>> which alters the brightness for the specified duration with one
>>>>>>> software timer.
>>>>>>>
>>>>>>> Moreover consumers can write 'hw_pattern' file to enable the hardware
>>>>>>> pattern for some LED controllers which can autonomously control
>>>>>>> brightness over time, according to some preprogrammed hardware
>>>>>>> patterns.
>>>>>>>
>>>>>>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>>
>>>>>> Do you have any comments for the v12 patch set? Thanks.
>>>>>
>>>>> We will probably have to remove hw_pattern from ledtrig-pattern
>>>>> since we are unable to come up with generic interface for it.
>>>>> Unless thread [0] will end up with some brilliant ideas. So far
>>>>> we're waiting for Pavel's reply.
>>>>>
>>>>> [0] https://lkml.org/lkml/2018/9/13/1216
>>>>
>>>> To paint a picture:
>>>>
>>>> brightness
>>>>
>>>>    rise hold          lower       hold down
>>>>   ^    XXXXXXXXXXXXXXX
>>>>   |   X               XX
>>>>   |  X                  XX
>>>>   | X                     XXXXXXXXXXXXXXXXXXXXXXXXXX
>>>>   +-------------------------------------------------------> time
>>>>
>>>> This is what Baolin's hardware can do, right?
>>>>
>>>> This is also what pattern trigger can do, right?
>>>>
>>>> So all we need to do is match the two interfaces, so that hw_pattern
>>>> returns -EINVAL on patterns hardware can not actually do.
>>>>
>>>> I believe I described code to do that in [0] above.
>>>
>>> You said that we should get the same effect by writing the
>>> same series of tuples to either pattern or hw_pattern file.
>>>
>>> Below command consists of four tuples (marked with brackets
>>> to highlight), and it will activate breathing mode in Baolin's
>>> hw_pattern:
>>>
>>> "[0 rise_duration] [brightness high_duration] [brightness fall_duration]
>>> [0   low_duration]"
>>>
>>> Now, I can't see how these four tuples could force the software
>>> fallback to produce breathing effect you depicted.
>>
>> I really should get some sleep now. But my intention was that software
>> fallback produces just that with those four tuples. (If it does not,
>> we can fix the software fallback to do just that).
> 
> And you are right, v12 1/2 seems to do the wrong thing.
> 
> My "brilliant idea" is to something closer to the original version I
> posted here. I'm attaching it for reference.
> 
> I'm also attaching the original documentation. It was clearly designed
> to do smooth transitions, too. (But pattern is written in slightly
> different way there, AFAICT).
> 
> Clearly, having same semantics for pattern and hw_pattern is possible.

Thank you for the attachment. The documentation part makes everything
clear. Comparing the patch from the attachment and the Baolin's patch
there is one vital part missing, from the original
pattern_trig_update():

if (data->next->brightness == data->curr->brightness) {
[...]
} else {
	/* Gradual dimming */
	led_set_brightness(data->led_cdev, compute_brightness(data));
	data->delta_t += UPDATE_INTERVAL;
	mod_timer(&data->timer, jiffies
		+ msecs_to_jiffies(UPDATE_INTERVAL));
}

And the compute_brightness() implementation:

static int compute_brightness(struct pattern_trig_data *data)
{
	if (data->delta_t == 0)
		return data->curr->brightness;

	if (data->curr->delta_t == 0)
		return data->next->brightness;

	return data->curr->brightness + data->delta_t
		* (data->next->brightness - data->curr->brightness)
		/ data->curr->delta_t;
}

With the above the linear gradual dimming is indeed feasible.
And for non-linear dimming like breathing mode the hw_pattern will do.

There is also vital discrepancy between the documentation and the
proposed ledtrig-pattern implementation. The doc says:

"Duration of 0 means brightness should immediately change to new value"

This syntax seems to be not supported in the Baolin's patch.

With all the above covered we will be almost there.

Now, only the issues raised by Bjorn need a clarification:

On 09/08/2018 07:02 AM, Bjorn Andersson wrote:
[...]
> The controls for my hardware is:
> * a list of brightness values
> * the rate of the pattern

The two can be described using [brightness delta_t] tuples.

> * a flag to indicate that the pattern should be played from start
>   to end, end to start or start to end to start

As above, but the tuples would have to be suitably arranged.

We won't need any specific flag to indicate how the pattern
should be played, but instead explicitly give the tuples in the
required order. For the start-end-start case the sequence of tuples
will need to be tripled, but the middle part should be put in the
reverse order.

> * a boolean indicating if the pattern should be played once or repeated
>   indefinitely.

We will have "repeat" file for that.

Baolin, would you mind adding the support for gradual dimming to your
ledtrig-timer.c implementation?

-- 
Best regards,
Jacek Anaszewski
