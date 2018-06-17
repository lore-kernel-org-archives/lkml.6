Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7491AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB5E20891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndpb4qSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB5E20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934297AbeFQQvA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 12:51:00 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40127 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933779AbeFQQu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 12:50:58 -0400
Received: by mail-ua0-f194.google.com with SMTP id l11-v6so9309402uak.7;
        Sun, 17 Jun 2018 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MM1QsBemKQT0PJf3HdcO3vJ9zbTbQNquuGBRTSXsego=;
        b=Ndpb4qSohpyvf6OkBYhoMzUWYmnSaKW9wblq9AHE+dumNqnxqU7Wz1TXvQn6KH2A2X
         69Ii/jBXlhRyyiSDp/ILOWbD63rf/QS9HbiYqRqvqSXHT2xweLzw+UqnMR+hOdnnx4E5
         tRS2MB/QxA8dLy8FjLIhfjdtqqha9uBRusuu+cs4iKlynLzTlFJzF7zSj+NmfSxd2Rh4
         IA6ZoLtluO9GW7CaerwhstrMDlV2EenrgdlqrwzqoUi3Zdsmrp3yozxtsEwr/pJKeDXe
         Koe2xX00tU7bHCIYqwwbcJyhsPfxTRU/Vfiy3eBKqPexQgW5vNKS1Q/K7CSWOlVUCL4r
         Sdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MM1QsBemKQT0PJf3HdcO3vJ9zbTbQNquuGBRTSXsego=;
        b=n0+PMrRijkfpbK1RSMMmScie+eCpGNbvKS1E9Ay3rbZ8vvpDcXbkQIyNEqTA9OrvFU
         qyKkx4tLT9fSJ8bm+BNgiyhccAjBr9Znclb5UPMQjz1xouL2jiTMUi4eR7DmTjgSin5a
         Sx/9Po0Z2vzOH9+wJ7NnS3iD2oKwLLGmixJ1fQWtUIoCWjRDsOgFXnYCc96njhJffpUU
         UJnlOcbiNluRAp5di3k3Pn/qnBKQHAYlPz0jD7PfB8Be3XS3UbbJP5b2rhiix7H7Uxia
         B3WBETnwmXf5QPlvjQGMQXX0q4tIBiG4tDYscLeC7gT8xOVVaHnBe4SI2A0+qO5NAqnm
         qc/g==
X-Gm-Message-State: APt69E2PzsWck91V8hf9Nx+rMbCuBHZr0Rm5G7gJjGLIDeBQvU+m/lZm
        OSJ+UD1ogkGLKD2O2B0pF50+9tDQi4XeDk5vxmgMJA==
X-Google-Smtp-Source: ADUXVKLnu52/jmhtSoEE7yIdflrVGjsrVy1Z/IQ75p+Er4Ysg1ONEdurLcSTpxORa9WzzPTGZd3OtiCW3itibh+mIo8=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr5875836uai.47.1529254257450;
 Sun, 17 Jun 2018 09:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180615111141.37184-1-tony@atomide.com> <20180615111141.37184-2-tony@atomide.com>
In-Reply-To: <20180615111141.37184-2-tony@atomide.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 17 Jun 2018 19:50:46 +0300
Message-ID: <CAHp75Vdi-9pEPYy3+hh9rw1-sMvmh7vahz_idug0XcMaCQh6=Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] pinctrl: core: Return selector to the pinctrl driver
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>, sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 2:14 PM Tony Lindgren <tony@atomide.com> wrote:
>
> We must return the selector from pinctrl_generic_add_group() so
> pin controller device drivers can remove the right group if needed
> for deferred probe for example.
>
> Note that fixes are also needed for the pin controller drivers to
> use the selector value.
>
> Fixes: c7059c5ac70a ("pinctrl: core: Add generic pinctrl functions
> for managing groups")
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/pinctrl/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c
> @@ -631,6 +631,7 @@ int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
>                               int *pins, int num_pins, void *data)
>  {
>         struct group_desc *group;
> +       int selector = pctldev->num_groups;
>
>         group = devm_kzalloc(pctldev->dev, sizeof(*group), GFP_KERNEL);
>         if (!group)
> @@ -641,12 +642,12 @@ int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
>         group->num_pins = num_pins;
>         group->data = data;
>
> -       radix_tree_insert(&pctldev->pin_group_tree, pctldev->num_groups,
> +       radix_tree_insert(&pctldev->pin_group_tree, selector,
>                           group);

A nit: Can it be now one line?

>
>         pctldev->num_groups++;
>
> -       return 0;
> +       return selector;
>  }
>  EXPORT_SYMBOL_GPL(pinctrl_generic_add_group);
>
> --
> 2.17.1



-- 
With Best Regards,
Andy Shevchenko
