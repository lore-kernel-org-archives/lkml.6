Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6B8C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF462409C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JjIrTTMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF462409C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753820AbeGFC44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 22:56:56 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43754 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753715AbeGFCzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 22:55:41 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so20744574oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5t6Xki4reh3NuZZvUyEjcudQC6NRSH5ccmaxBY0JQAQ=;
        b=JjIrTTMxiRqjU51qlBbLxj12EGMovvuYX9TG8y7nowhzbWoi/4NXRyPQ9iBTqk1pyk
         Ld27wjRQkOuOxpMOvhqDU2+gwJlgvZ5EyJtSWd2jhe/5FOqDjOx5FsK01NdKvSPsEmHG
         p06H/cRC6L3/nulUrUY64c8t+GCPak7GHf9rHPi8UpvfvGahaJi239rwsWOzCSVKZWVI
         YrAPyVWWxCBx+nDmuxS68eMR3JjeNTWl9/EhKk4x4i+sT/bAvkpNaptriDuhwnNfPX6s
         LO0XDTkexZuQHHKiWZ4uTgFh4OWd5WjuWro5vF+YU+2JeKcKZc1aDD831z92gditLKXT
         9Kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5t6Xki4reh3NuZZvUyEjcudQC6NRSH5ccmaxBY0JQAQ=;
        b=VoH7f3j4HwG8LKJg9tlTjqY4so6Kjybybs2YY8JpCDwpEwYeVEKhPVQ7bk2sdM8KwK
         VDew3tqd1ghA5YDlDD10ossgePmY+19HRVnYJV4+aa4eE1v5gjANG1MJe8xYr/T1emeH
         tBA+RhUoGGqhGB5aeAPenPIUnMUrz3sSWkpDhWtHp2XKkEsVXoONCtYb1brk7n4DnqXw
         avZkXKmvUL9/gHntboMNpu4vvZN6YUbWg6wfusCV2avMWxAYhfPAieXYDTpzjONiqLdr
         JST1DKrphPbwGROOhh4J6fItKpc2Qal5GQr833rk7yaiGmxYoMWj5ldryaMyABWY6sp0
         DPJQ==
X-Gm-Message-State: APt69E2Ga49m1pMqsX5I3kptL6sVTqp9ym5r0wz3Im9d3Ku+RZdlAp5H
        ySXdARLhUvcnS+9UigE1yPaPMhZEmo+z/mun+WUt6g==
X-Google-Smtp-Source: AAOMgpcnXNlyKcKI5Kh1VnLkOhbR8693M3rQWYvqL2iu7CEW/B5PQc7GoXsRzaMyBmlcQZ9xHZur+N5xVed6QO47ZBg=
X-Received: by 2002:aca:3954:: with SMTP id g81-v6mr10141446oia.215.1530845740514;
 Thu, 05 Jul 2018 19:55:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 19:55:40 -0700 (PDT)
In-Reply-To: <20180705082435.GA29656@gmail.com>
References: <153065162801.12250.4860144566061573514.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180705082435.GA29656@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 5 Jul 2018 19:55:40 -0700
Message-ID: <CAPcyv4hw1a8+wwTYaQ0G0jWQzBCDaZ8zxYXw6gXtuWBYGX1LeQ@mail.gmail.com>
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

On Thu, Jul 5, 2018 at 1:24 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Dan Williams <dan.j.williams@intel.com> wrote:
>
>> The calculation of a uniform numa-node size attempted to perform
>> division with a 64-bit diviser leading to the following failure on
>> 32-bit:
>>
>>     arch/x86/mm/numa_emulation.o: In function `split_nodes_size_interleave_uniform':
>>     arch/x86/mm/numa_emulation.c:239: undefined reference to `__udivdi3'
>>
>> Convert the implementation to do the division in terms of pages and then
>> shift the result back to an absolute physical address.
>>
>> Fixes: 93e738834fcc ("x86/numa_emulation: Introduce uniform split capability")
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Wei Yang <richard.weiyang@gmail.com>
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> I'm still getting this link failure on 32-bit kernels:
>
>  arch/x86/mm/numa_emulation.o: In function `split_nodes_size_interleave_uniform.constprop.1':
>  numa_emulation.c:(.init.text+0x669): undefined reference to `__udivdi3'
>  Makefile:1005: recipe for target 'vmlinux' failed
>
> config attached.
>
> These numa_emulation changes are a bit of a trainwreck - I'm removing both
> num_emulation commits from -tip for now, could you please resubmit a fixed/tested
> combo version?
>

So I squashed the fix and let the 0day robot chew on it all day with
no reports as of yet. I just recompiled it here and am not seeing the
link failure, can you send me the details of the kernel config + gcc
version that is failing?
