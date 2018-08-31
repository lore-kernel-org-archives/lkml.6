Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68856C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1759020837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1759020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeHaUFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:05:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeHaUFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:05:10 -0400
Received: from localhost (unknown [72.28.92.217])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 56BDEC83;
        Fri, 31 Aug 2018 15:57:01 +0000 (UTC)
Date:   Fri, 31 Aug 2018 08:56:57 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] staging: android: ion: check for kref overflow
Message-ID: <20180831155657.GA25066@kroah.com>
References: <20180830230946.228701-1-drosen@google.com>
 <20180831004144.GC20664@kroah.com>
 <589c036d-450a-3f3b-8f5a-4148713d4bfb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <589c036d-450a-3f3b-8f5a-4148713d4bfb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 06:36:18PM -0700, Daniel Rosenberg wrote:
> On 08/30/2018 05:41 PM, Greg Kroah-Hartman wrote:
> > On Thu, Aug 30, 2018 at 04:09:46PM -0700, Daniel Rosenberg wrote:
> > > This patch is against 4.9. It does not apply to master due to a large
> > > rework of ion in 4.12 which removed the affected functions altogther.
> > > 4c23cbff073f3b9b ("staging: android: ion: Remove import interface")
> > > 
> > > Userspace can cause the kref to handles to increment
> > > arbitrarily high. Ensure it does not overflow.
> > > 
> > > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > I signed off on this?  Where?  When?  Are you sure?
> > 
> > greg k-h
> The sign off was on the 4.4.y version that I cherry-picked this from.

Ah that wasn't obvious at all.  What is that git commit id?  You need to
give us a hint as to what is going on when you do that :)

> There was a trivial conflict moving it to 4.9, but it did not modify
> any changed lines, so I hadn't thought that was worth noting on the
> patch. I apologise if leaving the signed-off-by was incorrect here.

Why did I only apply this to 4.4 and not 4.9 when the original patch was
submitted?  That seems odd.

thanks,

greg k-h
