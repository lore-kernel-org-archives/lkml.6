Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1EBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1EB208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ+QZOCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1EB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbeK0ULN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:11:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbeK0ULN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:11:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B146320873;
        Tue, 27 Nov 2018 09:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543310039;
        bh=9KJKcfl8UzpdRgqf34l2QFTWk/Wiz1BdjMSd7Ce4bZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJ+QZOCTeWb7M4scRei/6cGVcLYDWs6H21XWovCutl9oC6peVN1yVxHt8Lrv3Je0H
         2dBwb3aiJAs6i7QojtnrOFNOcEvkzErh2JIBrs7hZzvmyrrLQrByFLhysOrH3J09yN
         QzvL7TPyJw4Sa/Ygw+DkVYLvorlXv5YMBeyyRYYY=
Date:   Tue, 27 Nov 2018 10:13:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, eric@anholt.net,
        dave.stevenson@raspberrypi.org, devel@driverdev.osuosl.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] staging: vchiq: dead code removal & misc fixes
Message-ID: <20181127091357.GA14089@kroah.com>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
 <2009845931.201432.1543260993249@email.ionos.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2009845931.201432.1543260993249@email.ionos.de>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 08:36:33PM +0100, Stefan Wahren wrote:
> > Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 20. November 2018 um 15:53 geschrieben:
> > 
> > 
> > Hi All,
> > 
> > This series was written in parallel with reading and understanding the
> > vchiq code. So excuse me for the lack of logic in the sequence of
> > patches.
> > 
> > The main focus was to delete as much code as possible, I've counted
> > around 550 lines, which is not bad. Apart from that there are some
> > patches enforcing proper kernel APIs usage.
> > 
> > The only patch that really changes code is the
> > vchiq_ioc_copy_element_data() rewrite.
> > 
> > The last commit updates the TODO list with some of my observations, I
> > realise some of the might be a little opinionated. If anything it's
> > going to force a discussion on the topic, which is nice.
> > 
> > It was developed on top of the latest linux-next, and was tested on a
> > RPIv3B+ with audio, video and running vchiq_test.
> > 
> > Regards,
> > Nicolas
> > 
> > RFC -> PATCH, as per Stefan's comments:
> >   - Remove semaphore initialization from remove_event_create()
> >     (commit 9)
> >   - Join all three semaphore to completion patches (commit 11)
> >   - Update probe/init commit message (commit 14)
> >   - Update TODO commit message and clean up (commit 16)
> >   - Fix spelling on some of the patches
> > 
> 
> The whole series is
> 
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> Unfortunately patch 05 might not apply.

I fixed it up.

thanks,

greg k-h
