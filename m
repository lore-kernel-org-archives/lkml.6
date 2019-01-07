Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180B6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79312085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OAY/sXGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfAGSKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:10:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46632 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfAGSKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:10:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id y14so949001lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iZ3FyP1ZklACIogNGg9kXSA98astrFQsu4QoSyvVAJo=;
        b=OAY/sXGcl9ciebn5V2U++XCLRpeEiCqPp+plp0U5ab7ji6YErV4/+s8jU5qIOBsDSD
         NPux+wbSZqAIBIESf/WK+/PgiZuiw7XrpY+VagrFKAi4oqGPRzhyGa+QbFZQ0le2s8xr
         plJMhXdeQC4LoSQ9evN04p2A/3xEDdBFUBZb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iZ3FyP1ZklACIogNGg9kXSA98astrFQsu4QoSyvVAJo=;
        b=tfakNEHck0KLJTVm4YccBZ9mzlHQ6sYenbu2MaPq2oDAiVupjoNp8y7jNIlmVqaqYR
         uW9wV/GWyiqVaT9yH7FHnCHiHjMIAlH/odD8kErb5tWg358yOgzLWdwU6My7NKCuZQ7S
         5JYiMuabFjrKJa9tVygYBwkllh7kwcf7nthobynfkp73yBhyncZwRHbozN2M6ih7nKMF
         +vG6wfe1UbqxF5gubtfn3xRlDpy0BqOzLrY6/ZqErk84yR3C9/P+jqFwixAPJD3PGin6
         lHt2gFTd7iTMCRU+IUI3iKbnfueMkEKCc72wNSF16a1kIGMefkdOudOqoBVy9sVt5UAR
         xzqg==
X-Gm-Message-State: AA+aEWZ6is2QikWOlFVb8LZhL/fB2CZcirhIpTSTF7V7ofgzcAzHt5/O
        QAcw9LRe1d5iC5OW8Wc/iLQJk7jCrxQ=
X-Google-Smtp-Source: AFSGD/UeSDvg8u2vvp1Cw+LdDdmAwBZteY/I1vFeBlEgnejoo6VUSpRWYtu7vbtHL8D1vnHK2d2L8g==
X-Received: by 2002:a19:5d42:: with SMTP id p2mr33051470lfj.83.1546884649291;
        Mon, 07 Jan 2019 10:10:49 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a62sm12826619lfa.37.2019.01.07.10.10.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:10:48 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id c16so969103lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:10:47 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr33529780lfc.124.1546884647534;
 Mon, 07 Jan 2019 10:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20190107180306.16602-1-j.neuschaefer@gmx.net>
In-Reply-To: <20190107180306.16602-1-j.neuschaefer@gmx.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Jan 2019 10:10:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgAH7QZrAyzaTV1-6MecaSdVkiowSZEM7qwa0L2oegpLA@mail.gmail.com>
Message-ID: <CAHk-=wgAH7QZrAyzaTV1-6MecaSdVkiowSZEM7qwa0L2oegpLA@mail.gmail.com>
Subject: Re: [PATCH] kernel/sys.c: Fix UNAME26 for 5.0
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:03 AM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> UNAME26 is a mechanism to report Linux's version as 2.6.x, for
> compatibility with old/broken software. Because of the way it is
> implemented, it needs to be adjusted to handle version 5.0.

Do we actually need this?

I'd rather let it bitrot, and just let it return random versions. It
will just start again at 2.4.60, won't it?

Anybody who uses UNAME26 for a 5.x kernel might as well think it's
still 4.x. The user space is so old that it can't possibly care about
differences between 4.x and 5.x, can it?

The only thing that matters is that it shows "2.4.<largeenough>",
which it will do regardless.

                Linus
