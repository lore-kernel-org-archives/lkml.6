Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C19C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B9520868
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uV2twWkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B9520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeJMKA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 06:00:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39272 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeJMKA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 06:00:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id l58so14121604otd.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 19:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AVT8yt4SB5J9DoLXgmc7fyXmf+sZ/QolyovgztLAQ10=;
        b=uV2twWkmECSPrusRnN/vXPmvBFYTjOqR8hUGj7uFIqFnja6HWyEE59/EX6URRSK7ei
         bsLQO8pq96Yj7M5G0CjsRbi5afMpRO5p6LGi6gqkF1Fsb96X2cpi7a6HzEjPHM5S5b/+
         frAsPOqLD9LWEf7OVOqxvcQcS5euFpCDZTZ4mQNwNIu+I5BIdazSX176UsMrE2WE7yqy
         vEzD1H9jpf2yN7Z39bZVobe1cuQmeBj/6yYghOi4Eg5BRvkIX/X2/Np9eIx+7MbesZ3i
         M/WKTCz0rPGomijvt/NLvxi250WzkhscHNYFINjgKIa6h6fyG7Vk/yjb5v+LZqg963lC
         Fyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AVT8yt4SB5J9DoLXgmc7fyXmf+sZ/QolyovgztLAQ10=;
        b=iO3iQcf9MSDHNE/4t8xHu6Q3sWW/OMv886ZyPBw+nOwQNsPfxyQb2lK5tDsU5Gesun
         MW0w65fnERfJXE/zQyftw5kqy3wpRJt5mr6qnuINti/LHe0v+s8v/FCuaPLYho5swfY7
         ef5J+I0zUgFf9DjRBGeIJD9i0eHhtQLKKVcSPCBhemSSS6KLcZqTVNSvO/fulL8offzd
         A1OukEV0YOJ2uk34FzvAT7uNsD5aRwqYcBYOXXdvde7jmfthwLqLHub6IqvIldnJGGIc
         +Pzd0RhKw5pNpx8p6QQKjyzFyAoIPLo9M7Exr5mT24U4nn+UcDdAqNatMXJbXCk9oSP0
         xOnQ==
X-Gm-Message-State: ABuFfoiHWtAmjM9y6JznS6ixTrapOz2OrCgyKDL/NIY2kfgSJWNv4Ulf
        tk5toBx4AStGfML400YgO0vkwHyHyTZxIoTC7N49gA==
X-Google-Smtp-Source: ACcGV626tmOS/hq+IOOBvcyLVHGavVFHf8rpMv7Ej7UrZuwws9AFWJei17jzLnNTEoqbyX0OG7eWDPlqeQQBpHBj980=
X-Received: by 2002:a9d:62cb:: with SMTP id z11mr5748873otk.342.1539397509267;
 Fri, 12 Oct 2018 19:25:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:56d8:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 19:25:08
 -0700 (PDT)
In-Reply-To: <20181013021057.GA213522@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1> <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net> <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
 <20181013014429.GB207108@joelaf.mtv.corp.google.com> <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
 <20181013021057.GA213522@joelaf.mtv.corp.google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 12 Oct 2018 19:25:08 -0700
Message-ID: <CAKOZueu2wdkeUFYLQ8qE48yJs1_uRz-9RVJRkp==CL=jp=Q8+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     David Miller <davem@davemloft.net>, kirill@shutemov.name,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Minchan Kim <minchan@kernel.org>,
        Ramon Pantin <pantin@google.com>,
        Hugh Dickins <hughd@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, Chris Zankel <chris@zankel.net>,
        dave.hansen@linux.intel.com, elfring@users.sourceforge.net,
        fenghua.yu@intel.com, geert@linux-m68k.org, gxt@pku.edu.cn,
        deller@gmx.de, mingo@redhat.com, jejb@parisc-linux.org,
        jdike@addtoit.com, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        lftan@altera.com, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm <linux-mm@kvack.org>, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, Max Filippov <jcmvbkbc@gmail.com>,
        nios2-dev@lists.rocketboards.org,
        Peter Zijlstra <peterz@infradead.org>, richard@nod.at
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 7:10 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Oct 12, 2018 at 06:54:33PM -0700, Daniel Colascione wrote:
>> I wonder whether it makes sense to expose to userspace somehow whether
>> mremap is "fast" for a particular architecture. If a feature relies on
>> fast mremap, it might be better for some userland component to disable
>> that feature entirely rather than blindly use mremap and end up
>> performing very poorly. If we're disabling fast mremap when THP is
>> enabled, the userland component can't just rely on an architecture
>> switch and some kind of runtime feature detection becomes even more
>> important.
>
> I hate to point out that its forbidden to top post on LKML :-)
> https://kernelnewbies.org/mailinglistguidelines
> So don't that Mr. Dan! :D

Guilty as charged. I really should switch back to Gnus. :-)

> But anyway, I think this runtime detection thing is not needed. THP is
> actually expected to be as fast as this anyway, so if that's available then
> we should already be as fast.

Ah, I think the commit message is confusing. (Or else I'm misreading
the patch now.) It's not quite that we're disabling the feature when
THP is enabled anywhere, but rather that we use the move_huge_pmd path
for huge PMDs and use the new code only for non-huge PMDs. (Right?) If
that's the case, the commit message shouldn't say "Incase THP is
enabled, the optimization is skipped". Even if THP is enabled on a
system generally, we might use the new PMD-moving code for mapping
types that don't support THP-ization, right?

> This is for non-THP where THP cannot be enabled
> and there is still room for some improvement. Most/all architectures will be
> just fine with this. This flag is more of a safety-net type of thing where in
> the future if there is this one or two weird architectures that don't play
> well, then they can turn it off at the architecture level by not selecting
> the flag. See my latest patches for the per-architecture compile-time
> controls. Ideally we'd like to blanket turn it on on all, but this is just
> playing it extra safe as Kirill and me were discussing on other threads.

Sure. I'm just pointing out that the 500x performance different turns
the operation into a qualitatively different feature, so if we expect
to actually ship a mainstream architecture without support for this
thing, we should make it explicit. If we're not, we shouldn't.
