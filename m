Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A38ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D1C2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b1fn/UD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D1C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeGRX5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:57:22 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46777 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbeGRX5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:57:22 -0400
Received: by mail-io0-f196.google.com with SMTP id i18-v6so5521616ioj.13;
        Wed, 18 Jul 2018 16:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VGnjQVyiEIv3D4SrVZwD74LjjQdW4ZKDWRDwDJnmdM=;
        b=b1fn/UD4WUAGhPLG5V6j2jLGSqXpG6jOFcUAa8TAIlcWFqFGoZH0Oo37Fc7iVIfmfd
         9tPZEq2Nf34fElrdWw6zqoaV7lKriQPax2SQcvuWw8evmSDfZmkrApLUUH3bOYN8NJv4
         O/Uxa+ZxmJwi3Oie/tCXHykGNDKzOoHDrHAGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VGnjQVyiEIv3D4SrVZwD74LjjQdW4ZKDWRDwDJnmdM=;
        b=RElElHdudS8wEYJA0BNoHghoG1SczQ3Hd7C8mT3W7rifgqFvryD0k1UkkTMFgqaTRW
         t1c1RGPKbW/vLLoQ8DuGN/7mQJL4wwWDgOovhG8Jsq+Pp5nojGods1hf/3n0mJXo5bkP
         XelCAgiBXba8YoaM+x5CzK67iSaV1DfxHGHupdpya5w6fyYKtMWO9DYOHvUKTwJgPojz
         twPU17av2ax1Q6wW/ultpGvoJ/zOkXslY0YwtmfsPWebK6Y2PD97e7YkXqRtesR9XPua
         VEBf+UIC/6UiS7An38tFwdMO7nLtmVxu4uZO80D4iLF5Hh23fa/Od7sEzgMOUrtxDb2/
         tQmQ==
X-Gm-Message-State: AOUpUlGhVxJAiHwy2AYe0SdERlgCVuHiO4OiZM9TbDc/8e/uqqpaDGEc
        FswABEwy2oo6OX9yh0meBzMeAujxlYFOXIF7hpU=
X-Google-Smtp-Source: AAOMgpeFILslLjkMP28ihB64vGfEHZ9qJ8J+ZF1SOZnnEZ1b153CDYMPM6apHNQFFaAGIQJ8nr0X7XSaruUe1Qrt+h4=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr7080602iov.203.1531955830887;
 Wed, 18 Jul 2018 16:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180718025636.GA26175@ZenIV.linux.org.uk> <20180718132955.2bf185b7@canb.auug.org.au>
 <CAOssrKf60FHqgG6pB5zOP7iV-qdHdDUODdG7SVpoNh3Pipo=6w@mail.gmail.com>
 <CAOssrKdqnsPSipweUCers6d2AgJX2aVGQUs1pd7cB79GoSJH1Q@mail.gmail.com>
 <20180718124340.GS30522@ZenIV.linux.org.uk> <CAOssrKcS+kwK+S1aojhbW_4p8FJLPaafBDqDu89d=F14wT-0rw@mail.gmail.com>
 <20180718181252.GU30522@ZenIV.linux.org.uk> <CA+55aFxh62Yttq-W2Cr_YQQ5tAL1xjijjnaz1-zdZNqZPQFM0g@mail.gmail.com>
 <20180718194637.GV30522@ZenIV.linux.org.uk> <CA+55aFydd9ji2eJSNVK7Fjpziehvm6fO3b1eTeUAn0L1tk3GmQ@mail.gmail.com>
 <20180718200411.GW30522@ZenIV.linux.org.uk> <CA+55aFwhnOPO26ubjJ9WhK6YT8JqD5_UTGmNLFWbPdv-On99=w@mail.gmail.com>
 <15538.1531949263@warthog.procyon.org.uk>
In-Reply-To: <15538.1531949263@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jul 2018 16:16:59 -0700
Message-ID: <CA+55aFzoh5GRD-R8Pm+gTqNb9St=x=2ebv_mDgzSP2_-8LFkkA@mail.gmail.com>
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

On Wed, Jul 18, 2018 at 2:27 PM David Howells <dhowells@redhat.com> wrote:
>
> As I may have said, I have tried modifying the kernel to pass the cred pointer
> down.

It should always be there in the 'struct file *'.

Now, we may have some broken stuff that passes only inodes down, but
they probably really should be fixed.

> The drivers and ioctl() implementations are/were particularly nasty in
> this respect.  So many of them were doing checks against the current thread,
> not f_cred.

So ioctl() may be ok, simply because at least you shouldn't be able to
fool suid programs to do ioctl's on untrusted file descriptors.

So using current_cred() is still technically very wrong, but it's
probably not a huge problem in practice.

Now, if there's some cachefs kind of "do ioctl at the behest of
somebody else", then *that* would be a problem. I'm hoping there
isn't.

               Linus
