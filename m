Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C29EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D582C23E7C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="0S8u4lzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D582C23E7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754124AbeGFQHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:07:01 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38282 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754001AbeGFQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:07:00 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so24420662oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jiQsadDyACdhjt8cBL3/fIVEmhSbTJeCha6CZ1fLEEM=;
        b=0S8u4lztf+O3/gMnhUVpZwU15lorf3HKBB7YGVQnQkSWGHzUQwHK8D+OpAnStMiTTz
         ZRw1JVDzClTVl+4ypXmZ78ZTQ1o8ml5dlvXhCODIF7QsRCvphW+h1kR3AmHvPwUU1Mp5
         pa5oYSONlejJF9YhOunp5qhR6RbaZmusnBQKg+6qrLdg2SbMhysINh8wMlh4xbZZU9Ma
         JhUwZMZSMFSCpVzLGAdWho6I4zfsdRbeW1/juGZ7Cc5c+SDJ+G3ko8KBoY9Fda8szbSk
         pqYd6FBUZWytSZftpsD7P2+PyAO10fyvTGVkG68ZDDZc7LLYdn/OTTh3LMXgLIniotVS
         LC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jiQsadDyACdhjt8cBL3/fIVEmhSbTJeCha6CZ1fLEEM=;
        b=Sc87VKD1Jb6VoaIF02yNGkzBzVkSN4EcqzvRu2gHyBOHAETyNm8toDhBa7xPXcYGPT
         NkDGREF3xQQFeHEK1shga1hSD3KTH0W1Tge1uNnTtPJIOyCvwwM2B/vD5pMP5w3BVjAP
         2fm7F7+h2f2qYIyg6OGdsHpgstYktB0ETFMcLiniKKZHES7hJAwTYtE33fi6PqQwAdi7
         v5+m/W+SMn5WbesRF58QjMACtupzXhqt5VZi0W7v/r8atvSpg7tmlukLp98wN4GS2mYD
         DG+CC8Cj74HQMXf3MQ4dPTRvddqN8MU1mdQ80TPbltQ+XOSd7kJdoSRsOV18iiXpsKwb
         ff2w==
X-Gm-Message-State: APt69E3MJHe6RCWZwhn4TdjPmbW8u6kAdv6Y0kE4dXjx90oOnhgqtjAt
        83/FdaHZG4hrGKxiu8dX4NuCgCdq+DaVkcOcDLcRHA==
X-Google-Smtp-Source: AAOMgpeXBsXUa8RLuW7c7J3UcP/uYFps/EZTgDsCveuZGdtohWKmH24mCE6AjTPko7C7CakICPzH6rTZI0P9vnl+2MQ=
X-Received: by 2002:aca:745:: with SMTP id 66-v6mr11408891oih.295.1530893219890;
 Fri, 06 Jul 2018 09:06:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 09:06:59 -0700 (PDT)
In-Reply-To: <20180706100310.GB3483@gmail.com>
References: <153065162801.12250.4860144566061573514.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180705082435.GA29656@gmail.com> <CAPcyv4hw1a8+wwTYaQ0G0jWQzBCDaZ8zxYXw6gXtuWBYGX1LeQ@mail.gmail.com>
 <20180706100310.GB3483@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 6 Jul 2018 09:06:59 -0700
Message-ID: <CAPcyv4gTVr7wiN5t4wUsqoWYpNajjj=77SEHC0Ew_gw0eDs93Q@mail.gmail.com>
Subject: Re: [PATCH] x86/numa_emulation: Fix uniform size build failure
To:     Ingo Molnar <mingo@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        kbuild test robot <lkp@intel.com>, X86 ML <x86@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 3:03 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Dan Williams <dan.j.williams@intel.com> wrote:
>
>> > config attached.
>
> Doh, I intended to attach the config - attached now.
>
>> > These numa_emulation changes are a bit of a trainwreck - I'm removing both
>> > num_emulation commits from -tip for now, could you please resubmit a fixed/tested
>> > combo version?
>>
>> So I squashed the fix and let the 0day robot chew on it all day with no reports
>> as of yet. I just recompiled it here and am not seeing the link failure, can you
>> send me the details of the kernel config + gcc version that is failing?
>
> My guess: it's some weird Kconfig combination in this 32-bit config.
>
> Can you reproduce it with this config?

Yup, got it, thanks!

Turning on debuginfo I get:

arch/x86/mm/numa_emulation.o: In function `split_nodes_size_interleave_uniform':
arch/x86/mm/numa_emulation.c:257: undefined reference to `__udivdi3'

Previously we were dividing by a power-of-2 constant MAX_NUM_NODES,
and I believe in my builds the compiler was still deducing the
constant from the "nr_nodes = MAX_NUM_NODES" assignment. Fix inbound,
and I believe it will make it even clearer the difference between the
typical split and the new uniform split capability.
