Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932565AbeCLRG6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:06:58 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39098 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932331AbeCLRG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:06:56 -0400
X-Google-Smtp-Source: AG47ELtdTLYPX5gvTuHRKXqnKQ8p2ABAUOwX9fUSP2w1IZBhNrkf4wpyG9RJ2EYQEQFZwx4jA7m/fxNO8KMm35ArIeo=
MIME-Version: 1.0
From: Kees Cook <keescook@google.com>
Date: Mon, 12 Mar 2018 10:06:54 -0700
Message-ID: <CAGXu5jLFDFF6ggSLRbvgfQ7cqTGNqGf4i-FeCSn0SftOcVg3TQ@mail.gmail.com>
Subject: Future of STACKLEAK plugin?
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I was curious, after the last week of discussion, what you thought of
the future of Alexander's port of the STACKLEAK plugin[0]. Given that
there is progress being made (by at least 8 people at last count) to
actually remove VLAs (and bogus warnings)[1], and that there appears
to be consensus[2] on the approach for how to deal with uninitialized
stack variables, this still leaves an aspect of STACKLEAK unaddressed,
which is reducing the lifetime of stack content validity.

We have options available for heap memory poison-on-free[3] (which can
serve both as a debugging feature and a security feature), but we
continue not to have this for the stack. I'd still like to be able to
provide coverage here. AIUI, your objections revolved around not
directly addressing the VLA and uninit cases (which are now underway).
Would you reconsider your NACK, and if not, what do you think the
right approach would be for performing stack clearing at the end of
syscalls?

Thanks!

-Kees

[0] http://www.openwall.com/lists/kernel-hardening/2018/03/03/7
[1] https://patchwork.kernel.org/project/LKML/list/?q=VLA
[2] https://marc.info/?l=kernel-hardening&m=152036383124266&w=2
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/Kconfig.debug?h=v4.15#n42
-- 
Kees Cook
Pixel Security
