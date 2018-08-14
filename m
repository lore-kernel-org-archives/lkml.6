Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DA7C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D113721738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D113721738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbeHNR1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:27:21 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:40200 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728458AbeHNR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:27:21 -0400
Received: (qmail 3155 invoked by uid 2102); 14 Aug 2018 10:39:53 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Aug 2018 10:39:53 -0400
Date:   Tue, 14 Aug 2018 10:39:53 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
cc:     Roger Quadros <rogerq@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
        "joe@perches.com" <joe@perches.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hub: try old enumeration scheme first for high
 speed devices
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED0C9B12B9@dggemm526-mbx.china.huawei.com>
Message-ID: <Pine.LNX.4.44L0.1808141022450.1466-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018, Zengtao (B) wrote:

> Hi alan: 
> 
> >-----Original Message-----
> >From: linux-usb-owner@vger.kernel.org
> >[mailto:linux-usb-owner@vger.kernel.org] On Behalf Of Alan Stern
> >Sent: Friday, August 10, 2018 10:20 PM
> >To: Roger Quadros <rogerq@ti.com>
> >Cc: Zengtao (B) <prime.zeng@hisilicon.com>; gregkh@linuxfoundation.org;
> >mathias.nyman@linux.intel.com; drinkcat@chromium.org;
> >felipe.balbi@linux.intel.com; drake@endlessm.com; mike.looijmans@topic.nl;
> >joe@perches.com; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> >Subject: Re: [PATCH] usb: hub: try old enumeration scheme first for high speed
> >devices
> >
> >On Fri, 10 Aug 2018, Roger Quadros wrote:
> >
> >> Hi,
> >>
> >> On 10/08/18 18:01, Zeng Tao wrote:
> >> > The new scheme is required just to support legacy low and full-speed
> >> > devices. For high speed devices, it will slower the enumeration speed.
> >> > So in this patch we try the "old" enumeration scheme first for high
> >> > speed devices.
> >>
> >> How slow does it get? Is it significant?
> >> Do we risk breaking existing HS devices that work? I don't think we
> >> can be sure till we run this through testing.
> >
> >Indeed.  I am extremely skeptical about a patch like this, unless somebody can
> >show that Windows uses the "old" scheme for high-speed devices.
> 
> Yes, this is what the windows has done, you can refer to 
> https://blogs.msdn.microsoft.com/usbcoreblog/2013/04/11/usb-2-1-2-0-1-1-device-enumeration-changes-in-windows-8/

And that blog post is 5 years old!

Okay, I think we can go ahead and make this change.  However, you 
should update the patch description to mention what Microsoft did in 
Windows 8 and say that the new behavior matches theirs.

Also, as Roger mentioned, you should update the documentation to say 
that the old_scheme_first module parameter now applies only to low- and 
full-speed devices, since high- and SuperSpeed devices always use the 
old scheme first.

Alan Stern

