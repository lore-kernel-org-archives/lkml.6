Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B35ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE1921471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MO667b/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE1921471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbeIRTpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:45:54 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33194 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbeIRTpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:45:54 -0400
Received: by mail-yb1-f196.google.com with SMTP id y9-v6so872016ybh.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hac5pA7WjfhQS3IltEqWiih/FiZdrS6bVORPC4vEDLA=;
        b=MO667b/np5AysEkSuTzWmBwvHGCHU6fnsr6hLjVt07LPN2HrfU1Tl6C3Gk2hKwkRS+
         tGC//NDv1/qQkURyIn+lAXD4dSisb2u1CAbUHo1lhhJ879T21yXelrKbD6dySMDntEPK
         cJfC6CIGQouuDn/SDvJn9ZEfbj3lFOzyeIXt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hac5pA7WjfhQS3IltEqWiih/FiZdrS6bVORPC4vEDLA=;
        b=Qn6m4LaB88ijN//GAKPebVauOVgapStVQaQC6tYvxL9kYSVXrFw05xw4iDfqtP+v8u
         AXmTO1yvw3oUfJ4l0rRutIP5SDamDqz/I7mULHBDevTlOru9Vpqb1WYuhA8lD95E3Wrs
         UB3oUoLa27Im08IqrLTeQdSbAQxkTJ1x1kGhQOPy0IToPXhdIPqmN3P0C5OIF2c2Q5QQ
         vKGdWc9GI9J7eGj+hDwEyMkqVN3g4hIYeRJVoRBKb0FO3DIBotoUlG04V/k7j8s4GQsM
         QtY1xU2SBA9K/poP4/yyJudMTBmQoNPhX8kwUWHFy4U3ZEGVfwqCOcWWcWnwSgT4udO9
         FmCw==
X-Gm-Message-State: APzg51Cjr3kqRyFv9eoJttWi2qMgZhg1tf1Y0YAjj2pwZB4IUsUhgsTY
        TYP7luLF58Hm+FFSPawWn7sKpv5FYi+xVl2AniDSgQ==
X-Google-Smtp-Source: ANB0VdYfNYyllvLEXmIeZLqJt4DpW+JgS9MWYqLAjPKKgCjJuhFb9aaMbtfw7YRYDAYBgTNwLfa9pqbYekqUZKNiq6k=
X-Received: by 2002:a25:9702:: with SMTP id d2-v6mr13290148ybo.77.1537279986498;
 Tue, 18 Sep 2018 07:13:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 07:13:06
 -0700 (PDT)
In-Reply-To: <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org> <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 19:43:06 +0530
Message-ID: <CALxhOngEqaA6sNKG_eRTTgnjj94vM2OftbpgHPEXMZ0Yv_nC2w@mail.gmail.com>
Subject: Re: [PATCH 0/3] System call table generation support
To:     Paul Burton <paul.burton@mips.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September 2018 at 22:47, Paul Burton <paul.burton@mips.com> wrote:
> Hi Firoz,
>
> On Fri, Sep 14, 2018 at 02:08:31PM +0530, Firoz Khan wrote:
>> The purpose of this patch series is:
>> 1. We can easily add/modify/delete system call by changing entry
>> in syscall.tbl file. No need to manually edit many files.
>>
>> 2. It is easy to unify the system call implementation across all
>> the architectures.
>>
>> The system call tables are in different format in all architecture
>> and it will be difficult to manually add or modify the system calls
>> in the respective files manually. To make it easy by keeping a script
>> and which'll generate the header file and syscall table file so this
>> change will unify them across all architectures.
>
> Interesting :)
>
> I actually started on something similar recently with the goals of
> reducing the need to adjust both asm/unistd.h & the syscall entry tables
> when adding syscalls, clean up asm/unistd.h a bit & make it
> easier/cleaner to add support for nanoMIPS & the P32 ABI.
>
> My branch still needed some work but it's here if you're interested:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git wip-mips-syscalls
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=wip-mips-syscalls
>
> There are some differences:
>
>   - I'd placed syscall numbers the 3 current MIPS ABIs in one table,
>     rather than splitting it up. I can see pros & cons to both though so
>     I'm not tied to having a single all-encompassing table.
>
>   - I'd mostly inferred the entry point names from the syscall names,
>     only specifying them where they differ. Again I'm not particularly
>     tied to this.
>
>   - I'd made asm/unistd.h behave like asm-generic/unistd.h with the
>     __SYSCALL() macro, where you generate separate syscall_table_*
>     headers. I'm fine with that too.
>
> So I'm pretty happy to go with your series, though I agree with Arnd on
> the ABI/file naming & the missing syscalls that were added in the 4.18
> cycle. We probably need to provide mipsmt_sys_sched_[gs]etaffinity as
> aliases to sys_sched_[gs]etaffinity when CONFIG_MIPS_MT_FPAFF isn't
> enabled in order to fix the issue the kbuild test robot reported.
>
> But I'm looking forward to v2 :)
>
> Thanks,
>     Paul

Thanks for your comments :)

We're planning to come up with a generic script for system call table
generation across all the architecture. So certain things I have to keep
same across  all the architecture.

Having a single script is always our plan for long run. But I have to keep a
separate versions for the start so each architecture can be handled  in one
series. Which would make easier to merge in the initial version.

we could probably add it to scripts/*.sh first, but that requires more
coordination between the architectures.

- Firoz
