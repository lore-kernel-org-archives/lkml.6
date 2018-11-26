Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38F8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6CF2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="QVEe2eHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6CF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeK0Ke0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:34:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46529 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeK0Ke0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:34:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id f23so14939871lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGKVNJXaxyGwpkt5lwxumgR4J0vhaQGpXNk2oMyBT0s=;
        b=QVEe2eHboKnM5Tn3wdNaNXlNYgCn25r8coPDe48Aj1eM0kW0JLNxsr77F/X3YMbuj9
         FfKmUCwNudhApfl4yKKI9sYuRfT+kjuQUEq7aI6IlHTCWuRejPVYvE+OrlNJeyjLQslJ
         n6wQEV99WmDjpMoTZBHuySOb1cNFHO6F7zvPsoQhbrkfITuig8qY1cRa9ZwDtsKAJ8JF
         tSKKhuJsuLw93ECVK8AEX55LqO32dOZaS4wdRpRQVmt5/Vq9Cr6XnSdZ46XjNZWMYuwu
         Oyu6WC9t8+6uoiEqYA8zHlVnu3jdrwius7ztOq/2oyTy7NzpvR4GcPNtDsm5wzn/ckFd
         M8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGKVNJXaxyGwpkt5lwxumgR4J0vhaQGpXNk2oMyBT0s=;
        b=Q1XL2EZJme4ZOcCJpUUR8FTB6N1bjZ1bAWYgS4RC4YANxuScdfZtCc6aYjmHJKC0v+
         HiyEFmc3l1h3I1BPyrHSMYUSHRzx6MlsP2DfLjQsin0r/0LFYhPWfyqwFkFiEpxZsvKF
         3Jp/bEYKFvP8XC+7b4PXFWBjf02/IyTDktpyWNSBEKjdKH9Xn5+Q/jq5gnD1ikjcVn0S
         GNMF0QbrdlPLooUbRs4DJLA0rW8OD4vs5UQSAxzt5vbcNiugCXnOYBPCmgJnzzAZyZH4
         RltVkxGf7YRFSrigI7+QvIyuDxNO9wjDJ/qIfXxLLGsYLn5CtEK9dmkbWUQWQ3gtFvTh
         YgSw==
X-Gm-Message-State: AGRZ1gLNzeBlM2oSLPC3m9n0iQeKIgCmhcwRYvSFszGQWY8YCsE5L6MX
        NofubAnxzRwbTnEmyF+UUr8uNcUuiiyzE81aNWpp
X-Google-Smtp-Source: AJdET5eiB6VnWHTQJ0HaakbTqVetbRuHEwIVEBktr9LtSUOwBqGdnDKmPj1+ecaKoXKDl+tVwrbVrb2pZ5HQBrpccCo=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr16631932lfk.151.1543275515679;
 Mon, 26 Nov 2018 15:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20181126150139.31989-1-tiny.windzz@gmail.com>
In-Reply-To: <20181126150139.31989-1-tiny.windzz@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Nov 2018 18:38:24 -0500
Message-ID: <CAHC9VhQt9q=wN2Rk1rvO=Xr9C4X-HztU4C=dMV_6ss_-BBzm8Q@mail.gmail.com>
Subject: Re: [PATCH] audit/filter: remove some duplicated includes
To:     tiny.windzz@gmail.com
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:01 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
> audit.h and fs.h are included twice.It's unnecessary.
> hence just remove them.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  kernel/auditfilter.c | 2 --
>  1 file changed, 2 deletions(-)

See my previous comments.

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index bf309f2592c4..6d43928a41c2 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -22,10 +22,8 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>  #include <linux/kernel.h>
> -#include <linux/audit.h>
>  #include <linux/kthread.h>
>  #include <linux/mutex.h>
> -#include <linux/fs.h>
>  #include <linux/namei.h>
>  #include <linux/netlink.h>
>  #include <linux/sched.h>
> --
> 2.17.0
>


-- 
paul moore
www.paul-moore.com
