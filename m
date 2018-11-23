Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA92EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE6B20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkptRutt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE6B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440136AbeKXB2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:28:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38515 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbeKXB2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:28:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so3178351pgc.5;
        Fri, 23 Nov 2018 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrG3IHL1GWTOlWtyEQam/Zgt7Aw27TgBC3WAsY4Di8E=;
        b=AkptRuttt9YcXWJPm4RVwW4OVDTKtHtJqY/V4RC/IWIMCmOFI8WxX2MTQPnflTqWfG
         XJhVOikbMB4F38jVSDKmDM+THxcOzDfHQquYLW5Uj8Q/dbXavGMcQkEQbW689/xr2R2C
         LDZj6rgIHzz2rTNthYb/gnaMs6yhreQq3smTaoVjsRRWzeICZQvyhkDUX+JNYg+Zo67W
         s866ELuxHxuoK5dE7uDRIWgja1FaAJh6UGaKYAw/adTM/dHH9vgVumoUY7EPp/DUeeV7
         yuaXIvBWsZqtti4HrixPyBtk0WkXgEDvjNPMYx643TCTSjfloC+ihVC8cBnZGpeg+HkK
         bFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrG3IHL1GWTOlWtyEQam/Zgt7Aw27TgBC3WAsY4Di8E=;
        b=nUxMbf52UUxbM6goc0QMrYTcybkIJRm/24V3WHlJ2RPCdn9RFKnHfF7FdFHpqP/gsT
         QsB0mYb+ehH0R1QXrRatiiGaljLa63WK/EdRjsqBtS/somPcuzyebZXmGbpG92d6Hpv6
         SS93GX5XfMlpDQNDGpmUqCjcCzl/HjOW0jdpjxG+0uLAxwWrCfabQUiQt5lAmdQYziKd
         Y2XNOxxCo0ox3oQ9ZVqdHSi9h9gasYVzbJOs97A1NZIaWgEVEpjViOIutrTNvyNbJsOt
         2EB2A4zsWyack8ckpsHk+CuqzEcqk2F7IGQwHJluc5ODq+dfPss8jnRnLbkm2pxBMXqi
         gFeA==
X-Gm-Message-State: AA+aEWYF1MRBlocaZwNBGutrM6k2Byh9flXQpitldDYZJLn5JpX6vG9d
        n1m7ukXI/KKhu94Gh5JANvhrVY2Y2GO/ZgKFoIc=
X-Google-Smtp-Source: AFSGD/WcStZPU7biu3PQxawFVejyyVwaIR3mIJ/nDoAusF5aQD2ZaxwiuvuKQD+PLBQLvEtGCW9guCCA4EjoKGtMGF8=
X-Received: by 2002:a63:e516:: with SMTP id r22mr14589727pgh.256.1542984231775;
 Fri, 23 Nov 2018 06:43:51 -0800 (PST)
MIME-Version: 1.0
References: <5bec5342.1c69fb81.b02fa.ace9@mx.google.com>
In-Reply-To: <5bec5342.1c69fb81.b02fa.ace9@mx.google.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Fri, 23 Nov 2018 20:13:40 +0530
Message-ID: <CAJr6mf1d=tviauDfd4Hq_750mGiypheUxHhQEv_tsdR_TrTkNA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
To:     satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 10:24 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced vmalloc + memset with vzalloc
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Any comment on this patch?

> ---
> v2: Removed additional braces
>
>  drivers/scsi/fnic/fnic_trace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
> index 8271785..bf0fd2a 100644
> --- a/drivers/scsi/fnic/fnic_trace.c
> +++ b/drivers/scsi/fnic/fnic_trace.c
> @@ -468,14 +468,13 @@ int fnic_trace_buf_init(void)
>         fnic_max_trace_entries = (trace_max_pages * PAGE_SIZE)/
>                                           FNIC_ENTRY_SIZE_BYTES;
>
> -       fnic_trace_buf_p = (unsigned long)vmalloc((trace_max_pages * PAGE_SIZE));
> +       fnic_trace_buf_p = (unsigned long)vzalloc(trace_max_pages * PAGE_SIZE);
>         if (!fnic_trace_buf_p) {
>                 printk(KERN_ERR PFX "Failed to allocate memory "
>                                   "for fnic_trace_buf_p\n");
>                 err = -ENOMEM;
>                 goto err_fnic_trace_buf_init;
>         }
> -       memset((void *)fnic_trace_buf_p, 0, (trace_max_pages * PAGE_SIZE));
>
>         fnic_trace_entries.page_offset =
>                 vmalloc(array_size(fnic_max_trace_entries,
> --
> 2.7.4
>
