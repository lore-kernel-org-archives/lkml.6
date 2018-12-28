Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E201C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2322146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546011567;
	bh=iVQ1kF9y6hHDgGvodrwcjSAGK0HbRMuIm2C7krxh6Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xZsYubKDtuYTrgYOvO+DJpEDH5loIixVWwQ2tJg98J10To/4hviqsLCAVuG7EVkDw
	 I17rVnnBXpQ9Cng7FeBgRP86lVAFjZxyUyg/Ad23f84ywQNMqNTuJY20VYkl6nhgTl
	 mP56deNsQBiF60+023TS035SNbbii4ui6g7D1Y9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbeL1PjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:39:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731178AbeL1PjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:39:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6643620869;
        Fri, 28 Dec 2018 15:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546011564;
        bh=iVQ1kF9y6hHDgGvodrwcjSAGK0HbRMuIm2C7krxh6Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNBQTsoCLNKKW8hIlBrQRrjTgVYxenNSuP6RcjBfOttxB75eouDsu1HX0NeApXZuO
         BBaCVlVkW/HP9tTSwDiyHNbvda0EJHb/Je97KHfsuDFGabcFeWJFZ6ljg0YwrJ3vjC
         XWMmGlEC1Sdll7qmdsJukRU6pY1foYH+h+ChpVf0=
Date:   Fri, 28 Dec 2018 16:39:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Char/Misc driver patches for 4.21-rc1
Message-ID: <20181228153922.GA24514@kroah.com>
References: <20181228153653.GA23909@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228153653.GA23909@kroah.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 04:36:53PM +0100, Greg KH wrote:
> The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:
> 
>   Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.21-rc1
> 
> for you to fetch changes up to fbc4904c287778ddb74bf6060ac9dec51992fc53:
> 
>   MAINTAINERS: add another Android binder maintainer (2018-12-21 08:35:45 +0100)

Note, there will be a merge conflict in your tree with the
drivers/ptp/ptp_clock.c file.  The fix should be pretty straightforward,
the chunk from this tree should be the one to take.

thanks,

greg k-h
