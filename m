Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53F5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF0120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF0120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeHaJEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 05:04:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:39119 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbeHaJEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 05:04:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7V4wfZB006011;
        Thu, 30 Aug 2018 23:58:42 -0500
Message-ID: <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5
 1/3] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     Stan Johnson <userm57@yahoo.com>, Rob Herring <robh+dt@kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Fri, 31 Aug 2018 14:58:41 +1000
In-Reply-To: <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
         <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
         <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
         <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 21:36 -0700, Frank Rowand wrote:
> > No idea whether that's relevant; I haven't done any further investigation. 
> > Complete dmesg output is attached. Please let me know if there's any more 
> > information you need to help find the bug.
> > 
> > Thanks.
> 
> I don't have any useful answers yet, but I am following the thread and have
> also quickly scanned the two commits for any obvious cause.  I will look
> into this some more, but have a few other tasks that I need to complete
> first.
> 
> A long shot, but something to consider, is that I failed to cover the
> cases of dynamic devicetree updates (removing nodes that contain a
> phandle) in ways other than overlays.  Michael Ellerman has reported
> such a problem for powerpc/mobility with of_detach_node().  A patch to
> fix that is one of the tasks I need to complete.

The only thing I can think of is booting via the BootX bootloader on
those ancient macs results in a DT with no phandles. I didn't see an
obvious reason why that would cause that patch to break though.

Cheers,
Ben.

