Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD75C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1CD20865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 08:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSAr+jnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1CD20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeKXTKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 14:10:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35707 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbeKXTKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 14:10:44 -0500
Received: by mail-io1-f67.google.com with SMTP id u19so10293350ioc.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 00:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5t+fx0Do+4kagFo/hIyFTnyUcejJytFsGwLaxVleVC4=;
        b=TSAr+jnjcNAFyzy2eucZU6+wMX8917Bp641x5LAFjqwKOqtR5uw/SlvKTCYDg4qBPS
         RhalUoBJuZnYRkbtoa9mNCzyJ+6WtaNmrqCxQXfqwH06orCrAe5Q8fsBW9OrYyE+/Cxe
         Tmms6iFNuXdIe9mpyQoY3c40R7vlvMhOAPpOZ/Dki4jhL4tHJt4CU+opDMKLO7m2V3Q1
         jWMVy1WXTNRXaFOWbiuetlGfXxVqmJY9CCKXr/hAm1nDR7heU1QirCdpCM9vb8BnWrg9
         nVIlTdIWmlwX/7tWWwWjZZj2mM4nK1ItmMSTbZr7dvihkhkUAbPFvCBFV95I/R1KZfX7
         t/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5t+fx0Do+4kagFo/hIyFTnyUcejJytFsGwLaxVleVC4=;
        b=keAnvWoy/UPwRT6rLEeIlIgBdxcsNs+eOEGoTnBfUMsliZxNxvp01zY1Y4iRXt+6FS
         tFPAA0NAqkcmCs3dAVYKrHOPvIM3vpomY2/+v7vSBAamDjvFoJYWxbJd1uTSAHY3Qxmd
         Gx0GOJf/pebZfEzeE5SkRORxTUtOiOfZcMRQDwkAbX3tsftWYfzbr/xXtVgYca0ltdyP
         mdBdPZHZSQqgVEvxv42aqb6iUKbBjWskbtEyIIyb/E4S1xs0tBlkIYLio0zLbDLh7k85
         cLObAAY+qvuFdGK/9z777y4zSAvncG4GUVySIcoAfH7vtBg/bZHuiKMvc6oWQ8xXiMTz
         x37w==
X-Gm-Message-State: AA+aEWYMiUo04Tzg2iXZxSddEt/z5VYVYCNGqeY7QMwLP3+Axn4/OLXG
        ePZgBVyVQONZt0KK5cdV38oO4QWqMwr89t3hv2E=
X-Google-Smtp-Source: AFSGD/Vp9UpBRgBqs9R6h2KZkJX8YOXacAT40d9C4c3EmOT25x9IzId90Ax/ffzRM1zVzfDFUgAcV4+q5pK9gPgZPlk=
X-Received: by 2002:a6b:c402:: with SMTP id y2mr15179949ioa.77.1543047780326;
 Sat, 24 Nov 2018 00:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20181116101353.GA2752@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181116101353.GA2752@hp-pavilion-15-notebook-pc-brajeswar>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Sat, 24 Nov 2018 13:52:45 +0530
Message-ID: <CAFqtX7k8HhqwubN7MORbWd+cUo_+btN8X2ZJfefWXr1uHrKRdQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus/qcom-ebi2.c: Remove duplicate header
To:     akpm@linux-foundation.org
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 3:43 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/io.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Any comment on this patch?

> ---
>  drivers/bus/qcom-ebi2.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/bus/qcom-ebi2.c b/drivers/bus/qcom-ebi2.c
> index a6444244c411..56b01e4344d3 100644
> --- a/drivers/bus/qcom-ebi2.c
> +++ b/drivers/bus/qcom-ebi2.c
> @@ -21,7 +21,6 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/init.h>
> -#include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/bitops.h>
> --
> 2.17.1
>
