Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8CAC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FD225469
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FD225469
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeGBQMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:12:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeGBQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:12:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 04B88E65;
        Mon,  2 Jul 2018 16:12:31 +0000 (UTC)
Date:   Mon, 2 Jul 2018 18:12:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     airlied@linux.ie, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] char: agp: Change return type to vm_fault_t
Message-ID: <20180702161229.GC11874@kroah.com>
References: <20180521181704.GA19646@jordon-HP-15-Notebook-PC>
 <CAFqt6zZdb5+32CvvU_4Pmb1u-d15-iAFb3ab0ftBLP95257Z-Q@mail.gmail.com>
 <CAFqt6zYX-BsGsTHzEzWHWTLGA=7VtSMWYy7w8dBx+hTzxyhyfw@mail.gmail.com>
 <CAFqt6zYKOaieNEQE3TrXLoh9uXwcWH496EyuT_Tuyf8nZ1zd=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYKOaieNEQE3TrXLoh9uXwcWH496EyuT_Tuyf8nZ1zd=w@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 09:33:19PM +0530, Souptick Joarder wrote:
> On Mon, Jun 18, 2018 at 5:07 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > On Thu, May 31, 2018 at 10:38 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >> On Mon, May 21, 2018 at 11:47 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >>> Use new return type vm_fault_t for fault handler. For now,
> >>> this is just documenting that the function returns a
> >>> VM_FAULT value rather than an errno. Once all instances are
> >>> converted, vm_fault_t will become a distinct type.
> >>>
> >>> Ref-> commit 1c8f422059ae ("mm: change return type to
> >>> vm_fault_t") was added in 4.17-rc1 to introduce the new
> >>> typedef vm_fault_t. Currently we are making change to all
> >>> drivers to return vm_fault_t for page fault handlers. As
> >>> part of that char/agp driver is also getting changed to
> >>> return vm_fault_t type from fault handler.
> >>>
> >>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> >>> ---
> >>>  drivers/char/agp/alpha-agp.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
> >>> index 53fe633..c9bf2c2 100644
> >>> --- a/drivers/char/agp/alpha-agp.c
> >>> +++ b/drivers/char/agp/alpha-agp.c
> >>> @@ -11,7 +11,7 @@
> >>>
> >>>  #include "agp.h"
> >>>
> >>> -static int alpha_core_agp_vm_fault(struct vm_fault *vmf)
> >>> +static vm_fault_t alpha_core_agp_vm_fault(struct vm_fault *vmf)
> >>>  {
> >>>         alpha_agp_info *agp = agp_bridge->dev_private_data;
> >>>         dma_addr_t dma_addr;
> >>> --
> >>> 1.9.1
> >>>
> >>
> >> Any comment for this patch ?
> >
> > Any further comment on this patch ?
> 
> Greg, Can we get this patch in queue for 4.19 ?

I am not the agp maintainer, am I?  That would be David...

thanks,

greg k-h
