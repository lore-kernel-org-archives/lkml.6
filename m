Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FB9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9872147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550734905;
	bh=aHpAjLwWkp/FhG2BKSNRUQYv/PiJHZtRxk94daxGVa4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jd97SwOyB/tocTvXQgw27Ba8k563bQeSqJCfduZ9pTqosw0yLZ56aitNEdwBlbQE7
	 C8yzGp9e+ywDNh4Zzl6FGhSff2uXKZn9+7D1UB6WXBP0Fo1fQCzu86Xu99pIMY2ilg
	 9WIjNhzRWJdNqL365a+8Mv7tkYPqAilUKPjTF/W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfBUHlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:41:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43244 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUHln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:41:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id m35so18247322ede.10;
        Wed, 20 Feb 2019 23:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBo2jtopDSY25tMk59SLMtIPfmFBSxFG9vz6EUEjXCo=;
        b=U4mnPVGes2cdaoQZr+D4VG8JSRceDOeHX4j3wFqaJG7v6qxm8Ap6njQYjHkJlJum7H
         Q25tDf3u7LgwBTsWOEWTOHG4QhYWoFSk1YBEPqoHF6LXQ6aTJcTWx0zdITikRbiRo3SM
         +hGu9+21+yKspMaa0bZwHVI+x0TjZRWsAynfDD2hvuIZCsi4EZYDYo3IceVzH0qGSVYa
         oQA24F69SNlEDtUt9FIZ8oWkjg+zKKFxFd0S6tYmSspPz8jTfuoaopKzDfn6ATGRv6ae
         DdEi9azLsXvYFa6I5l4A5Kn99w7grNtSt8xEh2BV+1EeDn20iFP/mLUMf75IRe1BEytY
         Lckw==
X-Gm-Message-State: AHQUAubByWaj6LLzUYzoO0SbqpMez1ek5NKXPsFAQoIRGMuXEtnMnerO
        re0u4h/bx7SAEdAxyGKuCAS2AM+FilPGUN73Fyo=
X-Google-Smtp-Source: AHgI3IaUGKBAqovN3qvSMtXYv4yejp9hIMDsaA9ZU0KsM0O17UQrWgqGtb2NkN6yaHlxF8SOsmV9w8a2ECChV5hvR3Y=
X-Received: by 2002:a50:b641:: with SMTP id c1mr671484ede.155.1550734901888;
 Wed, 20 Feb 2019 23:41:41 -0800 (PST)
MIME-Version: 1.0
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <0d54a56186fb9be7a8f622a4625a41dc600dd7a4.1550545163.git.len.brown@intel.com> <ceb7549e-6ccb-c6c7-241c-36c6e5c30770@inria.fr>
In-Reply-To: <ceb7549e-6ccb-c6c7-241c-36c6e5c30770@inria.fr>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 21 Feb 2019 02:41:30 -0500
Message-ID: <CAJvTdKm3gqY9G6nOVq_a3r0QX4ECcew7Z3cdr1OxDBGRVgUpkg@mail.gmail.com>
Subject: Re: [PATCH 05/11] x86 topology: export die_siblings
To:     Brice Goglin <Brice.Goglin@inria.fr>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brice,
Thank you for your suggestions!

> Patches #4 and #5 are changing the meaning the core_siblings (in the
> past, it always returned all threads in the entire package). All
> existing user-space tools will see each die as a separate package until
> they are updated to read die_siblings too. It only matters for multi-die
> CPUs when running a recent kernel with an old userspace tool, but it may
> still be consider as a sysfs ABI change.

I agree.

Exhibit 1 is the "lscpu" program.

> Worse, things will break again if you ever add tile_siblings for
> CPUID.1f "Tiles". User-space will suddenly see 2 dies of 2 cores instead
> 1 die of 2 tiles of 2 cores.

Agreed, the existing naming scheme is not resilient to future additions.

> I understand that this isn't easy to fix. But I want to make sure people
> are aware of the meaning of this change.

Here is my list of applications that care about the new CPUID leaf
and the concepts of packages and die:

cpuid
lscpu
x86_energy_perf_policy
turbostat

> The proper way to avoid this is to stop having file foo_siblings refer
> to "the container of foo" instead of "foo itself" (because that
> container changes when you add intermediate levels). Rename sysfs files
> like below, and you don't get any breakage anymore when adding
> intermediate levels:
>
> thread_siblings -> core_threads (can we do sysfs alias or symlink to
> keep the old name?)
>
> core_siblings -> die_threads
>
> die_siblings -> package_threads (needs an alias too)
>
> The documentation would also be much easier to read since "die_threads"
> is obviously "human-readable list of cpuX's hardware threads within the
> same die_id". And no need to modify the doc anymore when adding levels :)

I like your idea!

Hm, I think i'd skip creating "die_siblings", as it adds to the
fragile legacy naming scheme
that we want to deprecate.

And although it is ill-defined and has a mis-leading name, I now think
it would be
better to leave "core_siblings" as defined -- a legacy synonym for
"package_threads".  Deprecate it, but keep its original definition
until it is removed.

Updated applications would use:

core_threads
die_threads
package_threads

and they'll be future proof if/when we add any new levels.

the legacy thread_siblings and core_siblings will stick around as aliases:

core_threads (thread_siblings)
die_threads
package_threads (core_siblings)

thanks!
Len Brown, Intel Open Source Technology Center
