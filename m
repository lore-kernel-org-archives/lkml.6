Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEABC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F90B23CCD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="boO3KxJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F90B23CCD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932535AbeGCCog (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:44:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53638 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeGCCoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:44:34 -0400
Received: by mail-it0-f65.google.com with SMTP id a195-v6so1060139itd.3;
        Mon, 02 Jul 2018 19:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tWufW4CXMCA2e8nqe8Z2uXnWilwGXlAVpEl0VpSkwDQ=;
        b=boO3KxJJbXLNpbCKoC4t7w3BKzrOMP2AJQbspmQ5u85ziLUIXe1RzeTcnXXdhF8kuO
         J8SiexzQWPxHpBPIR+w5WpGEzx+sn6fZriD1KAuJg7dxU3+79NGk+/j9rowGhupHqECU
         perJ2rzyBU1eUBLSvhWWwIoIWWzm5Jry30bDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tWufW4CXMCA2e8nqe8Z2uXnWilwGXlAVpEl0VpSkwDQ=;
        b=h7NqNZMeZ5A2P+d8iFs/f1Kgb2PDwGGgQow1ih1RMBhkAmMrHnAh1cOtbyNIy9DTef
         dLOGsGsKH0EoY3IQrARKNcgJm6o4lhqPIAgKriu9oL8ZRL82+H+w/2Cf2xPmq8c0iCWs
         e35tp5DddK/PHxXYiTJnVHeS73BTfkKPQkOu0miBjGLCuo2QkpGLV8OE/JUSw+FGPr2e
         lUjk2TNe9yxk8Vs1D7E5u1+h9AkwajNIe5csscWLYf4bJZHAtNxkKpa1+GD7325WnXg/
         9AkFihL1K16n5HwuFeUSLYGqWmhvjNyxbWuWHckMg1q+TUh42oRDZXvupQsJva7uq1YD
         KhlQ==
X-Gm-Message-State: APt69E3VmOh0CBsBK1v8IzLDtXENly91ANv1HvlAlbpcnjNT5ZPw/KMk
        OBaK9CGfiEPx/nkp0T+IHvqpVU1fVx4tyonDgwWWsA==
X-Google-Smtp-Source: AAOMgpeujTOrDCAtbChlZ/KozdFbufDoHgnh2IemmNLmUjcwcFYf94qcQfgD4c1sOuRJPdHCq9wPcRGCZQpeZ0BNeD4=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr7703018itd.16.1530585874095;
 Mon, 02 Jul 2018 19:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com>
 <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com>
 <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com>
 <1959930320.10843.1530573742647.JavaMail.zimbra@efficios.com>
 <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net> <459661281.10865.1530580742205.JavaMail.zimbra@efficios.com>
 <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <CA+55aFxWMjwx-4TGBHt0H6bh6FXC3NKMsjp=eKGw5cgA4wMBUA@mail.gmail.com> <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com>
In-Reply-To: <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 19:44:23 -0700
Message-ID: <CA+55aFytFfjRSdWapQ0F6RjuFgy9oSHjMtFpDPwAh4G9QRfUNw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields, validate
 user inputs
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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

On Mon, Jul 2, 2018 at 7:30 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
>
> Is it really ? Last time we had this discussion, not all architectures
> guaranteed that reading a 64-bit integer would happen in two atomic
> 32-bit sub-parts.

All architectures that matter do.

Please don't overdesign this, or try to make a problem out of
something that isn't a problem.

Sure, maybe some toy architecture does a 8-byte "get_user()" as a
"copy_from_user()" one byte at a time, because that's the best way to
do unaligned accesses.

But nobody will ever care about rseq on such a thing anyway. Let it go.

               Linus
