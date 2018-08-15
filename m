Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C50C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 02:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126B021711
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 02:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e3gVpugS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126B021711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeHOEwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:52:37 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50815 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeHOEwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:52:37 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so108036ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 19:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKaQtJTUbTeuqNo3gJGa8vD/yzdxMxxE+e4NR/krCDg=;
        b=e3gVpugSZ1ofuhrjv913M/L63n2xDFKKevV3MdKOdTjKvJrRo8hj2diGMAzplgTsOc
         9rTUQzcsw7VrLrIa8MmiaWKE/rL3YuRnXGbtmUvUpTo0wUGycoj8V0h4qGDYpP3meFio
         LQslornutYH0FPtaeRB3F6AgHIlDgJvnTFLiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKaQtJTUbTeuqNo3gJGa8vD/yzdxMxxE+e4NR/krCDg=;
        b=JDdu5K9cTt5MzclCnQDbDX3gxSqQuRcv8Uy9cEy+vFJVjdd0EGPpSXArupnQQ1dvKK
         jwK2XOHh+yOvCZPzpwkD28W+zzSxkOXKMcbVnuAOzGBlB0AuuCBRYQPzeakIfSKJVJCE
         JLlPk3TmwtnG0ILvBUAXg16/lWKumL9j0Y6BgXFh6+2tjafDMt4PvaMqLVZHT4mp+hRB
         YO9BvqjaHW9dddYA8fczWMZ6gQYz0ZpTg5bsn0xqBudQ/uosJXQP68csgStnZQTtDpX9
         diYjoJEiT28EzwhDfZbS7G8APYOqeTZYDGfmGXnQmGXOcECRwiN9NPFTASA2K486G6Hh
         9XUw==
X-Gm-Message-State: AOUpUlFCpDLmzdwAuRqVG95lXNghwAbAxcQ3kiSqAIzeSbegc1B1wEU/
        f+KSAYcHbdGIZBCmXL3MMtwIk9LXuU3U8Nkp0P8=
X-Google-Smtp-Source: AA+uWPzm2zpIs3QIeUK8bkaRWixemF/svN1Z4hxRY5xrar5/SJ+QCewrrV4p+t62l2+PC9QiVyPi788ae2cOkHQb//I=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr20838972jas.72.1534298558096;
 Tue, 14 Aug 2018 19:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180814221735.62804-1-wnukowski@google.com> <20180814225716.GA3224@localhost.localdomain>
 <CA+55aFw-Fed2QJCYBosGby71AsXAVKGq8mG-HYR13rEnD9V2Lg@mail.gmail.com> <d57e77d8-88e2-b92a-9545-7118de4d8065@google.com>
In-Reply-To: <d57e77d8-88e2-b92a-9545-7118de4d8065@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Aug 2018 19:02:27 -0700
Message-ID: <CA+55aFxOc7_s-BbWJx-kyit-pH9m5fQJk6MSMJ57tFFvMtNh-w@mail.gmail.com>
Subject: Re: [PATCH] Bugfix for handling of shadow doorbell buffer.
To:     wnukowski@google.com
Cc:     keith.busch@linux.intel.com, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>, yigitfiliz@google.com,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 6:35 PM Michal Wnukowski <wnukowski@google.com> wrote:
>
> I got confused after comaring disassembly of this code with and
> without volatile keyword. Thanks for the correction.

Note that _usually_, the "volatile" has absolutely no impact. When
there is one read in the source code, it's almost always one access in
the generated code too.

That's particularly true if the read like this access do dbbuf_ei:

                if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))

is only used as an argument to a real function call.

But if that function is an inline function (which it is), and the
argument ends up getting used multiple times (which in this case it is
not), then it is possible in theory that gcc ends up saying "instead
of reading the value once, and keep it in a register, I'll just read
it again for the second time".

That happens rarely, but it _can_ happen without the volatile (or the
READ_ONCE()).

The advantage of READ_ONCE() over using "volatile" in a data structure
tends to be that you explicitly mark the memory accesses that you care
about. That's nice documentation for whoever reads the code (and it's
not unheard of that the _same_ data structure is sometimes volatile,
and sometimes not - for example, the data structure might be protected
by a lock - not volatile - but people might use an optimistic lockless
access to the value too - when it ends up being volatile. So then it's
really good to explicitly use READ_ONCE() for the volatile cases where
you show that you know that you're now doing something special that
really depends on memory ordering or other magic "access exactly once"
behavior.


> > I'm assuming that's the actual controller hardware, but it needs a
> > comment about *that* access being ordered too, because if it isn't,
> > then ordering this side is pointless.
>
> The other side in this case is not actual controller hardware, but
> virtual one (the regular hardware should rely on normal MMIO
> doorbells).

Ok, Maybe worth adding a one-line note about the ordering guarantees
by the virtual controller accesses.

                   Linus
