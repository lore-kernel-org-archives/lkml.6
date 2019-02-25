Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DB82083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gmzeN37K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBYTVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:21:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45491 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfBYTVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:21:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id d24so8185607ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5SLgh2ad68hmmQc3bNpzmrTEgnoW3E1pfzUpWQo3k6w=;
        b=gmzeN37K0YG/6dkLjIFAP6yUIZYCbcfpbac4ljy5i1AWN3X4kak9G3EPcEJhqlzy41
         8hAAwMeGv3MMg6mEFcz0j4vLXiQ2s77JQcqqu4mHjvWB+bPT49eSNY9zbLY3vLhFaABW
         sEN3oGJemXwTMQ6jprPfNFmtmq3cazlEwCj4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5SLgh2ad68hmmQc3bNpzmrTEgnoW3E1pfzUpWQo3k6w=;
        b=FTB5MZdjMESPfJR0NJu9Sfbi8q2mQgsi2G9b4OuHxzmab7VShdhy38r+qFHhiuiVBx
         A3FdJ6JdUrBzDZHLlPiaM7ZGG5QlsYNVboBBUPlYxbfuzNUjOoIsKpAaRYmR244HieZN
         3c4SFJViVBhjvIwl0qkw88PNki6WXiYos8OiHYFDiPwtS4tCrOzdxsFGYFKoRltahKl/
         ZDjqZRJxMU+3oQBW1+7Kxgok4rF+WdM9SPh6gMfFV8wBCnhMZ8BCnre0tG8qkabuOcTQ
         SqX1MXvW4MeKDHL3gDBZUMMBF3E1j20fjVO+n6RdbYUQWF0qtGFXeZaRG6P8z9lhe4wC
         VTFA==
X-Gm-Message-State: AHQUAuapQV7iKlZmNcjQ20tJN8c53sHskOLu6HVviTjjDI5Z0XIFZqYg
        PmUqXRO3xXUxKP75RfTAbpMamkRh6ys=
X-Google-Smtp-Source: AHgI3IbTozqBB9MVbaBswCiuVs1qt1zqoWrLN06Ou45CU8m0R+N3F8QiFIdRzf/fiOgnNuuPlzNOkg==
X-Received: by 2002:a2e:8644:: with SMTP id i4mr10635538ljj.192.1551122459532;
        Mon, 25 Feb 2019 11:20:59 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id p21sm2760306lfd.4.2019.02.25.11.20.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 11:20:58 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id d24so8185490ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:20:58 -0800 (PST)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr9689132lji.79.1551122458021;
 Mon, 25 Feb 2019 11:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20190225191109.7671-1-bp@alien8.de>
In-Reply-To: <20190225191109.7671-1-bp@alien8.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Feb 2019 11:20:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjOtNqb98XxYks0PMdhqgNiu97_hDxqOKG8Sz3F8H=VcQ@mail.gmail.com>
Message-ID: <CAHk-=wjOtNqb98XxYks0PMdhqgNiu97_hDxqOKG8Sz3F8H=VcQ@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: Remove unused __addr_ok() macro
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:11 AM Borislav Petkov <bp@alien8.de> wrote:
>
> This was caught while staring at the whole {set,get}_fs() machinery.

Heh.

You should probably have researched _when_ it became unused.

That seems to have happened in commit 5723aa993d83 ("x86: use the new
generic strnlen_user() function") which removed the single user from
the x86-32 version of strnlen_user(), which used to have

        unsigned long mask = -__addr_ok(s);

in it.

Way back in 2012.

Ack.

                 Linus
