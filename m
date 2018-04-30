Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755430AbeD3XfH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:35:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34272 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753647AbeD3XfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:35:06 -0400
X-Google-Smtp-Source: AB8JxZolsyl+KNxA2zuCbw3HmO06kBp9ZlMsTvfnbiVN2fdD0uXnqN0s9SWkoSZSORkZH3iE/NlVXg==
Date: Mon, 30 Apr 2018 17:35:00 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Thelen <gthelen@google.com>
Cc: Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tarick Bedeir <tarick@google.com>
Subject: Re: [PATCH 3/5] ib_srpt: depend on INFINIBAND_ADDR_TRANS
Message-ID: <20180430233500.GI26909@ziepe.ca>
References: <20180425223340.206907-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425223340.206907-1-gthelen@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 03:33:39PM -0700, Greg Thelen wrote:
> INFINIBAND_SRPT code depends on INFINIBAND_ADDR_TRANS provided symbols.
> So declare the kconfig dependency.  This is necessary to allow for
> enabling INFINIBAND without INFINIBAND_ADDR_TRANS.
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Cc: Tarick Bedeir <tarick@google.com>
>  drivers/infiniband/ulp/srpt/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/Kconfig b/drivers/infiniband/ulp/srpt/Kconfig
> index 31ee83d528d9..fb8b7182f05e 100644
> +++ b/drivers/infiniband/ulp/srpt/Kconfig
> @@ -1,6 +1,6 @@
>  config INFINIBAND_SRPT
>  	tristate "InfiniBand SCSI RDMA Protocol target support"
> -	depends on INFINIBAND && TARGET_CORE
> +	depends on INFINIBAND && INFINIBAND_ADDR_TRANS && TARGET_CORE

Isn't INFINIBAND && INFINIBAND_ADDR_TRANS a bit redundant? Can't have
INFINIBAND_ADDR_TRANS without INFINIBAND.

Jason
