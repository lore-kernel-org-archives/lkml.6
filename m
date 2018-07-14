Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2571CECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 21:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D702087C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 21:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tUxd8d+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D702087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=welchs.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbeGNVnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 17:43:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52709 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbeGNVnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 17:43:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so5738834wmh.2;
        Sat, 14 Jul 2018 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PIKBA3G3KyC/KO8U2oA9LAgTmF+hLODUJtOHS8oBte0=;
        b=tUxd8d+NdwVlQSL+WRt2XjAx35L3ae4+XvgziJma4NMVgs8SVuX8UCtBBLTbh/6T2W
         oq0hEZDgK9kmjiLrglROp8GLnQ2rzx7bKQF6P5PG7yvjGuzM8ooGq49I6prf6nlWgnxJ
         /vHwVGjgzu+cvNWHDbp3plyE/g39BSCAc0h9yd++a/5xYdd+QkjachQx5//pCq5YAucE
         9tIdKkeIHhZGPiNaHuqNl0H+JTftiFIjZCLmP2DFv6usHMxshV4zZUFglSa35jTj3Yr1
         9EqJj5CGseeF2YCxPbwvSBlaGbacTIc5XKYXm6zcpCb/OymI3Utt8Zgg+RTtBfEHQ6OY
         Li+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PIKBA3G3KyC/KO8U2oA9LAgTmF+hLODUJtOHS8oBte0=;
        b=C84CmBkW3jO/1fWgXz0Vo3TBcGGmdSfRLmO0XGk36Qs3mJOKeGxka2x3uGRmY9YSvQ
         BlrZ3dx/1mxCiFC8crujtUvvN8f03eY2JrfHFnVHuAxxL3OjULkFtpLTj0MUkwih2cCe
         /nYFyS/6HAUidvElZonk2J0R56d7cjR1sfvDiptbefOOcB6I1BjN9KvfKdzs9r3VkSpI
         YGJJ5YcJr5jfQdgDkRukE44KzkBtJEvvVI8Wp6IT+BR0BxXyGwvJqe/CwTdX77O6+mc7
         S7c/eDxP4iF8K3n1rA+oKY/SDSDQdERhWD0KHcWjZdFguE2jPptmkHc4FIIKntT1v9Jm
         CKSQ==
X-Gm-Message-State: AOUpUlGF2vr6G5p6QKcywc6K9X2CjRQ7HINvF7RfoBVhD3Y7iY4DKqfP
        lFlbi6qf8vZoCHN34W7teyY=
X-Google-Smtp-Source: AAOMgpdCTxlSy7WmNpoGgmGIDWFFQsIcEvAU1p5N8x5o1WlTa7+4L18NomTL5WKFiDOPyOdEtK7i3g==
X-Received: by 2002:a1c:afc3:: with SMTP id y186-v6mr6275389wme.87.1531603359003;
        Sat, 14 Jul 2018 14:22:39 -0700 (PDT)
Received: from hades ([2a00:23c5:58d:db00:68bb:47d:d5ca:9abd])
        by smtp.gmail.com with ESMTPSA id z3-v6sm25937015wru.27.2018.07.14.14.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:22:38 -0700 (PDT)
Received: from martyn by hades with local (Exim 4.89)
        (envelope-from <martyn@hades.welchs.me.uk>)
        id 1feRzx-0007VK-FX; Sat, 14 Jul 2018 22:22:37 +0100
Date:   Sat, 14 Jul 2018 22:22:37 +0100
From:   Martyn Welch <martyn@welchs.me.uk>
To:     Colin King <colin.king@canonical.com>
Cc:     Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vme: ca91cx42: remove redundant variable i
Message-ID: <20180714212236.buwuefu2j7a7fqfl@hades.welchs.me.uk>
References: <20180714163332.11600-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714163332.11600-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 05:33:32PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable i is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'i' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Martyn Welch <martyn@welchs.me.uk>

> ---
>  drivers/vme/bridges/vme_ca91cx42.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/vme/bridges/vme_ca91cx42.c b/drivers/vme/bridges/vme_ca91cx42.c
> index 5dd284008630..53bdc256805f 100644
> --- a/drivers/vme/bridges/vme_ca91cx42.c
> +++ b/drivers/vme/bridges/vme_ca91cx42.c
> @@ -970,7 +970,6 @@ static unsigned int ca91cx42_master_rmw(struct vme_master_resource *image,
>  {
>  	u32 result;
>  	uintptr_t pci_addr;
> -	int i;
>  	struct ca91cx42_driver *bridge;
>  	struct device *dev;
>  
> @@ -978,7 +977,6 @@ static unsigned int ca91cx42_master_rmw(struct vme_master_resource *image,
>  	dev = image->parent->parent;
>  
>  	/* Find the PCI address that maps to the desired VME address */
> -	i = image->number;
>  
>  	/* Locking as we can only do one of these at a time */
>  	mutex_lock(&bridge->vme_rmw);
> -- 
> 2.17.1
> 
