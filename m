Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D823DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A44A20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9KOX/kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfARKFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:05:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38489 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfARKFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:05:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so11150807lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJ205dDi2ixFxpwP81y40GqDgkPxHnuU8GfUzsPelD8=;
        b=A9KOX/kpqZbpPIy0I6Di6wJ5o+OX4oKK7d0Vv9Sc2FtnKpKWKdia/iphS6MQ+N15Ht
         PisSwgt/8rbBNw7EXqtoWWFEfRHjGVjHiQE3F1ff1g1IB8jUp7C2GXFOhX0xnEYfk4lG
         OSWOHdZREl+zBkxAyUR+8Wcy7du0FvXsmAfx3a0ExjaKu3TI4T0cXoleykd2jZXQnyTC
         EUfjn1MG6rebWXnqfqozD80vjQLNqR5XMYR+SHqRtbRHRrZvilcmZKv6aCBYN6BYi/0h
         jUwKQMX2aPPimsgX5pan9ga9+88ffj+KeTz9jja9dC7X/vYF6BQc1mgdOxtjFE3olvNC
         M9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJ205dDi2ixFxpwP81y40GqDgkPxHnuU8GfUzsPelD8=;
        b=Juo4gqiuFr9Z1+sNkTDxn6YCNohJRzx3ELBu3gLlYRnjaI0ZOcQxBsXpHPb8M8sHld
         yGhSHcY5E1vmpZ+4SGNusOmfhez64PffThwEXci6kZIkGeIUl/cmQcct3yPZIPH2BA8U
         8lXVB/TKl2lSZz//1eIW2BiIt3NoJtKlesDNoc1ocEG3HocBghcjCoFQ/aXZvh2Vn2BB
         WhWktSNNumvfYxidKzPYa+Kokwvtcz9fzKJOvB8DK/Izg060D+RdZdx2eoUrMnnzOr55
         UtTqevUhratWisBQ+MTmmecLCGJrmcELfgNjC+hLYAqlJI9J0JsFpUf4p9aIMLKQDnW3
         K1lg==
X-Gm-Message-State: AJcUukcpwTPu2eWGZujSfi4Tsugu6+A9jWllSO5pROeSd0QzaGcWbUMK
        bzqkfq2P3YOqiGN1tF/8UcToG1mFDjRfu5fbzBE=
X-Google-Smtp-Source: ALg8bN44e0Tjf3vXDjWe2aMD8Rf88ITASC4bEdArFLMOYmy9qUKgA33sXrtBVKA0hIRH8WNf9S58QEquyYgPgD8HaMI=
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr11289731ljw.75.1547805898424;
 Fri, 18 Jan 2019 02:04:58 -0800 (PST)
MIME-Version: 1.0
References: <5c40a8fd.1c69fb81.e4b1b.8f85@mx.google.com>
In-Reply-To: <5c40a8fd.1c69fb81.e4b1b.8f85@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 18 Jan 2019 15:34:45 +0530
Message-ID: <CAFqt6zbyZnk3vAnRHV0JsXpVF=HxoC-WA9x434R+k36b0vtKzA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        npiggin@gmail.com, msuchanek@suse.de, haren@linux.vnet.ibm.com,
        oohall@gmail.com, bsingharora@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 9:40 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/printk.h which is included more than once.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/powerpc/platforms/powernv/opal.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index beed86f..802de0d 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -26,7 +26,6 @@
>  #include <linux/memblock.h>
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
> -#include <linux/printk.h>
>  #include <linux/kmsg_dump.h>
>  #include <linux/console.h>
>  #include <linux/sched/debug.h>
> --
> 2.7.4
>
