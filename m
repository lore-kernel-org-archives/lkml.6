Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0F1C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015A020811
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAXL7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:59:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbfAXL7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:59:17 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 321CCF99A6169F84D543;
        Thu, 24 Jan 2019 19:59:15 +0800 (CST)
Received: from localhost (10.206.48.115) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 24 Jan 2019
 19:59:14 +0800
Date:   Thu, 24 Jan 2019 11:59:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>
CC:     Olof Johansson <olof@lixom.net>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "Dave Airlie" <airlied@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        <ogabbay@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <fbarrat@linux.ibm.com>, <linux-accelerators@lists.ozlabs.org>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
Message-ID: <20190124115902.000016cf@huawei.com>
In-Reply-To: <ba543301-9953-4dcd-f744-2aa66746a874@au1.ibm.com>
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
        <CAOesGMjU0tjJwAqCADaAv6XrCGbjB8G2oT=4LxOgSQBHO7Gptw@mail.gmail.com>
        <ba543301-9953-4dcd-f744-2aa66746a874@au1.ibm.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.206.48.115]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 12:03:06 +1100
Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:

> On 24/1/19 8:52 am, Olof Johansson wrote:
> > But, I think the largest question I have (for a broader audience) is:
> > 
> > I predict that we will see a handful of these kind of devices over the
> > upcoming future -- definitely from ML accelerators but maybe also for
> > other kinds of processing, where there's a command-based, buffer-based
> > setup sending workloads to an offload engine and getting results back.
> > While the first waves will all look different due to design trade-offs
> > made in isolation, I think it makes sense to group them in one bucket
> > instead of merging them through drivers/misc, if nothing else to
> > encourage more cross-collaboration over time. First steps in figuring
> > out long-term suitable frameworks is to get a survey of a few
> > non-shared implementations.
> > 
> > So, I'd like to propose a drivers/accel drivers subtree, and I'd be
> > happy to bootstrap it with a small group (@Dave Airlie: I think your
> > input from GPU land be very useful, want to join in?). Individual
> > drivers maintained by existing maintainers, of course.
> > 
> > I think it might make sense to move the CAPI/OpenCAPI drivers over as
> > well -- not necessarily to change those drivers, but to group them
> > with the rest as more show up.  
> 
> For cxl/ocxl, I have no objection to moving to this new subtree if 
> that's what we all agree to do. (what do people do about UAPI headers in 
> this situation? keep them where they are in misc/?)
> 
> If we do go ahead and set up this new subtree, perhaps we can use the 
> mailing list I set up at linux-accelerators@lists.ozlabs.org but we 
> haven't really started using...
> 
Assuming the concensus falls behind this...

I'll push this for the CCIX drivers as well as those start to turn up.

This particularly driver had passed me by until this email so great
to get the heads up via that list!

Sounds like a good plan in general to me.

Jonathan


