Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-986160-1521539339-2-3632510958750986117
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521539339; b=iSdZEvQ/q2wWDcNnXF3QBZZ11VK0qUS8QERSRBix0M4fT69
    OT2GzjL3PWUU78BnpfJ2Zu0SutARgfR0inJVWarevdNzIetfpCxPr3qfgUcc2e1d
    UQfl4sF2yTB7yWjLCc8N1MBJDbsiJ0gAKE+k7fjGq5cVDBZgKsTobv8xlhlD/DkM
    8x3Z/UELAH2CcQwE5RTRL0o72hh5WiMo4XcjER54WSyH1FX8Ps6Pyft3/TmrtbTn
    jxikRONUcIhJBnMMwMsPt8lQjuDuQWUcvpH1RRvkBzWONyZgfNIBZ61KgXyg6q/c
    i2pNCFhyewc7wgZbFYHitsH24n5+ddkavsgP8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521539339; bh=JedHAULSuzxsBiQ/7+5wxZVoGyDim+lPeKjit3
    wBo64=; b=mbp2zytFxnYldnD+Le49g5jq+8rEk75sRzLl4toU6kMxLwAE5s16lM
    r6oibM8oArWP9V2xJ8OP7UzTuE+lrGgDQnwD0lVBlSqkjpxgcIIf/31oY4RFfks2
    8WCZWinpM1/QPqTalv3P3VIaDYDtnT7rX4l3i2M98Cwm0+DefyB+yHZLfSWrepoG
    9mgB2eUDcCfwQqePHBewoshq+QPvoNcssL9xDSwsnQTY/G1MkYejDFzdNL6ovbgo
    VZ3hwBz37NpZdSGozWaVPVEeulrdl36DYDcdVjkiuiGaFWr6zEpbBSMZGqVYLnMA
    nxt/YiKweLublR1r7k37tnWHaqWyhEgw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cdqOCGMB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Sx6Ant8Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cdqOCGMB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Sx6Ant8Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeCTJsv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 05:48:51 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36167 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeCTJsu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 05:48:50 -0400
X-Google-Smtp-Source: AG47ELvsqcqxYp4/p5yKqQXroGbmUfhVmfXqE3mHMv2/QSJ30gGvs2BTLzmcisxlNpz5FewvQoyV3z5xWht0gLlPuRM=
MIME-Version: 1.0
In-Reply-To: <20180319161117.17833-44-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com> <20180319161117.17833-44-alexander.levin@microsoft.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Mar 2018 10:48:48 +0100
X-Google-Sender-Auth: 3tmHjvKrlDzFADFI_CUKonySZbM
Message-ID: <CAMuHMdUHR5-ULz_9Az1dq4CreydBA4xceeozhitJ=JR2vRhraQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 3.18 044/102] fix race in drivers/char/random.c:get_reg()
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sasha,

On Mon, Mar 19, 2018 at 5:12 PM, Sasha Levin
<Alexander.Levin@microsoft.com> wrote:
> From: Michael Schmitz <schmitzmic@gmail.com>
>
> [ Upstream commit 9dfa7bba35ac08a63565d58c454dccb7e1bb0a08 ]
>
> get_reg() can be reentered on architectures with prioritized interrupts
> (m68k in this case), causing f->reg_index to be incremented after the
> range check. Out of bounds memory access past the pt_regs struct results.
> This will go mostly undetected unless access is beyond end of memory.
>
> Prevent the race by disabling interrupts in get_reg().
>
> Tested on m68k (Atari Falcon, and ARAnyM emulator).
>
> Kudos to Geert Uytterhoeven for helping to trace this race.
>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

You probably want to apply follow-up commit 92e75428ffc90e2a
("random: use lockless method of accessing and updating f->reg_idx"), too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
