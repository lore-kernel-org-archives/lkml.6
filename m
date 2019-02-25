Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EE9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B742620842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dAgA/fSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBYRei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:34:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43426 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBYReh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:34:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id z20so8138684ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czpd+wHeQreQNGscu//MVeyMbeUVOhnYB0JJMlwu1LA=;
        b=dAgA/fSRTToW+Cce4rmYL8IXGY+hq1ZRVOBT3HzPS1PEVqOQyJPcgBzxbMZlceNgpa
         0vvs/Fe0MAyJZxXHXdLr9d5VoF6yIx+A4wG5Jaj+KjdVBtSyDvAhYLh9BkhaNRoUbQe2
         sNEAd/lOvKObQumYx/F5jb3pqVDwuBh8jpFh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czpd+wHeQreQNGscu//MVeyMbeUVOhnYB0JJMlwu1LA=;
        b=GmyK/67rbu93CJRPj3jXRlq3jhznB02JgJ+IG0EE8iHk97a89ges2AbVNkaTObQ5Jr
         45IDFoodLK9UopfLNFZ6D4RxDW1pb5BL3WrJLF40a46JtV9vtFSFaISrtVSHtK/02p1P
         3RjvkxOVbg2wkQgJfJ015Ry8QakCsiSJ5g68F8DCeHTr7+u9vtgHmgK3YLszM0c/pdSJ
         1VwIV8FUt2wFsydxxxB1I7H4huCxSS+Y2yyipXjt44Zl/zf803Mbtf7YMDd3c/k+F9il
         gBQ8GcQKKbTrJS1sfiQS7tojPdM2b2vkfhgYoDQNKpD4h9jco/kcgJJnjkSxRVblvDAl
         b8DA==
X-Gm-Message-State: AHQUAuYDaqD+wE/6eBuY/McpQtzE9kit+SYU1w0GYnuPhEW4k2eUobux
        v/EwwGap9rmlcvPbzZzwK/tSy522xtE=
X-Google-Smtp-Source: AHgI3IZQxlVWQgAH1a5nQ/TK9xmJyk6g6i5HvcMLd6WJaMjiKeuDbRuTHvDhsaWG4lKV7FQ2vRYVMg==
X-Received: by 2002:a2e:8456:: with SMTP id u22mr10335269ljh.108.1551116075204;
        Mon, 25 Feb 2019 09:34:35 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id v1sm408919lfg.13.2019.02.25.09.34.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 09:34:34 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id g2so7490961lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:34:33 -0800 (PST)
X-Received: by 2002:a19:c744:: with SMTP id x65mr1535829lff.148.1551116073198;
 Mon, 25 Feb 2019 09:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125232.191698923@infradead.org>
 <CALCETrW1_r=Qgbpiq8PsYYD11W7CwAS-UCAxzvvubJnMAHH2Dg@mail.gmail.com>
 <20190225161234.GM32477@hirez.programming.kicks-ass.net> <20190225171531.GD32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190225171531.GD32534@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Feb 2019 09:34:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzSnbX68x8PU1uRTqdLbKHHMUEBgx=fYAAeb7c7nF4Mw@mail.gmail.com>
Message-ID: <CAHk-=whzSnbX68x8PU1uRTqdLbKHHMUEBgx=fYAAeb7c7nF4Mw@mail.gmail.com>
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 9:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Ah, so the thing we need for inline-asm is %=, but Linus didn't like it:

Well, to be fair, I also didn't like the random big numbers.

I think that inline asm that has local labels should just use simple
enumeration, and always use the direction suffix to make those local
labels be unambiguous.

Now, there are cases where we may not be able to do that, because we
have internal macros within the asm that _also_ wants to do its own
numbers. This isn't such a case.

For that case, you might actually want to use a fancy "get me a unique
number and prefix", but it should be seen as the exception rather than
the first solution, because the code starts looking really random.

             Linus
