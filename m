Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 23C52C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72D3208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72D3208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933918AbeFLH7j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:59:39 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41289 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933892AbeFLH7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:59:35 -0400
Received: by mail-vk0-f68.google.com with SMTP id 128-v6so13841273vkf.8;
        Tue, 12 Jun 2018 00:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tl5tM7FpHYVBlgY0y8SiAMWZzlAOZngCZbxy0sTdzig=;
        b=hcDo/BRlicvUWXJZKSVn4GM1zfJi9ZtHUsP1T8EKhTwbzb64mZjxsGsEzvHDOHtATZ
         m4zD2XOKfEf7nLpmT/oA2rq7M1GtPcBmFFNMSIKOBWEfuCmgeFRFUcdo8c2D6ssZ1LK8
         PmzK/IBpI07w9Wh8yPRLIu+hqyJJU/huIJ3MSBm8FuTOHDbWZr2GkQO4hRUedT7mMctz
         qOmOwHQ+9gM9JXeoJ6kTEX2x8yELn6efw3/omN3655YWnZOKgNuLiF81Dd7K7mnPweT7
         4x2ZujXvGoCZYmMI3PghKO+t48sfCW5lTmtwCE5Iplz8+uSGjaKuYwF8riR2SThyeiUL
         Ordw==
X-Gm-Message-State: APt69E3xGXQRLFRqoo2yT6k0Txq43vvrQRdlmolw8lJmvqRpvpzr4cuM
        gk1k1qllgv0u879kF4lTzjcSbHoXxe/VsZf4eLs=
X-Google-Smtp-Source: ADUXVKImz9JI6kZsW0/c+FXuccHb+LNBrI2AA889Tr/vX6vDXDGEDZzHJX15UMAL85BYOnZ7sA7bX1J5LtiPipycbqQ=
X-Received: by 2002:a1f:9e8c:: with SMTP id h134-v6mr1386576vke.125.1528790374101;
 Tue, 12 Jun 2018 00:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <87o9ggqwwh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87o9ggqwwh.wl%kuninori.morimoto.gx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jun 2018 09:59:23 +0200
Message-ID: <CAMuHMdVjVgb+1HrUdOuKpDW8NiXBwPJPAucZhDbN64xb5FtN=A@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: rcar-dmac: don't use DMAC error interrupt
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran@ksquared.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

CC devicetree

Thanks for your patch!

On Tue, Jun 12, 2018 at 9:40 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current rcar-dmac is using DMAC error interrupt which will handle all
> channel's error. But in this design, error handling itself will be
> issue if user want to use virtualization, multi OS, etc.
> This patch removes current DMAC error interrupt handling, and handle it
> on each channel interrupt handler.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Who wrote this patch, you or Magnus? Or is this a joint effort?

> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> @@ -35,9 +35,8 @@ Required Properties:
>
>  - interrupts: interrupt specifiers for the DMAC, one for each entry in
>    interrupt-names.
> -- interrupt-names: one entry for the error interrupt, named "error", plus one
> -  entry per channel, named "ch%u", where %u is the channel number ranging from
> -  zero to the number of channels minus one.
> +- interrupt-names: one entry per channel, named "ch%u", where %u is the
> +  channel number ranging from zero to the number of channels minus one.

DT bindings describe hardware, not software policy.
So IMHO the error interrupt must not be removed from the bindings (and
from the DTS and example).

> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1522,25 +1518,37 @@ static irqreturn_t rcar_dmac_isr_channel(int irq, void *dev)

[...]

>
> +       if (reinit) {
> +               dev_err(chan->chan.device->dev, "Channel Address Error happen\n");

s/happen/happened/, or just drop the word (reducing kernel size ;-)

The rest looks good to me (but I haven't tested it), so with the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
