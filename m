Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54E6C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6568921738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6568921738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbeHMOFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:05:47 -0400
Received: from ozlabs.org ([203.11.71.1]:51935 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbeHMOEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:04:54 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ptd34Q5zz9sC7; Mon, 13 Aug 2018 21:23:03 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 550ddadcc7580ec2a6c22d4ed04291bc6e2428fb
In-Reply-To: <20180430145558.4308-14-npiggin@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [13/15] tty: hvc: hvc_write may sleep
Message-Id: <41ptd34Q5zz9sC7@ozlabs.org>
Date:   Mon, 13 Aug 2018 21:23:03 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-30 at 14:55:56 UTC, Nicholas Piggin wrote:
> Rework the hvc_write loop to drop and re-take the spinlock on each
> iteration, add a cond_resched. Don't bother with an initial hvc_push
> initially, which makes the logic simpler -- just do a hvc_push on
> each time around the loop.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/550ddadcc7580ec2a6c22d4ed04291

cheers
