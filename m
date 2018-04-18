Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbeDRBas (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 21:30:48 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42015 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752757AbeDRBaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 21:30:46 -0400
X-Google-Smtp-Source: AIpwx48gUYfAKDJ71nzrz4D+jCTskCKhBD6M/uU636jBK2TVP3K0XyI7TgCnimfZXcZ6b0qIYpLvTg==
Date: Tue, 17 Apr 2018 19:30:40 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH v2] infiniband: mlx5: fix build errors when
 INFINIBAND_USER_ACCESS=m
Message-ID: <20180418013040.GA9616@ziepe.ca>
References: <aa0dd9f7-3475-c2b3-8d5c-032a7ad72fe9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa0dd9f7-3475-c2b3-8d5c-032a7ad72fe9@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 06:51:50PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors when INFINIBAND_USER_ACCESS=m and MLX5_INFINIBAND=y.
> The build error occurs when the mlx5 driver code attempts to use
> USER_ACCESS interfaces, which are built as a loadable module.
> 
> Fixes these build errors:
> 
> drivers/infiniband/hw/mlx5/main.o: In function `populate_specs_root':
> ../drivers/infiniband/hw/mlx5/main.c:4982: undefined reference to `uverbs_default_get_objects'
> ../drivers/infiniband/hw/mlx5/main.c:4994: undefined reference to `uverbs_alloc_spec_tree'
> drivers/infiniband/hw/mlx5/main.o: In function `depopulate_specs_root':
> ../drivers/infiniband/hw/mlx5/main.c:5001: undefined reference to `uverbs_free_spec_tree'
> 
> Build-tested with multiple config combinations.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Matan Barak <matanb@mellanox.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: stable@vger.kernel.org # reported against 4.16
> ---
> v2: allow building mxl5 even when INFINIBAND_USER_ACCESS is disabled.
> 
>  drivers/infiniband/hw/mlx5/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

I added a

Fixes: 8c84660bb437 ("IB/mlx5: Initialize the parsing tree root without the help of uverbs")

Applied to for-rc thanks

Jason
