Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeBHXP4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:15:56 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:52177 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752265AbeBHXP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:15:56 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <201802090810.DBF09356.OFMQFVFJtOHOLS@I-love.SAKURA.ne.jp>
Cc: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com,
        jack@suse.cz, aryabinin@virtuozzo.com, dvyukov@google.com
References: <20180208190753.17690-1-chris@chris-wilson.co.uk>
 <201802090810.DBF09356.OFMQFVFJtOHOLS@I-love.SAKURA.ne.jp>
Message-ID: <151813172079.28809.12438916989037864311@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH] khungtaskd: Kick stuck processes
Date: Thu, 08 Feb 2018 23:15:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tetsuo Handa (2018-02-08 23:10:43)
> Chris Wilson wrote:
> > After spotting a stuck process, and having decided not to panic, give
> > the task a kick to see if that helps it to recover (e.g. to paper over a
> > missed wake up).
> 
> Yes, we are seeing hangs at io_schedule(), but doesn't optionally allowing
> io_schedule() be replaced with timeout version (e.g. dump_page() upon timeout
> if io_schedule() was called for e.g. wait_on_page_bit()) give us more clue?

Yes, this isn't for debugging who left the page locked (or the exact
root cause), this is just trying to allow the system to limp along
afterwards :) From personal experience, I know how easy it is to lose a
wakeup and the only thing to notice is khungtaskd shouting every 120s.
-Chris
