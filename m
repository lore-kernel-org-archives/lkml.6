Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9149AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A8A2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnlo4xmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A8A2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeJQAkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:40:09 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:46946 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeJQAkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:40:08 -0400
Received: by mail-oi1-f176.google.com with SMTP id k64-v6so18611929oia.13;
        Tue, 16 Oct 2018 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgrwPfP/LQGwJ7wWIllixp2zjCrgb6yOvKBVxWLpFRY=;
        b=bnlo4xmbiJv3jKUfyLKQHOUCryZZ8LfevgTsCuWaGiy0OYYmwM7vfWJq8uvLqUkgGe
         dpCQ1UGcwYeXXxUG4vlmINvRJIJCJ2Fb74FSR9iJmX1oUquPLEonkAt3QjKUG0RPB074
         alv03yORFCWsG3uXIg/LGfADnmL+/ieox917m/T21c9YspYLe/SiK5ErKI9+Bauuroc/
         yUYlh6RQ48PFEHGn6fdvOl0ZsNRChYyqjDBgs2tJpmQVJzRzfrL7Sx0qBzUwexqqBt7z
         PKZyB93N2q2+eJ5nAygseekEPK0nG/CA+x65k4z1SQ0py/zM1Y6kzmikjDYYFu7/5dTV
         pTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgrwPfP/LQGwJ7wWIllixp2zjCrgb6yOvKBVxWLpFRY=;
        b=pKx+OD+/zCBZelH9HqE0L3asLBm3WACmyrceH+quHSvP0kkFMg0PJcmwMHXBj+TLpt
         wcfvGiWk7w170N5lRFZwKVg/CN38q+qU6GGQCVONSH7YvipJTrMJJ4NXtiUn+F16rfqH
         ENLNIIjghuw+31aknH0fByFpfK1h+7bbHYUgZJQzEV1GLJk9gU04C+6f2lyM7TLCJXp4
         KhnflDDkboAcO3tVrgosypEHfJsHbNRMb9K0oH/Eiy3+9uAHg7t3Hg8UQutJ5DydhaUu
         IopuqiWFz+nuqqiQtB+YsdLclbTIFdpISjJWyAHP7tStB0EpOjUS8X/vT0w9yS/hqNgl
         9iTw==
X-Gm-Message-State: ABuFfogyCDEBsLwqk1YYRmiFpT/uzq1b+aBAofl4x6PtQqFJvOX+fioo
        Xw9DQ+ZWMMCVSRf2UgcBoi0ZqpMhBFD2GEuVO00=
X-Google-Smtp-Source: ACcGV6204QaFRG6t83TKB07ECeZnQZtS+/FfEQEftqcHN/QOuIoZ+HGZkilT2jIgDwES71exXMGJycwW6Ok5hE5IvP4=
X-Received: by 2002:aca:c7c9:: with SMTP id x192-v6mr11487414oif.43.1539708531557;
 Tue, 16 Oct 2018 09:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181016164218.3736-1-l.stach@pengutronix.de> <20181016164218.3736-2-l.stach@pengutronix.de>
In-Reply-To: <20181016164218.3736-2-l.stach@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 16 Oct 2018 13:48:59 -0300
Message-ID: <CAOMZO5CS6e00V4aCeCwEBO6z8FXq2ZiCJK-FgWDDK5qu6cYOqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip: add driver for imx-irqsteer controller
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On Tue, Oct 16, 2018 at 1:43 PM Lucas Stach <l.stach@pengutronix.de> wrote:

> --- /dev/null
> +++ b/drivers/irqchip/irq-imx-irqsteer.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

According to Documentation/process/license-rules.rst this should be:
// SPDX-License-Identifier: GPL-2.0+

> +       ret = clk_prepare_enable(data->ipg_clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
> +               return ret;
> +       }
> +
> +       /* enable channel 1 by default */
> +       writel_relaxed(1, data->regs + CHANCTRL);
> +
> +       data->domain = irq_domain_add_linear(np, data->channum * 32,
> +                                            &imx_irqsteer_domain_ops, data);
> +       if (!data->domain) {
> +               dev_err(&data->pdev->dev, "failed to create IRQ domain\n");

You should call clk_disable_unprepare(irqsteer_data->ipg_clk); prior
to returning.

> +               return -ENOMEM;
