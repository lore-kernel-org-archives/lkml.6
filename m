Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325C6C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E321121746
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E321121746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbeHMOEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:04:54 -0400
Received: from ozlabs.org ([203.11.71.1]:51401 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbeHMOEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:04:51 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ptd06Yfbz9sCX; Mon, 13 Aug 2018 21:23:00 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ec97eaad1383ab2500fcf9a07ade6044fbcc67f5
In-Reply-To: <20180430145558.4308-12-npiggin@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [11/15] tty: hvc: hvc_poll break hv read loop
Message-Id: <41ptd06Yfbz9sCX@ozlabs.org>
Date:   Mon, 13 Aug 2018 21:23:00 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-30 at 14:55:54 UTC, Nicholas Piggin wrote:
> Avoid looping with the spinlock held while there is read data
> being returned from the hv driver. Instead note if the entire
> size returned by tty_buffer_request_room was read, and request
> another read poll.
> 
> This limits the critical section lengths, and provides more
> even service to other consoles in case there is a pathological
> condition.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ec97eaad1383ab2500fcf9a07ade60

cheers
