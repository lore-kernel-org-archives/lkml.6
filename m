Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20FCC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EF620834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MEtcOJ+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EF620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeJFAho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:37:44 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:42215 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeJFAhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:37:43 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d70b5390;
        Fri, 5 Oct 2018 17:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=sJM2xZ5pstyh+eUmNRLpvJyjYjk=; b=MEtcOJ
        +0akxYb38ucSad3OxdYK8aKz/osuRGSRcTbsdyFMAyZhuKHXKld14WILaamJd/rr
        99Li7I2i/dig7eQcJocYqXlk+PVfL2NflnHLJBZSQ1MbbypClObn1kYBwy8v08hq
        jLjdLsdyKIwtD/uwEALk/qg70jQkvgFIgRktR3NN5yd699FUqz1drdpWZOW/GTlQ
        5y6xbWRgoTuzdiJTMczKJOOo/zXVvtdIxLiPDQND6ADzKZNIvH+t7RiRX0EdXq2Q
        Japg+dKrBmxvEWH7GtYMGOdyoGOKIIKprGH69eYTIC2qKn8YJIJlgi/Nm1oI4oAT
        ucXk0Jesl8uHAGoA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4f6278fb (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 5 Oct 2018 17:37:31 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id y81-v6so11050696oia.6;
        Fri, 05 Oct 2018 10:37:57 -0700 (PDT)
X-Gm-Message-State: ABuFfojjK4B85JLOKAX6lLnsFuO1r55XZ0UkiJDj6oG3FYYKcBQnvrXt
        DAOKJBquEG9Ys2LP0qiazgFIJPyOnMbnKIdyJZY=
X-Google-Smtp-Source: ACcGV63HrUPCNwTe+qa0U1mdJpTIXnbp4ml2S10xIOuzmw4JB7vaQwjHA4F7/vnqW1OYrmJdRzUubOypSXCKqRbbr0A=
X-Received: by 2002:aca:b04:: with SMTP id 4-v6mr3891323oil.192.1538761076036;
 Fri, 05 Oct 2018 10:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org> <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net> <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
 <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
 <CAKv+Gu-oHBtgGbWXJu6+z4+BNhBZyY5VvF_v6cJJUGk_5YX1eQ@mail.gmail.com>
 <CALCETrU=fm+ZG4WZJfG-5GwL7kv5_GS1aZYu=L42d5BuSbhJDQ@mail.gmail.com>
 <CAKv+Gu8eHPEsUbkhN=61z9FvhdCo2e3VOdemp4g0bzdO1EJFYQ@mail.gmail.com> <CALCETrVMBULVP9qEQDVuisxAMzdheM1qQ97AZFs-xcO0eaXiiA@mail.gmail.com>
In-Reply-To: <CALCETrVMBULVP9qEQDVuisxAMzdheM1qQ97AZFs-xcO0eaXiiA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 5 Oct 2018 19:37:44 +0200
X-Gmail-Original-Message-ID: <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com>
Message-ID: <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function pointers
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, benh@kernel.crashing.org,
        paulus@samba.org, Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, richard@nod.at,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 7:29 PM Andy Lutomirski <luto@kernel.org> wrote:
> (None of this is to say that I disagree with Jason, though -- I'm not
> entirely convinced that this makes sense for Zinc.  But maybe it can
> be done in a way that makes everyone happy.)

Zinc indeed will continue to push in the simpler and more minimal
direction. Down the line I'm open to trying and benching a few
different ways of going about it with dynamic patching -- something
that will be pretty easy to experiment with given the lean structure
of Zinc -- but for the initial merge I intend to do it the way it is,
which is super fast and pretty straightforward to follow.

Jason
