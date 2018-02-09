Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbeBILbE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:31:04 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59724 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbeBILbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:31:03 -0500
To: chris@chris-wilson.co.uk, linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com,
        jack@suse.cz, aryabinin@virtuozzo.com, dvyukov@google.com
Subject: Re: [PATCH] khungtaskd: Kick stuck processes
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180208190753.17690-1-chris@chris-wilson.co.uk>
        <201802090810.DBF09356.OFMQFVFJtOHOLS@I-love.SAKURA.ne.jp>
        <151813172079.28809.12438916989037864311@mail.alporthouse.com>
In-Reply-To: <151813172079.28809.12438916989037864311@mail.alporthouse.com>
Message-Id: <201802092030.GCE64020.JVOLHFFQSOtMFO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Fri, 9 Feb 2018 20:30:41 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wilson wrote:
> Quoting Tetsuo Handa (2018-02-08 23:10:43)
> > Chris Wilson wrote:
> > > After spotting a stuck process, and having decided not to panic, give
> > > the task a kick to see if that helps it to recover (e.g. to paper over a
> > > missed wake up).
> > 
> > Yes, we are seeing hangs at io_schedule(), but doesn't optionally allowing
> > io_schedule() be replaced with timeout version (e.g. dump_page() upon timeout
> > if io_schedule() was called for e.g. wait_on_page_bit()) give us more clue?
> 
> Yes, this isn't for debugging who left the page locked (or the exact
> root cause), this is just trying to allow the system to limp along
> afterwards :) From personal experience, I know how easy it is to lose a
> wakeup and the only thing to notice is khungtaskd shouting every 120s.

Calling wake_up_process() does not sleep, does it? Then, I think you can
do it using SystemTap, for SystemTap gives you ability to call exported
functions at (almost) arbitrary line of (almost) arbitrary file. You can find
https://events.static.linuxfound.org/sites/events/files/slides/LCJ2014-en_0.pdf
for an example.
