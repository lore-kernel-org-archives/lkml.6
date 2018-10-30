Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945C4C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684122082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684122082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeJ3Xzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:55:46 -0400
Received: from ozlabs.org ([203.11.71.1]:56711 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbeJ3Xzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:55:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42kvnZ4y8Bz9s9J;
        Wed, 31 Oct 2018 02:01:54 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alistair Popple <alistair@popple.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/npu-dma: Remove NPU DMA ops
In-Reply-To: <20181030132401.GC30783@lst.de>
References: <20181030110203.27257-1-alistair@popple.id.au> <20181030125841.GB30158@lst.de> <30359cc433e97739d93e13717b2897e462895097.camel@kernel.crashing.org> <20181030132401.GC30783@lst.de>
Date:   Wed, 31 Oct 2018 02:01:53 +1100
Message-ID: <87wopziila.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Wed, Oct 31, 2018 at 12:09:29AM +1100, Benjamin Herrenschmidt wrote:
>> On Tue, 2018-10-30 at 13:58 +0100, Christoph Hellwig wrote:
>> > Please take my patch instead.  We have a kernel polcity to not keep
>> > dead code around, and everyone including Linus and the attending IBMers
>> > confirmed this.
>> 
>> Let's call a cat a cat ... ;-)
>> 
>> It's not *dead* code. It's code that is used by an out of tree driver
>> (which also happen not to be open source).

(Actually that part of the driver is MIT licensed, but yes other parts
 are not open source.)

> Which clearly makes it a derived work of the kernel if it uses an
> interface just create for it, and thus even more important to remove
> it to not get anyone into legal trouble.

We don't want driver code calling into firmware, that's the job of
platform code, so we would need the same API (or something similar) for
a GPL driver.

cheers
