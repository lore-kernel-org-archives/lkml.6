Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F049BC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9977021655
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ox89KHqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9977021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754308AbeGGRgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 13:36:18 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44437 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754068AbeGGRgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 13:36:17 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so29058083oih.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2llGn4TVPi9P7N9nRUj9MwVVfbyMoOuQdI1lH9Qt2AY=;
        b=ox89KHqx7B2Ks9oqlkWNkV55ouQ02x81H1AOM4inkhF6ZNAHbiapOG97ACYgAkEasb
         tvAqaz6DKgFgECvRKc3etEfRe8yKKZttJP/yQ3CjNCA0t1y8OXkfNH52gC6+1+jRLtFF
         G4TgyWnsWE3mY58HJZlLk7CTZNK6lE2ciiGO0wRipx3vcBrDdAenO4Mq5SalTUTszGEF
         A/rfGM6JSc8qu6zPLGsIvResnktXVXb7Cl7lGnz4nfjLzZXvUAqoIBjbCQPiZ5lZ/BzM
         ZPCvWJMAc3HmEVJjHgWfJNBFmf9odUb6abwip7lcMsYTMyKJ0pG1iIPfGk7HAJuAbn41
         B+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2llGn4TVPi9P7N9nRUj9MwVVfbyMoOuQdI1lH9Qt2AY=;
        b=ZBvGRpDzD7vRgv64xyVUgv4RbA61/Nsi3caADANKHEuv+A51oG26mK7iVw3s0h/EUj
         NSznWjnVrye3T05BzTgp+fGe6L0MTMHt5+ei9qx0a6dk9ZVU5ETvbDfcYQro1ykYr4vW
         ITho4fw/8mZyElI5DAP/wdbgq6hSZ1Ibdsg0HK6Ng9Bv6kevtazqlZdEVY4QaOGO94V8
         +PkZFhhSC7UTjv6836ypQbVCfYME04tOUWIZZhlKljzi2QtFnOCXS7YC493Xn9NF1+X2
         UZUClByGg7MHg1IhoraA1H2/oh14+7Nwp1fZ/wvdeRIXFgXpBShlosZp4hH7NHFu9fJX
         9QZw==
X-Gm-Message-State: APt69E07zSo1D6IUG80TFIu+T3MW0UC7e7mrvECUmFeyq+VsoqRCz5vv
        FVDE/AEjH+qYxf5fwYHTEnhsRAgqU72Sx7tlyd84Hw==
X-Google-Smtp-Source: AAOMgpfe90v8ebdXcsR9JCGoMJly7Do+BjyznVxnn89SeY4LFV5WYxPJ2HP6wXqAzCrSTljpDRtlFHwLrz9qQLWYCrc=
X-Received: by 2002:aca:3954:: with SMTP id g81-v6mr17425012oia.215.1530984976800;
 Sat, 07 Jul 2018 10:36:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 10:36:16 -0700 (PDT)
In-Reply-To: <CAOSf1CFuxga8BAbnvPdZvutgpAxmzgjiqxzHFuVTVLOkMwKO+A@mail.gmail.com>
References: <20180706082911.13405-1-aneesh.kumar@linux.ibm.com>
 <20180706082911.13405-2-aneesh.kumar@linux.ibm.com> <CAPcyv4gjrsswcakSog7jxT+agH7NrBEvwxe9jT0ycU3RZV5sWA@mail.gmail.com>
 <CAOSf1CFuxga8BAbnvPdZvutgpAxmzgjiqxzHFuVTVLOkMwKO+A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 7 Jul 2018 10:36:16 -0700
Message-ID: <CAPcyv4ihixEN9LV6TMqax3Qa2huiPnR-kFyhtO0H51GvGu2C2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/pmem: Add memblock based e820 platform driver
To:     Oliver <oohall@gmail.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 12:15 AM, Oliver <oohall@gmail.com> wrote:
> On Sat, Jul 7, 2018 at 5:38 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>> On Fri, Jul 6, 2018 at 1:29 AM, Aneesh Kumar K.V
>> <aneesh.kumar@linux.ibm.com> wrote:
>>> This patch steal system RAM and use that to emulate pmem device using the
>>> e820 platform driver.
>>>
>>> This adds a new kernel command line 'pmemmap' which takes the format <size[KMG]>
>>> to allocate memory early in the boot. This memory is later registered as
>>> persistent memory range.
>>>
>>> Based on original patch from Oliver OHalloran <oliveroh@au1.ibm.com>
>>>
>>> Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>  drivers/nvdimm/Kconfig        |  13 ++++
>>>  drivers/nvdimm/Makefile       |   1 +
>>>  drivers/nvdimm/memblockpmem.c | 115 ++++++++++++++++++++++++++++++++++
>>>  3 files changed, 129 insertions(+)
>>>  create mode 100644 drivers/nvdimm/memblockpmem.c
>>>
>> [..]
>>> +/*
>>> + * pmemmap=ss[KMG]
>>> + *
>>> + * This is similar to the memremap=offset[KMG]!size[KMG] paramater
>>> + * for adding a legacy pmem range to the e820 map on x86, but it's
>>> + * platform agnostic.
>
>> The current memmap=ss!nn option is a non-stop source of bugs and
>> fragility. The fact that this lets the kernel specify the base address
>> helps, but then this is purely just a debug facility because
>> memmap=ss!nn is there to cover platform firmware implementations that
>> fail to mark a given address range as persistent.
>
>> If this is just for debug, why not use qemu?
>
> To make a long story short, we have two virtualisation stacks and only one of
> them is based on qemu. An unfortunately large chunk of our customers (and
> our internal test systems) run the other one so we need to accommodate them
> somehow.
>
>> If this is not for debug what are these systems that don't have proper firmware
>> support?
>
> I wrote the original version (for RHEL 7.something) for a customer who wanted
> to do some testing which needed to be run on real hardware for some reason.
> We couldn't install a FW update on their system so this ended up being the least
> painful way to get them going. That's not a strong argument for
> merging this, but
> the point is that it's sometimes useful to have the capability in the kernel.

Ok, correct me if I'm wrong, but it seems to be purely about debug and
emulation? If that's the case would it be acceptable to just add more
capabilities to tools/testing/nvdimm/ for what you want to do? That
has been our primary vehicle for testing libnvdimm.
