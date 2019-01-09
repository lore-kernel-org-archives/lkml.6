Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3647C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA6C214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547025710;
	bh=jSoDBAj4He6gbPyknlAFOnGD771n1ccXmODXEB+rA34=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G6DExRbl2p0eWB/XBy2mgCdhgGuIIUzylgNW/7ygT69/MYoZr2074hUr18UYZ4UBN
	 whvUXfSTjGSgYUTBd4LWHs/ousnOf8NEXDsuakejV4TbdvHRP1/X+3p8oLkxgKlCbG
	 BIm/tMktBaP1pQCbA7LtwZy9dTeuMS7BlDflVHOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfAIJVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:21:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44119 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfAIJVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:21:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id m6so5719439oig.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijJHPkL7MDwSOoHK+fa5FDtblxjmSaM4LwORxxXzQ+M=;
        b=AskHXOjlzPbjBJ0NaCNGFZhbscQS07wR0WO/NyXzVcZO0qZH2LWLh1jBOM9Xz99Hvd
         rOUfs2Q89Dpaq84piy9exUB6dSSO7N5GB3F52CMZlXxuaWWk25vFe9X/R85pJ3O7GJbB
         +1xeKNpdwVjy6VS3chKwYPhqWZv1O7mdhc//Jyu7D4XRvl8sap9E1x0qGOZTxoHmW693
         Jxxc8zE8EFZGgiTRpBPFPTf0gjyl7zaAUh6oh6E9q+xgoPvwz9I6dlDKGDy4l6ajPdFa
         UJaFAcoabd4dlU/ELICA1pE61V0AsPR4cHGjZwBAJzsY0ags0FMpQ2BbbDy2VddYQJaN
         IzJA==
X-Gm-Message-State: AJcUukeTqNP0bToDSS89ztE/VpOmpL5E/zwgP1T5TARdNQY0jIDblKlL
        l5dbkjSIGXRuqchf3EsvRUDQajwcecIeCxOZqxg=
X-Google-Smtp-Source: ALg8bN6xEfv0x5KtD22nbiXxhVnM6mtCjtV+Asb87aYyNunU65l5kJzdd5w31fllHPwWWAuDOtEMK0bUy8oeI1pWUSk=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr3530628oia.95.1547025708157;
 Wed, 09 Jan 2019 01:21:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547024167.git.tsu.yubo@gmail.com> <db8c353e82b944654fec17beb99d96bebff91864.1547024167.git.tsu.yubo@gmail.com>
In-Reply-To: <db8c353e82b944654fec17beb99d96bebff91864.1547024167.git.tsu.yubo@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jan 2019 10:21:37 +0100
Message-ID: <CAJZ5v0guQizE2mi3qv=0CVz9FYf6Kzv222Ff0RX1NyGuKAiucA@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] kobject: drop newline from msg string
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
> There is currently a missing terminating newline in non-switch case
> match when msg == NULL
>
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>

I have given you an R-by for this one already, so why haven't you added it here?

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes in V4:
> Recovery originly declaration, requested by Greg.
>
> Change in V3:
> Improve the commit log, requested by Rafael.
>
> Changes in V2:
> Drop newline from msg according to Joe's suggestion.
> ---
>  lib/kobject_uevent.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index c87a96c4800e..f05802687ba4 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -200,7 +200,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>
>         r = kobject_action_type(buf, count, &action, &action_args);
>         if (r) {
> -               msg = "unknown uevent action string\n";
> +               msg = "unknown uevent action string";
>                 goto out;
>         }
>
> @@ -212,7 +212,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>         r = kobject_action_args(action_args,
>                                 count - (action_args - buf), &env);
>         if (r == -EINVAL) {
> -               msg = "incorrect uevent action arguments\n";
> +               msg = "incorrect uevent action arguments";
>                 goto out;
>         }
>
> @@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>  out:
>         if (r) {
>                 devpath = kobject_get_path(kobj, GFP_KERNEL);
> -               pr_warn("synth uevent: %s: %s",
> +               pr_warn("synth uevent: %s: %s\n",
>                        devpath ?: "unknown device",
>                        msg ?: "failed to send uevent");
>                 kfree(devpath);
> --
> 2.11.0
>
