Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AE2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F46A223AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F46A223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754114AbeGETUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:20:33 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45910 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753844AbeGETUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:20:31 -0400
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so8052998qti.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 12:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9iFPdkpqz6OKKB7zkn4shqcYtK+7CI/1F4tW+6bjexg=;
        b=kd1Ivb+NYaN0CDMTun2yzEr14oeUw8WEFcvP2owLyiEiUQBS/d5i0XgXGDmMJOAB3z
         Mp/O8eZ6HIraW45l9glJfSXRsOoB/ld3B1o+hrQvBgowG+etf3owyuFOGmX5i8GHQ7c0
         3Gq6UHri3Je9lKy3YBl3zXWyq/j0dqOetL1SnFZ4ERY1OkSK6cglgR7GlVCe12jVqRyz
         MBaobvg3FFQjwRXj49Bt2SAUblpZc+9bGGGkgKUfeRnQecmSbdSBqyMz1dSfQeWzuAEt
         nMOgYqyq021goo+M3rLQSNTbzprCTmWvhN6wTD0FT9tKsWLKS2uOvpYIwPoMS4MWPuMI
         nLCw==
X-Gm-Message-State: APt69E0O2VtRROA9L4FvVSwCCrKCNmqnkuVpEPCWE3GFz4fq6mn0XITe
        HgMDeWB5E4lEBwk3GVXsWKt9NA==
X-Google-Smtp-Source: AAOMgpebWAnYFoPeT/IadmUazYvKefFyHB5FO1R0k2k3O8U6u6Z/mv7Gx4kBMiJMVkhV4N5UjR6Bjg==
X-Received: by 2002:aed:3848:: with SMTP id j66-v6mr6618183qte.218.1530818430873;
        Thu, 05 Jul 2018 12:20:30 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::f0c1? ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id h195-v6sm4204024qke.58.2018.07.05.12.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 12:20:29 -0700 (PDT)
Subject: Re: [PATCHv5 1/4] kbuild: Add build salt to the kernel and modules
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-2-labbott@redhat.com>
 <CAK7LNAS7XBwDidNaLKC1wD+G30AyAvTHG5GN=UAiP5zz1EO8JA@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <5e3ce0f4-0c4b-e0aa-2b21-9bf4b5bce9e2@redhat.com>
Date:   Thu, 5 Jul 2018 12:20:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS7XBwDidNaLKC1wD+G30AyAvTHG5GN=UAiP5zz1EO8JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 08:59 PM, Masahiro Yamada wrote:
> Hi.
> 
> Thanks for the update.
> 
> 
> 2018-07-04 8:34 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>>
>> The build id generated from --build-id can be generated in several different
>> ways, with the default being the sha1 on the output of the linked file. For
>> distributions, it can be useful to make sure this ID is unique, even if the
>> actual file contents don't change. The easiest way to do this is to insert
>> a section with some data.
>>
>> Add an ELF note to both the kernel and module which contains some data based
>> off of a config option.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> v5: I used S-o-b here since the majority of the code was written
>> already.
> 
> 
> I think Suggested-by is good enough.
> S-o-b is appended as a patch is passed from people to people.
> 
> Anyway, this looks good except one bike-shed.
> 
>> Please feel free to change the tag if you think it's not
>> appropriate. I also tweaked this to take an ascii string instead of just
>> a hex value since this makes things much easier on the distribution
>> side.
>> ---
> 
> 
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 041f3a022122..8de789f40db9 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -107,6 +107,15 @@ config LOCALVERSION_AUTO
>>
>>            which is done within the script "scripts/setlocalversion".)
>>
>> +config BUILD_SALT
>> +       string "Build ID Salt"
>> +       default "Linux"
> 
> 
> How about empty string ""
> for default?
> 

Sure, seems to work fine.

Thanks,
Laura

