Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEABC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D756204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D756204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeJ3B56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:57:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52386 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeJ3B55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:57:57 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHB1e-0007YR-U6; Mon, 29 Oct 2018 18:08:27 +0100
Date:   Mon, 29 Oct 2018 18:08:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
In-Reply-To: <20181029163738.10172-12-axboe@kernel.dk>
Message-ID: <alpine.DEB.2.21.1810291805540.5984@nanos.tec.linutronix.de>
References: <20181029163738.10172-1-axboe@kernel.dk> <20181029163738.10172-12-axboe@kernel.dk>
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

On Mon, 29 Oct 2018, Jens Axboe wrote:

> A driver may have a need to allocate multiple sets of MSI/MSI-X
> interrupts, and have them appropriately affinitized. Add support for
> defining a number of sets in the irq_affinity structure, of varying
> sizes, and get each set affinitized correctly across the machine.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

This looks good.

Vs. merge logistics: I'm expecting some other changes in that area as per
discussion with megasas (IIRC) folks. So I'd like to apply that myself
right after -rc1 and provide it to you as a single commit to pull from so
we can avoid collisions in next and the merge window.

Thanks,

	tglx
