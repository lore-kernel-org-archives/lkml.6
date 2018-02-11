Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753817AbeBKV2B (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 16:28:01 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40527 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbeBKV2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 16:28:00 -0500
X-Google-Smtp-Source: AH8x227kLCwUywVEtzRKVq5eoqm0IzahyDKGkuT3E0O1E3lo7c4PlbzJjrTCy53YswuJYldRNA8jtVvYRrcJE5lT1fE=
MIME-Version: 1.0
In-Reply-To: <20180210211110.GA24324@avx2>
References: <20180210211110.GA24324@avx2>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 11 Feb 2018 13:27:58 -0800
X-Google-Sender-Auth: xSWYYId6Q9kkDXUqM-POEg9bgPU
Message-ID: <CAGXu5jL2xLz88X8in-9GjLZyDQzynYvf3bKDnCPVgL+e3uGFLw@mail.gmail.com>
Subject: Re: [PATCH] kstrtox: make kstrtobool_from_user() very strict
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 1:11 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> Once upon a time module parameter parsing code accepted
> 0, 1, y, n, Y and N for boolean values. Gratituous but contained
> to module code and thus tolerable.

And kernel command line.

> Commit ef951599074ba4fad2d0efa0a977129b41e6d203
> ("lib: move strtobool() to kstrtobool()") promoted that ugly wart
> to kstrtobool() and, more importantly, kstrtobool_from_user().
>
> Later set of accepted values was expanded to "on" and "of".
> Now there are 6+8=14(!) valid strings for a boolean.
>
> This patch reduces set of accepted values to "0" and "1"
> (with optional newline) in spirit with other kstrto*() functions.
>
> I'm starting with kstrtobool_from_user() as it is explicitly designed
> to be used for interacting with userspace. Currently there are 9 users
> all debug code, so there is hope.
>
> Please send before 4.16 so no real users start to depend on verbose behaviour.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Why bother? What's wrong with generous input parsing? This just
creates a divergence where none is needed.

-Kees

-- 
Kees Cook
Pixel Security
