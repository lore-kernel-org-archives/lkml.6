Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932603AbeE3WET (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:04:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40270 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932509AbeE3WEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:04:10 -0400
X-Google-Smtp-Source: ADUXVKJZcQo6O1VP/QESYF7EvUXPVZ0vnwm0BIjA/Jn73tzRQ0U86FuNUQY8/mqQovZBC6D022yl5A==
Date: Wed, 30 May 2018 16:04:05 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iw_cxgb4: add INFINIBAND_ADDR_TRANS dependency
Message-ID: <20180530220405.GH30754@ziepe.ca>
References: <20180530215826.1343234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530215826.1343234-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:58:18PM +0200, Arnd Bergmann wrote:
> The newly added fill_res_ep_entry function fails to link if
> CONFIG_INFINIBAND_ADDR_TRANS is not set:
> 
> drivers/infiniband/hw/cxgb4/restrack.o: In function `fill_res_ep_entry':
> restrack.c:(.text+0x3cc): undefined reference to `rdma_res_to_id'
> restrack.c:(.text+0x3d0): undefined reference to `rdma_iw_cm_id'
> 
> This adds a Kconfig dependency for the driver.
> 
> Fixes: 116aeb887371 ("iw_cxgb4: provide detailed provider-specific CM_ID information")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/hw/cxgb4/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Oh, I think we need to solve this with maybe a header fill null stub
instead..

We don't want to disable drivers just because a user interface is
disabled.

Thanks,
Jason
