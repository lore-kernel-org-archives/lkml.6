Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C69C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2E4223FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2E4223FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeHJQth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:49:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:57334 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727432AbeHJQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:49:37 -0400
Received: (qmail 1574 invoked by uid 2102); 10 Aug 2018 10:19:30 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Aug 2018 10:19:30 -0400
Date:   Fri, 10 Aug 2018 10:19:30 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Roger Quadros <rogerq@ti.com>
cc:     Zeng Tao <prime.zeng@hisilicon.com>, <gregkh@linuxfoundation.org>,
        <mathias.nyman@linux.intel.com>, <drinkcat@chromium.org>,
        <felipe.balbi@linux.intel.com>, <drake@endlessm.com>,
        <mike.looijmans@topic.nl>, <joe@perches.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: hub: try old enumeration scheme first for high
 speed devices
In-Reply-To: <a29afa26-22b4-3188-f9ee-993e44df7703@ti.com>
Message-ID: <Pine.LNX.4.44L0.1808101017050.1425-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018, Roger Quadros wrote:

> Hi,
> 
> On 10/08/18 18:01, Zeng Tao wrote:
> > The new scheme is required just to support legacy low and full-speed
> > devices. For high speed devices, it will slower the enumeration speed.
> > So in this patch we try the "old" enumeration scheme first for high speed
> > devices.
> 
> How slow does it get? Is it significant?
> Do we risk breaking existing HS devices that work? I don't think we can
> be sure till we run this through testing.

Indeed.  I am extremely skeptical about a patch like this, unless
somebody can show that Windows uses the "old" scheme for high-speed 
devices.

Alan Stern

