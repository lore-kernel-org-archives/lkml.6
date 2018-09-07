Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F298C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C903120645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C903120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeIGKVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:21:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43688 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeIGKVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:21:42 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E947EC87;
        Fri,  7 Sep 2018 05:42:25 +0000 (UTC)
Date:   Fri, 7 Sep 2018 07:42:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH AUTOSEL 4.18 02/88] usb: usbtest: use irqsave() in USB's
 complete callback
Message-ID: <20180907054223.GA10250@kroah.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
 <20180907003547.57567-2-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907003547.57567-2-alexander.levin@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:35:52AM +0000, Sasha Levin wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> [ Upstream commit 6f3fde684d0232e66ada3410f016a58e09a87689 ]
> 
> The USB completion callback does not disable interrupts while acquiring
> the lock. We want to remove the local_irq_disable() invocation from
> __usb_hcd_giveback_urb() and therefore it is required for the callback
> handler to disable the interrupts while acquiring the lock.
> The callback may be invoked either in IRQ or BH context depending on the
> USB host controller.
> Use the _irqsave() variant of the locking primitives.

All of the "use irqsave in USB's complete callback" patches are not
stable material as they are prep work for changes that have yet to hit
Linus's tree.

So you can drop this one.

thanks,

greg k-h
