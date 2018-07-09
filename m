Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8691C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC84208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="mwn6lOGp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uZoniIUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC84208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeGIXVW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:21:22 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43833 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754502AbeGIXVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:21:21 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 19:21:21 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5AE03519;
        Mon,  9 Jul 2018 19:15:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 09 Jul 2018 19:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=QEI7mJLrQdPUwYKs7NWVAYDmMiMmBjySoN1YhIyk0Nc=; b=mwn6lOGp
        7aNvdT6r1Q9iKTj1ii9dK2MawdEgXwcs5YK3Vw8ONKZrI0p4BFLnmawTv3M64KAs
        riP/0OLBrMWo093jvhlU5jrEacvpcWdRhhq+pzaoo5o+NX8l3wH9X+5PfMl+iCFL
        5DuOcSxAuSUaU56m9rVbSidf6Pp0ewd6BQy7l7PZlZCftXrGfKWyQlZS6PdRh+i9
        3WeRdcnYM10y+fYRbewL6X4U4D/oySrxduR1cu96Aq7LITOPDO99ywfzlfB+8kCb
        GKgNhqggReSewVlHbJsqvrZy0ISRe9/bbQIGLR6JRnYHmW7bmlFiT6EVPiV+ftHT
        6pO+CQ/jNyEwnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=QEI7mJLrQdPUwYKs7NWVAYDmMiMmB
        jySoN1YhIyk0Nc=; b=uZoniIUy/Kc6pDRDesL/ZfnzY+AEng6oyIgmN75j0AzjJ
        QlbJ4sO6YqUtl6RdApv4VjwECSjMNPg925JDVcbngvZk9gCpfUhMbRJaLYazEE0O
        U5RF9sJkfhPtkQmzmf7IhX8BcUY4zz9gDOUxWaQLTQrEMzMMB9u7PagXV/O1gNBY
        /EzwtSKUgEWQ7EWgo+lP7AO8dvdUHZK53Esl5PO2cpin1W60gVx52VbHE2q8R3oY
        0HHBa9gWbUJPrN4jI1c4TfiBO3S4CGWNCWv2UCdDiks6SsizAeMB14aN5bU0xz0W
        Gyv51V7O0rxK3rSDinqe6isgXh1ris0t/Ibw8/XpQ==
X-ME-Proxy: <xmx:lOxDW1Tktt1Zokoxl0XIv6FbmLaQCRghMqNvJK3SQmG37CXjjUI1EQ>
    <xmx:lOxDW7qEkJQfrAfLkSFsM9OlA_LLG28K3xtOp9fER7utrBl-tP-sEw>
    <xmx:lOxDW6lUzM3NUY-kBrn2uZTzPdkC5wo68ixEn1_hyMg2YvzOe0ndVA>
    <xmx:lOxDW8cRXE_9NjhPOLPuucLv-VsMxHDgMew4A0kohAaT1aMX9RlZ8g>
    <xmx:lOxDW-oRQokACuOY2w71_NSoDs2AlukSXHbncf0F4DssMsz_S4Bl_g>
    <xmx:lOxDW9LQsGblgrzrXJkMw3rLWNWr2HMI6peFq5aNDjWsEpyRCVLfVQ>
X-ME-Sender: <xms:lOxDW-Bh-3t4sQaAEVbAXOAFiZEtX2PvAiEOtfReqgxZ5GXMKp2Kdg>
Received: from localhost (ppp121-44-208-89.bras1.syd2.internode.on.net [121.44.208.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3C3A10273;
        Mon,  9 Jul 2018 19:15:31 -0400 (EDT)
Date:   Tue, 10 Jul 2018 09:15:28 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: fix build warning
Message-ID: <20180709231528.GF4447@eros>
References: <20180706134724.563799-1-arnd@arndb.de>
 <20180706144213.GA411@tigerII.localdomain>
 <20180706114951.6e739180@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706114951.6e739180@gandalf.local.home>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:49:51AM -0400, Steven Rostedt wrote:
> On Fri, 6 Jul 2018 23:42:13 +0900
> Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> 
> > On (07/06/18 15:47), Arnd Bergmann wrote:
> > [..]
> > > Fixes: bfe80ed3d7c7 ("vsprintf: add command line option debug_boot_weak_hash")  
> > 
> > Seems like this one is still in linux-next.
> > Can we squash this patch and bfe80ed3d7c7?
> > 
> 
> I prefer not to do squashes unless absolutely necessary. Yes, it is in
> next, but even branches pulled into next should try to resist rebasing
> (I never rebase my next branch unless there is a real bug that will
> break bisecting).

So this seems to be my fault.  I was under the impression that next
branches were rebased.  This warning was introduced in v7 of my patch
set applied by Ted to his random tree.  The build warning issue was
found by the kbuild test bot and based on my _incorrect_ understanding
of how linux-next worked I implemented the fix and _incremented_ the
version number of the original patch set thinking Ted would rebase
random-next and apply the latest version.

I now see that I should have done a new patch set on top of
random-next.  Thanks for fixing this Arnd, it helped me notice that the
other code changes in the final version of that patch set didn't make it
in :)

thanks,
Tobin.
