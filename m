Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DB9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A60208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmdEQBVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A60208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbeKPEIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:08:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42098 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKPEIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:08:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so5583652pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53ULN/eUPXJWILCpXkBWhrT7ZwImYSEtLPNzjJN0TII=;
        b=AmdEQBVjNuJFw+0ioZ3L9QRNJ2+RS0FiClJTht0FofgD5UK5Q5SIrK4kjWvUscbD+g
         sSClySqVNbX4A3jIF4d2A6qo0BjLS5oQccO+sZ/ZHzLVvxX4THBcSD/dZKECUWSKgdJg
         JxpCZimjupLMLl2X6ghjl7Pd6BKVYi4fjiyJsNo6BxYQ3nBHWCAyeHcBfTYOfxbdKAgX
         Dn/vjmQzRtqnFASg/1HPDtrxU/6C0FNzQdLhlC5yc814U49ylyiqAsUs5efbj7SwU6Tu
         dgcbmWh4J5/1djkP0VFpiXloqVTTBrAyn2Puic5KoNma9uiXDcohALgrPRVfeJ6FUpyn
         t6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53ULN/eUPXJWILCpXkBWhrT7ZwImYSEtLPNzjJN0TII=;
        b=kOJnRIhA2Mo8aHw1/LaFDaSSC0nx9D0oFi0UoUoP6bBwkhKZHZKcz7bREWx56tIXSJ
         ucq+Qcjsjguy715OqSYIpWF1Gu2nd9qN6uXLtMwNUG0ESCPujog40X9WJxuoO6ldTN34
         rRNDw3aGcL3HvfJV8VpswRjRypbGJ31Uw9nizB7phInXoicd3V6Y7ZAA0RnHZcP5fegn
         UoZ18/GVpiYoIVJv+XZfqT0cErGFoXKSjAYOR+enD5qKhpcDyQfa/x4aCCetAUg9mfRH
         3HryErwsysCchRgJAZ/k2V7a5mXTMCy+XK5ZD+ra6BC3yPt841Y/b4gDhvB3jSYOe5r1
         EhCA==
X-Gm-Message-State: AGRZ1gLtzLkfxAnnyRy/U/HiVtLJk3Oo4OARdH7AdpGlcz0rpuDOnpTS
        Mn9EtTxh37yjAgzBR8G7RDMThLEEqzKtGkf/deA=
X-Google-Smtp-Source: AJdET5dIE5Q756/4N7rZNkhbsYEd+dz02gGnwlFO7tpoACMwa1eDOxKK3/Kfr8tyEhwSSzBdrpU1uB9G62Co8K2V7Wg=
X-Received: by 2002:a63:7154:: with SMTP id b20mr6685371pgn.342.1542304804137;
 Thu, 15 Nov 2018 10:00:04 -0800 (PST)
MIME-Version: 1.0
References: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com>
In-Reply-To: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Thu, 15 Nov 2018 23:29:52 +0530
Message-ID: <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        joe@perches.com, darren@stevens-zone.net, christophe.leroy@c-s.fr,
        geoff@infradead.org
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 8:58 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Any comment on this patch?

> ---
>  arch/powerpc/platforms/pasemi/dma_lib.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
> index 53384eb..d18d164 100644
> --- a/arch/powerpc/platforms/pasemi/dma_lib.c
> +++ b/arch/powerpc/platforms/pasemi/dma_lib.c
> @@ -255,15 +255,13 @@ int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size)
>
>         chan->ring_size = ring_size;
>
> -       chan->ring_virt = dma_alloc_coherent(&dma_pdev->dev,
> +       chan->ring_virt = dma_zalloc_coherent(&dma_pdev->dev,
>                                              ring_size * sizeof(u64),
>                                              &chan->ring_dma, GFP_KERNEL);
>
>         if (!chan->ring_virt)
>                 return -ENOMEM;
>
> -       memset(chan->ring_virt, 0, ring_size * sizeof(u64));
> -
>         return 0;
>  }
>  EXPORT_SYMBOL(pasemi_dma_alloc_ring);
> --
> 2.7.4
>
