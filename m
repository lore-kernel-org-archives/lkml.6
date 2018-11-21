Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C7EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0328B206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="rAZ4dOYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0328B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390195AbeKVJNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:13:31 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40406 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390182AbeKVJNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:13:31 -0500
Received: by mail-oi1-f194.google.com with SMTP id t204so5906588oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ae6joNWCGG2N/kPBwBWkjbaVaan30FBJrlkqbEQ4suY=;
        b=rAZ4dOYlNx2TuHsrs0F7Bkn/Z1YrEgsZBT5/gKIe4TV5pELm4XXKP0KgvFgpV3D/Ec
         4nuXiwFDV3D4qNZsBpdhYvM2K2t0ARBqVtPl1oxSbaitqgfEWV/BNx15itsogiD3WAJ+
         a1iIoIhNYNvDmrGMU1eQagnPFOzWTDA3oTLX1+kttZvoDU6D6lFbIeMztLRTjfxtPGAv
         RwwNuJXY5NfKR07WwpCoS+9R0vznvZ9eapRkuvJTsd1cwNrJbsfOwDECby8jpSsaVe55
         KFS+f2P7UiJOmdSo9VYpXg8RdkBLXCf7t2NxtNgwG7HA3DPag6HLFe84UKT9L9fg1Vqw
         vuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ae6joNWCGG2N/kPBwBWkjbaVaan30FBJrlkqbEQ4suY=;
        b=ojVhg3gmPxZ41a2GdV89nfWTNlU/+I8gq48vahHgueOC2Bnk/7WYQdjRXKVtMRz0xW
         1t0HFJ1jmBJbYGy986+7D0PWHm7BtbfYp2EBDClw97nfSjtlSNaix1V2C8hOI+bmyZpo
         qDevg8MoP1yeADf4YMa2jS56ftYlXwoNE280ekXBB3Mpvnc/dBoRQTGBSQGWELnaSK64
         pkaEKISC9VRcQmT/x4llP8zbqV1opiVCTJE9/uw9VA6K+u4IvVY8fEJzAXYuBQ5lmV6m
         8aARx4tFjXheJX9q8dmbFuTxCQH6W+aYxwNqAealSH37jd8FZXEV8m5J1hU2j9kBbYqt
         wDEQ==
X-Gm-Message-State: AGRZ1gJZV08vLlFsPKYMLYYfmU+B91AVsualsnz8Y/Uqhx+XafgZTMdr
        FrsKs1rdD6XyWO5sNqKmKWhUVl50qbEMRpw3EHh0Sw==
X-Google-Smtp-Source: AJdET5fz6HQOeiETwkqnkdfBwweOq6qZwnHrZ4z37fs21l3vnK1pDJV8BU2yFLns9YFuCvfTqKw/3ADBPDgj6wVzPqI=
X-Received: by 2002:aca:745:: with SMTP id 66-v6mr4510610oih.280.1542839828643;
 Wed, 21 Nov 2018 14:37:08 -0800 (PST)
MIME-Version: 1.0
References: <154266954452.2939184.974606608701109493.stgit@dwillia2-desk3.amr.corp.intel.com>
 <279dadae-9148-465c-7ec6-3f37e026c6c9@intel.com> <7b1bbfd295c4709e85ca26457b460fb4d36aa276.camel@intel.com>
 <20181120090336.GF2131@hirez.programming.kicks-ass.net>
In-Reply-To: <20181120090336.GF2131@hirez.programming.kicks-ass.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 21 Nov 2018 14:36:57 -0800
Message-ID: <CAPcyv4hP8X6-L9a8AXWse7vHW0g-81jSk5e9_LRq4Hj6=nS9Ew@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 1:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 20, 2018 at 02:59:32AM +0000, Williams, Dan J wrote:
> > On Mon, 2018-11-19 at 15:43 -0800, Dave Hansen wrote:
> > > On 11/19/18 3:19 PM, Dan Williams wrote:
> > > > Andy wondered why a path that can sleep was using __flush_tlb_all()
> > > > [1]
> > > > and Dave confirmed the expectation for TLB flush is for modifying /
> > > > invalidating existing pte entries, but not initial population [2].
> > >
> > > I _think_ this is OK.
> > >
> > > But, could we sprinkle a few WARN_ON_ONCE(p*_present()) calls in
> > > there
> > > to help us sleep at night?
> >
> > Well, I'm having nightmares now because my naive patch to sprinkle some
> > WARN_ON_ONCE() calls is leading to my VM live locking at boot... no
> > backtrace. If I revert the patch below and just go with the
> > __flush_tlb_all() removal it seems fine.
> >
> > I'm going to set this aside for a bit, but if anyone has any thoughts
> > in the meantime I'd appreciate it.
>
> Have you tried using early_printk ?

No, it boots well past printk, and even gets past pivot root.
Eventually live locks with all cores spinning. It appears to be
correlated with the arrival of pmem, and independent of the tlb
flushes... I'll dig deeper.

> So kernel_physical_mapping_init() has a comment that states the virtual
> and physical addresses we create mappings for should be PMD aligned,
> which implies pud/p4d could have overlap between the mappings.
>
> But in that case, I would expect the new and old values to match.
>
> So maybe you should be checking something like:
>
>         WARN_ON_ONCE(pud_present(*pud) && !pud_same(pud, new));

Yes, that looks better.
