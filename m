Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeFERjh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:39:37 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38898 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeFERjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:39:35 -0400
X-Google-Smtp-Source: ADUXVKLhKLaIQndzn20TGCvDoDOvDdm119PC7hBHwWJsMaTLaUCT+tmoej7yYlXjs0RBDETgRrHonHyt+q0q7CQoklc=
MIME-Version: 1.0
References: <CAJZ5v0jq45atkapwSjJ4DkHhB1bfOA-Sh1TiA3dPXwKyFTBheA@mail.gmail.com>
 <CA+55aFyoxvrA-7X_8ZfQXd1=GfLT96ZaHAM+o5gKwOOfiy_HDA@mail.gmail.com>
In-Reply-To: <CA+55aFyoxvrA-7X_8ZfQXd1=GfLT96ZaHAM+o5gKwOOfiy_HDA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Jun 2018 10:39:23 -0700
Message-ID: <CA+55aFw8yUOweiQSEp-ZHzEeSAGggZ0-Ksy0e4GQgEhKvmwLog@mail.gmail.com>
Subject: Re: [GIT PULL] Device properties framework update for v4.18-rc1
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 10:30 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, this looks questionable to me.
>
> I'm not talking about the changes themselves - I can live with them.
> But the _rationale_ is pure and utter garbage, and dangerously so.

Side note: I've merged it, and it's going through my build tests, so
it's really not that I hate the code.

But I really find that kind of one-sided rationale that ignores
reality unacceptable.

And I find it dangerous, because it *sounds* so "obviously correct" to
people who don't know any better. If you don't know that gcc
explicitly says that you should use unions to do type punning to avoid
aliasing issues, you might believe that union type punning is a bad
thing from that commit message.

So it's dangerously misleading, because lots of people have a
dangerous reverence for paper over reality.

In programming, "Appeal to Standards" should be considered a potential
logical fallacy. Standards have their place, but they definitely have
their caveats too.

                    Linus
