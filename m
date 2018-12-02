Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC9CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5442B2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFz50pKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5442B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbeLBUIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbeLBUIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:08:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6C2020645;
        Sun,  2 Dec 2018 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543781301;
        bh=lXVAzyeR+YutSAs+eU1y5NX5ScJc66P3X6XtnjTePV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFz50pKj8uyGvgDaIsLPwFOwTjgIzWU3S9PjDdndYWdiTe+zSMZK/4yad814Fioja
         tMRI8rrd4kSX0j6h/1wXe9bQTW075ZZOoPt9uOySe4GnQRIBtWTpBfUru8V7I4mXF/
         lHKJU096fnnP8y9+uGH/hh5BbLqasEtuul8MUYvU=
Date:   Sun, 2 Dec 2018 21:08:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "Luis R. Chamberlain" <mcgrof@kernel.org>
Subject: Re: XFS patches for stable
Message-ID: <20181202200819.GA3932@kroah.com>
References: <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm>
 <20181130215005.GP19305@dastard>
 <20181201074909.GC213156@sasha-vm>
 <CAOQ4uxhCH3oxVWDMVRcXMZO3JSTCA1Pp5AYnHP5pDxyNktqONw@mail.gmail.com>
 <20181202152547.GI221015@sasha-vm>
 <20181202161016.GA27696@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202161016.GA27696@infradead.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 08:10:16AM -0800, Christoph Hellwig wrote:
> As someone who has done xfs stable backports for a while I really don't
> think the autoselection is helpful at all.

autoselection for xfs patches has been turned off for a while, what
triggered this email thread was a core vfs patch that was backported
that was not obvious it was created by the xfs developers due to a
problem they had found.

> Someone who is vaguely familiar with the code needs to manually select
> the commits and QA them, which takes a fair amount of time, but just
> needs some manual help if it should work ok.
> 
> I think we are about ready to have a new xfs stable maintainer lined up
> if everything works well fortunately.

That would be wonderful news.

thanks,

greg k-h
