Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40055C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106B22085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106B22085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbeKEUn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:43:29 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34542 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbeKEUn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:43:29 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJczH-0003Ls-Sj; Mon, 05 Nov 2018 12:24:08 +0100
Date:   Mon, 5 Nov 2018 12:24:07 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH 0/4] irq: fix support for allocating sets of IRQs
In-Reply-To: <alpine.DEB.2.21.1811041938340.10744@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1811051220330.1566@nanos.tec.linutronix.de>
References: <20181102145951.31979-1-ming.lei@redhat.com> <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk> <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de> <5787f309-fa34-36df-83be-934a64989583@kernel.dk>
 <alpine.DEB.2.21.1811041938340.10744@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

On Sun, 4 Nov 2018, Thomas Gleixner wrote:
> On Sun, 4 Nov 2018, Jens Axboe wrote:
> > On 11/4/18 5:02 AM, Thomas Gleixner wrote:
> > > So I assume, that I can pick up Mings series instead.
> > 
> > Yes, let's do that.
> > 
> > > There is another patch pending affecting the irq affinity spreading. Can
> > > you folks please have a look at it?
> > > 
> > > https://lkml.kernel.org/r/20181102180248.13583-1-longli@linuxonhyperv.com
> > 
> > I'll give that a look and test. Thanks for the heads-up.

I picked the series from Ming and the patch from Long and merged it into
tip/irq/core.

The result is available for you to pull from:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-block

That branch is immutable now and I keep it around in case that there are
incremental updates necessary before the merge window.

Thanks,

	tglx
