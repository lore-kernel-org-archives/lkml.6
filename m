Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B17C6778B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611C02781B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bYcuY3Dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611C02781B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeF2RDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:03:25 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40100 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeF2RDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:03:22 -0400
Received: by mail-io0-f194.google.com with SMTP id t135-v6so9062752iof.7;
        Fri, 29 Jun 2018 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXLquTH6VPFikEBQcUIKH2gS1OeMQHyP1aEiY5BxmGU=;
        b=bYcuY3Dd+kPqEKk7T2RNnfNX6m5hT9DdOVLHKjKTlEpa2MfFFFbMmsD3rcKDBpOwQi
         vgkV/sVQ51juYFOB/LMFfMojqJYOBuDJO8UxntSsxKeUs4wbM8itZtJTe1hPEOgRMVtm
         EOCCMCILYQ7CKjbU7cc+xAPMk4mSk45AQRqZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXLquTH6VPFikEBQcUIKH2gS1OeMQHyP1aEiY5BxmGU=;
        b=pWQbRL8FZ9H9sa5pD+j1dUW/ag34EFv4aW9dszAOKqA/8mvrSJICjzGOg7C9R2Ll4i
         OCZ0bfNgSjPNPTLRfU0foqztGRRHZVrKWB6mfgwK+bvztrmT1bLwhjgG4bygegbtJq5W
         tcbzNCEJ+X2mO9Nbz50z3mvo3VffTNSTe5TAcgEEPzJ60A2IWpktiI+TSSdmC8+pLOo5
         1/0ka1/tu6xaUuXwIPeSEQn51M+sGMpsgzUHXdlKgc0GkNzJWn6Rn2h2LHgSCwHT+V0z
         01HuKFYpIvgc3DQpeiW6TAeR6A7mQ6wWfQcRxhsPOPoLlz4bhXkOt37Gj3gT1Ov4zAWR
         ArQA==
X-Gm-Message-State: APt69E2f9NUTU+O5KZdysWzYPj0eOQyvwBhvLbJenBkKmZejrA70Fiym
        yb3i9lWDYH+8ftVKHVJOP5vBz6ev7KupH3QBcnU=
X-Google-Smtp-Source: AAOMgpc5kwgO1MUXbRu1A90KkhqFtAyPobcoZNj2fl8HSeLzMqtSeFYCC8MnP9fsy7u/8ER6MmTqNCTvJBU+1fRWItQ=
X-Received: by 2002:a6b:980e:: with SMTP id a14-v6mr8322290ioe.238.1530291802040;
 Fri, 29 Jun 2018 10:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <9200ED2A-AE4B-4094-81C9-E92240B4840F@amacapital.net> <CA+55aFzpD5xF80iiFNd+EMkJnRQdKPumM5p24Sr+LeBt8Gg=wg@mail.gmail.com>
 <1706339668.9644.1530281144560.JavaMail.zimbra@efficios.com>
 <CA+55aFxRJWjbgLeSQ_swi3F5nF1SYgZnC-R7QsOvZdcuSaWeaw@mail.gmail.com>
 <729451355.9702.1530284622326.JavaMail.zimbra@efficios.com>
 <CA+55aFw==YnFJn7iGnKMW=RbPT74YHNa0QDF96mEdMPA2oX9SA@mail.gmail.com>
 <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com> <247789350.9741.1530288432573.JavaMail.zimbra@efficios.com>
In-Reply-To: <247789350.9741.1530288432573.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jun 2018 10:03:10 -0700
Message-ID: <CA+55aFz8KyVqFsVnp-6g+thz7vmm5nK_FSdRTPSks7gsNVNRdQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 9:07 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> This code is not invoked from syscalls, but rather on return from
> interrupt/trap after a preemption.

But when we register the rseq, we could easily check that the top bits
of the IP is clear, no?

Sure, user space can change it after the fact, but at that point it's
literally "user space is being intentionally stupid".

The real worry is that 32-bit compat code never initializes those bits
at all, no?

                Linus
