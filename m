Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFA9C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B66920843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B66920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeJ2BI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:08:59 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33665 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbeJ2BI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:08:59 -0400
Received: by mail-vs1-f65.google.com with SMTP id 125so3768073vsi.0;
        Sun, 28 Oct 2018 09:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgS8MBf8Xm8UzRTuzM573QByAISRdHNx+gnkMrsiO+c=;
        b=f1GBUICFD3rlslfcFhKoVnqvgUavStJsotX4ceVEP2Vp0sMQnp+kauKRINlNunIlL0
         gRR4Eoy7u+ZWimR2x0Z8HnNe3494E15RPmH/qoWu+EhVNnmHgutECq9rg+JJTBs4komk
         M0Bwwz1cX48jw8xPJ0xKmYvhEUVWIfCNNiTwOUgt/P8WuTd5g8dy2Arxc7vsdf3tXSG+
         JClRVAZP2NP2KnWV+wdzQBOc26626rn9G52+eHvURB13+whhXeqYcMS56gvdfKxP8Z6f
         cTPGxgP5tyqoA+MUB9bi3l3vX6fo58oJjco18lPUyAW/j5qNiF4Gg7Xw6Oq2E2FEma67
         s4LQ==
X-Gm-Message-State: AGRZ1gJa/NaeSki2Jn5dVTO5bt5CN3ikVnumBlrhWVITiPsws161Squy
        9eM1VrlWGHdpnqUJzuOYJV0ohTh5MlKy+RDBtmo=
X-Google-Smtp-Source: AJdET5elxA3FjmYGOexUgOd1Yr8fZ1sK+XHvBykntYLmugDNYGjoogZebW7bcwL2b+AAJdhmmCiDpxQVupBiMNi2yQU=
X-Received: by 2002:a67:c202:: with SMTP id i2mr2866798vsj.11.1540743834553;
 Sun, 28 Oct 2018 09:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-dccf1bad4be7eaa096c1f3697bd37883f9a08ecb@kernel.org>
In-Reply-To: <git-mailbomb-linux-master-dccf1bad4be7eaa096c1f3697bd37883f9a08ecb@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 28 Oct 2018 17:23:42 +0100
Message-ID: <CAMuHMdXYCuNLw9ak4=WuDRQMWJYt9m5cr7arK7-nqFnfyAK3Tw@mail.gmail.com>
Subject: Re: usb: dwc2: Disable all EP's on disconnect
To:     Minas.Harutyunyan@synopsys.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

On Fri, Oct 26, 2018 at 6:59 PM Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
> Commit:     dccf1bad4be7eaa096c1f3697bd37883f9a08ecb
> Parent:     4c19cc14064d99ef0a20fb5ba0d45c94dbedb13c
> Refname:    refs/heads/master
> Web:        https://git.kernel.org/torvalds/c/dccf1bad4be7eaa096c1f3697bd37883f9a08ecb
> Author:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
> AuthorDate: Wed Sep 19 18:13:52 2018 +0400
> Committer:  Felipe Balbi <felipe.balbi@linux.intel.com>
> CommitDate: Tue Oct 2 10:33:15 2018 +0300
>
>     usb: dwc2: Disable all EP's on disconnect
>
>     Disabling all EP's allow to reset EP's to initial state.
>     On disconnect disable all EP's instead of just killing
>     all requests. Because of some platform didn't catch
>     disconnect event, same stuff added to
>     dwc2_hsotg_core_init_disconnected() function when USB
>     reset detected on the bus.
>
>     Changed from version 1:
>     Changed lock acquire flow in dwc2_hsotg_ep_disable()
>     function.

Dan had some comments on v1, and requested to document why the locking
games you're playing are safe, cfr.
https://lists.01.org/pipermail/kbuild/2018-September/002945.html

Unfortunately you didn't CC him for v2...

> --- a/drivers/usb/dwc2/gadget.c
> +++ b/drivers/usb/dwc2/gadget.c

> @@ -3993,6 +4004,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
>         unsigned long flags;
>         u32 epctrl_reg;
>         u32 ctrl;
> +       int locked;
>
>         dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);
>
> @@ -4008,7 +4020,9 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
>
>         epctrl_reg = dir_in ? DIEPCTL(index) : DOEPCTL(index);
>
> -       spin_lock_irqsave(&hsotg->lock, flags);
> +       locked = spin_is_locked(&hsotg->lock);
> +       if (!locked)
> +               spin_lock_irqsave(&hsotg->lock, flags);

This looks really fishy to me.
What if another CPU takes the lock in between?

Can you please explain, and fix if necessary?

Thanks!

>
>         ctrl = dwc2_readl(hsotg, epctrl_reg);
>
> @@ -4032,7 +4046,9 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
>         hs_ep->fifo_index = 0;
>         hs_ep->fifo_size = 0;
>
> -       spin_unlock_irqrestore(&hsotg->lock, flags);
> +       if (!locked)
> +               spin_unlock_irqrestore(&hsotg->lock, flags);
> +
>         return 0;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
