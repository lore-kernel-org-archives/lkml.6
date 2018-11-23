Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2585C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829E220685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFyaXke8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829E220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408891AbeKWUGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393770AbeKWUGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:06:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F9420663;
        Fri, 23 Nov 2018 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542964995;
        bh=N3ZrEXK2gCvFz5IC2hgM3BDDkWUDgSuVUpMbb0DZnYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFyaXke8ybGaTIUrFlKabnPgDxhSfUkYn9NUfuH8jUM1duMCbvErM+Bcms9FVqAQo
         Vf1wJac7XSEfe7uj3dkkRAyzxMF2TPSOWU+rNKm3JJCRmpOecwxRgMZHShtF5cW4jk
         lupFv0A0N0EaWGauNJjS+eBlQ4DzQcTCyRFPUnLk=
Date:   Fri, 23 Nov 2018 10:23:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rainer Fiebig <jrf@mailbox.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.9.139
Message-ID: <20181123092313.GA20555@kroah.com>
References: <20181123074731.GA12130@kroah.com>
 <1668382.GpLhWH2QsV@siriux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668382.GpLhWH2QsV@siriux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 09:55:47AM +0100, Rainer Fiebig wrote:
> Am Freitag, 23. November 2018, 08:47:31 schrieb Greg KH:
> > I'm announcing the release of the 4.9.139 kernel.
> > 
> > All users of the 4.9 kernel series must upgrade.
> > 
> > The updated 4.9.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> > linux-4.9.y and can be browsed at the normal kernel.org git web browser:
> > 	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Just *in case* this was an oversight: STIBP is still active in 4.9.139.
> 
> Not that I would mind because for my modest Core i3 that I mainly use for 
> office-work I don't see *any* difference in performance compared to 4.9.136 
> (no STIBP).
> 
> So long!

Wait, really?  I thought I reverted the patch.  Oh crap, I only did it
for 4.14.y and 4.19.y, my fault :(

I'll go queue up the revert now, so sorry about that.

greg k-h
