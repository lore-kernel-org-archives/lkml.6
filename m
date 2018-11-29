Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A63A206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyHUgCzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A63A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeK2XxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbeK2XxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:53:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7159206B6;
        Thu, 29 Nov 2018 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543495678;
        bh=nzk3zguAl0SYfq8RAal1Up0FeK3ZhmMaIfSkhqDw9+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyHUgCzCZjfbkR2Hh3/WXVwMfnhRbDrrfsd8LUFxuJz/vQwOqKn7UfCVo/OG0oF0s
         A+KMciw1EM7pNQZHgvlea/IWCo626gCMgpsgERPS4ZQIwm6UdVc6BvZWTup0vJ2kic
         0QMzSGpa+4nbZOhkFle1I79gBq03XAtKHa3vYTmU=
Date:   Thu, 29 Nov 2018 13:47:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181129124756.GA25945@kroah.com>
References: <20181129060110.159878-1-sashal@kernel.org>
 <20181129060110.159878-25-sashal@kernel.org>
 <20181129121458.GK19305@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129121458.GK19305@dastard>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:14:59PM +1100, Dave Chinner wrote:
> 
> Cherry picking only one of the 50-odd patches we've committed into
> late 4.19 and 4.20 kernels to fix the problems we've found really
> seems like asking for trouble. If you're going to back port random
> data corruption fixes, then you need to spend a *lot* of time
> validating that it doesn't make things worse than they already
> are...

Any reason why we can't take the 50-odd patches in their entirety?  It
sounds like 4.19 isn't fully fixed, but 4.20-rc1 is?  If so, what do you
recommend we do to make 4.19 working properly?

thanks,

greg k-h
