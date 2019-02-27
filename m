Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7299C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8E02084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfB0KrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:47:21 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44042 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfB0KrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:47:21 -0500
Received: by mail-vk1-f195.google.com with SMTP id w85so1844635vkw.11;
        Wed, 27 Feb 2019 02:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAyqaqET+lrXNBuVom0a7Mdg0P0ORGnE7iTubSw+dYY=;
        b=MzYCWniu5y0Dnfn11IS9IXjfXXMdKy9IOhQUrDn68c2uuRhOaxKTq1To2WadijUxXj
         47BjSMQsvkxAZX0cniztW7BvXowlOI3ePNGL20EIrZzd6RXeapICXMTCOW6lVdM5vmnG
         ZKaeB5ZIHcxa7g3a3/zQn7XSSOK6J9j0poMa9qeY0OZXlKr0YDJIUGCwfBAXHLFBw3Aj
         b+HojPJMFZmi8k9zE34VtRcm9y3TR9Wd54JpWB2XXAm9j3l1s0PD5FPW+hTorNjtnS4c
         A0rloSypu1djZM3Nv1IblKfSlUD/U0w7QOq1gmuvQFzgXDG8id3KdqejaJh+OnqI50Vp
         Eyxg==
X-Gm-Message-State: AHQUAuZjnUjQM2uQiXGsD7kcpbFiNhFZ1eHjR0uw8ZgH+ATHMX+eHXUR
        9scTYpIqZt/+T1SSHG6q5gyFFN2gqbCkwp8jMP4=
X-Google-Smtp-Source: AHgI3IYj9t081ezCS0VBK8LI2aPZWB64A4fpFbYjkVpjkYwIeRCLvcBcQDDxYhLUAIgLxYTkl6s1rzQLnSRgbrQQO80=
X-Received: by 2002:a1f:95d5:: with SMTP id x204mr275126vkd.72.1551264440394;
 Wed, 27 Feb 2019 02:47:20 -0800 (PST)
MIME-Version: 1.0
References: <1551250826-10302-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1551250826-10302-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Feb 2019 11:47:08 +0100
Message-ID: <CAMuHMdXMyS1aW+iWu-4Ffcy_xZ5pE_J_eihSSBN0A84DkMDuGg@mail.gmail.com>
Subject: Re: [PATCH] phy: renesas: rcar-gen2: Fix memory leak at error paths
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shimoda-san,

On Wed, Feb 27, 2019 at 8:00 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch fixes memory leak at error paths of the probe function.
> In for_each_child_of_node, if the loop returns, the driver should
> call of_put_node() before returns.
>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Fixes: 1233f59f745 ("phy: Renesas R-Car Gen2 PHY driver")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
