Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C91C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9796420856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBI5fjhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfAQRlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:41:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37885 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbfAQRlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:41:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id t18-v6so9312465ljd.4;
        Thu, 17 Jan 2019 09:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTZ59nDAiEcqlfQkFfxIM4LQXzJKV5+9U+oD6goaKvo=;
        b=pBI5fjhkEjaw4kzVfqiDyAq6RXZCOGj8mgMwNNZ4dTefXK25sc34x18pD2YVbXiSCU
         YE3q7s+GZimWXa25IDhHcAb+558nlsIIJuuXchnGZX7A/roGMHTH5gs2M0UFsg2MxjVC
         LCZKGSvcUio3/39FJ3NvYDx65/mEZ3ZlnFMuXpRcWBRdzcp+JFUEMxMOCA/EOCCQU48i
         7EzVRnwh4bJhoGZgJi2O5XU+bSwdWlhO1cFlPM7f2INRonon9bje1NSkWvRAPW4MgPqh
         CZM0yWtgbpl5PnD1Rm7wUEayCbCOmhJxLu/SHClMuMCkdMUS678oLtxrqlRNTVLiEMl6
         bqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTZ59nDAiEcqlfQkFfxIM4LQXzJKV5+9U+oD6goaKvo=;
        b=UBxwMOlrZc/uDljo3Noy5uOlArWIcSBI5bW993YH5MPABLAb3nv0vNFPdumrgnLAKI
         A54I70GRAMhJmW+ByPW7LXZ0JvABSep1LcQ5rFYurFuHMS3khBG/LieMSo1d88Av6N6j
         jLheydsxE7+/pkBFciK8M7k2+76bnRVT4mZ3/Hqym9LkXw37tv9Jvc6HxeGck4D/ANeD
         IPVjbNAtI89+QPAtc8TaSN8Rl71L72NDa2eZXKxCKvdd6vzfXUVYj1gr3WH51yV9n0HR
         vXyT+p8SeDIg6uPJNPigMaYBJ1rH/5R48KuvrVilXgLyog0KMljjbLnpRyhY/fd4yqkt
         BnGQ==
X-Gm-Message-State: AJcUukdSH55+Sh70dmmL3vDk9Hy6alxa+H2TV45ZsW78/RAhOVoMhTcX
        3c5KHGHOnj/n0/0xXNA2U8ywOOXJl9mJxBxjwfe1Hg==
X-Google-Smtp-Source: ALg8bN7j0ACwWRcSXHTUZkYtPT8Y2gkNy3KKjP0LpHtR56hfBs6snRXiRc590laGQjpCW01fm8PQcZZegKv8sRLYsXY=
X-Received: by 2002:a2e:9c52:: with SMTP id t18-v6mr9122074ljj.149.1547746907775;
 Thu, 17 Jan 2019 09:41:47 -0800 (PST)
MIME-Version: 1.0
References: <5c40acf3.1c69fb81.5b02f.880c@mx.google.com>
In-Reply-To: <5c40acf3.1c69fb81.5b02f.880c@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 17 Jan 2019 23:15:44 +0530
Message-ID: <CAFqt6zaHuWfVWS1Aa4MQm-qE9Wjj68Bq5ioEWbk+hrg32VNRCw@mail.gmail.com>
Subject: Re: [PATCH] sh: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 9:57 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/irq.h which is included more than once.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/sh/boards/mach-dreamcast/irq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
> index 2789647..69fa91c 100644
> --- a/arch/sh/boards/mach-dreamcast/irq.c
> +++ b/arch/sh/boards/mach-dreamcast/irq.c
> @@ -10,7 +10,6 @@
>   */
>  #include <linux/irq.h>
>  #include <linux/io.h>
> -#include <linux/irq.h>
>  #include <linux/export.h>
>  #include <linux/err.h>
>  #include <mach/sysasic.h>
> --
> 2.7.4
>
