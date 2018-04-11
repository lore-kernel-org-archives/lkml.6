Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756633AbeDKU23 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 16:28:29 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:53613 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbeDKSu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:50:26 -0400
X-Google-Smtp-Source: AIpwx4/XvRPTG5u3BSpBdz2PgpyOx2YaQHPyOA8t9vg2+2vsrIiX0Jj14j8yCJGhAT43shJCSsct6NK4aETtdBC7dUA=
MIME-Version: 1.0
In-Reply-To: <CAHp75VcH0N2BZHaVko3EGWJGk8g_GriCCS_izyjXFSXG81q4rg@mail.gmail.com>
References: <20180410171227.GA12596@smile.fi.intel.com> <CA+55aFxzkm0ELM4Xa_rkJpsv4hqeFa7yh2Tvkrh_xnhQqZs=Kg@mail.gmail.com>
 <CAHp75VcH0N2BZHaVko3EGWJGk8g_GriCCS_izyjXFSXG81q4rg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Apr 2018 11:50:25 -0700
X-Google-Sender-Auth: NlGfG9TFFvNY5nt-UMcJWCrZaSs
Message-ID: <CA+55aFxODGv7-AvnqFmxrXBcS2w0XzHuZ7UuRi3EMQz4-oeLJA@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 4.17-1
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 1:35 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> That's good news.
> I'm using whatever is in Debian Unstable (old for less than month) and
> what I tried was
>
> % git checkout -b test origin/master
> % git merge for-next # our branch for you
>
> It complained to me that file was renamed / deleted and it didn't
> resolve conflicts automatically.

Hmm. I don't know what the difference might be. debian-unstable is
usually not *so* ancient that I'd expect big git version differences
(even if I personally tend to run very recent git trees, because it's
the one thing in addition to the kernel that I build myself).

Sometimes things like the git rename limits hit people. Your side
didn't have a lot of file creation/deletion (which is when the default
git rename limits can bite you), but my side did.

Did you perhaps also get a message like "inexact rename detection was
skipped due to too many files"? If you have lots of memory, it can be
a good idea to just disable the rename limits:

  git config diff.renameLimit 0
  git config merge.renameLimit 0

but it's also possible that some tweak to the diff algorithm triggered
this, or just the fact that we tried merging at slightly different
points.

Not a big deal.

              Linus
