Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ECDC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CB420865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCbqd/n/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CB420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeKXTJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 14:09:54 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37162 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeKXTJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 14:09:54 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so20762919iti.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 00:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUWVgLE8gangxvYSG8LI7g5QW7DESiSCL/ee27PVkG0=;
        b=OCbqd/n/FLj1+Ih6SxLKcznWmS9coW6vb4RIwhskKNuiUvQUGEkmuY/4uW/H+gIYgM
         SuWouEXkKBlrnVVM1LYmyq9xnaxoboO8Gax6USGOb5ZsnYDmHz6o7Em3kFM7RUblJlbf
         KSHaIYehBbv0PT4jJ3GLNqUrT4l/GZRYnkDUXuNFjIIwcjATDIQK27MQdRJ7ITJxlgSQ
         Ggc89RfNKf8vSkCvmmNp8yzAc01E6uHG+car54MMAITZQ01UcEEbQqoEWsnKDzgqCJ39
         XpqHwJEjBA1rskhtLjkUB2A/adzmOent5Q/EwT1djIDLWYK+5uxpiEcxSxWfe1rmwUoT
         FZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUWVgLE8gangxvYSG8LI7g5QW7DESiSCL/ee27PVkG0=;
        b=hoAaP3SZUz9TuaOgxSj2wI1EjRTNCj7QwwHYTv7vlPdXir4LYKEV7qr94JW4wrMMlC
         UljC1OnHGqhThzW2kuxq/Nn6My/cDG9rdldBbqdd9f8KeEHJzBazAmGi2IoTNqvVsCdu
         13onen0p1g0sHepGNphUpmdCQsRQIVaosakNYzcyArTYVkG9FCWqycjXRo8QX1MUeBWB
         8ytxvLPQ0s6xpJ3QvELzYZNeted38PMUEy3uVSweTZzHosBW4CDnKBw0uL2he0BkDYHs
         dugBHJYATxxmCwKpMOmnN1WrX0qegHQmWUdnuTxUV9ai1ZeOyNNLKBo6JkQ5ScDAMABp
         nUSw==
X-Gm-Message-State: AGRZ1gIH9aHu0Q1vwT2/GWoNBXSVRYxnLlNrz1ubjeqbcAwc1d2Mg8u+
        OCaL0+MGjfBee97MxQXb99dHFZUxUy3B6V2TL7Y=
X-Google-Smtp-Source: AJdET5flC8QjMzzywFvxi7lSCB3LfF9XW17q9REKswtXa7H4CKD50771LDbIQoW74QddbtKtSkGsnvkc/JOpvNE68EY=
X-Received: by 2002:a24:5a8f:: with SMTP id v137mr15786332ita.65.1543047730639;
 Sat, 24 Nov 2018 00:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20181116104703.GA10221@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181116104703.GA10221@hp-pavilion-15-notebook-pc-brajeswar>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Sat, 24 Nov 2018 13:51:55 +0530
Message-ID: <CAFqtX7mbVfcB_fYL3Fj=+314Ze3ckR3iGZ=hhvsHROKA6bf7+w@mail.gmail.com>
Subject: Re: [PATCH] drivers/fsi/fsi-scom.c: Remove duplicate header
To:     benh@kernel.crashing.org, eajames@linux.vnet.ibm.com,
        alistair@popple.id.au, cbostic@linux.vnet.ibm.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 4:17 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/cdev.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Any comment on this patch?

> ---
>  drivers/fsi/fsi-scom.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index df94021dd9d1..81dc01ac2351 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -20,7 +20,6 @@
>  #include <linux/fs.h>
>  #include <linux/uaccess.h>
>  #include <linux/slab.h>
> -#include <linux/cdev.h>
>  #include <linux/list.h>
>
>  #include <uapi/linux/fsi.h>
> --
> 2.17.1
>
