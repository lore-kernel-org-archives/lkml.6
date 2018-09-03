Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3027C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34CD2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34CD2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeICUv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:51:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeICUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:51:59 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1DC4CE9;
        Mon,  3 Sep 2018 16:31:06 +0000 (UTC)
Date:   Mon, 3 Sep 2018 18:31:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] staging: android: ion: check for kref overflow
Message-ID: <20180903163104.GF6712@kroah.com>
References: <20180830230946.228701-1-drosen@google.com>
 <20180831004144.GC20664@kroah.com>
 <589c036d-450a-3f3b-8f5a-4148713d4bfb@google.com>
 <20180831155657.GA25066@kroah.com>
 <4b4e64a4-bf6f-b3d0-4221-2a0d3206a6a9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b4e64a4-bf6f-b3d0-4221-2a0d3206a6a9@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 02:31:38PM -0700, Daniel Rosenberg wrote:
> 
> 
> On 08/31/2018 08:56 AM, Greg Kroah-Hartman wrote:
> > On Thu, Aug 30, 2018 at 06:36:18PM -0700, Daniel Rosenberg wrote:
> > > The sign off was on the 4.4.y version that I cherry-picked this from.
> > Ah that wasn't obvious at all.  What is that git commit id?  You need to
> > give us a hint as to what is going on when you do that :)
> b84ec04bae905901("staging: android: ion: check for kref overflow") in 4.4.y
> > > There was a trivial conflict moving it to 4.9, but it did not modify
> > > any changed lines, so I hadn't thought that was worth noting on the
> > > patch. I apologise if leaving the signed-off-by was incorrect here.
> > Why did I only apply this to 4.4 and not 4.9 when the original patch was
> > submitted?  That seems odd.
> > 
> > thanks,
> > 
> > greg k-h
> I don't know. I had included it in the range of kernel versions it should be
> applied to in the original patch, and noted the minor conflict for later
> kernel versions. You added it in 3.18 and 4.4, and I assumed not 4.9 because
> of the conflict in applying the patch, so I sent this version.
> 
> b1fa6d8acb50c8e9 ("staging: android: ion: Pull out ion ioctls to a separate
> file") is the patch that causes the minor conflict in applying the original
> patch.
> 4c23cbff073f3b9b ("staging: android: ion: Remove import interface") is the
> patch that removes the affected code altogether in later kernels versions.

Ok, that makes more sense, thanks for letting me know, this was an odd
one-off and I didn't remember it at all.

Now queued up.

greg k-h
