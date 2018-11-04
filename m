Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4494AC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DF120685
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DF120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbeKDVRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 16:17:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:32813 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbeKDVRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 16:17:10 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJH6g-0005BC-K1; Sun, 04 Nov 2018 13:02:18 +0100
Date:   Sun, 4 Nov 2018 13:02:18 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Long Li <longli@linuxonhyperv.com>
Subject: Re: [PATCH 0/4] irq: fix support for allocating sets of IRQs
In-Reply-To: <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk>
Message-ID: <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de>
References: <20181102145951.31979-1-ming.lei@redhat.com> <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

On Sat, 3 Nov 2018, Jens Axboe wrote:

> On 11/2/18 8:59 AM, Ming Lei wrote:
> > Hi Jens,
> > 
> > As I mentioned, there are at least two issues in the patch of '
> > irq: add support for allocating (and affinitizing) sets of IRQs':
> > 
> > 1) it is wrong to pass 'mask + usedvec' to irq_build_affinity_masks()
> > 
> > 2) we should spread all possible CPUs in 2-stage way on each set of IRQs
> > 
> > The fix isn't trivial, and I introduce two extra patches as preparation,
> > then the implementation can be more clean.
> > 
> > The patchset is against mq-maps branch of block tree, feel free to
> > integrate into the whole patchset of multiple queue maps.
> 
> Thanks Ming, I ran this through my testing, and I end up with the
> same maps and affinities for all the cases I cared about. I'm going
> to drop my initial version, and add the three.

So I assume, that I can pick up Mings series instead.

There is another patch pending affecting the irq affinity spreading. Can
you folks please have a look at it?

https://lkml.kernel.org/r/20181102180248.13583-1-longli@linuxonhyperv.com

Thanks,

	tglx


