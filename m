Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE15ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832C32086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832C32086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbeIXQwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:52:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47784 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeIXQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:52:21 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91FB9105A;
        Mon, 24 Sep 2018 10:50:49 +0000 (UTC)
Date:   Mon, 24 Sep 2018 12:50:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Lars Persson <lists@bofh.nu>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martinbayern@outlook.com
Subject: Re: [PATCH 4.9 069/101] ubi: fastmap: Correctly handle interrupted
 erasures in EBA
Message-ID: <20180924105047.GA16476@kroah.com>
References: <20180701160757.138608453@linuxfoundation.org>
 <2076412.mQRaXglRsh@blindfold>
 <CADnJP=sJE6hpG6inp5Yu+5P2F-d0=6GP-2dAXJTmBOb_rPzgvw@mail.gmail.com>
 <1657546.ePJIJPgWtA@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657546.ePJIJPgWtA@blindfold>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 08:32:12AM +0200, Richard Weinberger wrote:
> Lars,
> 
> Am Sonntag, 23. September 2018, 15:49:42 CEST schrieb Lars Persson:
> > Hi Richard
> > 
> > Sorry, I assumed this omission from -stable was a mistake.
> > 
> > The timing for our boot increased from 45 seconds to 55 seconds on one
> > chip and 42 seconds to 48 seconds on another chip. The regression was
> > completely fixed by applying the extra patches. The way I see it the
> > first patch is a significant slow-down so the second patch is required
> > to restore performance.
> 
> okay, this is not good. Let's put the performance patch also into -stable
> to get rid of that regression.
> Usually I'm rather conservative with adding non-trivial material to -stable.
> As history has shown, Fastmap is special. ;-)
> 
> Out of interest, what flashes are these? I'm interested in page vs. erase size.
> Did you give UBIFS bulk-read try?
> 
> Greg, I'll send another mail which will state what patches are needed.

Thank you, as I am totally confused here...

greg k-h
