Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DA9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AFD20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d83ML8M+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AFD20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbeGQVl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:41:56 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41527 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731336AbeGQVlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:41:55 -0400
Received: by mail-vk0-f67.google.com with SMTP id j11-v6so1358413vke.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6tQthbItpELtx2tcVt6A1Q4NFrs2iYph/zHKnFp+TCE=;
        b=d83ML8M+HyZzQZclz4nDfOe8rxYgkWvY6q/dHQAT2Xg3eJ5mY65HtloBvky9OSqsEJ
         k2JnXjRxUQHom03K50w9BCM7tG6DAC/tZK1SwFodgZ1a5CYPIEmRUR5Lbt70R+5Ut2/p
         glg0bTuX8U+ifQUi4JLTUOgizditEO6W/cL03m9+0brIMFupU6oKPXiZ7i0NOpvpqJsh
         smjBXNkYTX1p+9wDbJXsonSZR1kaE3ro+pXBH+3EZ2pl+S9fjx8X0h9crj++XieDqIO/
         KGUb7hOR9unmihS6XluSTvQrrsUpJNgeCD3vA2yRVHIJ1xNw3MUXZeJcbYoZhKd8kQRe
         /YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6tQthbItpELtx2tcVt6A1Q4NFrs2iYph/zHKnFp+TCE=;
        b=oHBF+9ktlcCxzPNs5NLfCmCjUL7uG/b4J/GJf/M8oG7Ils4qNXAsre66zXQ35tDqkv
         tKu8SrcHCjc5UGuMR1qsVLnOcRjnvdAqg0kGbkYbKSotnfGPOjzDkPNW+19Pb8YEPQpW
         UiXE9nATvr6aoSiqx+IU52dTeHwTrAI4IRpjtlaRPCeCqTMwSvak2Eowx7NvyhVHo0LI
         LIEJlJ7ej/AcgYNh4Ov5J0tsKnOAZR9mvOjtxg5dh7/ePfv5nZPYy390ME3rJSXKUzQi
         ZliU/GMHni23EcJ4wX8/kCb8eXHbmyTJHq8Sd9wTgHSDsLn5IbjZBEBwDdji8neZ9g1O
         3EFw==
X-Gm-Message-State: AOUpUlHIbwfmwVlnEAvvgGfJ/1/EnslQh929PA0nIOtl+15jQSWy9ytJ
        Skgbr7ZTSHdTe6URfKq2VUCDmcos/UsU8KaKRV5LQA==
X-Google-Smtp-Source: AAOMgpd1VuIVAE3XnFuqXLq7G5crZ8eCK1UFFnY9PBBrUmeTGhlp2xih4ooMGOZWCkcLhd7vsRE7HVZdI6BFiUzcO7w=
X-Received: by 2002:a1f:8e4d:: with SMTP id q74-v6mr1984328vkd.161.1531861646996;
 Tue, 17 Jul 2018 14:07:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 14:07:26
 -0700 (PDT)
In-Reply-To: <12409dc4-c10a-d77a-f88d-165aa92b489e@rasmusvillemoes.dk>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180707111209.GA27768@gmail.com> <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
 <12409dc4-c10a-d77a-f88d-165aa92b489e@rasmusvillemoes.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 00:07:26 +0300
Message-ID: <CAHp75VddPcCDhQsYBV1JGM1fgZMb2B7Mi0YLLJH146d87sjROA@mail.gmail.com>
Subject: Re: [PATCH] x86: Avoid pr_cont() in show_opcodes()
To:     Rasmus Villemoes <mail@rasmusvillemoes.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.skaura.ne.jp>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:01 PM, Rasmus Villemoes
<mail@rasmusvillemoes.dk> wrote:

> +       printk("%sCode: %*ph <%02x> %*ph\n", loglvl,

Ah, I had looked at this code and thought about %ph, but didn't get
through how to split it correctly.

Thanks for the hint!

P.S. I see the result, pretty nice and doesn't use pr_cont() at all.

-- 
With Best Regards,
Andy Shevchenko
