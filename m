Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3816BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0641221479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0641221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeLFJCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:02:21 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38126 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeLFJCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:02:21 -0500
Received: by mail-vk1-f195.google.com with SMTP id w72so5335570vkd.5;
        Thu, 06 Dec 2018 01:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+KEZUE1Nta3XMphlatUHgB3m0dTmUFZU2ZyMO3dwXw=;
        b=CKT+H2WtwROF1E/559KZhpo3goPs9AtZsdPlkuZynEKUavBDZSYfAgCIzapLOSLQEW
         RLpJ1LUQNh5a2Wht4Pf1qfgOI2czwEY34q2kRiqie+mL7fTsdc6LiJq2rXD8PfwZ6bbk
         SxypJ9/M88q0vjrQhCPKJ+FM/KQy+bvbjUHfYt51pv6uCDWaOO0LMogJZgkdwiGjI0Nb
         /fZdWVUPbDHYVeORwVOHw5IQPxDkt3dPfK+DrBQZq5Ss66ylG55zhJ7maJI0waGLKvqI
         r58JvKAKaFDwOSlsmfpPxQock0omsKA3jwit19tYWnf8nDi/fHj+W+HyIZchFriMtbvF
         zWiw==
X-Gm-Message-State: AA+aEWYvWGX8B7ZVAAVxD1ol0p6/dLCQrCbb8tbSNvdOxOI+SV+r/Ehj
        mnU13WMLxIHR0uOamLCNkFoa1foT9HNFdzXFNqEj/A==
X-Google-Smtp-Source: AFSGD/Vv3MZ4l8n5RfkkMt2L3CLrnGW06nhRlVCRSBmQfuuO3IfovtUYrqrne8oQIQPyuhivsqvIkAs5QLbxhk6ASZg=
X-Received: by 2002:a1f:2ed7:: with SMTP id u206mr11963253vku.72.1544086939726;
 Thu, 06 Dec 2018 01:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20181205153945.13767-1-geert+renesas@glider.be>
In-Reply-To: <20181205153945.13767-1-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Dec 2018 10:02:07 +0100
Message-ID: <CAMuHMdU89s997JhFpWOaDTFohcy4+Ym5deUUuv1EO7EybdJrkg@mail.gmail.com>
Subject: Re: [PATCH 0/4] soc: renesas: rcar-sysc: Miscellaneous fixes and cleanups
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 4:39 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This series (against renesas-devel-20181204-v4.20-rc5) contains
> miscellaneous fixes and cleanups for the R-Car SYSC driver.
>
> This has been tested on R-Car Gen2 (H2 and M2-W) and R-Car Gen3 (H3
> ES1.0, H3 ES2.0, M3-W, M3-N, D3, E3, and V3M) (without 3DG).
>
> This not been tested on R-Car H1 and R-Car V3H.

Now tested on R-Car H1 (Marzen), with no ill effects on secondary CPU
boot and CPU hotplug.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
