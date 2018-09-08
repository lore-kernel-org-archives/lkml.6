Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4F7C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6C920855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtDar8su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6C920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeIIBGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:06:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39695 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeIIBGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:06:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so17674315wmq.4;
        Sat, 08 Sep 2018 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZNJmlwFylUMaTOqdlmwF6kXUG0vTUL6zYGWJBwTic3A=;
        b=PtDar8sui22s+uQUAK1jdbpIPNAy0Z9CHSGj1jTgft/FsuhciU2eaefXKjkGE5JVXi
         FavXUMDvZX/pXLhn7EKpjuNdnrVCCcGkSZ5Xv6ApcsxihfdqSQBQr8uEL7jK8vhvoYhT
         WDnj9q8QyCTEKbL7NaBiRlRRxarQHrzYBaXtOl0r/kS4gKTy6HmpfSqxBvQZcFH3Sibi
         bsNBvgaw7wcqAg0/VHBhIZMQuqSUMyybDYo94izRMjfub2y1yRwt/tTyyiNjV/WdPCax
         2zPAijfHrRehugIWhTrS65xvSXQYN37zYfRAgiOoFUnQKG7hxrqjh7hyMrR42BCnu2+T
         OQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZNJmlwFylUMaTOqdlmwF6kXUG0vTUL6zYGWJBwTic3A=;
        b=oVuPkj9y1m+kHHOkjW0uwqh9mcevkA1N9Iq/jjbfPG6gv/UoZ0RRAyoraisIvKI1Zb
         G97M6hJ/sxKzn7D7gbju/q5ItzXJkkxDxw8a5Faf6xwnVjR9f3HGTHBbRucWJ9VTjv0I
         Y7hOWQ9geF4rVwFGL4gmYNPY9kpTIBwr5OUWKENHQSwdZFgNwoOJ6xX02c08Sxtno1nW
         cy132oV696RH5zqfnCL1YX/AUQJ98PeXZmuPvO20sfksrD4g5RmJ49wB5COL42UMy/N1
         qTLzFSpZUNF4TnNqNfxXLvlhTSoaOe39Y1LW+YE1+yQZUA9PgfsMlehUxONpgXwp/H/U
         wK7g==
X-Gm-Message-State: APzg51B9Wm56HBqsFiOJ7QzZjlA8TfJTYisXjgLNVZ9Wa0zDrT1HV7Zd
        jjRLmhU8IKAjOypA20R7wbU5Tcy+
X-Google-Smtp-Source: ANB0VdaDKTiOJkgkpfKCKNOYyzKGY5h2PVLS5R7nCLkh9R7AeuP1bIfAPojzlJAN5JSIrSV01pIPoQ==
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr8208804wmq.36.1536437955039;
        Sat, 08 Sep 2018 13:19:15 -0700 (PDT)
Received: from [192.168.1.18] (civ14.neoplus.adsl.tpnet.pl. [83.31.45.14])
        by smtp.gmail.com with ESMTPSA id 14-v6sm18877146wmp.32.2018.09.08.13.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 13:19:13 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v8 1/2] leds: core: Introduce LED pattern trigger
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     pavel@ucw.cz, rteysseyre@gmail.com, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <20180908050208.GY2523@minitux>
Message-ID: <0190dc10-99a3-abb7-b196-a537c49a2b6e@gmail.com>
Date:   Sat, 8 Sep 2018 22:19:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180908050208.GY2523@minitux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 09/08/2018 07:02 AM, Bjorn Andersson wrote:
> On Tue 04 Sep 04:01 PDT 2018, Baolin Wang wrote:
> 
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> [..]
>> +What:		/sys/class/leds/<led>/hw_pattern
>> +Date:		September 2018
>> +KernelVersion:	4.20
>> +Description:
>> +		Specify a hardware pattern for the LED, for LED hardware that
>> +		supports autonomously controlling brightness over time, according
>> +		to some preprogrammed hardware patterns.
>> +
>> +		Since different LED hardware can have different semantics of
>> +		hardware patterns, each driver is expected to provide its own
>> +		description for the hardware patterns in their ABI documentation
>> +		file.
>> +
> 
> So, after a full circle we're back at drivers with support for hardware
> patterns should have their own ABI for setting that pattern.
> 
> The controls for my hardware is:
> * a list of brightness values
> * the rate of the pattern
> * a flag to indicate that the pattern should be played from start
>   to end, end to start or start to end to start
> * a boolean indicating if the pattern should be played once or repeated
>   indefinitely.
> 
> Given that the interface now is hw specific, what benefit is there to
> attempt to cram these 4 knobs into "hw_pattern"? Or am I allowed to
> create additional files for the latter three?

So this is an argument corroborating my concerns raised in [0].
I really think that we should allow for custom pattern interfaces
defined by LED class drivers.

>> +What:		/sys/class/leds/<led>/repeat
>> +Date:		September 2018
>> +KernelVersion:	4.20
>> +Description:
>> +		Specify a pattern repeat number. 0 means repeat indefinitely.
>> +
>> +		This file will always return the originally written repeat
>> +		number.
> 
> I'm still convinced that this will confuse our users and to me it would
> be more logical if this denotes the number of times the pattern should
> be repeated, with e.g. negative numbers denoting infinite.

Sounds reasonable. Let's change this semantics as you propose.

> In particular I expect to have to explain why my driver expects that you
> write 0 in the file named "repeat" to make it repeat and 1 to make it
> not repeat.



[0] https://lkml.org/lkml/2018/9/3/1192

-- 
Best regards,
Jacek Anaszewski
