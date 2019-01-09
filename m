Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FEDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A48206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aepgE+cW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfAIR3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:29:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45623 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfAIR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:29:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so7163300ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 09:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjbGaDlY4j3vos7UOie8DxVecMawV+2oY2/TL7n8zgU=;
        b=aepgE+cWGX46jE+yJU/pgMZYj3kYNAXMqZQ40w4HmeAGrpPgJv9EprlMocBh9LygSH
         JBQwjlnreXCLpk1BWzFqey8QvuAkgRaWpaKogdIab2BbsEfR2quU5taDQnm04kg+JJXc
         DTdoeL82WsFGTNTiuL/S7iztNZHA3Gz9kRzeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjbGaDlY4j3vos7UOie8DxVecMawV+2oY2/TL7n8zgU=;
        b=dN+MugWGZjJkac21Lua/TFosFdFlXtvjff6dbCLS5uwlBWBLHCjXA3ubv6aMkoaVkJ
         DxWuFuV0NKVXUI9WWuDIsEZwxSaiZZzsXiUx6qd0gdSZVUFucaSJfP5QA50tWksNZEyI
         4TvUQRMyw3vAhfxjw7GFzYGavfQOPDwyFKfpIxhv5c1i3Ge4tWi/XCrXvCd7uJjM3AJG
         c5CvDt6n+ek1kDjOudzo+DqrUGUkKNBeoqTr3qCZui24vL5sJOdA382SvquU502UDies
         3rkg3R3Xw0QaWHWNI2jt/wCaTx2F6DaNAfL20Riy7qu8LzKYEW7TafQxuSIQAyMEfZti
         7yJw==
X-Gm-Message-State: AJcUukfjSbyKHvkg39f0Hrf+qRl+jvzfKlW0ukeCzJdjSvlZfcyOsWul
        IK2q6vZg3C5J71wDfv63D/tIKwJtCm8=
X-Google-Smtp-Source: ALg8bN5SBUADVkyBQDf93WYuEnOjtCAwn7lNxY3BvlsF0pDqo32khamrudMdTHedwdq22a86BKSXpg==
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr4333395ljf.127.1547054976460;
        Wed, 09 Jan 2019 09:29:36 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id x21sm13928647lfe.6.2019.01.09.09.29.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 09:29:35 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id i26so6275332lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 09:29:35 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr3868350lfa.106.1547054974492;
 Wed, 09 Jan 2019 09:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20190109164025.24554-1-rpenyaev@suse.de> <20190109164025.24554-10-rpenyaev@suse.de>
In-Reply-To: <20190109164025.24554-10-rpenyaev@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jan 2019 09:29:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whD=pjn4myRysuyeAiNOxv49XVQuJaE7Xd6ZBEMf6eXtA@mail.gmail.com>
Message-ID: <CAHk-=whD=pjn4myRysuyeAiNOxv49XVQuJaE7Xd6ZBEMf6eXtA@mail.gmail.com>
Subject: Re: [RFC PATCH 09/15] epoll: introduce stand-alone helpers for
 polling from userspace
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 8:40 AM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> ep_vrealloc*()
>     realloc user header, user index or bitmap memory

What? No.

This is wrong, it's much too complicated. And because your
'vrealloc()' doesn't follow the normal realloc rules, it looks both
confusing and buggy, and people have to remember that "oh, vrealloc()
isn't actually vrealloc(), it's really vdupalloc()".

Your other patch to allow users to apparently also do mremap of these
things seems entirely wrongheaded too. Especially when you then have
magical rules for vm_pgoff, which is one of the things that unmapping
parts of a mmap will touch.

So I say no, no, no. This is all *much* too complicated, and the
interfaces are mis-designed to be overly generous to people doing odd
and pointless things.

If you can't have a fixed-size user buffer that stays in one place,
don't even bother.

             Linus
