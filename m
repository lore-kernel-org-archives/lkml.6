Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6A5C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9ED4214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547025632;
	bh=lHoM7/4O/LM2gt5uh9mzGu4CMzautCVPG4hQWl/wgRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x2CJ9ncomnE8MTudWHm2S4CW+0YAKlCGVy9N1dcG6yAf7lVYzLU24j/Ys29IlXFKd
	 pGsOPReifSY3njaAocv03LD0vPnUPC/mBpa9ApzsFBMLXdkh3LgHyttmjezxQTRZMp
	 ESPjYqmeGRdQnaxJOVV+5Js5dVVv6NuvWsVdI4AE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfAIJUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:20:31 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32855 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbfAIJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:20:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so5783120oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:20:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13DAwGIcZbDE6y55GldF98FlJBg/ruKsjhIbPFxhRyQ=;
        b=cFrrPBDgFTGzHAYKLswugyHA7w4n6ZyFSEM5NYfg+ZjzT3aCdOF/ukLsA2pHpv43rc
         uav6LCNJE6satkddtY7hM0OoEGnom8IEA5zLB8Aew7CxhqEkLfjlVGZIYcegERbBgDxL
         nfR2GEypWvtS3f9ggyQWpwV1uurITH1TBTua/l5Wu4Y9fM/n0iHfWnh+G8xAH96m6y9h
         VJPt21rzhzCP96h6Y6uk2M/8nlzRBl7N1iNPWS6D/Y/LwpOIr+R6j2TA8TdUkvu5Bp6B
         n2H4PoDpztRLsC8xZle4Rjh5oUhMi3MPLF3JwrWbqENKkZgE6wqOsThoEMVBmVolgs9F
         sReA==
X-Gm-Message-State: AJcUukfXXAfOyhZYXfuEoK8shVgmQ/BAGgpLqKSYwc/0ucTSYely2Xfb
        TXz7XRXwVDTxJYtpNUWMuwXSzy1rKjzNIdPp4mM=
X-Google-Smtp-Source: ALg8bN4ZX9ks8p1FR6CKmJN/z0/I6dsg2XcLjcAr/Wf58blyc6LQa4MFU+tSxHang3UR2tH1wK8PGO7Y7jjYgy361xE=
X-Received: by 2002:aca:368a:: with SMTP id d132mr3583767oia.193.1547025628990;
 Wed, 09 Jan 2019 01:20:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547024167.git.tsu.yubo@gmail.com> <99e9edd31414bd240286b5b63b39140fc74e6ca5.1547024167.git.tsu.yubo@gmail.com>
In-Reply-To: <99e9edd31414bd240286b5b63b39140fc74e6ca5.1547024167.git.tsu.yubo@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jan 2019 10:20:17 +0100
Message-ID: <CAJZ5v0iaMuj=MPEaY2-RPMtDeez=ke1Y1wMA9qwhWw=sONqvOg@mail.gmail.com>
Subject: Re: [PATCH V5 1/2] kobject: to repalce printk with pr_* style
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, yuzibode@126.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 10:17 AM Bo YU <tsu.yubo@gmail.com> wrote:
>
> Repalce printk with pr_warn in kobject_synth_uevent and replace
> printk with pr_err in uevent_net_init to make both consistent with
> other code in kobject_uevent.c
>
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>
> ---
> Changes in V2:
> Improve the commit log, doing as the patch did.
> ---
>  lib/kobject_uevent.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 27c6118afd1c..c87a96c4800e 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>  out:
>         if (r) {
>                 devpath = kobject_get_path(kobj, GFP_KERNEL);
> -               printk(KERN_WARNING "synth uevent: %s: %s",
> +               pr_warn("synth uevent: %s: %s",
>                        devpath ?: "unknown device",
>                        msg ?: "failed to send uevent");
>                 kfree(devpath);
> @@ -765,8 +765,7 @@ static int uevent_net_init(struct net *net)
>
>         ue_sk->sk = netlink_kernel_create(net, NETLINK_KOBJECT_UEVENT, &cfg);
>         if (!ue_sk->sk) {
> -               printk(KERN_ERR
> -                      "kobject_uevent: unable to create netlink socket!\n");
> +               pr_err("kobject_uevent: unable to create netlink socket!\n");
>                 kfree(ue_sk);
>                 return -ENODEV;
>         }
> --
> 2.11.0
>
