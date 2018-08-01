Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663AEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1FC208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJr7IAbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1FC208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389445AbeHAPnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:43:04 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46003 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389272AbeHAPnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:43:04 -0400
Received: by mail-io0-f194.google.com with SMTP id k16-v6so16122315iom.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7P8SKpbqeC5DLfk2NzGeMxtD2qEsr08+ftI8qv47uQM=;
        b=SJr7IAbV9ry/UaJNYkf0VE28MAIYT+gvfIgiqq+8PEf1j1Wqc3PZ5I+3IY2lx+utPm
         zUNDqnWT8hqOdaLVckfL+QjPJ1zQ8ckoQNoNNCByl8ucBGQgKZdEuD6jbItM95r6MwQz
         /f9p+4zBCvcLla4+j0eXjJqa5Iup5S3WEvW6XReMO7nkwaOfIyTZKRhXrFQhDOzZtIM9
         6fu9ztCu0SVeWA66FHuza2yVsfEQjbgN55KE42ywkMbaD6cy3SSHbu6BTMyO1K+Ty5iD
         Tw/UEzbRQVycC9PvtABySfL7Jvd6vPd7MdvmDYkFCpabptnOutIjzWHHIruIdbe9GCd4
         eMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7P8SKpbqeC5DLfk2NzGeMxtD2qEsr08+ftI8qv47uQM=;
        b=Sk5zYXybHWIEInq0v+9GPcppDB6LuVMO3hB2rUAw1aZMkLli7u7AlxFlKVOPsvhG6N
         TpfoQ9lXctAB4mP5wYmjWgyCn2kVwqEJ7AM9+6xYgvFRwnvqUexHTKOGGSLS6zq3z4LM
         XG0ahp8CijMbRoXmKCJdx7S0TpBxXYVv6cNt99k+8thuxncjly6h7a67re2iqOsxp2PO
         UXVyPekR/OuBIBi/in+AXgkBvVW2AUN1CA+IlPL2h1rO9YPd4T2ybF86AVXmnzkf3gqe
         e72qHLh5aNGOcZb79zdZ8rreXMZ9tSLU9ABoNNRO4PeFe7W1sZ6uJiEDdGiXxNashPca
         FE5w==
X-Gm-Message-State: AOUpUlG6Tf+r6QgUo99oJLT+VkPdum9Gqi/nd00/fG61Dn0L1qPxEshV
        cuLVJjOllBNVondm6f+yR1ovhM8UXoA=
X-Google-Smtp-Source: AAOMgpdgYW3oHSxcyVgJUInZJjYk15hTAJcnT1ZWP3zD5r0TJh7rPi1YrhjYn4EMrhiWeRCCKGvrBw==
X-Received: by 2002:a6b:254e:: with SMTP id l75-v6mr3280474iol.47.1533131830231;
        Wed, 01 Aug 2018 06:57:10 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id r13-v6sm5140565ioc.71.2018.08.01.06.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 06:57:09 -0700 (PDT)
Subject: Re: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
To:     Alexei Colin <acolin@isi.edu>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        John Paul Walters <jwalters@isi.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu> <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
 <f2723578-f39d-27ac-b376-0f06905caa67@gmail.com>
 <20180731204656.GC38497@guest228.east.isi.edu>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <89caf5a7-f7cc-ea9b-71ab-038602244a5f@gmail.com>
Date:   Wed, 1 Aug 2018 09:57:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731204656.GC38497@guest228.east.isi.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 04:46 PM, Alexei Colin wrote:
> On Tue, Jul 31, 2018 at 04:29:56PM -0400, Alex Bounine wrote:
... skip
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>>> Cc: John Paul Walters <jwalters@isi.edu>
>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>> Cc: linux-kernel@vger.kernel.org,
>>>>> Signed-off-by: Alexei Colin <acolin@isi.edu>
>>>>> ---
>>>>>    arch/arm64/Kconfig | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> Thanks, this looks much cleaner than before:
>>>>
>>>> Acked-by: Will Deacon <will.deacon@arm.com>
>>>>
>>>> The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
>>>> unconditionally in the arm64 Kconfig. Does selecting only that option
>>>> actually pull in new code to the build?
>>>>
>>> HAS_RAPIDIO option is intended for SOCs that have built in SRIO
>>> controllers, like TI KeyStoneII or FPGAs. Because RapidIO subsystem core
>>> is required during RapidIO port driver initialization, having separate
>>> option allows us to control available build options for RapidIO core and
>>> port driver (bool vs. tristate) and disable module option if port driver
>>> is configured as built-in.
>>
>> I am thinking about where HAS_RAPIDIO option can be set for arm64 branch.
>> Having it set globally is too broad. For example we have Xilinx Zinq US
>> board with SRIO IP on it. Having it globally in arm64 branch - bad. Probably
>> having it set in drivers/soc/... is the best place.
>>
>> Will, Alexei what do you think?
> 
> Since the HAS_RAPIODIO flag adds meta info about SoC, maybe the line
> that 'select's it can go where the rest of the meta info is, which
> differs across architectures:
> * For ARM64, in arch/arm64/Kconfig.platforms under each config ARCH_*
> for each SoC that includes RapidIO.
> * For ARM, in arch/arm/mach-*/Kconfig
> 
> But, if we want the flag to be automatically selected for some larger
> set of ARM64 SoCs without explicitly adding it to each one, then the
> above is not going to do that.
>

Thank you for clarification. I am leaning towards fine control of 
available configuration options, on per-board basis.
As Russell mentioned in some of his comments, RapidIO is relatively rare 
thing to ordinary user. Because of that I would prefer not to pollute 
config menu with selection options unrelated to most of boards supported 
in given arch.

Also it looks like proposed patches introduce minimal changes to the 
generic part of code.

>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>> index a8f0c74e6f7f..5e8cf90505ec 100644
>>>>> --- a/arch/arm64/Kconfig
>>>>> +++ b/arch/arm64/Kconfig
>>>>> @@ -308,6 +308,8 @@ config PCI_SYSCALL
>>>>>    source "drivers/pci/Kconfig"
>>>>> +source "drivers/rapidio/Kconfig"
>>>>> +
>>>>>    endmenu
>>>>>    menu "Kernel Features"
>>>>> -- 
>>>>> 2.18.0
>>>>>
