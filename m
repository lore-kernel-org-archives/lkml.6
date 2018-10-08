Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59342C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1695A2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xYX2q2Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1695A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJHVkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeJHVkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:40:15 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D8372075C;
        Mon,  8 Oct 2018 14:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539008895;
        bh=o1mnGNdcH60LR1/UDO1/SBCOxCEPw8HfaV0F+r+50Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xYX2q2TvzTlmxDbW5rkpPyJHUZs0bXqelthEJ96TRLvTcMdESCM3HPhgl04OBfsoD
         akbsZKRmS1gTX8+ckZkTHC5AUlETHdL4phXZSAe3HF5f0pATShpjFSoSMHNuzw1WVg
         jvfOSjKzUhBuWDJ6Dqr2y07IHtFFF4t0B+TV7WKc=
Date:   Mon, 8 Oct 2018 16:28:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 4.19-rc7
Message-ID: <20181008142813.GB7310@kroah.com>
References: <20181007154529.GA4493@kroah.com>
 <20181007223622.GA12196@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181007223622.GA12196@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 03:36:22PM -0700, Guenter Roeck wrote:
> On Sun, Oct 07, 2018 at 05:45:29PM +0200, Greg KH wrote:
> > Hi all,
> > 
> > Yet again, it's time for a kernel -rc release.  This one is bigger than
> > -rc6 was, for a variety of unrelated reasons it seems.  Lots of
> > different trees being merged this week, much more so than the previous
> > one.  Highlights include two sets of networking fixes, lots of different
> > driver subsystem fixes, arm and arm64 and x86 and riscv and powerpc64
> > fixes, as well as scheduler, iommu, and vfs fixes.  Not a huge quantity
> > overall, just overall a lot of different things.
> > 
> > Given the current rate of change, and looking at the travel/conference
> > schedule happening this month, it seems like we will be having a -rc8
> > just to be sure 4.19 is solid as well as not having to be in the middle
> > of a merge window during a conference week.  Please go test and make
> > sure any remaining problems are sent in in time.
> > 
> 
> Build results:
> 	total: 135 pass: 135 fail: 0
> Qemu test results:
> 	total: 318 pass: 318 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.
> 
> Notes:
> - sparc32:allmodconfig is no longer built.
>   Starting with v4.19, nds32:allmodconfig will be built instead.
> - CONFIG_OF_UNITTEST is now disabled.

Ah, not building broken tests helps :)

thanks for testing these and letting me know.

greg k-h
