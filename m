Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CBAC6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0E120865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oO7CQBJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0E120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeJMJ3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:29:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41708 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeJMJ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:29:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id c32so14078678otb.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ruDqHADLGhUq/OqjXNRFevT5jDn0habRcwA3l0QGuG8=;
        b=oO7CQBJ0o3h4W+oksCLNlcAMMdo7sg4Jtv1VCUZcuw6SrUuKQoC7/yRbVEByqVegR5
         2XakAmI6gLBq49bXmjVYz4+acBeAcuwKtUHPjj2sGXy+jzOkdhqdTL0YPcZPqB+LKt6o
         bhRful9oO7cRR8nbmHw1A7uqI9ttcB1fV31XpSXw7a9IcC+joMzcgVc8TxQKKcRQt8Re
         zoNMfZUWu+1do2+6RW0MSWVyN/9DUjKrGt5dJpbjxpWiCS22HxYleuy9uZIoJeze7/q0
         zCoyyhRBLvqgZ71FAynWB3xe4pRvB3ibgZGe60xwaYIUrVPx8bwkXyzud+F7R7U1MaXx
         /VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ruDqHADLGhUq/OqjXNRFevT5jDn0habRcwA3l0QGuG8=;
        b=O4U0g8BC4DyFZo36yrtoT018ZQoEULqkvr27of2t7ZAHL5Q7pxuDJOq+yJogcG0nH3
         rX51gEy7APoXm5ObOOuCP4U3ipNRTPxI3VUbGusI3rT77YM6k2Bjd/1Orw6UiZAw3/mA
         D+1JnUAa8pPv0nlH9Mq50ZAkE0A8vnRkls5rNoz7mOQgKP8T1NkGP3zEtZ9BPj2+4kLP
         0d1elmNErU+4gVGOuJEYM1AqYa6Cp3hSbaooCEJoKlqsnhdgqeH04vR9vqkEnCRsAoR3
         6wRle6UQu647Em5j5Ku2kMrOxMWeThe3FdLbd7CF/IViKHPf1G/Ca73u9Fl/4Eo9sqYg
         4CLA==
X-Gm-Message-State: ABuFfogY0+5UmirSngCKJC58gDIGRiNePoiYCacKbNQ13fjea/OMO31o
        d/gt4Zeh4QNvncT9etU8yIzb6jeOjdeOfl2l4vjm3g==
X-Google-Smtp-Source: ACcGV61wTHJT8KA0FRbB4T8HJavFhx8DCnBEFcv7It/8YmRplkdtkLJbpEFBtddWCai0iE4efhP92rfUMrMKw3tumlM=
X-Received: by 2002:a9d:3a21:: with SMTP id j30mr2325823otc.237.1539395674440;
 Fri, 12 Oct 2018 18:54:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:56d8:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 18:54:33
 -0700 (PDT)
In-Reply-To: <20181013014429.GB207108@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1> <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net> <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com> <20181013014429.GB207108@joelaf.mtv.corp.google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 12 Oct 2018 18:54:33 -0700
Message-ID: <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     David Miller <davem@davemloft.net>, kirill@shutemov.name,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Minchan Kim <minchan@kernel.org>,
        Ramon Pantin <pantin@google.com>, hughd@google.com,
        Lokesh Gidra <lokeshgidra@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, chris@zankel.net,
        dave.hansen@linux.intel.com, elfring@users.sourceforge.net,
        fenghua.yu@intel.com, geert@linux-m68k.org, gxt@pku.edu.cn,
        deller@gmx.de, mingo@redhat.com, jejb@parisc-linux.org,
        jdike@addtoit.com, jonas@southpole.se, Julia.Lawall@lip6.fr,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        lftan@altera.com, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm <linux-mm@kvack.org>, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com,
        nios2-dev@lists.rocketboards.org,
        Peter Zijlstra <peterz@infradead.org>, richard@nod.at
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder whether it makes sense to expose to userspace somehow whether
mremap is "fast" for a particular architecture. If a feature relies on
fast mremap, it might be better for some userland component to disable
that feature entirely rather than blindly use mremap and end up
performing very poorly. If we're disabling fast mremap when THP is
enabled, the userland component can't just rely on an architecture
switch and some kind of runtime feature detection becomes even more
important.

On Fri, Oct 12, 2018 at 6:44 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Oct 12, 2018 at 06:39:45PM -0700, Daniel Colascione wrote:
>> Not 32-bit ARM?
>
> Well, I didn't want to enable every possible architecture we could in a
> single go. Certainly arm32 can be a follow on enablement as can be other
> architectures. The point of this series is to upstream this feature and
> enable a hand-picked few architectures as a first step.
>
> thanks,
>
>  - Joel
>
