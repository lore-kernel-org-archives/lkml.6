Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB667C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A435E208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="f5NtrIb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A435E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeK0Kdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:33:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41704 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbeK0Kdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:33:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so14982927lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEMPWpcRdJwqoxxn2uGsySlTQlz8YrJG3TBPUm/5CRY=;
        b=f5NtrIb9lRuL6bBKqBYfO329emLp2kx+/jSTEFgnwLghNVjiJcO2YvsRbd41FFuREk
         uhjP5qUKH5JNCpli/slpFvctj8P3bdaV9Qy/yjum7WvXJmC4hA63QI5gh6HV6gedGNvg
         IwMdokrZ4++7+V++64x7b46k0GZAhlfBCtrgRe1l0+g+HD4HgKUdFSlp+ibyuNECaNpA
         +a9DyleUanMWp4EHWnaGL5iSF44amqqR9HlFkqKnwwwIfeZE/BmAmi9BHAV5DxVNBop0
         aYkemDCyLueDvlzyt3viyFB9AYdgMPbQLgVUjf1NN9XxOBdOHrIlNxvxagsMUrvpTCTU
         sMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEMPWpcRdJwqoxxn2uGsySlTQlz8YrJG3TBPUm/5CRY=;
        b=OhSWkyT1FE2pXIsD3ECpoeVaCC/vypce02GZ8Xswd/rLpHwTIfdv6/Cn2/Y7KntsAF
         M1cr9qM2tYgXD/1Pfmk6ERqI+2SA6+efg6sKvwzDXXa39bJis6HHBuRY96v6atzW2wb+
         7dgYZgY1N+hNbimGpu388NdlaSYE29MbCokJ0IwfbYR+eGsC73e8D6uNp+yf1wgIrz3t
         jP5fvR+c72Mem24311VO7p+DceHhXtEB1F0mKkBgsR4Dc64/x2o3g5Qy1gpP9+NJWZiR
         QlOJeeY8O19Tf/t8yzl0P0Bzqldok4NvmmmoFt7jP7T+21H78vNjOv0kpeWiUwLszjj4
         o9nQ==
X-Gm-Message-State: AGRZ1gLVEEu5A5WqxwnexfejGPUt39JY2V9+d8LFJEdNwoH2fakwu42M
        QRqhvyiMShDtRfGMVhB/oD6peGRNO3iK/KZwEP6v
X-Google-Smtp-Source: AJdET5cqSi7OdCEnv850ydXQ8G3S8F0cZpiANQdNu97Vv39oE+hfRVupGSR9h0/6bMoEvWVoTSMYQHzgA7Wy5Dnvjns=
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr16340499lfe.4.1543275474596;
 Mon, 26 Nov 2018 15:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20181126145434.31705-1-tiny.windzz@gmail.com>
In-Reply-To: <20181126145434.31705-1-tiny.windzz@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Nov 2018 18:37:43 -0500
Message-ID: <CAHC9VhRX8vs42AYaQRAwqs1VonJWai75fcsHogn17FxDT431_g@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: remove some duplicated includes
To:     tiny.windzz@gmail.com
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 9:54 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> audit.h and fs.h are included twice.It's unnecessary.
> hence just remove them.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  kernel/audit_fsnotify.c | 2 --
>  1 file changed, 2 deletions(-)

I currently prefer to keep things as-is, see my response to your previous patch.

> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index fba78047fb37..5b54386a9edf 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -16,10 +16,8 @@
>   */
>
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
