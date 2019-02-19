Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E675E21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU/xVmig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfBSMBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:01:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41770 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfBSMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:01:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so10035511pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 04:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/LG/yEoER1LLbq1ZVxXJDkWgtoKcYvIkZiPzXMpJeVo=;
        b=iU/xVmigyl6P6JQ+57cD4HVDHnGSrProH0Bj7J/IpfGxTbo5jggrj2JEO3KEx0vnOA
         0U6lLcIN6jAKKai0MyqAA4vC3XPyGqdpr1dCMD0QHOYR6Ea6W9d8LCK6jdp6+YOJmnol
         sJPlA8QkFRIoZ3qaWBBHgf+fikdu8LMUkeB+fCYhd+SzBE0sDcrS+B7mpWE6tBcXvyiz
         NwPKXPltrdr05Or1JEujlgMfwxABSEVs7WRYJj4lOJ4v2npwW26pe+mGH7cMYhK7+Dbg
         G2yqOxYMRwm8uHIS2zFIdMNg1ov5kgoTBobqduB/kY/KKStgWeNih+p8NCLASz91DtQ1
         h0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/LG/yEoER1LLbq1ZVxXJDkWgtoKcYvIkZiPzXMpJeVo=;
        b=o6z8VwwO5XSoF0iEUSnrnGkCSsaOkTcOk0lQQrJmhbUGoJZ6vIkf6fFsQJIcWuN614
         81e05QWaDhIBIuGNwM8Ym0RQXNUL7CRLvkQIC8/c4PtnXMdChy1ej6i79fYoo2JffCUt
         w7h9SbIkHS8PNvEZIhwjlxgoHvX07I1Z5yjyysWG5OrOwTA+Iwgj2MHIkFM9GWpH/TTT
         9kmeV/diZhWGZm7AMnncIaRzIzxrnkaX9JRNrKAiWbYR1ZIaGpLfqggZoDE+i2lV7dds
         SKSwYir8FWfEghAju4TiS0McOu6uLuiZRcMaIN1op5oIE8Kya8WoRrjw6vTKSyd2mtRK
         YL3A==
X-Gm-Message-State: AHQUAubZ9vvatL9F1Dm+3LDbWVCJhuP343lg2IFE+ZT971JsUDeObSnN
        mdlE96dpBdFl/6eRZLTYM+TYd3bp
X-Google-Smtp-Source: AHgI3IZIhLtBpykbTg6j8A/bl1aKD6Q13H0vmWwXiKvP/FU0TZwarjAbPGHY9e/NaBzjEBvj6uDodA==
X-Received: by 2002:a63:6605:: with SMTP id a5mr2454975pgc.372.1550577678304;
        Tue, 19 Feb 2019 04:01:18 -0800 (PST)
Received: from localhost ([203.219.252.113])
        by smtp.gmail.com with ESMTPSA id o2sm20849302pgq.29.2019.02.19.04.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 04:01:17 -0800 (PST)
Date:   Tue, 19 Feb 2019 23:01:14 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        erhard_f@mailbox.org, jack@suse.cz, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due
 to pgd/pud_present()
Message-ID: <20190219120114.GK31125@350D>
References: <20190214062339.7139-1-mpe@ellerman.id.au>
 <20190216105511.GA31125@350D>
 <20190216142206.GE14180@gate.crashing.org>
 <20190217062333.GC31125@350D>
 <87ef86dd9v.fsf@concordia.ellerman.id.au>
 <20190217215556.GH31125@350D>
 <87imxhrkdt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imxhrkdt.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:49:18AM +1100, Michael Ellerman wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> > On Sun, Feb 17, 2019 at 07:34:20PM +1100, Michael Ellerman wrote:
> >> Balbir Singh <bsingharora@gmail.com> writes:
> >> > On Sat, Feb 16, 2019 at 08:22:12AM -0600, Segher Boessenkool wrote:
> >> >> On Sat, Feb 16, 2019 at 09:55:11PM +1100, Balbir Singh wrote:
> >> >> > On Thu, Feb 14, 2019 at 05:23:39PM +1100, Michael Ellerman wrote:
> >> >> > > In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
> >> >> > > rather than just checking that the value is non-zero, e.g.:
> >> >> > > 
> >> >> > >   static inline int pgd_present(pgd_t pgd)
> >> >> > >   {
> >> >> > >  -       return !pgd_none(pgd);
> >> >> > >  +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
> >> >> > >   }
> >> >> > > 
> >> >> > > Unfortunately this is broken on big endian, as the result of the
> >> >> > > bitwise && is truncated to int, which is always zero because
> >> >> 
> >> >> (Bitwise "&" of course).
> >> >> 
> >> >> > Not sure why that should happen, why is the result an int? What
> >> >> > causes the casting of pgd_t & be64 to be truncated to an int.
> >> >> 
> >> >> Yes, it's not obvious as written...  It's simply that the return type of
> >> >> pgd_present is int.  So it is truncated _after_ the bitwise and.
> >> >>
> >> >
> >> > Thanks, I am surprised the compiler does not complain about the truncation
> >> > of bits. I wonder if we are missing -Wconversion
> >> 
> >> Good luck with that :)
> >> 
> >> What I should start doing is building with it enabled and then comparing
> >> the output before and after commits to make sure we're not introducing
> >> new cases.
> >
> > Fair enough, my point was that the compiler can help out. I'll see what
> > -Wconversion finds on my local build :)
> 
> I get about 43MB of warnings here :)
>

I got about 181M with a failed build :(, but the warnings pointed to some cases
that can be a good project for cleanup

For example

1. 
static inline long regs_return_value(struct pt_regs *regs)
{
        if (is_syscall_success(regs))
                return regs->gpr[3];
        else
                return -regs->gpr[3];
}

In the case of is_syscall_success() returning false, we should ensure that
regs->gpr[3] is negative and capped within a certain limit, but it might
be an expensive check

2.
static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
                                        unsigned int index, unsigned int hidx)
{
        hpte_slot_array[index] = (hidx << 1) | 0x1;
}

hidx is 3 bits, but the argument is unsigned int. The caller probably does a
hidx & 0x7, but it's not clear from the code

3. hash__pmd_bad (pmd_bad) and hash__pud_bad (pud_bad) have issues similar to what was found,
but since the the page table indices are below 32, the macros are safe :)

And a few more, but I am not sure why I spent time looking at possible issues,
may be I am being stupid or overly pessimistic :)

Balbir


