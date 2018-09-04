Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB6EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B792077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5XAJlyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B792077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeIEAEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:04:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40744 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIEAEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:04:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id x26-v6so3960549lfi.7;
        Tue, 04 Sep 2018 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tsqbdi1m3Y1Bx8nuEk1g2u0F7fj06JUZlvnFtG7xWMM=;
        b=u5XAJlyWW2tvvqN9f9XsczJaAvViBlBbxsriRbsgPpLG/Us9irmjQI2UXNTLo5S2g7
         pwXmOp35gEVMs04mNPpYpFl5PiHH31nbu8Vzozru55dJ0xRHCro6UH5sZ1qX8QjEQpoD
         5x8MSm+kTzI/mHz28rUQsvxiEoL4sGkIfE5vIniPV1ks2W3f0QNId1FncLnMoUHfKAOC
         XOnfVQSLfoJHM6d4Uir+SKM0KG2NOXTbKuzkBfryHtzh/i2VceAfuCNY/dJ8ZV7k69D9
         bQUKGSM0X+Tx2IL8gjBEq9YvNOb7Az/g2W7KgOfXYHnRorL+DIOTlC7Hh4/McxNNtbxW
         LN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tsqbdi1m3Y1Bx8nuEk1g2u0F7fj06JUZlvnFtG7xWMM=;
        b=JLjUZPA89e6QJxP1Dmg83lMcuWqgRgyRb3GOujg3FFfSmJYlgl8+IruXX2cKEA3Yyq
         p/jtja6ZbqbJnpeUeI97fqcAvlxvP068KwB4VRhi0jpKTHQSTWvT2Mq15wj3YOvQfVqJ
         lC/Ci3sEcqUxG7RxykajPvHy45lG+G0XwTRv3I7SgEAXNdI/4fXBELuzyyaPIPsWwEdn
         CValuJF4dLeOdPANfCcdnG1Bim5BL8soucjuA1uumXOpzaBErN2gKu2DgrBynuYD0R92
         4+Y5YvQupBHo29BPQglLtfyTQ/Emc+fMmq9yxr6q3G9g1oO8DaqmhuGIZygAUJ+L3vFE
         hMyw==
X-Gm-Message-State: APzg51CxpKuwFiox/Inm7ScNMmOHBjcQqUXnkhqTlIio9L/atCs8KNcc
        D7VV29QI4Q9ijSD2el8T8u0c8JEq
X-Google-Smtp-Source: ANB0VdYaX2N3Sp4lneh1wyvkc/UuF0uIdfGL3NBPcXCnwzKcpji9P1fIYtdH4EFPJr7vl2gveV7J3g==
X-Received: by 2002:a19:c20f:: with SMTP id l15-v6mr22618712lfc.21.1536089897375;
        Tue, 04 Sep 2018 12:38:17 -0700 (PDT)
Received: from [192.168.1.18] (bgs148.neoplus.adsl.tpnet.pl. [83.28.82.148])
        by smtp.gmail.com with ESMTPSA id t14-v6sm4186257ljg.17.2018.09.04.12.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:38:16 -0700 (PDT)
Subject: Re: [PATCH v7 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     bjorn.andersson@linaro.org, Baolin Wang <baolin.wang@linaro.org>,
        rteysseyre@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e6d4e7be537a4e4d6fce26c6d446703b1910eab9.1535700092.git.baolin.wang@linaro.org>
 <ef266d4a-ba0e-cba6-ae30-ebbf730e28a2@gmail.com> <20180903215323.GA21489@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <e6cf7c2d-917a-b05f-178c-012c6b4161cf@gmail.com>
Date:   Tue, 4 Sep 2018 21:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903215323.GA21489@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2018 11:53 PM, Pavel Machek wrote:
> Hi!
> 
>>> +static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
>>> +{
>>> +	struct pattern_trig_data *data = led_cdev->trigger_data;
>>> +
>>> +	if (!data->npatterns)
>>> +		return 0;
>>> +
>>> +	if (data->is_hw_pattern) {
>>> +		return led_cdev->pattern_set(led_cdev, data->patterns,
>>> +					     data->npatterns, data->repeat);
>>> +	}
>>
>> I have doubts here if it is a good idea to enforce array of tuples
>> as a generic interface for all hw_patterns. It may not fit well for
>> every hw pattern engine. It seems that the only feasible solution will
>> be allowing drivers to come up with their own interfaces, i.e. the
>> approach you proposed at first for your driver. It seems that the
>> ledtrig-pattern with software pattern mechanism will be just
>> a nice side effect of this series :-)
>>
>> Unless someone will propose a better solution.
> 
> I believe array of tuples will work for everyone. It is just a LED, it
> can change intensity over time.

We have an example of different semantics in case of hw pattern
for leds-sc27xx-bltc.c, from this patch set.

Proposed hw_pattern ABI documentation:

+What:		/sys/class/leds/<led>/hw_pattern
+Date:		September 2018
+KernelVersion:	4.20
+Description:
+		Specify a hardware pattern for the SC27XX LED. For the SC27XX
+		LED controller, it only supports 4 hardware patterns to configure
+		the low time, rise time, high time and fall time for the breathing
+		mode, and each stage duration unit is 125ms. So the format of
+		the hardware pattern values should be:
+		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
+		duration_3 brightness_4 duration_4".

In this case low time and high time can be easily described with
use of the proposed [brightness delta_t] tuples. It is not equally
obvious in case of rise time and fall time.

I can imagine hw pattern that would require defining blink rate
over period of time, or blink rate during rise/fall time - in the
latter case we would have odd number of pattern components. Probably
it wouldn't be a big deal, we'd need one "padding" value, but still
there's room for improvement IMHO.

>> We need a broader consensus here. I'd like to hear Pavel's opinion,
>> since he's been always in favor of common pattern interface, and
>> inspired this work.
> 
> I believe Baolin did good work here. I believe it will cover most, if
> not all, hardware engines out there. I think we should merge it, and
> see what happens -- it should be good enough.
> 
> (Yes, there's still more work to do, but that will be stuff like RGB
> LED synchronization.)
> 
> (And yes, one of the LED chip has pattern engine that can compute
> prime numbers on its own. I don't expect to support
> _that_. Fortunately, nobody but me is likely to want that pattern, so
> we are still okay :-) 
> 
> https://gitlab.com/tui/tui/blob/master/ofone/tests.notcc/primes.nc
> 
> )
> 									Pavel
> 

-- 
Best regards,
Jacek Anaszewski
