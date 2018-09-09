Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFE2C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 17:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D1420833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 17:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D1420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeIIWLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 18:11:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:55855 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbeIIWLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 18:11:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w89H4QVV032538;
        Sun, 9 Sep 2018 12:04:27 -0500
Message-ID: <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5
 1/3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     Stan Johnson <userm57@yahoo.com>, Rob Herring <robh+dt@kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Sun, 09 Sep 2018 19:04:25 +0200
In-Reply-To: <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
         <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
         <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
         <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
         <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 14:58 +1000, Benjamin Herrenschmidt wrote:
> 
> > A long shot, but something to consider, is that I failed to cover the
> > cases of dynamic devicetree updates (removing nodes that contain a
> > phandle) in ways other than overlays.  Michael Ellerman has reported
> > such a problem for powerpc/mobility with of_detach_node().  A patch to
> > fix that is one of the tasks I need to complete.
> 
> The only thing I can think of is booting via the BootX bootloader on
> those ancient macs results in a DT with no phandles. I didn't see an
> obvious reason why that would cause that patch to break though.

Guys, we still don't have a fix for this one on its way upstream...

My test patch just creates phandle properties for all nodes, that was
not intended as a fix, more a way to check if the problem was related
to the lack of phandles.

I don't actually know why the new code causes things to fail when
phandles are absent. This needs to be looked at.

I'm travelling at the moment and generally caught up with other things,
I haven't had a chance to dig, so just a heads up. I don't intend to
submit my patch since it's just a band aid. We need to figure out what
the actual problem is.

Cheers,
Ben.


