Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E572CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9462075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xavuISes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9462075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeJZFaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:30:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46900 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeJZFaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:30:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id u26so9367179otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DHCjLc4509m+D7qeWfqSbnrM1ss/+Qi04nfzzOd/Sfc=;
        b=xavuISesakORM38WqarGXNAn8dz8v/Qdkb+M5weamfB3JdmgSGHAq+gfZEIRin8/I3
         3MxNfkPl44/Nhs6cSN6gt9NYEvp4zH5kK/jPY0MGta2rRBR7jPo4mSdrfc5OTTgIAWHD
         Ceo4KRzUnnkpScpAvSRPl+ZcNUV+mNGQOYDfbiVWTHFFKg2ruuppZMdVNMvCkooy0VmD
         ppoCju+gQAzljMroYA6BKBkcq7eN1T2yKaQZW6HkZAbf+dEHXWvX0HEZv4C0KM3Gg5ep
         dOHe0xWuiHm6WXHzG94n6zAtXJT8wQRSrQzmblXQ8N0fcJ9Z1h9t4QnHaGO428+b3sVF
         VmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DHCjLc4509m+D7qeWfqSbnrM1ss/+Qi04nfzzOd/Sfc=;
        b=B75XulCn6YF+tWvc3EdUToY1yT5gWIkZL4ww0TkCzHaBata2nJqL4bKON9TpNAZ9p9
         1Fn9SWOXY0iTe7f73JgxsK6Q6zEUfZ84OOq5lgCSo8eR9wcizbEfE97IvgA5n9XzsJ5F
         DwACnXtELnqIh1dxWd0sdUK9Y7LBPffMYfmylN5yQ2hruCF2XuL7vxBpsT/Kvqp1O097
         PwSAQAuJcSBLztz494fQiXHpSTT9cSfPphtJvh2ehuOU7YUT6A3v0vfKP+0u5jFd0uHr
         94p+M80+j9QViJAyFiMT0KzXoujHdoK+ovnT19Q+OODYGyQxow/3a2ZBZTUw46tsGboo
         mhHw==
X-Gm-Message-State: AGRZ1gKowT09YOa6yYRL4jWD6BO7VdlYY7P847HIoBmiMw41SePbpBHx
        BdJvs2RSbqgzJmnaASMcAC0dLu5Fb3IDS76SWw9NVw==
X-Google-Smtp-Source: AJdET5cQ31QbRp7qM6BpOQ1UyiBlP90Svzi3ZpvlxQhs1ucvjPII8DOrCtFLfebDd2mrihUbUTFTRdVzcYnRUpnZ5aE=
X-Received: by 2002:a9d:2372:: with SMTP id k47mr515987otd.98.1540500963992;
 Thu, 25 Oct 2018 13:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <154049911459.2685845.9210186007479774286.stgit@dwillia2-desk3.amr.corp.intel.com>
 <d2987470-3680-9923-d114-a7d7b08c06e7@intel.com>
In-Reply-To: <d2987470-3680-9923-d114-a7d7b08c06e7@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 25 Oct 2018 13:55:53 -0700
Message-ID: <CAPcyv4hkJNFonsaR=ENq8DL8RMhoZUZ4M6boTBxK-nt2ZKJTEw@mail.gmail.com>
Subject: Re: [PATCH v3] x86/numa_emulation: Fix uniform-split numa emulation
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        stable <stable@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        alexander.h.duyck@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 1:52 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/25/18 1:26 PM, Dan Williams wrote:
> > --- a/arch/x86/mm/numa_emulation.c
> > +++ b/arch/x86/mm/numa_emulation.c
> > @@ -400,9 +400,17 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
> >               n = simple_strtoul(emu_cmdline, &emu_cmdline, 0);
> >               ret = -1;
> >               for_each_node_mask(i, physnode_mask) {
> > +                     /*
> > +                      * The reason we pass in blk[0] is due to
> > +                      * numa_remove_memblk_from() called by
> > +                      * emu_setup_memblk() will delete entry 0
> > +                      * and then move everything else up in the pi.blk
> > +                      * array. Therefore we should always be looking
> > +                      * at blk[0].
> > +                      */
> >                       ret = split_nodes_size_interleave_uniform(&ei, &pi,
> > -                                     pi.blk[i].start, pi.blk[i].end, 0,
> > -                                     n, &pi.blk[i], nid);
> > +                                     pi.blk[0].start, pi.blk[0].end, 0,
> > +                                     n, &pi.blk[0], nid);
>
> So, has this *ever* worked on a multi-socket configuration?  Or has it
> just never been run on a multi-socket configuration?

It happened to work on 2-socket. We only saw issues when moving to
4-socket and above, and sometimes only a grey failure with an
odd-sized node not outright crash / boot failure.

> Either way, nice changelog, and nice comments.  I'd have some minor nits
> if you have to respin it, but otherwise:
>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks.
