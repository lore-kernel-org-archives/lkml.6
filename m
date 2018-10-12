Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA78C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C7720865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1WKYKsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C7720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbeJLU6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:58:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32919 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbeJLU6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:58:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id q50so12379290otd.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1bN5G+XKGxUs+23Ib3MwF0bz1K1t5vyGLPbrQpB528=;
        b=Z1WKYKsyAfvPowq5lkcn19UyCPjtwVJhEvh/9ETxSW+/QC1Rw5jA88iECYizFcPLdn
         a40LbctNnqCauDRgQhg2m939bElCpm6dp/B4gGfm5TmxI+N8VvcK1wmcItz+qNX6nbH7
         OEeQXfIna68Isa5eFRxQsDPBKyJBjEkiA0F9553VOnKp/s8oKq1mr8GCERmKVJIyDAeA
         paa6J95PN+mkGZeqP6Ik2OHD6ppKacANMTZALCWnB3uyIeOL/UkB7WyPXxqJNqx0/UmD
         YoCBuef/SQ0WvkWzM2gRnUEDtzEf8ctb81QhRcP5C/KUEU7BjswZLIvSK/jsDlQDY5GC
         Ck6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1bN5G+XKGxUs+23Ib3MwF0bz1K1t5vyGLPbrQpB528=;
        b=iuLPR9E7oKlcbkPgh2ln84WPJ5KxYF4S4RHv6MLelFFU/vA01qkjyuqXr1Fnl7W9qn
         ENLPjkCtURaUt1fKhfvxUR74Q3viTYDoU256JBOPXhBHtzFzOnvdNZh5WXEf8pF5eqn7
         pH68FtdKoQQehZRYfknF4B0OHUOc5Zsh2yC0Z0BUDTsquukFTfJ+Plbke9gsOTEc2Kiw
         3H4FcqLNhN2c6LBH2CQkz3ysPmOvo+4LzVYb8o+oewbqRrjUoflozUVy7W3eRyLHAkiR
         33Jg7dbp1VeQ88sRsyy93gP+unWTbm3E9QNAbzF13PdFVE4Sa6neBYStIl4a6FV7YXK2
         OBwQ==
X-Gm-Message-State: ABuFfogEmJSB8F8WbyPryLk6jzwT0jOXiQQXI2ZOmCkR1jP+bryJ6tJQ
        vU/AqdFN+CluaxAhzekYCnXMAU8Bgu+Y2oSlE85YhQ==
X-Google-Smtp-Source: ACcGV63Gq7OGezHD4GfeGgsaagkuuFTDgG5m18jLoY29y8LarW34cVuTUJMTd9TSH9Ly4n9E8TfF2kj48YZRFslrgi4=
X-Received: by 2002:a9d:49ac:: with SMTP id g44mr4078970otf.198.1539350773154;
 Fri, 12 Oct 2018 06:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181011185458.10186-1-kristen@linux.intel.com>
 <CALCETrW5sNz-TO8w8e+7d1oD_CmnUX_txnBuKe2+wM7qFaK64A@mail.gmail.com> <CAEX_ruGcWOYuhF6Gtm0a9kh8JsUvZzRLxzi8Q982iiWA2ioYpg@mail.gmail.com>
In-Reply-To: <CAEX_ruGcWOYuhF6Gtm0a9kh8JsUvZzRLxzi8Q982iiWA2ioYpg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 15:25:46 +0200
Message-ID: <CAG48ez0aTJMREb1JL6SaT5rNLs6oUZVevj+BGrUzVEprZNFKOw@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     sneves@dei.uc.pt
Cc:     Andy Lutomirski <luto@kernel.org>, kristen@linux.intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:41 AM Samuel Neves <sneves@dei.uc.pt> wrote:
>
> On Thu, Oct 11, 2018 at 8:25 PM Andy Lutomirski <luto@kernel.org> wrote:
> > What exactly is this trying to protect against?  And how many cycles
> > should we expect L1D_FLUSH to take?
>
> As far as I could measure, I got 1660 cycles per wrmsr 0x10b, 0x1 on a
> Skylake chip, and 1220 cycles on a Skylake-SP.

Is that with L1D mostly empty, with L1D mostly full with clean lines,
or with L1D full of dirty lines that need to be written back?
