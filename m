Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932231AbeCLNbv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:31:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeCLNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:31:49 -0400
Date: Mon, 12 Mar 2018 14:31:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>, will.deacon@arm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com, mingo@kernel.org,
        mpe@ellerman.id.au, oleg@redhat.com, benh@kernel.crashing.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: smp_mb__after_spinlock requirement too strong?
Message-ID: <20180312133135.GJ4064@hirez.programming.kicks-ass.net>
References: <CAJDTihwMgUqjK6YL2M_WZY4VBaifVYgNvdZOF_fNrnk_p27Kvw@mail.gmail.com>
 <20180312054412.yqyde34ly3kjoajj@tardis>
 <CAJDTihxxhy7zmhTJ-ky4wvMby_o9y8UOcs9R1dABN7NccekAiQ@mail.gmail.com>
 <20180312085600.aczjkpn73axzs2sb@tardis>
 <20180312085646.GE4064@hirez.programming.kicks-ass.net>
 <CAJDTihyP96H6XTh5M17uMbMHxz8YjFZ89u0YsBGsRpR+BaEU_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJDTihyP96H6XTh5M17uMbMHxz8YjFZ89u0YsBGsRpR+BaEU_Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 05:13:03PM +0800, 焦晓冬 wrote:

> If the fixed comment could point out where this RCsc is used, it will be great.

The one that comes to mind first is RCU-sched, that relies on a context
switch implying a full smp_mb(). But I think there's more..
