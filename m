Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFD5C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D122145D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkCsOTpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D122145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbeLBULK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:11:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbeLBULK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:11:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CEE42082F;
        Sun,  2 Dec 2018 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543781467;
        bh=aiwYg2GP7Pg7r8WpWStxktgldyFk3AXtqxxQuKN36Jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkCsOTpN546+qGe6yJMUlxcMlkQg4N+O8H+MSjZLK30BfpZHnHcRz5XaqeGz01/XZ
         /6oURwq5HBTV8ehHODdB4K7f0tJkXnMdLFVlbkHFp15cbTz8EmzyTYdQe3Wop/4P3z
         ZhXIGncBZbHi/V7+unP2MZLXdFBfkXMKVmGesXxM=
Date:   Sun, 2 Dec 2018 21:11:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181202201105.GB3932@kroah.com>
References: <20181129060110.159878-1-sashal@kernel.org>
 <20181129060110.159878-25-sashal@kernel.org>
 <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130214548.GO19305@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130214548.GO19305@dastard>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 08:45:48AM +1100, Dave Chinner wrote:
> > > Right now the XFS developers don't have the time or resources
> > > available to validate stable backports are correct and regression
> > > fre because we are focussed on ensuring the upstream fixes we've
> > > already made (and are still writing) are solid and reliable.
> > 
> > Ok, that's fine, so users of XFS should wait until the 4.20 release
> > before relying on it?  :)
> 
> Ok, Greg, that's *out of line*.

Sorry, I did not mean it that way at all, I apologize.

I do appreciate all the work you do on your subsystem, I was not
criticizing that at all.  I was just trying to make a bad joke that it
felt like no xfs patches should ever be accepted into stable kernels
because more are always being fixed, so the treadmill wouldn't stop.

It's like asking a processor developer "what chip to buy" and they
always say "the next one is going to be great!" because that is what
they are working on at the moment, yet you need to buy something today
to get your work done.  That's all, no harm ment at all, sorry if it
came across the wrong way.

greg k-h
