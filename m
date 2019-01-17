Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72680C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E64F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="XDmMmTRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfAQQvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:51:09 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46923 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfAQQvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:51:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so6637347oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eeqNNNSjGfrb/VOAvSUOR6b42db+Jqg9XHBp+kCWRWk=;
        b=XDmMmTRIBB5vKWP6TrUwQCEHemONZ8D/s0D83Xpx/UVBf9cANGrt0DX50SHJ9AGymu
         HGb+gf7w0IPrP41Y1j69q32oQnM1pvz89kwP3E/1/8xqNps7J5ibJPJ1dEso3eGhxQSD
         uZmCIpOfTK8l9dfeWt+Lryevm4UKRmUTz7h97P7SlCQD6vinUE2fUhhgVng/6w739Zfp
         Va3bxvf1ta0DfOAnb/GD6tnWwXaj8JFYUtcalUHgaeUCbhZmoeHYX8O7+zSRPw3lHhY4
         WJXtIfp+GcvstcMA8ht+i0wW4eTQKWaDy3h/WWczw6uMXUP4+iOlnLScTvXwjiM6b/lF
         64ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eeqNNNSjGfrb/VOAvSUOR6b42db+Jqg9XHBp+kCWRWk=;
        b=AvJ/mwZyTEC6ZcqcSSBFssVDqfy7E+mPDJv2/elJFUbL/g6JR1Bmg09CUl4rSZaVMD
         1DU6NeAL5MGMHqUdZk2b0cQbpN27vUY+Ghz3AZ4lD+LJXvLOYhVM2SnZkZKYy4MzqPh1
         vJw3jLlo+PY7jkf44ImBLGgMDZ2wzKwdnK+3jIr0UOhW8sES7/0sZPlpQdQNN0jlyt+O
         iVshS/15dTlxc5MSI651ClSpw3Upm74ZOJPfAEc92Ezo/dk4i66imPLLBiU3VScNQ08/
         XglWbyaRzIEQDnqbFUB549dcRpvMUbijPBH2Zs3thbuhJkhBAMckfbNIWH0q+Ojp2Fh/
         pDBg==
X-Gm-Message-State: AJcUukeMF2/h3flazA0n6pZOHZ48g8JvmlJq7wTxleiJglnYT7CL1+CG
        kVHovraCnDq+3+Ceqrss80s/sjw0HDJnyR6h4bR+rw==
X-Google-Smtp-Source: ALg8bN5MbqsOaTEFby+rDYnDy2cAuiqqwg7op/akn51pGzRtGj2Cio9wpi3j/48ESGJDtvGyDnPXPzS9B6yq0EDd9sg=
X-Received: by 2002:aca:d905:: with SMTP id q5mr5249519oig.0.1547743868290;
 Thu, 17 Jan 2019 08:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20190116181859.D1504459@viggo.jf.intel.com> <x49sgxr9rjd.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49sgxr9rjd.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Jan 2019 08:50:57 -0800
Message-ID: <CAPcyv4je0XXWjej+xM4+gidryQH=p_sevD=eL6w8f-vDQzMm3w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Allow persistent memory to be used like normal RAM
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dave Hansen <dave@sr71.net>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Takashi Iwai <tiwai@suse.de>,
        Ross Zwisler <zwisler@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 8:29 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dave Hansen <dave.hansen@linux.intel.com> writes:
>
> > Persistent memory is cool.  But, currently, you have to rewrite
> > your applications to use it.  Wouldn't it be cool if you could
> > just have it show up in your system like normal RAM and get to
> > it like a slow blob of memory?  Well... have I got the patch
> > series for you!
>
> So, isn't that what memory mode is for?
>   https://itpeernetwork.intel.com/intel-optane-dc-persistent-memory-operating-modes/

That's a hardware cache that privately manages DRAM in front of PMEM.
It benefits from some help from software [1].

> Why do we need this code in the kernel?

This goes further and enables software managed allocation decisions
with the full DRAM + PMEM address space.

[1]: https://lore.kernel.org/lkml/154767945660.1983228.12167020940431682725.stgit@dwillia2-desk3.amr.corp.intel.com/
