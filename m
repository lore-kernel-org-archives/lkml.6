Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B690C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C28E2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C28E2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeJCF2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:28:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJCF2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:28:02 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9055511F5;
        Tue,  2 Oct 2018 22:42:22 +0000 (UTC)
Date:   Tue, 2 Oct 2018 15:42:21 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 01/15] platform: goldfish: pipe: Remove the
 goldfish_interrupt_tasklet global variable
Message-ID: <20181002224221.GC25355@kroah.com>
References: <20181002221903.19476-1-rkir@google.com>
 <20181002223021.GA30567@kroah.com>
 <CAOGAQer-MSSsUocmjing7FhJb1SEV0T5v9StYr=DDPdTJeU0cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQer-MSSsUocmjing7FhJb1SEV0T5v9StYr=DDPdTJeU0cw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 03:33:11PM -0700, Roman Kiryanov wrote:
> > I don't see a "global" variable here, what are you referring to.
> >
> > This one:
> >
> > > -static DECLARE_TASKLET(goldfish_interrupt_tasklet, goldfish_interrupt_task, 0);
> >
> > ?
> 
> Yes.
> 
> > That looks static to this file to me.
> > what am I missing here?
> 
> It has a global lifetime but it is visible only in this file. How do I
> say better, just drop the word "global"?

Yes.  It's not a global variable at all.  It's file-scope only.

What you are doing is moving the variable to be attached to the device
itself, allowing you to have multiple devices handled by the same code,
which is great.  But please document it as such.

Same goes for the other patches in this series.

thanks,

greg k-h
