Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59817ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CE02075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvRl1Enu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CE02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeGQVLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:11:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32835 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeGQVLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:11:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so2138161ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xdYZ9I+0EGo6ZObYsg7iFyjx14BuzI9pXyO+Vy3hO9A=;
        b=dvRl1EnulBe06Op3iXHe+WrV29i7SjbZWvoUITO4EGE2xjs3synWyczLNzU4aONdS2
         aGNGi9p7h5ovqYW2L9OquJtWJLfOVxJkSbFybM5Se1SejdeDsRwDzsSzJc7HTQKZVKnQ
         fFPpnBEvC+R0CNwfmNC+feX12Vha12WZ+ljKlBBRyHffcegtmism/wBlp7J7IT/dZcLU
         dqE2WGH+7a45Uz0x3eWHSn2Ft3NobaqnrPaJwq+35cccDBAXwxRlGwSeqAKH5udvmclT
         lUZus4LsrPxp2HPTzKPDxvV4sHqJWpo5kBu7CCa+c67pFAshKKJPWs1Py/ysESrZD1Jh
         CfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xdYZ9I+0EGo6ZObYsg7iFyjx14BuzI9pXyO+Vy3hO9A=;
        b=TS5L5EME6A9kHYeJA7WYSV7OHFV8a5WBDWEuovc3jgK0zMze0kTdTxuFMnKDQgt6p4
         mVN9KfjUzIY/nJIVoaL4hJQcyC9nJ0lflDxzaYB1EDwVda2cCIP3jvWX5i0PMjv6p8M3
         hdgNCNoSC3Eabv9Fu1xk62P3EM+SZyTN4hooZB7aAlOZ65A1yl1M8eg9RXPgvTPtDdLV
         Kwoz0TZaUWyOZ4njtf00qe9HLWha6i2UQu92vAQ5zxbQnOOsvbkFl86bn/snz9aVVx4v
         NCvFYri8fT6irZwauuTGM+xmCegFH5aw+vQy7JNuMSAFGOuA4c6QNcqGk0+7Ah5Tuz+2
         9AzA==
X-Gm-Message-State: AOUpUlFJ/biylMpEemxZGW+IdEkhOtAurdCeK7V3U1biQhMNTrAyJE2h
        8SmKMGVTAlvGfabT4JuYdOE3QtARA+FsAraVhBA7id3j
X-Google-Smtp-Source: AAOMgpfk5Hr9mflVN3RzaJubNkSDb6tUjrkMSSa/neCwhVv4MC+EWU3YTszNf+uatCv4xhRNJO2TAFzFDgbiHvNuavw=
X-Received: by 2002:a2e:9599:: with SMTP id w25-v6mr2443575ljh.6.1531859846892;
 Tue, 17 Jul 2018 13:37:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:37:26
 -0700 (PDT)
In-Reply-To: <CA+55aFxjx+naf3vQ++kqxBNS=dvevPebcKOzA=OYWfMJZ2CrzA@mail.gmail.com>
References: <20180717135307.3713325-1-arnd@arndb.de> <CA+55aFxjx+naf3vQ++kqxBNS=dvevPebcKOzA=OYWfMJZ2CrzA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Jul 2018 22:37:26 +0200
X-Google-Sender-Auth: -ALq-XOyXcy-RxGzHzSRmGgK4LA
Message-ID: <CAK8P3a3XyrfU0pFkSLVmaWwEC1g1uhPjDxsx8+jNjZUQ1K+HbA@mail.gmail.com>
Subject: Re: [PATCH] random: fix rdrand mix-in
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, tcharding <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 6:26 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jul 17, 2018 at 6:54 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> The newly added arch_get_random_int() call was done incorrectly,
>> using the output only if rdrand hardware was /not/ available. The
>> compiler points out that the data is uninitialized in this case:
>
> Ack.
>
> Except:
>
>>                 for (b = bytes ; b > 0 ; b -= sizeof(__u32), i++) {
>> -                       if (arch_get_random_int(&t))
>> +                       if (!arch_get_random_int(&t))
>>                                 continue;
>>                         buf[i] ^= t;
>>                 }
>
> Why not just make that "continue" be a "break"? If you fail once, you
> will fail the next time too (whether the arch just doesn't support it
> at all, or whether the HW entropy is just temporarily exhausted).
>
> So no point in "continue". Just give up. Maybe it will work much
> later, but not _immediately_.

Makes sense. I found that a bit odd, but didn't think much of it:
on all architectures other than x86, arch_get_random_int()
will return a hardcoded 0 from an inline function, so the compiler
should be able to drop the entire loop either way.

On x86 however, it will keep evaluating arch_has_random()
pointlessly.

> (I don't actually see the commit in question - it's not in my pile of
> emails only in linux-next, maybe there's some reason further down
> prefers "continue" and the whole loop be finished).

I didn't see one.

      Arnd
