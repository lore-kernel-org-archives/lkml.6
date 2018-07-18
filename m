Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B464BECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7942075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ID3mbr1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7942075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbeGRXyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:54:07 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36661 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeGRXyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:54:06 -0400
Received: by mail-it0-f65.google.com with SMTP id j185-v6so6775107ite.1;
        Wed, 18 Jul 2018 16:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kvc+RjayhfwVtxtOtRYYL3aCt9CTr+SKqvY1kns2YWw=;
        b=ID3mbr1abJ1UrmSemuwSnUwmBd0cooTdA15Y0fH/VzdA7Lf5eg9AHGEI24/C0tOAAf
         kL+k9rptNF4H7wlEDFvHsbZK07ZpLM5kAnf8L2pU8QmXec5w3b+rwGVKURM+mLTtZA8t
         Y9AjYZvmp0pn6bnI5nf8MTUfY6rJoAR5gSK3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kvc+RjayhfwVtxtOtRYYL3aCt9CTr+SKqvY1kns2YWw=;
        b=ucfUP1QcNag93bUmmW8Zxyh2czMgeYFO7mqeRHnPCzVCssjNb3u4+UcM8IPywvQ/oG
         3NTax5kKcwxbC9jM7QWxQQbDeyOuFxQONrTojS2JFtcsxcdj0Oi9xGblVr8Kt42VNglR
         bmoydwVr/IPmzly1MkGB03b/0EryLsLzD83gDNa3Ui0PcH0kMeuyVIYrqrgcTe8E+Yqt
         OnNR8Naqud0hmniDCfpi327Hip6tKrcoLXkqdIH4wWw+TNHTYRRlFPY1NgvHRxHNPqFM
         88GWwzitVnyzSNdYPxgJuIggMkrdvrh07xW/oEykuSDrg5Q4CqzpvVKuEikeA221oM5O
         gexQ==
X-Gm-Message-State: AOUpUlFTG8ZUJeYAEUapESMPX4K7ZDJTIu/KTbjV7p28mSp8b6ojW97w
        l3kcbIATG5WAqsERIU5GLrbmpuT/nzn+zEciL2sAzNKx
X-Google-Smtp-Source: AAOMgpfgvLhOHYJwmKv5oAuM9zdXpddoQHt3BYOUdmohT5otWjcqhY0y3cepC8B9UOV23bBn1WduurDw89VpTCmUepw=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr3657097itm.113.1531955636277;
 Wed, 18 Jul 2018 16:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180711161540.GS30522@ZenIV.linux.org.uk> <20180712124326.GA19272@ZenIV.linux.org.uk>
 <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
 <20180712155337.GU30522@ZenIV.linux.org.uk> <20180718025636.GA26175@ZenIV.linux.org.uk>
 <20180718132955.2bf185b7@canb.auug.org.au> <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
 <20180718124340.GS30522@ZenIV.linux.org.uk> <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
 <20180718181252.GU30522@ZenIV.linux.org.uk> <CA+55aFxh62Yttq-W2Cr_YQQ5tAL1xjijjnaz1-zdZNqZPQFM0g@mail.gmail.com>
 <15659.1531949324@warthog.procyon.org.uk>
In-Reply-To: <15659.1531949324@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jul 2018 16:13:45 -0700
Message-ID: <CA+55aFwMXV7wC4jvNZ9wiVyTn9Zio+n-r91jGj1xsT14GZJndw@mail.gmail.com>
Subject: Re: [RFC] call_with_creds()
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 2:28 PM David Howells <dhowells@redhat.com> wrote:
>
> Are network filesystems allowed to use f_cred at I/O time to determine the
> authentication/encryption parameters to commune with the server?

Absolutely. file->f_cred is very much "what was my ID at open time".

Of course, you may well have reasons why you actually want to cache
the key itself (and hide it in private_data or similar rather than
look it up, but if looking it up by uid is ok, then file->f_cred is
ok.

And if you check permissions at IO time (again using file->f_cred),
that's ok from a kernel perspective, but it's not really
POSIX-compliant. But obviously a lot of netrwork filesystems aren't
posix-compliant anyway.

                  Linus
