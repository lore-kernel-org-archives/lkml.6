Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECF4C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE8520671
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="pnGhATGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE8520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389161AbeG1Bmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 21:42:50 -0400
Received: from imap.thunk.org ([74.207.234.97]:37422 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbeG1Bmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 21:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=V/rq9AjCmrv1vLkZ8SJ0RCyE7QiKZl4Rwvwd94hvRSA=; b=pnGhATGpzDuU7lKN+PMygiNI+y
        Bn2oBD/nZYq3ntg4lnAJ9+NxGPJq4upKz+HGZ29eCkc72ayy7Kh3isuw+BAzd2S0LBXqqRFTA3UGh
        YuEVHkCU53yl8i3gTxY4UWNeTOM7BqLTxKQEr6wU0BfGzyzWGwsou6DnnvHEWj73c0Ok=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fjCwI-000386-68; Sat, 28 Jul 2018 00:18:30 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 23F097A6163; Fri, 27 Jul 2018 20:18:23 -0400 (EDT)
Date:   Fri, 27 Jul 2018 20:18:23 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     adilger.kernel@dilger.ca, wen.xu@gatech.edu,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Remounting filesystem read-only
Message-ID: <20180728001823.GA28432@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sodagudi Prasad <psodagud@codeaurora.org>, adilger.kernel@dilger.ca,
        wen.xu@gatech.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <366cf3ac534bbadaaa61714a43006ac7@codeaurora.org>
 <e9869d6cd358e9de395d730ab7b3aa60@codeaurora.org>
 <20180727195213.GE13922@thunk.org>
 <c121825198eba667c09fc53fa9b4fd3a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c121825198eba667c09fc53fa9b4fd3a@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 01:34:31PM -0700, Sodagudi Prasad wrote:
> > The error should be pretty clear: "Inode table for bg 0 marked as
> > needing zeroing".  That should never happen.
> 
> Can you provide any debug patch to detect when this corruption is happening?
> Source of this corruption and how this is partition getting corrupted?
> Or which file system operation lead to this corruption?

Do you have a reliable repro?  If it's a one-off, it can be caused by
*anything*.  Crappy hardware, a bug in some proprietary, binary-only
GPU driver dereferencing some wild pointer that corrupts kernel
memory, etc.

Asking for a debug patch is like asking for "can you create technology
that can detect when a cockroach enter my house?"

So if you have a reliable repro, then we know what operations might be
triggering the corruption, and then you work on creating a minimal
repro, and only *then* when we have a restricted set of possibilities
that might be the cause (for example, if removing a GPU call makes the
problem go away, then the patch would need to be in the proprietary
GPU driver....)

> I am digging code a bit around this warning to understand more.

The warning means that a flag in block group descriptor #0 is set
that should never be set.  How did the flag get set?  There is any
number of things that could cause that.

You might want to look at the block group descriptor via dumpe2fs or
debugfs, to see if it's just a single bit getting flipped, or if the
entire block group descriptor is garbage.  Note that under normal code
paths, the flag *never* gets set by ext4 kernel code.  The flag will
get set on non-block group 0 block group descriptors by ext4, and the
ext4 kernel code will only clear the flag.

Of course, if there is a bug in some driver that dereferences a
pointer widely, all bets are off.

					- Ted
