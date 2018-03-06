Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbeCFXe0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:34:26 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45122 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754122AbeCFXeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:34:24 -0500
X-Google-Smtp-Source: AG47ELvpEdsSpkiOjgeQiPnwSsX/m0Jr2Q4TTMOKGLuxwedPrfWF9NqNOBjyp8g4aJ7gfc2rVkNzPQ==
Date: Tue, 6 Mar 2018 16:34:19 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Colin Ian King <colin.king@canonical.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: remove redundant assignment to pointer 'rdi'
Message-ID: <20180306233419.GA8328@ziepe.ca>
References: <20180301162354.17420-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301162354.17420-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 04:23:54PM +0000, Colin Ian King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer rdi is being initialized with a value that is never read
> and re-assigned immediately after, hence the initialization is redundant
> and can be removed.
> 
> Cleans up clang warning:
> drivers/infiniband/sw/rdmavt/vt.c:94:23: warning: Value stored to 'rdi'
> during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>  drivers/infiniband/sw/rdmavt/vt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to for-next, thanks

Jason
