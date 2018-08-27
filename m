Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1C5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA121208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yjcp6TpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA121208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH1DXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:23:43 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33370 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbeH1DXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:23:42 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so1375520oip.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQAZoDUdDICPMtjrPU4kKGmlSTIoMBB+bmXKKFvwp4k=;
        b=Yjcp6TpP0Ha6f2rJB7xDQeSu2yVcQc/yHqhj8AA/D6LMedp84HYZC6Ae3UbFgQbX+L
         H56H8MAHF8W1G+hd0MbxsQAmA3cbIR3Ti5Y3nCTyyfCqyViSMD9Aj7MXFjtYPUNHjGMq
         N9sj9fyuP8eKgSHIbbZyoalV3HrKJijWUgljANy0/EK+v15rGGzW1z6bT4dRQ16yM/P4
         ggFyHggar8lCArQ+l8GVv+vqn5FaUKZPahxo5AonEwncNTw7VMRC1KMZ6rZTZTQvKMFj
         TM8d3MBKvnZdHVrtKREpKpFC16vqmGwBcV4j/FY9RAJzoUep31LC03/Qzr+dVvuBbwfG
         /jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQAZoDUdDICPMtjrPU4kKGmlSTIoMBB+bmXKKFvwp4k=;
        b=N11fPqX3+Lor66Lki9jQj0vmtbh97+IPGE91bI7cVWx9imvJcQcPtpBDJV3+ycSdnb
         xJfP0vcfLwA0JoCBjP9+YhEWRyGmFalo28bzWB65RlX3se3EqYM8Ib1E7KW1O8p5LwF/
         eEDQguoxaUC7nIjJ88cHJmP3w2AyojPMPyQan/BBsKYo2kH2BXevnXrwkHk6Y90uOYlf
         T56UoXmb6LJSQU7fjvJZlDWDoHNrr3+PF2op4tY/wyL/I01LsQE0DDhj15/A7B5/1sqe
         s33ukCIz9AtEhcRz5Lxa0NJFblQeVAif4q+PNO8IE8uitAbcD+UvY/82KyQBGXeNpCfJ
         X8LQ==
X-Gm-Message-State: APzg51Bt070MqSdf+iu17syALNF6tsN9poLBmJKrchZEDF0seXlUPcZ1
        pIX5Y/tYtB+HQDRE7OuMktex8yQkL137EzPH5KS//w==
X-Google-Smtp-Source: ANB0VdaGmvw1UMqpFIK3WcgSM322Va2iKqRPAjBt/j/kWAHEagBEs1p++FL6wctbKD1FB/vi9ORhbv2fHNjsoIcLS3M=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr711788oia.229.1535412891856;
 Mon, 27 Aug 2018 16:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <c7ee1ee7a1b8d17743f7c3680ea5d2c32bf3e897.1535410956.git.luto@kernel.org>
 <CAG48ez2DkjrvmP57JvbC+4ee0qCXCEXEyYuA4YApWGX_k29y_w@mail.gmail.com> <CALCETrXHaAFARQ4Gq2ku1DMbD+78cx1JjWDpTenbNns4OWT+FA@mail.gmail.com>
In-Reply-To: <CALCETrXHaAFARQ4Gq2ku1DMbD+78cx1JjWDpTenbNns4OWT+FA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Aug 2018 01:34:25 +0200
Message-ID: <CAG48ez3+HLOhyXY64wt4_LKv4qKq8A0KQmuSg05945ZrDjgowQ@mail.gmail.com>
Subject: Re: [PATCH] x86/nmi: Fix some races in NMI uaccess
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 1:26 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Aug 27, 2018 at 4:12 PM, Jann Horn <jannh@google.com> wrote:
> > On Tue, Aug 28, 2018 at 1:04 AM Andy Lutomirski <luto@kernel.org> wrote:
> >>
> >> In NMI context, we might be in the middle of context switching or in
> >> the middle of switch_mm_irqs_off().  In either case, CR3 might not
> >> match current->mm, which could cause copy_from_user_nmi() and
> >> friends to read the wrong memory.
> >>
> >> Fix it by adding a new nmi_uaccess_okay() helper and checking it in
> >> copy_from_user_nmi() and in __copy_from_user_nmi()'s callers.
> >
> > What about eBPF probes (which I think can be attached to kprobe points
> > / tracepoints / perf events) that perform userspace reads / userspace
> > writes / kernel reads? Can those run in NMI context, and if so, do
> > they also need special handling?
>
> I assume they can run in NMI context, which might be problematic in
> and of themselves.  For example, does BPF adequately protect against a
> BPF program accessing a map while bpf(2) is modifying it?  It seems
> like bpf_prog_active is intended to serve this purpose.
>
> But I don't see any obvious mechanism for eBPF programs to read user memory.

Look in kernel/trace/bpf_trace.c, which defines a bunch of eBPF
helpers that can only be called from privileged eBPF code. Ah, but I
misremembered, the userspace write helper does have a guard against
interrupts, just the arbitrary read helper doesn't.

BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
{
    int ret;

    ret = probe_kernel_read(dst, unsafe_ptr, size);
    if (unlikely(ret < 0))
        memset(dst, 0, size);

    return ret;
}
[...]
BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
       u32, size)
{
    /*
     * Ensure we're in user context which is safe for the helper to
     * run. This helper has no business in a kthread.
     *
     * access_ok() should prevent writing to non-user memory, but in
     * some situations (nommu, temporary switch, etc) access_ok() does
     * not provide enough validation, hence the check on KERNEL_DS.
     */

    if (unlikely(in_interrupt() ||
             current->flags & (PF_KTHREAD | PF_EXITING)))
        return -EPERM;
    if (unlikely(uaccess_kernel()))
        return -EPERM;
    if (!access_ok(VERIFY_WRITE, unsafe_ptr, size))
        return -EPERM;

    return probe_kernel_write(unsafe_ptr, src, size);
}
