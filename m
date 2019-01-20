Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BCFC6369F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832592087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 13:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQs1yjEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfATNE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 08:04:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37770 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbfATNE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 08:04:28 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so13614975lfj.4;
        Sun, 20 Jan 2019 05:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rw8t1BZ5ouoNoJISrQlHLxtYmn9AYuqm7x0WnAVcO0U=;
        b=bQs1yjEv3evOioeCPWEHmkMJ32xQeloSBCy4740ydb67MK1T0FX7nhNmXfeXQ2vtyt
         FJcapcAQVLss9tgxGJUNybjzgpPitjl6tspycTusnOOJeru5h8qBnVsuGpRgKitKUJqz
         oOmt8Vz7GV0ncmsLfuP2OMqOIHQ5lKw6zQLkb2xi3XE2wOiX0zqdgLavg+y/O0iSPRGY
         zGka4VbDm0z2Zc7TRorbc/og7z9aeZD+zrSMRARWK84xlssVQ1Kj0sXqvRaIS1D0N6Wf
         WJNsjKZUl+6LPa0hqjKTzxw/wbgOGe10Y4RDtotOIuV5aQtqV0RsQZhxRQmnBmpZEFSC
         KE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rw8t1BZ5ouoNoJISrQlHLxtYmn9AYuqm7x0WnAVcO0U=;
        b=RQA4PEFcMeScBLEIiqynr+E+mirjeV9PA+g5Z5R7v+BW/bJF3aHnUAbIXG5XHzToFy
         qxIc7Ow3vrR8M25f4W0CppJE7+XYJEIiv3FWL86wSTBPk8HxfD2ucquTr9NTH2dQUQbR
         j7nxYsI/xToVFp4+9KqPuH5rX3EAkGpOT9tsPQ9PlHNKxUMg/IF7jP0DMprQY2xHFGB7
         J/p3xJwAdimu1T9IJqOE+Ood0JR3euHsBKcHmkjzflr4Ma3tghaGDpJNbFjS/arrXQHs
         3x6i80bsh31L9uyzowgcBEotvGvXCYondwLsbNCRNm93G92IvBisXUllM3o2GDAUw+zk
         qV3Q==
X-Gm-Message-State: AJcUukdO960Sj/5e6doW6PFDtP0ntEZXE7dBFkIFb/0yXT/AHkWKjPNx
        gprTOA2PcC37jTGZf6H1dF0g/Xezozw+acKpU3U=
X-Google-Smtp-Source: ALg8bN6WHmjrSm51/C+RdXGBxN96l24iaZGpgRF93FeCXXFffr0m6QVgdFl01vjsh2sY0A87E4eN3SWc4aiANo+rfUg=
X-Received: by 2002:a19:d90c:: with SMTP id q12mr15581326lfg.24.1547989466271;
 Sun, 20 Jan 2019 05:04:26 -0800 (PST)
MIME-Version: 1.0
References: <5bd55e34.1c69fb81.b2503.b6f5@mx.google.com>
In-Reply-To: <5bd55e34.1c69fb81.b2503.b6f5@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 20 Jan 2019 18:38:24 +0530
Message-ID: <CAFqt6zYkgrUgtFQbc-W=Jap84wshPSH5aTRTBfsRkOQhaSROdQ@mail.gmail.com>
Subject: Re: [PATCH] arch/sh/mm/consistent.c: Use dma_zalloc_coherent
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org,
        thomas.petazzoni@free-electrons.com, robin.murphy@arm.com,
        jacopo+renesas@jmondi.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 12:29 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherant
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/sh/mm/consistent.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
> index 792f361..fc8d235 100644
> --- a/arch/sh/mm/consistent.c
> +++ b/arch/sh/mm/consistent.c
> @@ -52,13 +52,12 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
>         if (!memsize)
>                 return 0;
>
> -       buf = dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
> +       buf = dma_zalloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
>         if (!buf) {
>                 pr_warning("%s: unable to allocate memory\n", name);
>                 return -ENOMEM;
>         }
>
> -       memset(buf, 0, memsize);
>
>         r->flags = IORESOURCE_MEM;
>         r->start = dma_handle;
> --
> 2.7.4
>
