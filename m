Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034433AbeE1PbB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:31:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38547 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968545AbeE1Paz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:30:55 -0400
Date: Mon, 28 May 2018 17:30:32 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Julia Cartwright <julia@ni.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Ogness <john.ogness@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Gratian Crisan <gratian.crisan@ni.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable-rt@vger.kernel.org
Subject: Re: [PATCH RT] seqlock: provide the same ordering semantics as
 mainline
Message-ID: <20180528153032.pdhl6kaiwruulh7r@linutronix.de>
References: <20180426192258.GK12238@jcartwri.amer.corp.natinst.com>
 <20180426200203.11560-1-julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180426200203.11560-1-julia@ni.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-26 15:02:03 [-0500], Julia Cartwright wrote:
> The mainline implementation of read_seqbegin() orders prior loads w.r.t.
> the read-side critical section.  Fixup the RT writer-boosting
> implementation to provide the same guarantee.
> 
> Also, while we're here, update the usage of ACCESS_ONCE() to use
> READ_ONCE().

I'm taking this without the READ_ONCE hunk because ACCESS_ONCE is gone
since v4.15 and I had to move on in v4.16.

> Fixes: e69f15cf77c23 ("seqlock: Prevent rt starvation")
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Julia Cartwright <julia@ni.com>

Sebastian
