Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BC8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E48020855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E48020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeKZTkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:40:11 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44567 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeKZTkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:40:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D8E17207BF; Mon, 26 Nov 2018 09:46:44 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id AE3C62074D;
        Mon, 26 Nov 2018 09:46:34 +0100 (CET)
Date:   Mon, 26 Nov 2018 09:46:34 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] i3c: fix an error code in
 i3c_master_add_i3c_dev_locked()
Message-ID: <20181126094634.6166a238@bbrezillon>
In-Reply-To: <20181123071324.iwmbay2yrbiocisf@kili.mountain>
References: <20181123071324.iwmbay2yrbiocisf@kili.mountain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 10:14:42 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> We should return "ret" as-is.  The "newdev" variable is a valid pointer.
> 
> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Queued to i3c/next.

Thanks,

Boris

> ---
>  drivers/i3c/master.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 0ea7bb045fad..bda4b9613e53 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1823,10 +1823,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
>  		return PTR_ERR(newdev);
>  
>  	ret = i3c_master_attach_i3c_dev(master, newdev);
> -	if (ret) {
> -		ret = PTR_ERR(newdev);
> +	if (ret)
>  		goto err_free_dev;
> -	}
>  
>  	ret = i3c_master_retrieve_dev_info(newdev);
>  	if (ret)

