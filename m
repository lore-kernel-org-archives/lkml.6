Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95573C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4F3218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548149009;
	bh=pJe8XyLxKPkUajc+9M0rp/1UfMXdLKAiLqf5eVtJ1do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=je35hEG3HKR/MFicZZ1+Ac3j5elcGMhkc3MiCSK53cs3pI6CopIpSdYDklKsTcTKo
	 EsOFAfspTSbbJU4nKSrjkHlXeNFHZ1kipfF/kjqyw96oBVMjL3Cknr4iuxI3+upqIj
	 HTul3W2JDGGzwolRhSfBbB0g5/qMndEcupt6rCKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfAVJX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfAVJX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:23:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FBD218D9;
        Tue, 22 Jan 2019 09:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548149005;
        bh=pJe8XyLxKPkUajc+9M0rp/1UfMXdLKAiLqf5eVtJ1do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yJJBUcGxeRP8VcJuLBNkE3A/Qc7mCzfGP/ETh1uv+S9gyP8fS1gtivtPizLzMzijS
         1n5CcAgC92zc3su5gY3cwWqQBFhQZzbeCVnfxUEGduy893js2ywVtm7fWTwtVULv4K
         wSdmveUrnHxJPf4clsBeKsgTQhkt0K5TL7VwefGQ=
Date:   Tue, 22 Jan 2019 10:23:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvram: annotate implicit fall through
Message-ID: <20190122092301.GA23719@kroah.com>
References: <20190114204415.22296-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114204415.22296-1-malat@debian.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 09:44:15PM +0100, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
> 
> This commit remove the following warning:
> 
>   drivers/char/generic_nvram.c:83:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/char/generic_nvram.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
> index ff5394f47587..53123c110f7b 100644
> --- a/drivers/char/generic_nvram.c
> +++ b/drivers/char/generic_nvram.c
> @@ -81,6 +81,7 @@ static int nvram_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  #ifdef CONFIG_PPC_PMAC
>  	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
>  		printk(KERN_WARNING "nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
> +		/* fall through */
>  	case IOC_NVRAM_GET_OFFSET: {
>  		int part, offset;
>  

This file is now gone from my tree, sorry.

greg k-h
