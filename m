Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52045C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1059220684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1059220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJCFlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:41:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:41:41 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6681614EC;
        Tue,  2 Oct 2018 22:55:59 +0000 (UTC)
Date:   Tue, 2 Oct 2018 15:55:58 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: cxl: Move a deference below a NULL test
Message-ID: <20181002225558.GA27362@kroah.com>
References: <1537962072-13732-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537962072-13732-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 07:41:12PM +0800, zhong jiang wrote:
> It is safe to move a deference below a NULL test.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> ---
>  drivers/misc/cxl/guest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> index 3bc0c15..559e835 100644
> --- a/drivers/misc/cxl/guest.c
> +++ b/drivers/misc/cxl/guest.c
> @@ -1018,11 +1018,11 @@ int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_n
>  
>  void cxl_guest_remove_afu(struct cxl_afu *afu)
>  {
> -	pr_devel("in %s - AFU(%d)\n", __func__, afu->slice);
> -
>  	if (!afu)
>  		return;
>  
> +	pr_devel("in %s - AFU(%d)\n", __func__, afu->slice);
> +

This call should just be deleted, ftrace can be used if this type of
thing is really needed.

thanks,

greg k-h
