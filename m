Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB85ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0D9208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0D9208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeGQLw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:52:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbeGQLw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:52:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A67B0C34;
        Tue, 17 Jul 2018 11:20:19 +0000 (UTC)
Date:   Tue, 17 Jul 2018 13:20:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.17.7
Message-ID: <20180717112017.GA17910@kroah.com>
References: <20180717105929.GA18343@kroah.com>
 <20180717111126.GA24208@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717111126.GA24208@flashbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:11:26AM -0700, Nathan Chancellor wrote:
> On Tue, Jul 17, 2018 at 12:59:29PM +0200, Greg KH wrote:
> > NOTE, this kernel release is broken for i386 systems.  If you are
> > running such a machine, do NOT update to this release, you will not be
> > able to boot properly.
> > 
> > I did this release anyway with this known problem as there is a fix in
> > here for x86-64 systems that was nasty to track down and was affecting
> > people.  Given that the huge majority of systems are NOT i386, I felt
> > this was a safe release to do at this point in time.
> > 
> > Once the proper fix for i386 systems has been accepted into Linus's tree
> > (it has been posted already), I will pick it up and do a new 4.17.y
> > release so that users of those systems can update.
> > 
> 
> Just a heads up, it was picked up by Linux yesterday but it wasn't
> tagged for stable: d1b47a7c9efc ("mm: don't do zero_resv_unavail if
> memmap is not allocated").

Ah, I missed that!  Now queued up, let's run this on my build system and
then push it out for the world to test in a few hours.

thanks,

greg k-h
