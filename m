Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E11C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DD520852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DD520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbeGXPG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:06:26 -0400
Received: from ozlabs.org ([203.11.71.1]:58963 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388329AbeGXPG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:06:26 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41Zg380lfkz9s3N; Tue, 24 Jul 2018 23:59:47 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bd90284cc6c1c9e8e48c8eadd0c79574fcce0b81
In-Reply-To: <20180430145558.4308-2-npiggin@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [01/15] powerpc/powernv: opal_put_chars partial write fix
Message-Id: <41Zg380lfkz9s3N@ozlabs.org>
Date:   Tue, 24 Jul 2018 23:59:47 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-30 at 14:55:44 UTC, Nicholas Piggin wrote:
> The intention here is to consume and discard the remaining buffer
> upon error. This works if there has not been a previous partial write.
> If there has been, then total_len is no longer total number of bytes
> to copy. total_len is always "bytes left to copy", so it should be
> added to written bytes.
> 
> This code may not be exercised any more if partial writes will not be
> hit, but this is a small bugfix before a larger change.
> 
> Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Patches 1-9 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bd90284cc6c1c9e8e48c8eadd0c795

cheers
