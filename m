Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F368C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F67206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O0BeH79q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfAOBNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:13:44 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35057 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfAOBNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:13:44 -0500
Received: by mail-vk1-f193.google.com with SMTP id b18so252094vke.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xalgf0gPnoByW49DMFh9qJbLDgTPKrWP+HijoiEdQb0=;
        b=O0BeH79qINijcJmjv2t6L4u5vAIqxhqIKoy233zwEcks/8jDYZyn9rvmw+ik2ExZxn
         /QqhbHnsY00fAytQt6UesFULETek7+QT/W/zcqdFvAcMRi6qxlOH9sv5Bkh6U1CRx+Cc
         g4MZKSO8uc9ZEq9Ah3+zbwT8Jtxw9jhktabt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xalgf0gPnoByW49DMFh9qJbLDgTPKrWP+HijoiEdQb0=;
        b=E0I3yskG4b926TjfvZUc54vA59wZjNVvXn4TF9RS0f8Ku5llgzr+0mm5kjO/HqpnvO
         FHB0pvPToRkwJR82aIDlK5px7bYLtagjoGWxAvu4e0ALPc0i3Y9vzS/2E4jIRzLaXd66
         7Uy6UTFSV6ioyrSPJhyXbM/dt+qJtceUdbwU4gWcw3M6fyAJV9mpvl7twS+Ucem5+ro6
         odXlk5jOA5NSl/iQhcuz5F61J5xVDLT5/nXLlmyfX1UpMagu5fdxWQG+q8xMGvEKfTj8
         1oH6TQ8QBmL4F6Ly4nI68TwPib/e+K/jLlkbG6WCgyNwHc0Vx7jJV/Ljg5IprzkcP0Tt
         SCfw==
X-Gm-Message-State: AJcUukd9lY7Mc4ATH0MoEQ+xiAcHed1LYtVSdR2CLlXLwvUoRaV963yP
        JO3HZQaFx0C9FTN344Z2z+neacIkGbg=
X-Google-Smtp-Source: ALg8bN5Pvm/b/Xni+1QpzNl7or7/Xp6ifLeF6VuQ3SQv24YQ7QvXdNJkLceDFSOVS+yPvxv0gZXarA==
X-Received: by 2002:a1f:d647:: with SMTP id n68mr509409vkg.33.1547514817555;
        Mon, 14 Jan 2019 17:13:37 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id o1sm1185545uaj.4.2019.01.14.17.13.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 17:13:35 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id z3so662476vsf.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:13:35 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr610977vsc.48.1547514814595;
 Mon, 14 Jan 2019 17:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20190112152844.26550-1-w@1wt.eu> <20190112152844.26550-4-w@1wt.eu>
In-Reply-To: <20190112152844.26550-4-w@1wt.eu>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 14 Jan 2019 17:13:21 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+BZtej03_xK1Nrk2AjRCbSUJMbOPNQ=QLs8TnMEWGXkg@mail.gmail.com>
Message-ID: <CAGXu5j+BZtej03_xK1Nrk2AjRCbSUJMbOPNQ=QLs8TnMEWGXkg@mail.gmail.com>
Subject: Re: [PATCH 4/8] ASoC: change snprintf to scnprintf for possible overflow
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 7:28 AM Willy Tarreau <w@1wt.eu> wrote:
>
> From: Silvio Cesare <silvio.cesare@gmail.com>
>
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.
>
> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> In this case, if snprintf would have written more characters than what the
> buffer size (SIZE) is, then size will end up larger than SIZE. In later
> uses of snprintf, SIZE - size will result in a negative number, leading
> to problems. Note that size might already be too large by using
> size = snprintf before the code reaches a case of size += snprintf.
>
> 2) If size is ultimately used as a length parameter for a copy back to user
> space, then it will potentially allow for a buffer overflow and information
> disclosure when size is greater than SIZE. When the size is used to index
> the buffer directly, we can have memory corruption. This also means when
> size = snprintf... is used, it may also cause problems since size may become
> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> configuration.
>
> The solution to these issues is to use scnprintf which returns the number of
> characters actually written to the buffer, so the size variable will never
> exceed SIZE.
>
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: Timur Tabi <timur@kernel.org>
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> ---
>  sound/soc/fsl/imx-audmux.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
> index 392d5eef356d..99e07b01a2ce 100644
> --- a/sound/soc/fsl/imx-audmux.c
> +++ b/sound/soc/fsl/imx-audmux.c
> @@ -86,49 +86,49 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
>         if (!buf)
>                 return -ENOMEM;
>
> -       ret = snprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
> +       ret = scnprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
>                        pdcr, ptcr);
>
>         if (ptcr & IMX_AUDMUX_V2_PTCR_TFSDIR)
> -               ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +               ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>                                 "TxFS output from %s, ",
>                                 audmux_port_string((ptcr >> 27) & 0x7));
>         else
> -               ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +               ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>                                 "TxFS input, ");
>
>         if (ptcr & IMX_AUDMUX_V2_PTCR_TCLKDIR)
> -               ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +               ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>                                 "TxClk output from %s",
>                                 audmux_port_string((ptcr >> 22) & 0x7));
>         else
> -               ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +               ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>                                 "TxClk input");
>
> -       ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
> +       ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
>
>         if (ptcr & IMX_AUDMUX_V2_PTCR_SYN) {
> -               ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +               ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>                                 "Port is symmetric");
>         } else {
>                 if (ptcr & IMX_AUDMUX_V2_PTCR_RFSDIR)
> -                       ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +                       ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>                                         "RxFS output from %s, ",
>                                         audmux_port_string((ptcr >> 17) & 0x7));
>                 else
> -                       ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +                       ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>                                         "RxFS input, ");
>
>                 if (ptcr & IMX_AUDMUX_V2_PTCR_RCLKDIR)
> -                       ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +                       ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>                                         "RxClk output from %s",
>                                         audmux_port_string((ptcr >> 12) & 0x7));
>                 else
> -                       ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +                       ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>                                         "RxClk input");
>         }
>
> -       ret += snprintf(buf + ret, PAGE_SIZE - ret,
> +       ret += scnprintf(buf + ret, PAGE_SIZE - ret,
>                         "\nData received from %s\n",
>                         audmux_port_string((pdcr >> 13) & 0x7));
>
> --
> 2.19.2
>


-- 
Kees Cook
