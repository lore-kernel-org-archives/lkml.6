Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC7CC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EC1224F8
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POetnnV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EC1224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeGGHPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:15:12 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38297 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbeGGHPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:15:09 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so9606055itb.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 00:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ST6Z6AJE90k2MgI4FISgb9v1xSFXTsPcwAXKMPrM9dE=;
        b=POetnnV2i7hkR7v3+7Y3PqUUUinrlEscat+47/hhT+1x8KM8qtgtWwpk11FjVpV8Ra
         wPF1G51zmMzmfwQvfqJ7sOgvBEk9n/aZ2XsGMjgQLdctFSTqsaXasn7dwC9yMzuwE2x7
         Jq5WlAEAJxGa91BCXVBvo/jmb9xAUf4iTfrnjgr8oV4OKT1wCeU15kOYXDH7C/D23T6W
         kKubHo6LzwSP3DitB3bg2ewQMRb5U8gmmL6NX/JKOu3UbRu68f41YErz7C/ARYdJXfY8
         gz2hVaaD9zLHgwrIt/wmFe2nSaMXzPJEmqOMqpENxgko9JJkg5M/eLIX01N40IQw8WOZ
         S9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ST6Z6AJE90k2MgI4FISgb9v1xSFXTsPcwAXKMPrM9dE=;
        b=Zy0GEauZretKQAlxquighLUk/z839NAT26do5sfBm5M460RTydrTrjMTa3Wq/mlZkI
         XvPu7TtAh3/UWa/OqiYVBeI4pdQIQTLeVHMtP5S0GkDYDodY26rpgxjhfps8JJkZ3bsO
         jH2lR9Dvytd7a2TRqRdk+NcnFjOmhEbRawN1+JFCZwVVtlpTfUGld8h0LZyHhksB2YHC
         00SDi8SokuQUXGdgwEqDYtDeCf+1iEx6qDKA1IuzCJC8l2CjqvZQrlq3FXAFihFqduZE
         ncdYDcIa2AwuI/iv1BUN81nm3Pn+VA17YnkSImAgarwanZ5IFcRWOeE2t8LqYviMrLzS
         9EqQ==
X-Gm-Message-State: APt69E3SH+M7NKNiEbOkJK5nJ22T3asiY+k3GRSpGQoS/mV+IJEB4MmL
        BIVUe7PaA9y2+gfBJitwJPxs4CN9PGM8LilJZNk=
X-Google-Smtp-Source: AAOMgpfblgAvT8/kjvSogbLNzjx2kdASk5b6Wk6NetwAzk8H5Y36sFgno5eE1+g0RmPBMBy0FPidsVXAKo5YR6hTFfA=
X-Received: by 2002:a24:3d81:: with SMTP id n123-v6mr10863309itn.40.1530947708983;
 Sat, 07 Jul 2018 00:15:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:c3cc:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 00:15:08 -0700 (PDT)
In-Reply-To: <CAPcyv4gjrsswcakSog7jxT+agH7NrBEvwxe9jT0ycU3RZV5sWA@mail.gmail.com>
References: <20180706082911.13405-1-aneesh.kumar@linux.ibm.com>
 <20180706082911.13405-2-aneesh.kumar@linux.ibm.com> <CAPcyv4gjrsswcakSog7jxT+agH7NrBEvwxe9jT0ycU3RZV5sWA@mail.gmail.com>
From:   Oliver <oohall@gmail.com>
Date:   Sat, 7 Jul 2018 17:15:08 +1000
Message-ID: <CAOSf1CFuxga8BAbnvPdZvutgpAxmzgjiqxzHFuVTVLOkMwKO+A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/pmem: Add memblock based e820 platform driver
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 5:38 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Fri, Jul 6, 2018 at 1:29 AM, Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>> This patch steal system RAM and use that to emulate pmem device using the
>> e820 platform driver.
>>
>> This adds a new kernel command line 'pmemmap' which takes the format <size[KMG]>
>> to allocate memory early in the boot. This memory is later registered as
>> persistent memory range.
>>
>> Based on original patch from Oliver OHalloran <oliveroh@au1.ibm.com>
>>
>> Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  drivers/nvdimm/Kconfig        |  13 ++++
>>  drivers/nvdimm/Makefile       |   1 +
>>  drivers/nvdimm/memblockpmem.c | 115 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 129 insertions(+)
>>  create mode 100644 drivers/nvdimm/memblockpmem.c
>>
> [..]
>> +/*
>> + * pmemmap=ss[KMG]
>> + *
>> + * This is similar to the memremap=offset[KMG]!size[KMG] paramater
>> + * for adding a legacy pmem range to the e820 map on x86, but it's
>> + * platform agnostic.

> The current memmap=ss!nn option is a non-stop source of bugs and
> fragility. The fact that this lets the kernel specify the base address
> helps, but then this is purely just a debug facility because
> memmap=ss!nn is there to cover platform firmware implementations that
> fail to mark a given address range as persistent.

> If this is just for debug, why not use qemu?

To make a long story short, we have two virtualisation stacks and only one of
them is based on qemu. An unfortunately large chunk of our customers (and
our internal test systems) run the other one so we need to accommodate them
somehow.

> If this is not for debug what are these systems that don't have proper firmware
> support?

I wrote the original version (for RHEL 7.something) for a customer who wanted
to do some testing which needed to be run on real hardware for some reason.
We couldn't install a FW update on their system so this ended up being the least
painful way to get them going. That's not a strong argument for
merging this, but
the point is that it's sometimes useful to have the capability in the kernel.

Oliver
