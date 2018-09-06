Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3CFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D87206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUUHyH2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D87206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbeIFRq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:46:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40380 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIFRq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:46:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id l63-v6so5213317pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rO1PSP1fUVLt++p6MAZgQFBqzMDQO8wzKiZsa+LYKFA=;
        b=oUUHyH2ht3jeu0iPEegLMeG6aHVuCH/i1AnZPiS/bmftKk1mJ0O/LJmObyDDGms1fI
         SjBhyyBS7/+Y+hb127dJwsyd/FIuho5miMhzzE2fTHtxP9xMOnKh2e2qD5VeRKGZ5/QK
         /qHm9cXSfjQZrZQX5zY/UzF+pgYsdOtIlx1Tdm1/otz92bSUDsnoa2tq/eQwXqjeNS85
         cl89qaYNIkmy9nqnwPXBqyz51Fnie3tHOPKy35qPBfH9LjigFYS9Qzax1Rel2KcAtTem
         Ap+5a0ku7xbRjl9GkDj1w6lP2nMFce2UpcBTDBjiNqNrIuj9PA2Aob6xbyxUbPpiEnLH
         GV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rO1PSP1fUVLt++p6MAZgQFBqzMDQO8wzKiZsa+LYKFA=;
        b=LY1s8o9pynA3TTrCjppLElp11b233rxbxJH7VpLgZ4w1zf7f37z8OgFyCuDmvTWgjs
         lt4In3wM5X1B15LOU/JGJx7fzpgRkmO1Ppfm2IVz5iQItdijAwVdYHN0Uz75zP2hvMsk
         XxbGc8vbht7qEbKYn7x4a/jS4hHgvi1aaWu60971JrRWyNxdpBjer7X74zF2KJH25tuc
         rRiwfbZ7UDnQChOarceZoBagtknIWeDwmX3NUu4Zyc6ZW2xF6u+2vE/XUhXx3SvF2Kto
         IDYn3fH1ojsrPeA5UTGGXxU++jvkssBFjYdUEN4Bt8D6vCShqYadi7/8lQM5e678p6BQ
         VtpQ==
X-Gm-Message-State: APzg51D9D1MxNjIw7r7hLILaDa7zg7oN2kgkqWD7kI8xcHpflkOCgWcZ
        7SBvjXu0rHuCiCKBkwc4vhc=
X-Google-Smtp-Source: ANB0VdYLYVSxrEqXHF11l0q75thM+Pe9RhvPwkZic2nCZPz/mdshNu33yqgq9sPtaOMpfznrE5AWDg==
X-Received: by 2002:aa7:8713:: with SMTP id b19-v6mr2691409pfo.151.1536239461066;
        Thu, 06 Sep 2018 06:11:01 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (115-64-249-220.tpgi.com.au. [115.64.249.220])
        by smtp.gmail.com with ESMTPSA id l9-v6sm6214786pgg.79.2018.09.06.06.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 06:11:00 -0700 (PDT)
Date:   Thu, 6 Sep 2018 23:10:39 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matteo Croce <mcroce@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: Re: [PATCH 3/3] tty: hvc: hvc_write() fix break condition
Message-ID: <20180906231039.7b71186a@roar.ozlabs.ibm.com>
In-Reply-To: <20180905121439.23809-4-npiggin@gmail.com>
References: <20180905121439.23809-1-npiggin@gmail.com>
        <20180905121439.23809-4-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Sep 2018 22:14:39 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Commit 550ddadcc758 ("tty: hvc: hvc_write() may sleep") broke the
> termination condition in case the driver stops accepting characters.
> This can result in unnecessary polling of the busy driver.
> 
> Restore it by testing the hvc_push return code.
> 
> Fixes: 550ddadcc758 ("tty: hvc: hvc_write() may sleep")
> Tested-by: Matteo Croce <mcroce@redhat.com>
> Tested-by: Leon Romanovsky <leonro@mellanox.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  drivers/tty/hvc/hvc_console.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index bacf9b73ec98..c09a38fb0d66 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -522,6 +522,8 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
>  		return -EIO;
>  
>  	while (count > 0) {
> +		int ret;
> +
>  		spin_lock_irqsave(&hp->lock, flags);
>  
>  		rsize = hp->outbuf_size - hp->n_outbuf;

That needs to be 'int ret = 0;' to avoid used uninitialized.

Let me know if I should resend the patches.

Thanks,
Nick
