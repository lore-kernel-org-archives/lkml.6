Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BDAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A15D20818
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MzzzTO3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A15D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeKJPWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:22:31 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:44351 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeKJPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:22:30 -0500
Received: by mail-pl1-f180.google.com with SMTP id s5-v6so1863091plq.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 21:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=A3/1sFXQUOL8UOKDGcWLhA0s/DfcT8HNWuJiRW9U6C4=;
        b=MzzzTO3u4wJK+ojMryhq648tL9PYuTe0Vmr4GGhSJMd/SJWnue+d1k9RdQc1KuWevA
         yrh6hbbQi/cmRsCyA09vVDg7ztup7L6ih0wcEYRrBjlIiTWKXS3KU4/s7F6QSKgX0v9Y
         RRSMbWxvqMDmCT3HLGqCrqaAAhvu0gd0mCriGpGr1v/iqhOzsFq2MD6SGn2JSAk8Yyye
         bk8SrpN9GN52i3aKrfeCcW7k7Yr8yOhm1RAOYSyihYeVxTQjaXtgdHmYXGqK3AkaFfYn
         B65QSOJLQ3SIzrcUnwQ6aMy0i8/6UJIWCq4GMItI47z1sP185VN4V9hhznMZzzIPyEBj
         d1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A3/1sFXQUOL8UOKDGcWLhA0s/DfcT8HNWuJiRW9U6C4=;
        b=NP88ah4vpwEP+FtQJquhssuVp11xrFyxGp66HCJe07rVNn5kEsOLBJwUU/MfFgZyQ1
         4uib9Dpms75lBU8zHxwW8qr324V5p5aufNdWrByGN6bfyi4IY3lnlSfDlWU01wkiEioG
         yk5mkgKxHY9BCbEhHFCi4mzDx98JkZkhMopbLYYTacP0vrDRd8Ke6dUca9AO6AowPLzB
         rEUKPpr598twEe0F+KBI0Q5uC/UFykGHmr7DtxZNV8D2Lsv9NHts5f/Eo/dEL/66M/9P
         A3Ugf+M9zsS7Sp/WUHbru778foZjHQcEnQPf6qI0GZe98PmbLTiTrzdWOTiJkW4X784o
         ZluA==
X-Gm-Message-State: AGRZ1gItqXJAwAuRWg1jyCi3tklYfxwCm6qXhD+Y9p3GKDZ70bAx5q3/
        8oW4oFXmlTSaUrVUwKALFbCewg==
X-Google-Smtp-Source: AJdET5dKuTUxsok2kKvt1YZIN1xFRiD6prEycwQ6RmO67NhjCUEq1Q9QjwjZL08KL9MOehwHaXz1qw==
X-Received: by 2002:a17:902:64c1:: with SMTP id y1-v6mr11794125pli.210.1541828325610;
        Fri, 09 Nov 2018 21:38:45 -0800 (PST)
Received: from [10.17.0.26] ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h128-v6sm9753006pfb.52.2018.11.09.21.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:38:45 -0800 (PST)
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Wesley Terpstra <wesley@sifive.com>, linus.walleij@linaro.org,
        palmer@sifive.com, linux-kernel@vger.kernel.org, hch@infradead.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo> <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
 <20181016110142.GC8852@ulmo>
 <6e108e3c-15c1-b13b-ac3e-60c5eb209c7b@sifive.com>
 <20181016220437.GB31973@mithrandir>
From:   Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <e4e80da0-103b-1812-3478-8331e867a914@sifive.com>
Date:   Fri, 9 Nov 2018 21:38:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181016220437.GB31973@mithrandir>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/16/18 3:04 PM, Thierry Reding wrote:
> On Tue, Oct 16, 2018 at 10:31:42AM -0700, Paul Walmsley wrote:
>> On 10/16/18 4:01 AM, Thierry Reding wrote:
>>> On Mon, Oct 15, 2018 at 03:57:35PM -0700, Atish Patra wrote:
>>>> On 10/10/18 6:49 AM, Thierry Reding wrote:
>>>>> On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
>>>>>> +Required properties:
>>>>>> +- compatible: should be one of
>>>>>> +	"sifive,fu540-c000-pwm0","sifive,pwm0".
>>>>> What's the '0' in here? A version number?
>>>>>
>>>> I think yes. Since fu540 is the first Linux capable RISC-V core, SiFive Guys
>>>> decided mark it as version 0.
>>>>
>>>> @Wesly: Please correct me if I am wrong.
>>> It seems fairly superfluous to me to have a version number in additon to
>>> the fu540-c000, which already seems to be the core plus some sort of
>>> part number. Do you really expect there to be any changes in the SoC
>>> that would require a different compatible string at this point? If the
>>> SoC has taped out, how will you ever get a different version of the PWM
>>> IP in it?
>>>
>>> I would expect any improvements or changes to the PWM IP to show up in a
>>> different SoC generation, at which point it would be something like
>>> "sifive,fu640-c000" maybe, or perhaps "sifive,fu540-d000", or whatever
>>> the numbering is.
>>
>> The "0" suffix refers to a revision number for the underlying PWM IP block.
>>
>> It's certainly important to keep that version number on the "sifive,pwm0"
>> compatible string that doesn't have the chip name associated with it.
> Isn't the hardware identified by "sifive,pwm0" and "sifive,fu540-c000"
> effectively identical? 


The intention was that the "sifive,pwm0" compatible string specifies a
register interface and programming model that the IP block exposes to
the software, rather than a particular underlying hardware
implementation.  That is in contrast to a string like
"sifive,fu540-c000-pwm" which might activate particular workarounds or
quirks that are specific to the integration of the IP block on a given SoC.


The idea is that, for this and similar open-source hardware IP blocks,
the driver code can just match on a generic "sifive,pwm0" compatible
string.  The SoC DT data would include both the SoC-specific
"sifive,fu540-c000-pwm0" and the common interface "sifive,pwm0".  But
the driver would only need the SoC-specific compatible string if the SoC
wound up needing some SoC-specific quirks.


In the past, some folks have had a problem with that idea, since for
closed-source IP blocks, it's been difficult to determine what changes
went into a specific version of the IP block.  Thus folks generating
data for later SoCs usually specify a compatible string for another,
older, SoC that seems to have the desired behavior.  But since this
particular IP block has open-source RTL, and contains a "sifive,pwmX"
version string in the RTL itself:


https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/pwm/PWM.scala#L74


... it's straightforward to see what interface the hardware exposes to
the software for a given compatible string.


> Is there a need to have two compatible strings
> that refer to the exact same hardware?


There's no intention that "sifive,pwm0" and "sifive,fu540-c000-pwm0"
refer to the same hardware; just the same software interface and
programming model.  Even now, it's usually pretty unlikely that two
different SoCs that refer to (say) "nvidia,tegra20-pwm" contain the same
hardware, since differences in synthesis, place and route, ECOs, and
integration change the actual realization of the hardware.  Some folks
interpreted that compatible string reuse as implying the same "hardware"
is in use on both SoCs, but we're really just identifying a software
interface.


>> As to whether there could ever be a FU540-C000 part with different IP block
>> versions on it: FU540-C000 is ultimately a marketing name.  While
>> theoretically we shouldn't have another "FU540-C000" chip with different
>> peripheral IP block versions on it, I don't think any engineer can guarantee
>> that it won't happen.
> I would argue that if at some point there was indeed a chip with the
> same name but a different IP block version in it, we can figure out what
> to call it. Sure there are no guarantees, but it's still fairly unlikely
> in my opinion, so I personally wouldn't worry about this up front.
>
> Anyway, I don't feel strongly either way, I'm just pointing out that
> this is somewhat unusual. If you want to keep it, feel free to.


Thanks for the review, Thierry -


- Paul

