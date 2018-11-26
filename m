Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D415C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A162082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="F6zoWUP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A162082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeK0KeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:34:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34783 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbeK0KeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:34:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so18336152ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vSPEoo8UirkbUzoFtdd/0N+Ncp7rxO3RvWkbjta/Sc=;
        b=F6zoWUP3kJGjnWQiAm0SKmGxt3cB7sZzwu9Jk2K25C4kYzvb8Sb4JdPAxPj9uk3YhS
         /Kh9Uy/OdTa1xxc/Xk9VLP+tabNZmRfwqzsvbk9ezhfSyAFp5dAr1o51xKkSvcaSKREu
         qG1zpzxfbTszKmF8VqqsXrisUITPqQYdPI6i31mc2KD83ScZ8jLRaM7z4NJvUuoD0Bgw
         FxxN1dNBB/7qC1ARnKMPDUJtRX1/xGNHjFpLSkZIIWsQgLt7TDjEC0Jcl2auYFJKn1Hp
         aRhsYjhax9ls+KfTMGaTvBNNFxGsmRlFwUoDUaA/CGlipUPg1Lp8csX+cA+5t7p1gyM5
         ktug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vSPEoo8UirkbUzoFtdd/0N+Ncp7rxO3RvWkbjta/Sc=;
        b=ZklMpT29DhpWpVCUZYTR0j8ItUjdu/DeN+T/NLp0ahQfXQinL+wzL9uYzCqWSMeRHY
         HYKeS3Sme/YRbJd+4SQ8V073o42FJGe7QsDf+HTlPTpyXpebkqqVUoXA5i+nSitStDgA
         Fp4Nmd2drR7iH3ECaOcrHyy42n01OcIqZML44b9HTwN2x/8HcxvccaV/lYwGqUa/NJgh
         aWNVFAK1KpzrECRhqElfp/qHayoPDchMKK7Fe5L/bT7vxg/VDrm99ELswwfplfZl6sM4
         I1a81ip+qKKr2YCYC4btGKJ4hIAuy95sh6xxHAnvAeNbzPo6xA2Y/28nyHs/wEA91CnJ
         sJCQ==
X-Gm-Message-State: AA+aEWZaBfm9Z3tqI0F6EuvR7MEVEwDU+fw2h0dtBu4camKV9shxTVCe
        qKLCMMm5Ba6FVIsGO2ra0TdOz6ozHsDI1kBS4TtZ
X-Google-Smtp-Source: AFSGD/V3bdfxy7u/3nQoRKDAAjDq6cQnJU6alOQwaPZil2iw5nhKy/cBoVqPegA1nLF9c8DFFyCDuI+o5C2ot87wWoE=
X-Received: by 2002:a2e:8ec8:: with SMTP id e8-v6mr1996645ljl.162.1543275495723;
 Mon, 26 Nov 2018 15:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20181126145830.31882-1-tiny.windzz@gmail.com>
In-Reply-To: <20181126145830.31882-1-tiny.windzz@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Nov 2018 18:38:04 -0500
Message-ID: <CAHC9VhS4oQKv+YgsLdA_ef2_o5bAXN9P3xO43GcnKoHBd2KoSw@mail.gmail.com>
Subject: Re: [PATCH] kernel/audit: remove some duplicated includes
To:     tiny.windzz@gmail.com
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 9:58 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> audit.h and fs.h are included twice.It's unnecessary.
> hence just remove them.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  kernel/audit_watch.c | 2 --
>  1 file changed, 2 deletions(-)

Same as my previous comments.

> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 787c7afdf829..8c8b1a87fd2b 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -21,10 +21,8 @@
>
>  #include <linux/file.h>
>  #include <linux/kernel.h>
> -#include <linux/audit.h>
>  #include <linux/kthread.h>
>  #include <linux/mutex.h>
> -#include <linux/fs.h>
>  #include <linux/fsnotify_backend.h>
>  #include <linux/namei.h>
>  #include <linux/netlink.h>
> --
> 2.17.0
>


-- 
paul moore
www.paul-moore.com
