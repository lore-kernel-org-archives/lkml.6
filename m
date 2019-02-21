Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A288FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6223B214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550737981;
	bh=jxyCt1teAbYxOFsBzjkOLzdwwkln/jxSiPEiNWsOLDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wyM+jCKLjqV2NS8JRPD33WxvlY3VcQZbVJjUrjuTIPrazQ83amGapaTC88YxpqDAl
	 JIgE/+I4jV+amnXuz/azJf64N5gSjKt2d66InQJuXeocKnul6saItzClri2tLJaO/5
	 SKs5+FGGyOkeeYgOOLkmLMQzfDdOEO0xZ5EpMpL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfBUIdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:33:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfBUIc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:32:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F5A2148D;
        Thu, 21 Feb 2019 08:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550737979;
        bh=jxyCt1teAbYxOFsBzjkOLzdwwkln/jxSiPEiNWsOLDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ou8GbNSKYvnSEJa2uHdi+ogmWTdkg09AVUo680pE8GofKlVE1ewj+mfpEIq7YS7Pr
         uXMokW1Utxo5brsmnnNR40uBCcrbprl0MeLi6liELnrrnELV8W27MRi/hrIskurTo6
         AvBORhtSH8mHm5yRIUI7FZqJZj6AbqiPWvmf3W+w=
Date:   Thu, 21 Feb 2019 09:32:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matt Hsiao <matt.hsiao@hpe.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        david.altobelli@hpe.com, mark.rusk@hpe.com, jerry.hoemann@hpe.com
Subject: Re: [PATCH 4/4] misc: hpilo: Update driver version
Message-ID: <20190221083256.GA6397@kroah.com>
References: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
 <1550736282-25416-5-git-send-email-matt.hsiao@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550736282-25416-5-git-send-email-matt.hsiao@hpe.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:04:42PM +0800, Matt Hsiao wrote:
> Bump version number to reflect recent minor changes.
> 
> Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> ---
>  drivers/misc/hpilo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
> index 927309b..4ef6802 100644
> --- a/drivers/misc/hpilo.c
> +++ b/drivers/misc/hpilo.c
> @@ -913,7 +913,7 @@ static void __exit ilo_exit(void)
>  	class_destroy(ilo_class);
>  }
>  
> -MODULE_VERSION("1.5.0");
> +MODULE_VERSION("1.5.1");

This line means nothing, it should just be removed entirely.  The
"version" of the driver is the kernel version itself.

Want me to drop it?

thanks,

greg k-h
