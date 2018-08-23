Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1365BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3093208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 03:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3093208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeHWG6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 02:58:32 -0400
Received: from ozlabs.org ([203.11.71.1]:34055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbeHWG6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 02:58:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41wqgj3fj1z9ryt;
        Thu, 23 Aug 2018 13:30:57 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: remove deprecated attach_adapter callback
In-Reply-To: <20180821150240.19964-1-wsa@the-dreams.de>
References: <20180821150240.19964-1-wsa@the-dreams.de>
Date:   Thu, 23 Aug 2018 13:30:57 +1000
Message-ID: <87in41lpxq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> So, I wanted to do this in the next cycle, but Linus seems to want it this
> cycle already [1], so here it is:
>
> Remove the attach_adapter callback from the 2.4 times by converting
> the last user to a custom probing mechanism based on deferred probing. We used
> this already in commit ac397c80de89 ("ALSA: ppc: keywest: drop using attach
> adapter") successfully on HW, so we agreed to use it on the windtunnel driver
> as well.
>
> With the last user gone, we can then remove the callback \o/ I think this
> allows for more cleanup in the core, but let's do this later and focus on the
> removal for now.
>
> Tested on a Renesas R-Car Salvator-XS board (M3N) by using and rebinding
> various I2C busses. Build bot and checkpatch are happy, too.
>
> I'd like to send a pull request to Linus this merge window, so looking forward
> to super fast comments, acks, etc...

Sure, I don't have a G4 hooked up to test this, so just merge it and if
it breaks we can fix it.

cheers
