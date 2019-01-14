Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2D7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178FF20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfPftRx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfANIKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:10:37 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42294 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfANIKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:10:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so14876953lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBOVB/7xrwKXjL0CT2rcKjIPM91ADoQu0lBiffNId4c=;
        b=sfPftRx+WscjuyNsTrUBbhWJz6XbF52jA5TtKVWrjOpBz9s4FaztEf2vwc+AaFXquE
         mJ7nZBJWSPxe1yMLdqsCl5VkmivNMPRzKIvjy1PRrParmp5NXM7znNgU8mZ2kHptChxS
         ahrZ8tOPgjGgVoaciD4lICVJao93rJZkZN8EcxPVKzOtXD+4fXNC72hpslD/b1qKyXJ2
         KJY1q/RV7lv8TtLD9Kat7k71e60SsyVztfi7/0XwUkyUENFFpq5KCJY6aMzltNeclZQf
         qpw5KL97suU0IMTcIJXdOW8+dGZcC4wsoWxr4rrMxdBUkH39XC8u+NlH4LygiHv6As91
         qLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBOVB/7xrwKXjL0CT2rcKjIPM91ADoQu0lBiffNId4c=;
        b=RRr1AyqxmpI2cfDMlyXUK7Gzr/xXQx4AVw/iSzZv0ZJsOQHJBUrNAuGVvi9etsjhY8
         95/pOvXXc92grl0qG7fPdEuvuaaXcu1/WMqEeYjjWXRuPOPFMX24/6aHy/5r+H4jv7/8
         tVWUJk3m5GUBixUnEVcW1lDstSFXITe944lCc0vPIIDp5c+wBnH+f3vlwUFSjTF6ng32
         PakmR6J5oMJGDWpytHuym8RrH3sUi0e8DguI2QRqGXN2fGczRyEAlhBSAw7qHcE3sXP3
         4WIdzzekkl12kmaGeDQFoSLa4W/+KhACprYldIrqPkJLgyvIJHIMuUIY3903p9bbb5DF
         PSFA==
X-Gm-Message-State: AJcUukf0WIUw4yykYVbUSnNsdNjGMfm38UI7/KTzFvC9bq75ppkaqPSf
        Sq85bMayHYym32ZjRhn4+aBg3u8ixo/fIx7UZ3o=
X-Google-Smtp-Source: ALg8bN4FFJTpmkrqjOpQnPQy5v8Hg0xvGjXJGWLE5GbLiYQL+baxyXFnprrpmst7I2c4dnD6TD6GA7CdhaZ75G3wsZs=
X-Received: by 2002:a19:c396:: with SMTP id t144mr12263073lff.110.1547453434697;
 Mon, 14 Jan 2019 00:10:34 -0800 (PST)
MIME-Version: 1.0
References: <5c38b64a.1c69fb81.a0651.e342@mx.google.com>
In-Reply-To: <5c38b64a.1c69fb81.a0651.e342@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 14 Jan 2019 13:40:22 +0530
Message-ID: <CAFqt6zbaAmQCaKXDGR6hJEyh2PXJzQEsyO_TuHMg0jOX38_wog@mail.gmail.com>
Subject: Re: [PATCH] fs/coda/psdev.c: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 8:59 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/poll.h which is included more than once
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  fs/coda/psdev.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
> index c5234c2..f2bb798 100644
> --- a/fs/coda/psdev.c
> +++ b/fs/coda/psdev.c
> @@ -39,7 +39,6 @@
>  #include <linux/device.h>
>  #include <linux/pid_namespace.h>
>  #include <asm/io.h>
> -#include <linux/poll.h>
>  #include <linux/uaccess.h>
>
>  #include <linux/coda.h>
> --
> 2.7.4
>
