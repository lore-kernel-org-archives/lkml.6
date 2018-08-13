Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7AEC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFFB21746
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFFB21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbeHMOEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:04:55 -0400
Received: from ozlabs.org ([203.11.71.1]:51401 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbeHMOEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:04:55 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ptd45pPpz9sCQ; Mon, 13 Aug 2018 21:23:04 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9f65b81f36e31563c5a5e4df3b3b8bc7550b6030
In-Reply-To: <20180430145558.4308-15-npiggin@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [14/15] tty: hvc: introduce the hv_ops.flush operation for hvc drivers
Message-Id: <41ptd45pPpz9sCQ@ozlabs.org>
Date:   Mon, 13 Aug 2018 21:23:04 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-30 at 14:55:57 UTC, Nicholas Piggin wrote:
> Use .flush to wait for drivers to flush their console outside of
> the spinlock, to reduce lock/irq latencies.
> 
> Flush the hvc console driver after each write, which can help
> messages make it out to the console after a crash.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9f65b81f36e31563c5a5e4df3b3b8b

cheers
