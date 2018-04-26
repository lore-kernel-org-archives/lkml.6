Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755614AbeDZW2a (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:28:30 -0400
Received: from imap.thunk.org ([74.207.234.97]:35924 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754949AbeDZW22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:28:28 -0400
Date: Thu, 26 Apr 2018 17:03:57 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Jens Axboe <axboe@kernel.dk>
Cc: jannh@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: random: GFP_KERNEL from irq context
Message-ID: <20180426210357.GF5965@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>, jannh@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c10e7248-4463-59d4-a977-1e4433c7231f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10e7248-4463-59d4-a977-1e4433c7231f@kernel.dk>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 10:28:13AM -0600, Jens Axboe wrote:
> during boot. We end up doing the numa_crng_init() from interrupt context, which
> makes things unhappy since you do GFP_KERNEL | __GFP_NOFAIL allocations from
> there.

I've already sent a pull request to Linux to fix this; see the
random.git tree.

Apologies for not noticing this earlier.  My test environment had
virtio-rng enabled by default, and while I did test the CONFIG_NUMA
case, the call to add randomness doesn't happen from interrupt context
with virtio-rng so I missed it in my testing.

Cheers,

					- Ted
