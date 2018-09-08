Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63300C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 00:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B4E20869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 00:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tD7ped4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B4E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeIHFV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 01:21:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38233 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbeIHFVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 01:21:25 -0400
Received: by mail-oi0-f68.google.com with SMTP id x197-v6so30440093oix.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 17:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W1vxdDPtAmulUNUs2/T31hahMNL7ilVK5SxM02gAB1M=;
        b=tD7ped4qJm6Kj8WhTtwgII0mTJ+ATCQkedui6kAM619RQiXkOF9cw49RIq2gH8Mer8
         MmFSPvfBbSYiAMf6B75wfEllvX3p2FTRjpzliofKsxsmv2/2u+v1ghLWbr4NlBsfZE48
         OyOrdESEz7isKAaEUXUwHIIJ3sICNA3xnt9DGPgNXrLNnz2V0HRAc4rj2DZMjhmFyJss
         FHZ0etxWYvbLhZElTviS7P4ssTc5V1t+yMpqaZqPFpzs2sM0y4dEOcKPRNSqOWu9JL0b
         0SbfzXLA87U2LIktxy52J1qrPNpKDQTgUHHW1sV0IbRCUY9VcHi3su6BCze+treYlFP/
         zR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1vxdDPtAmulUNUs2/T31hahMNL7ilVK5SxM02gAB1M=;
        b=CiATqHCNy2oPHdaNMgKSvKyLuhM5rYTZKOfZCBBskTDXPJhei1NMJtx9dFU68McbNd
         Ce+z8Rtiq2HKawTA8Wr4fvqpKNb8goUJJSK2O1+oZvzx6bXYRd6wwPP7ocUUVm9YYRqD
         rcGl9I0syBsi35zSss0fewsmgOSbF7tlJCGKBrwbwAfNFo4/fV0JwDn6b7+UbVHaeUi5
         VgBt0hRnFgiHH//xIKAkvvnF3crndAxcdQ5al+yVRtVsYG73yHHkRV+MyAzbOL3rKWT/
         kB/tLtA53/F1TssK3fPrlYVZ+CnLp/TRH5aN2BCFAtl1kQKzEeJBpEYuLdozuo7mnhPT
         9xOg==
X-Gm-Message-State: APzg51AsO67xbo0ZxoXLEh8aRMpeqOI83yCyTPt5FjCOWIZuPLkdN/78
        V/0T91VOvJFzUYKvsM9IRAgmfYCqSJnZmxargRMDiA==
X-Google-Smtp-Source: ANB0VdYi4JcjrphCvHXA+H01sD3d7PrAM71Mh7UCoHRMtXrIT//qd2+LbrJCFygjJJdpsCWvKEuyXGDUwA9LSkNLPbc=
X-Received: by 2002:aca:e504:: with SMTP id c4-v6mr10144918oih.246.1536367074472;
 Fri, 07 Sep 2018 17:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180907194852.3C351B82@viggo.jf.intel.com> <20180907194900.DF3B41C0@viggo.jf.intel.com>
In-Reply-To: <20180907194900.DF3B41C0@viggo.jf.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 8 Sep 2018 02:37:27 +0200
Message-ID: <CAG48ez1wuPaYmjNpuhA9pUhg+4Eu33Kavtmd9Ew8qq-NDHrwzw@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/8] x86/mm: fix exception table comments
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 2:22 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> +        * Kernel-mode access to the user address space should only occur
> +        * inside well-defined areas of code listed in the exception

Actually, not areas, but single whitelisted instructions. It would
probably be nice to say that more clearly.

From arch/x86/include/asm/extable.h:

/*
 * The exception table consists of triples of addresses relative to the
 * exception table entry itself. The first address is of an instruction
 * that is allowed to fault, the second is the target at which the program
 * should continue. The third is a handler function to deal with the fault
 * caused by the instruction in the first field.
 *
 * All the routines below use bits of fixup code that are out of line
 * with the main instruction path.  This means when everything is well,
 * we don't even have to jump over them.  Further, they do not intrude
 * on our cache or tlb entries.
 */

struct exception_table_entry {
        int insn, fixup, handler;
};

> +        * tables.  But, an erroneous kernel fault occurring outside one of
> +        * those areas which also holds mmap_sem might deadlock attempting
> +        * to validate the fault against the address space.
>          *
> -        * As the vast majority of faults will be valid we will only perform
> -        * the source reference check when there is a possibility of a
> -        * deadlock. Attempt to lock the address space, if we cannot we then
> -        * validate the source. If this is invalid we can skip the address
> -        * space check, thus avoiding the deadlock:
> +        * Only do the expensive exception table search when we might be at
> +        * risk of a deadlock:
> +        * 1. We failed to acquire mmap_sem, and
> +        * 2. The access was an explicit kernel-mode access
> +        *    (X86_PF_USER=0).
>          */
>         if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
>                 if (!(sw_error_code & X86_PF_USER) &&
>                     !search_exception_tables(regs->ip)) {
> +                       /*
> +                        * Fault from code in kernel from
> +                        * which we do not expect faults.
> +                        */
>                         bad_area_nosemaphore(regs, sw_error_code, address, NULL);
>                         return;
>                 }
> _
>
