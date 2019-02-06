Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60B9C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF8D2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549471379;
	bh=lvgIWCrUGGxAy7KZs86WQQAiKIpXdaU9n9l5AsEIecI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mkzS5awe3OTT5UbJIf8MTuKDHYp6TjmJIqbrXQUNwsgkP0lYbcs39L20z2WGfpyXG
	 Qp3oERyIfY7afqE45kv2FWaJ8gV++biqNKbWY869wqP/wGAjdWmULdERieHXAmAZ/0
	 nt0loz9yMb6Ew8marVwSv9UmZLXGe23Eu1NZo42U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfBFQm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbfBFQm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:42:57 -0500
Received: from localhost (mobile-107-92-61-93.mycingular.net [107.92.61.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 013DF20811;
        Wed,  6 Feb 2019 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549471377;
        bh=lvgIWCrUGGxAy7KZs86WQQAiKIpXdaU9n9l5AsEIecI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzk2wZdMwz5yje+W2lxxYjvGplaUxpkwiN8x9nE+SqZfaqBzKTswYru0b0IsR5hZA
         zjNwTQ8Bxd1tGFeQv0z0+gdkfv/We93yisX2HxWFi0FXW9pj6ru0yTUDAyRF44Oq6u
         bgX3tbQrczjWQee0qgkOM4gq7emSBLBs1in9Sh3k=
Date:   Wed, 6 Feb 2019 17:42:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Julien Freche <jfreche@vmware.com>
Subject: Re: [PATCH 1/6] vmw_balloon: bump version number
Message-ID: <20190206164245.GA8466@kroah.com>
References: <20190206051336.2425-1-namit@vmware.com>
 <20190206051336.2425-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206051336.2425-2-namit@vmware.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 09:13:31PM -0800, Nadav Amit wrote:
> Following recent changes.
> 
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  drivers/misc/vmw_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index f8240b87df22..7294f305753f 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -34,7 +34,7 @@
>  
>  MODULE_AUTHOR("VMware, Inc.");
>  MODULE_DESCRIPTION("VMware Memory Control (Balloon) Driver");
> -MODULE_VERSION("1.5.0.0-k");
> +MODULE_VERSION("1.6.0.0-k");

Please just drop this pointless line, it means nothing and is always out
of date.  It's been removed from many other drivers, and I really don't
want to see it come back.

Your driver "version" is the kernel version, full stop.  That's all you
need to ever worry about.

thanks,

greg k-h
