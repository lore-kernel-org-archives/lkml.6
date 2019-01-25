Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A742FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8ED217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfAYVht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:37:49 -0500
Received: from netrider.rowland.org ([192.131.102.5]:45553 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726329AbfAYVht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:37:49 -0500
Received: (qmail 4528 invoked by uid 500); 25 Jan 2019 16:37:48 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2019 16:37:48 -0500
Date:   Fri, 25 Jan 2019 16:37:48 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Bin Liu <b-liu@ti.com>
cc:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Fix potential NULL dereference
In-Reply-To: <20190125164412.GJ18982@uda0271908>
Message-ID: <Pine.LNX.4.44L0.1901251636140.4354-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019, Bin Liu wrote:

> On Thu, Jan 24, 2019 at 09:47:02PM +0300, Matwey V. Kornilov wrote:
> > By the way, why do we need to store the qh in urb->hcpriv?
> > qh can always be accessible through urb->ep->hcpriv
> > Wouldn't it be better to drop entire urb->hcpriv usage?
> 
> I am not sure why. The code is there since the first commit in a decade
> ago. But I tend to agree with you.
> 
> In a quick search for urb->hcpriv and urb->ep->hcpriv, based on the
> usage in core/hcd.c, it seems to me that urb->hcpriv should not be
> changed in each controller driver, but I see both have been used in most
> controller drivers. I will leave this to others to educate me.

In some of the older HCDs, urb->hcpriv != NULL is used to indicate that 
urb is on an endpoint queue.  Perhaps that usage was copied.

Alan Stern

