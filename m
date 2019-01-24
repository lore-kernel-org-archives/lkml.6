Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACD2C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF8F21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548317751;
	bh=ack29QH4xqRdXg+FVs9les4gl/Bcp4LrSb/D2S89Qf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fGlC0sZNJeMsuu0DOlOWeTa+FbZ2kI5nWnK7V+p6mekppQFLkQMgFh2mKupjChA27
	 TFFUu/zph8E8T/Z7RmRXcXZalV7CSLa/9yYd62OGv4LSccHuiN08GfOCi3RfbGDt3s
	 OsPy0E5zh+ppbjqdk/w5utMI+250crO4dePJZ/6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfAXIPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:15:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfAXIPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:15:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C60B8218A2;
        Thu, 24 Jan 2019 08:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548317747;
        bh=ack29QH4xqRdXg+FVs9les4gl/Bcp4LrSb/D2S89Qf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G6XQ/DwkiqVqjaAYRHADEzoPJ6HbUR1abxElBsQltof83rQv4Q4/18R4jju1F+x1L
         o9I0TtSQSwSbge6XiVim1GoQhkJTeTuwDzUQg7rXFIz8mJFwy0vGKZoChJu62bjLFp
         6oPp0YdpsUbxQUma27u4x06Ysf4A4uj1vyLmycVo=
Date:   Thu, 24 Jan 2019 09:15:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
Message-ID: <20190124081544.GA1649@kroah.com>
References: <20190123230634.1815021-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123230634.1815021-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 03:06:34PM -0800, Vijay Khemka wrote:
> Corrected some of return values with appropriate meanings.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> index 332210e06e98..97ae341109d5 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -68,7 +68,6 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>  		unsigned long param)
>  {
>  	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
> -	struct device *dev = file->private_data;
>  	void __user *p = (void __user *)param;
>  	struct aspeed_lpc_ctrl_mapping map;
>  	u32 addr;
> @@ -93,8 +92,8 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>  
>  		/* If memory-region is not described in device tree */
>  		if (!lpc_ctrl->mem_size) {
> -			dev_err(dev, "Didn't find reserved memory\n");
> -			return -EINVAL;
> +			pr_err("aspeed_lpc_ctrl: ioctl: Didn't find reserved memory\n");

Why did you change from dev_err() to pr_err()?  You just lost a lot of
information that the user previously was getting from dev_err() :(



> +			return -ENXIO;
>  		}
>  
>  		map.size = lpc_ctrl->mem_size;
> @@ -134,16 +133,16 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>  
>  		if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
>  			if (!lpc_ctrl->pnor_size) {
> -				dev_err(dev, "Didn't find host pnor flash\n");
> -				return -EINVAL;
> +				pr_err("aspeed_lpc_ctrl: ioctl: Didn't find host pnor flash\n");

Again, don't do that :(

thanks,

greg k-h
