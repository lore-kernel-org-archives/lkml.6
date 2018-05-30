Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbeE3WZ2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:25:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35842 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753659AbeE3WZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:25:26 -0400
X-Google-Smtp-Source: ADUXVKIf/w8xdNzBmoFvqRX5BicyjWJinuQzjxngelN/Ez8aC4+1cifFglXmCy+ljjuhCw8pCspwkw==
Date: Wed, 30 May 2018 16:25:20 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iw_cxgb4: add INFINIBAND_ADDR_TRANS dependency
Message-ID: <20180530222520.GJ30754@ziepe.ca>
References: <20180530215826.1343234-1-arnd@arndb.de>
 <20180530220405.GH30754@ziepe.ca>
 <0be4e0fb-8d8e-b337-fc8d-550c90829d8c@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be4e0fb-8d8e-b337-fc8d-550c90829d8c@opengridcomputing.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 05:10:35PM -0500, Steve Wise wrote:
> 
> 
> On 5/30/2018 5:04 PM, Jason Gunthorpe wrote:
> > On Wed, May 30, 2018 at 11:58:18PM +0200, Arnd Bergmann wrote:
> >> The newly added fill_res_ep_entry function fails to link if
> >> CONFIG_INFINIBAND_ADDR_TRANS is not set:
> >>
> >> drivers/infiniband/hw/cxgb4/restrack.o: In function `fill_res_ep_entry':
> >> restrack.c:(.text+0x3cc): undefined reference to `rdma_res_to_id'
> >> restrack.c:(.text+0x3d0): undefined reference to `rdma_iw_cm_id'
> >>
> >> This adds a Kconfig dependency for the driver.
> >>
> >> Fixes: 116aeb887371 ("iw_cxgb4: provide detailed provider-specific CM_ID information")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>  drivers/infiniband/hw/cxgb4/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> > Oh, I think we need to solve this with maybe a header fill null stub
> > instead..
> >
> > We don't want to disable drivers just because a user interface is
> > disabled.
> >
> 
> Why does CONFIG_INFINIBAND_ADDR_TRANS disable building rdma_cm.ko? That
> is not correct.

That seems like a reasonable thing to do..

But why does it break the compile? Those functions are in cma.c...

Jason
