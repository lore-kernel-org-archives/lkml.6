Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8109C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880A120877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880A120877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeJDL3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:29:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeJDL3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:29:36 -0400
Received: from localhost (unknown [209.136.236.94])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EBCE5305;
        Thu,  4 Oct 2018 04:38:13 +0000 (UTC)
Date:   Wed, 3 Oct 2018 21:38:12 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] misc: cxl: delete possible null pointer dereference
Message-ID: <20181004043812.GA8134@kroah.com>
References: <1538621808-28080-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538621808-28080-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 10:56:48AM +0800, zhong jiang wrote:
> It is safe to dereference an object below a NULL test. For the sake
> of debugging. Just delete the call of possible null pointer dereference.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/misc/cxl/guest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> index 3bc0c15..472e8db 100644
> --- a/drivers/misc/cxl/guest.c
> +++ b/drivers/misc/cxl/guest.c
> @@ -1018,7 +1018,7 @@ int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_n
>  
>  void cxl_guest_remove_afu(struct cxl_afu *afu)
>  {
> -	pr_devel("in %s - AFU(%d)\n", __func__, afu->slice);
> +	pr_devel("in %s\n", __func__);

This call should just be deleted, it's not needed, ftrace can be used
instead.

thanks,

greg k-h
