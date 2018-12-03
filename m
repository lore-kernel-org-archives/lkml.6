Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C0AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A1520848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="benXf2jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A1520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLCTLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:11:07 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40298 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeLCTLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:11:07 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so8049662qki.7;
        Mon, 03 Dec 2018 11:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJayU86gN5c7gVFAdfJTKIdp6WisZ945WpWlRBdBUXI=;
        b=benXf2jfPkK4cW6HMhQubkWj/IEckmwNSFv16biN+10qPVFiByOmM7cKu5OnRSHa8y
         N4+6OrRDQfPXJ1H+VQ4yoBUbMCYIh6Taxi0FbMcLjLDpkDji41x9clu1PF6Bn/Q/gB2+
         24s8oAI/fw1x2zoeESRRF9Z5k7nbThONC7tQ1jAONPkXYVsPWaRqGWwUKOwNWGLh30F0
         hWXABzqGWwvnx4A0ERnRll/UQeJenaivHdUP+8dk289Ypvhjfp2ezYJ6Vvm6JqDdA/8B
         pdPo4JC2OWiQRPsJjzxvDiqHxzF3UVMADsfOuIPUqR1Gid73c2yqqkcANcNPCf7Ym02G
         jPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJayU86gN5c7gVFAdfJTKIdp6WisZ945WpWlRBdBUXI=;
        b=WbC8E0Dar1nj1eDcreA4Ei+pG5vCovjFVpHKQAi3CUiQViCWLQ+4o2ZSkTf9kHyc7x
         DE5EQVier5tQPCBTBF3/XEDlyCorn6YqYUSCgDdYq2rF70rEQKtUzxT4/Ld7LxPHtCnL
         VQTEWemDZcjMwuoKsxgYsYoYZuRaC5QZqAsAHS5T5Cm5QkN2OrmCR2cU8nfqcWb/JCvc
         nVv1vNhunsMIylJMylh6r3IOKiGQxNxMOPrDzveieoogHJzZcXsB48/FF5oSEgwNqakr
         cVe8nsqpl4VvZ3LuAX7HYsDNNggj9d9AyiYTLFCYRLmkPkqT2QQ6UcVd1Z8vJQeR3pHx
         CPmQ==
X-Gm-Message-State: AA+aEWYOnpdrXsiu3CLpDNhMxl67t1BDp0HU99rcv25B9BZCKjPRR3HR
        ZdD+8aOv0wN72z41egwUFnx5c6fW42WIFGjDRnA=
X-Google-Smtp-Source: AFSGD/WChBLhrWo1Ig/NrqRdCUxuGagCJ++/lwxfopFFHNG+X+g4jWjJfE5/rXnVo7pj2m1N+5V6Z400oruTbvthZyw=
X-Received: by 2002:a37:c3c3:: with SMTP id r64mr15874899qkl.70.1543864264816;
 Mon, 03 Dec 2018 11:11:04 -0800 (PST)
MIME-Version: 1.0
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de> <1543760930051-726829870-3-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930051-726829870-3-diffsplit-thomas@m3y3r.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 21:10:53 +0200
Message-ID: <CAHp75VcTMORW52cuY+CYmu-g+VMiMYD-59qoh3i__0r7u5dOHw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_ips: NULL check before some freeing
 functions is not needed.
To:     thomas@m3y3r.de
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 10:55 PM Thomas Meyer <thomas@m3y3r.de> wrote:
>
> NULL check before some freeing functions is not needed.

Pushed to my review and testing queue, thanks!

>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>
> diff -u -p a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -1300,8 +1300,7 @@ static const struct file_operations ips_
>
>  static void ips_debugfs_cleanup(struct ips_driver *ips)
>  {
> -       if (ips->debug_root)
> -               debugfs_remove_recursive(ips->debug_root);
> +       debugfs_remove_recursive(ips->debug_root);
>         return;
>  }
>


-- 
With Best Regards,
Andy Shevchenko
