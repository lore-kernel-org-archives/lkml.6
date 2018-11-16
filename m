Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AB8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A152086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TBvD2Ijk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A152086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeKQDK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:10:27 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41821 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKQDK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:10:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so17006603lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLX8uRLZb0A3oBBx4L2FX6gakeyT9+leIOHPXjQr9lE=;
        b=TBvD2IjkemsKaSr16QfwzdiBYUsZ0MdY9EaS8oXPIs95wKy5bm6D7b3HWMppAutHd8
         9y9zCdGkF+Q+STrok8Thq9whUQnySlh8oFnpsqSNzfl7iHdlcbiL1uDDBG2mUC0pl31O
         H8YxR0lmt57XHrpW2xezT3gha/cgxQZiZNUVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLX8uRLZb0A3oBBx4L2FX6gakeyT9+leIOHPXjQr9lE=;
        b=tb9pUFFRPXd/SY9nsN3NB3Ga9flLhaXAJzWccvcT64PiNyUf2PqtldSzReuXnA96VY
         MH/dWyCztV4dZ5SMSk38FsaAnxZH5S6vO4b/VKnXMAstrjwFEhDAUJ1Oxk+wmm2dlyai
         rKWpdDOg8C/QxD+Ws2FYUWF8+ZYzeq0NUbp/th68TNyj27g5pQaT+hosXWnPtlek1Hy7
         kCpgXj/FVlg7EjP7WkJSkfaepqqqcBgUmbJZC5gVPDF+GJs5H+jMgmLpFQv4ieV2dH78
         XpNZ8wRS0CdUY15/PBPSBxffYWvWl+hJjj/uG/SLa2+flEJrNn5Y6bnN0tsv9M/WCTsA
         SljQ==
X-Gm-Message-State: AGRZ1gJhuACsm5KZAKsDuyDlxYhA0tHUiOok43V9YCYuczRFVH0W0J5X
        rAkFb1RMtEWoiDnztJHTnCkG470SJkw=
X-Google-Smtp-Source: AJdET5c6L2wOKwf/IJGfLMLiyBYbeYSq5CczePQmJo978evc5yXIw8L1qe3/19YfTdN+Vocn34F+BQ==
X-Received: by 2002:a19:c203:: with SMTP id l3mr5758399lfc.113.1542387435213;
        Fri, 16 Nov 2018 08:57:15 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id e14-v6sm4783371ljl.43.2018.11.16.08.57.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:57:14 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id t22-v6so20900935lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:57:14 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr7116901lji.133.1542387433572;
 Fri, 16 Nov 2018 08:57:13 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZ+vw7X12dimJ20SCgv2Bryt8hBSc736tHqAHXVNUi4o6Q@mail.gmail.com>
In-Reply-To: <CACsaVZ+vw7X12dimJ20SCgv2Bryt8hBSc736tHqAHXVNUi4o6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Nov 2018 10:56:56 -0600
X-Gmail-Original-Message-ID: <CAHk-=wj2NoonnH=H3VpfqkPk7t-UyEG8ij5WG0sLOyDdy59dnQ@mail.gmail.com>
Message-ID: <CAHk-=wj2NoonnH=H3VpfqkPk7t-UyEG8ij5WG0sLOyDdy59dnQ@mail.gmail.com>
Subject: Re: Oops: 0003 [#1] PREEMPT SMP NOPTI
To:     kyle.leet@gmail.com
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 8:29 PM Kyle Sanderson <kyle.leet@gmail.com> wrote:
>
> 2008(!) dual-core Atom box.
> [1027541.963573] BUG: unable to handle kernel paging request at ffffffffb0428a44
> [1027541.963647] IP: format_decode+0x20/0x3d0

The code decodes to:

   0: 55                    push   %rbp
   1: 48 8d 2e              lea    (%rsi),%rbp
   4: 53                    push   %rbx
   5: 48 8d 1f              lea    (%rdi),%rbx
   8: 48 8d 64 24 f8        lea    -0x8(%rsp),%rsp
   d: 0f b6 06              movzbl (%rsi),%eax
  10: 48 89 3c 24          mov    %rdi,(%rsp)
  14: 3c 01                cmp    $0x1,%al
  16: 74 4c                je     0x64
  18: 3c 02                cmp    $0x2,%al
  1a: 0f 84 a2 01 00 00    je     0x1c2
  20:* c6 06 00              movb   $0x0,(%rsi) <-- trapping instruction
  23: 0f b6 07              movzbl (%rdi),%eax
  26: 84 c0                test   %al,%al
  28: 0f 84 db 02 00 00    je     0x309

and that trapping instruction is, as far as I can tell, this one:

        /* By default */
        spec->type = FORMAT_TYPE_NONE;

and the fault seems to be a protection fault due to a write to a
read-only area (and yes, we *have* read from that 'spec' pointer
before that write.

> [1027541.965114] RIP: 0010:format_decode+0x20/0x3d0
> [1027541.965463] Call Trace:
> [1027541.965501]  vsnprintf+0x56/0x4d0

This is all very odd, because that "spec" pointer points to an
automatic variable on the stack of the vsnprintf() function, but we
have:

    RSP: ffff9e8c02267ba0
    RSI: ffffffffb0428a44

so it looks like some completely crazy register state corruption.

Is this repeatable at all? Do you see other random faults?

               Linus
