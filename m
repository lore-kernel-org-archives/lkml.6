Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E0222504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Yq3LbNln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E0222504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbeKMGcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:32:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35019 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeKMGcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:32:35 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so15743893qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 12:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4CDInkZUoTOv8ilWmD4SOAmz61ScUtKiWAoUQGQWJ/o=;
        b=Yq3LbNlnDMAi1af9mqNKRbbXEymSQYYkJzQXy9MT2tXsF72IkHVed+8vjgUMAzQDsb
         WBn7SxLp2VlIsaDiK2nGfWV9BGASP+MhnabfVGTeHStoUDfhu1ww4P+PhOzxTSEKzaDU
         1p0UOSic7x/WIglG231bYe2vlFMrltpZRq29W1CZPZWbrkhUl4j4pTOQmp+gAm8TLVOt
         Xjs7Sn/eK3JN37B8FCxj+pYHgtKdyU225dmtqr0jk84Pqtu14Bh/aYbuAGWbAPTrxolk
         vuTQ819+jZ2gpWXmyaQkCrESPsXF82zDa1Qe28nd6a+PTqdg3nNTmNIQXafp0ufa/+ga
         uq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4CDInkZUoTOv8ilWmD4SOAmz61ScUtKiWAoUQGQWJ/o=;
        b=it9hpNxZBT3ctBMG5KJTOEJ+hzfA7eaLs6jx8hqE2W6530OF51/8NIykvvjcoZWMyg
         RPUwQmWdelsrz8yikMNHPU6Kkv/t2FFB8+NZqp78nkEUhTVslfhDxdJ2r/DEgh1q2Ro5
         CUrmtX49OxkSYWaUR6j6PpRTkFx9uNsDyp6a5NQfZkg7fiI1XxH+qaM/dI0FkVbvebzn
         J5+hWnWj5pqtCEWzCRbtQQ8t36NL7cls0n3CrP4O/aflDRkINcK1jOUCKpHMoEy1LY2J
         WDB3iEJqvDo0OYinIVhW4TJbFC65kPfgHsLrkvB9qzIRbMVebX/SOREgsfbOuN8wJ58n
         7+8A==
X-Gm-Message-State: AGRZ1gKfMP8A1Lr0pFhZTSFm4OcA4w772vy9vtvRzaof6gPo658L30c8
        rBO3C8i/WDKdm4aSgXKt+a7lSA==
X-Google-Smtp-Source: AJdET5f1r8EmChHeICX5OHcTKuiTqTyaBksV/SY4wKbYQTekrimL773rkyGQfP9GDrDceGJxbI0Ryw==
X-Received: by 2002:a0c:fc09:: with SMTP id z9mr2520755qvo.157.1542055062275;
        Mon, 12 Nov 2018 12:37:42 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id b17sm9599505qkj.69.2018.11.12.12.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 12:37:40 -0800 (PST)
Date:   Mon, 12 Nov 2018 20:37:37 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        alexander.h.duyck@linux.intel.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-mm <linux-mm@kvack.org>, sparclinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-nvdimm@lists.01.org,
        David Miller <davem@davemloft.net>,
        pavel.tatashin@microsoft.com, Michal Hocko <mhocko@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        rppt@linux.vnet.ibm.com, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, khalid.aziz@oracle.com,
        ldufour@linux.vnet.ibm.com,
        Mel Gorman <mgorman@techsingularity.net>,
        yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
Message-ID: <20181112203737.e4jnsp4rxpie4trr@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181109211521.5ospn33pp552k2xv@xakep.localdomain>
 <18b6634b912af7b4ec01396a2b0f3b31737c9ea2.camel@linux.intel.com>
 <20181110000006.tmcfnzynelaznn7u@xakep.localdomain>
 <0d8782742d016565870c578848138aaedf873a7c.camel@linux.intel.com>
 <20181110011652.2wozbvfimcnhogfj@xakep.localdomain>
 <CAKgT0UdDYC5RvZ1XgLTamFpBe3foPMs+SV_kSUVNDWLvxSC_1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdDYC5RvZ1XgLTamFpBe3foPMs+SV_kSUVNDWLvxSC_1Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-12 11:10:35, Alexander Duyck wrote:
> 
> The point I was trying to make is that it doesn't. You say it is an
> order of magnitude better but it is essentially 3.5x vs 3.8x and to
> achieve the 3.8x you are using a ton of system resources. My approach
> is meant to do more with less, while this approach will throw a
> quarter of the system at  page initialization.

3.8x is a bug, that is going to be fixed before ktasks are accepted. The
final results will be close to time/nthreads.
Using more resources to initialize pages is fine, because other CPUs are
idling during this time in boot.

Lets wait for what Daniel finds out after Linux Plumber. And we can
continue this discussion in ktask thread.

> 
> An added advantage to my approach is that it speeds up things
> regardless of the number of cores used, whereas the scaling approach

Yes, I agree, I like your approach. It is clean, simplifies, and
improves the performance. I have tested it on both ARM and x86, and
verified the performance improvements. So:

Tested-by: Pavel Tatashin <pasha.tatashin@soleen.com>


> requires that there be more cores available to use. So for example on
> some of the new AMD Zen stuff I am not sure the benefit would be all
> that great since if I am not mistaken each tile is only 8 processors
> so at most you are only doubling the processing power applied to the
> initialization. In such a case it is likely that my approach would
> fare much better then this approach since I don't require additional
> cores to achieve the same results.
> 
> Anyway there are tradeoffs we have to take into account.
> 
> I will go over the changes you suggested after Plumbers. I just need
> to figure out if I am doing incremental changes, or if Andrew wants me
> to just resubmit the whole set. I can probably deal with these changes
> either way since most of them are pretty small.

Send the full series again, Andrew is very good at taking only
incremental  changes once a new version is posted of something
that is already in mm-tree.

Thank you,
Pasha
