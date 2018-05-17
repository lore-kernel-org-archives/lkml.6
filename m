Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeEQRBi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:01:38 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45939 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQRBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:01:36 -0400
X-Google-Smtp-Source: AB8JxZoy/o2ZW5FcrSrmv1CJB9/JCTHz3ei61/uwFW9ep/dwq2Y8RFnX8pnBrvooZkaEqothntK6QF68E1dg9YrVJfo=
MIME-Version: 1.0
References: <20180516214750.82710e21075ad1461dd4c04b@linux-foundation.org> <20180517075124.GA2057@avx2>
In-Reply-To: <20180517075124.GA2057@avx2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 May 2018 10:01:24 -0700
Message-ID: <CA+55aFwpwho_MMxuFHDKgffH4Fz93wf3A6QVNZmCyNZ8G3xyng@mail.gmail.com>
Subject: Re: Fw: [PATCHSET] workqueue: Show the latest workqueue name in /proc/PID/{comm,stat,status}
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 12:51 AM Alexey Dobriyan <adobriyan@gmail.com>
wrote:


> I'd say anything that extends ->comm past 16 charactes is no-no.
> The reason is that userspace may do something stupid like:

>          char comm[16];

Not may - does. We're already talking to the procps-ng people exactly
because of this.

That said, nobody actually mis-parses anything or overflows any buffers
(you'd actually have to work at it to do so), it's just that they don't
save the full length of the result.

So we can extend the kernel size (there are others who want it
independently of the workqueue issue), but some of the tools simply won't
show the full name until updated.

So instead of showing "[kworker/4:2-events]", current procps-ng shows
"[kworker/4:2-eve]" for example. Annoying, but not really any more cryptic
than the current situation without the patch.

               Linus
