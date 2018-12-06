Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76805C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3073C20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="dDiALFZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3073C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLFTBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:01:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42198 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeLFTBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:01:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so542229pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TUPs1DuZQY6P34mosLdecWr2TkDfq74DuTs901HRomE=;
        b=dDiALFZCL31CR2+/MQPePavyjaSNZImNewZgXKk4F24+q8VZim/Ph+030O3K91S9pK
         yrLBoEa3f7uPUaKQnI0TUikrw+SornoKR9DSq/pWxpw0W7uH99fG9vPBUM5FGKr2gih4
         Rtandws2H6gKHhrASfq6O7b98hD4cG7TekoTuypPw6ub+TV+NTD2ySX8rpimjM6FdlTf
         k5X/u6E/hJsjf11kgMTZEyVuZNAs3cR8P6u/xlR63yfJjM0LJ0dz4AHwrhDhBTzaxLgt
         arCBovUffBhvfaOomN5cXFo3SqFGFnYRjuLw5bdN/ylbAtypKAUcBS3LWFGXMAP0jr7d
         DJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TUPs1DuZQY6P34mosLdecWr2TkDfq74DuTs901HRomE=;
        b=cuT5nyWfOLMoPdiIKWDFWeUNv6+VNTCzIJNHphpnOLKeC8IJqEmRdz/TEUfnlEhoOw
         Gu8ISiQl0Wz7Zdx5i8o7V0RuI7T4/lk2VE/1JfzPbZCLz4LtmoOM1Lc5GyxrpQdH33Mh
         AL6hyxsZ+p28XEHuJggctM6IXBgKnKtmUtrxpEbGRwoD94ME0eBAR/E/jyx8L1UYyIXB
         jULmGkzIJRh1mxZ9JyYZg4HbaSHekbPX60NFBJL3HTnxZ0YzkflScl7rSQeo50wtX3ZJ
         yZ97vG9wP+f55P7ZxyDKd+lAexxGgs/rdJFiXjiK+2g7Rkbk731QEF4fMKJF8r1xXaFX
         dlDA==
X-Gm-Message-State: AA+aEWaBI7ShOcd9XYXE2xRY07QuHbDsRi6KQ+cNRFOSNnrVg3PB+7Df
        OXAv9EebLVc2Bga3BWijqsR+lw==
X-Google-Smtp-Source: AFSGD/VvNAm+B78TYoGTvwZvFdjPOIasX+R12kh4oLfKgkD2NvcdNR/qHpv5nm/IckvMulwQolHDVw==
X-Received: by 2002:a62:2b8b:: with SMTP id r133mr18255475pfr.246.1544122880017;
        Thu, 06 Dec 2018 11:01:20 -0800 (PST)
Received: from cisco ([128.107.241.180])
        by smtp.gmail.com with ESMTPSA id 125sm1905653pfx.159.2018.12.06.11.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 11:01:18 -0800 (PST)
Date:   Thu, 6 Dec 2018 12:01:15 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jann Horn <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
Message-ID: <20181206190115.GC10086@cisco>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com>
 <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <20181204160304.GB7195@arm.com>
 <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
 <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
 <20181205114148.GA15160@arm.com>
 <CALCETrUdTShjY+tQoRsE1uR1cnL9cr2Trbz-g5=WaLGA3rWXzA@mail.gmail.com>
 <CAKv+Gu_EEjhwbfp1mdB0Pu3ZyAsZgNeaCDArs569hAeWzHMWpw@mail.gmail.com>
 <CALCETrVedB7yacMU=i3JaUZxiwsnM+PnABfG48K9TZK32UWshA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrVedB7yacMU=i3JaUZxiwsnM+PnABfG48K9TZK32UWshA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:53:50AM -0800, Andy Lutomirski wrote:
> > On Dec 5, 2018, at 11:29 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> >> On Thu, 6 Dec 2018 at 00:16, Andy Lutomirski <luto@kernel.org> wrote:
> >>
> >>> On Wed, Dec 5, 2018 at 3:41 AM Will Deacon <will.deacon@arm.com> wrote:
> >>>
> >>>> On Tue, Dec 04, 2018 at 12:09:49PM -0800, Andy Lutomirski wrote:
> >>>> On Tue, Dec 4, 2018 at 12:02 PM Edgecombe, Rick P
> >>>> <rick.p.edgecombe@intel.com> wrote:
> >>>>>
> >>>>>> On Tue, 2018-12-04 at 16:03 +0000, Will Deacon wrote:
> >>>>>> On Mon, Dec 03, 2018 at 05:43:11PM -0800, Nadav Amit wrote:
> >>>>>>>> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe <rick.p.edgecombe@intel.com>
> >>>>>>>> wrote:
> >>>>>>>>
> >>>>>>>> Since vfree will lazily flush the TLB, but not lazily free the underlying
> >>>>>>>> pages,
> >>>>>>>> it often leaves stale TLB entries to freed pages that could get re-used.
> >>>>>>>> This is
> >>>>>>>> undesirable for cases where the memory being freed has special permissions
> >>>>>>>> such
> >>>>>>>> as executable.
> >>>>>>>
> >>>>>>> So I am trying to finish my patch-set for preventing transient W+X mappings
> >>>>>>> from taking space, by handling kprobes & ftrace that I missed (thanks again
> >>>>>>> for
> >>>>>>> pointing it out).
> >>>>>>>
> >>>>>>> But all of the sudden, I don’t understand why we have the problem that this
> >>>>>>> (your) patch-set deals with at all. We already change the mappings to make
> >>>>>>> the memory wrAcked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > itable before freeing the memory, so why can’t we make it
> >>>>>>> non-executable at the same time? Actually, why do we make the module memory,
> >>>>>>> including its data executable before freeing it???
> >>>>>>
> >>>>>> Yeah, this is really confusing, but I have a suspicion it's a combination
> >>>>>> of the various different configurations and hysterical raisins. We can't
> >>>>>> rely on module_alloc() allocating from the vmalloc area (see nios2) nor
> >>>>>> can we rely on disable_ro_nx() being available at build time.
> >>>>>>
> >>>>>> If we *could* rely on module allocations always using vmalloc(), then
> >>>>>> we could pass in Rick's new flag and drop disable_ro_nx() altogether
> >>>>>> afaict -- who cares about the memory attributes of a mapping that's about
> >>>>>> to disappear anyway?
> >>>>>>
> >>>>>> Is it just nios2 that does something different?
> >>>>>>
> >>>>> Yea it is really intertwined. I think for x86, set_memory_nx everywhere would
> >>>>> solve it as well, in fact that was what I first thought the solution should be
> >>>>> until this was suggested. It's interesting that from the other thread Masami
> >>>>> Hiramatsu referenced, set_memory_nx was suggested last year and would have
> >>>>> inadvertently blocked this on x86. But, on the other architectures I have since
> >>>>> learned it is a bit different.
> >>>>>
> >>>>> It looks like actually most arch's don't re-define set_memory_*, and so all of
> >>>>> the frob_* functions are actually just noops. In which case allocating RWX is
> >>>>> needed to make it work at all, because that is what the allocation is going to
> >>>>> stay at. So in these archs, set_memory_nx won't solve it because it will do
> >>>>> nothing.
> >>>>>
> >>>>> On x86 I think you cannot get rid of disable_ro_nx fully because there is the
> >>>>> changing of the permissions on the directmap as well. You don't want some other
> >>>>> caller getting a page that was left RO when freed and then trying to write to
> >>>>> it, if I understand this.
> >>>>>
> >>>>
> >>>> Exactly.
> >>>
> >>> Of course, I forgot about the linear mapping. On arm64, we've just queued
> >>> support for reflecting changes to read-only permissions in the linear map
> >>> [1]. So, whilst the linear map is always non-executable, we will need to
> >>> make parts of it writable again when freeing the module.
> >>>
> >>>> After slightly more thought, I suggest renaming VM_IMMEDIATE_UNMAP to
> >>>> VM_MAY_ADJUST_PERMS or similar.  It would have the semantics you want,
> >>>> but it would also call some arch hooks to put back the direct map
> >>>> permissions before the flush.  Does that seem reasonable?  It would
> >>>> need to be hooked up that implement set_memory_ro(), but that should
> >>>> be quite easy.  If nothing else, it could fall back to set_memory_ro()
> >>>> in the absence of a better implementation.
> >>>
> >>> You mean set_memory_rw() here, right? Although, eliding the TLB invalidation
> >>> would open up a window where the vmap mapping is executable and the linear
> >>> mapping is writable, which is a bit rubbish.
> >>>
> >>
> >> Right, and Rick pointed out the same issue.  Instead, we should set
> >> the direct map not-present or its ARM equivalent, then do the flush,
> >> then make it RW.  I assume this also works on arm and arm64, although
> >> I don't know for sure.  On x86, the CPU won't cache not-present PTEs.
> >
> > If we are going to unmap the linear alias, why not do it at vmalloc()
> > time rather than vfree() time?
> 
> That’s not totally nuts. Do we ever have code that expects __va() to
> work on module data?  Perhaps crypto code trying to encrypt static
> data because our APIs don’t understand virtual addresses.  I guess if
> highmem is ever used for modules, then we should be fine.
> 
> RO instead of not present might be safer.  But I do like the idea of
> renaming Rick's flag to something like VM_XPFO or VM_NO_DIRECT_MAP and
> making it do all of this.

Yeah, doing it for everything automatically seemed like it was/is
going to be a lot of work to debug all the corner cases where things
expect memory to be mapped but don't explicitly say it. And in
particular, the XPFO series only does it for user memory, whereas an
additional flag like this would work for extra paranoid allocations
of kernel memory too.

Seems like maybe we should do this for rodata today?

> (It seems like some people call it the linear map and some people call
> it the direct map.  Is there any preference?)

...and some people call it the physmap :)

Tycho
