Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932067AbeA3SLQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:11:16 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:52421 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeA3SLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:11:12 -0500
X-Google-Smtp-Source: AH8x22454wxmYqyNJcOBzQa67ZdQM6mRc+ckVa2+hOtlg4RmiWdKL74l9vkdruAaJedIttesW9nfkDISAQmpAiaxxsA=
MIME-Version: 1.0
In-Reply-To: <20180130063002.gxmruvxcqsfp5hv4@gmail.com>
References: <alpine.DEB.2.20.1801290935160.1849@nanos> <CA+55aFy6FX6Ewg9exGH12PWnzSNKBfmc--v6H6UYpcSAEWUR8A@mail.gmail.com>
 <20180130063002.gxmruvxcqsfp5hv4@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2018 10:11:10 -0800
X-Google-Sender-Auth: PdFB6zxEo2DxUo47Be6TDhCOsMw
Message-ID: <CA+55aFxzm6fY396+Nh3mZm5BroW4ZQmh3gj0YLvg7nKs5qzQKg@mail.gmail.com>
Subject: Re: [GIT pull] Timer core updates for 4.16
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 10:30 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> These are in cases significant driver simplifications, but they also enable the
> real deal, the elimination of the hrtimer tasklet:
>
>  softirq: Remove tasklet_hrtimer
>
>    include/linux/interrupt.h | 25 -----------------------
>    kernel/softirq.c          | 51 -----------------------------------------------
>    2 files changed, 76 deletions(-)
>
> ... which is a pretty nice thing in itself even without the driver
> simplifications!
>
> Plus the _real_ secret motivation behind it all is the -rt kernel and
> CONFIG_PREEMPT_RT=y and the ability to push most of the hrtimer processing into
> softirq context - while it still keeps the main hrtimer machinery capable to run
> in hard-RT hardirq domain. Turns out it was possible to implement this duality via
> the softirq-hrtimers, with a good chunk of benefits to non-rt upstream as well.

So this is the kind of explanation that I would have liked in the
"please pull" (and that would have been great in the merge message).
Explaining not just the "what", but very much the "why".

Anyway, it's obviously pulled regardless, and I'm just pointing this
out for "maybe next time".

                  Linus
