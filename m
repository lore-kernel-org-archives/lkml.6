Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3E7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F2720661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F2720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeH3V0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:26:39 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36779 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbeH3V0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:26:39 -0400
Received: by mail-oi0-f65.google.com with SMTP id r69-v6so16829350oie.3;
        Thu, 30 Aug 2018 10:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcvIvmzMABKhLe7MMReJJuxvEFaScSIiUX+xPnpgA5w=;
        b=ok+boPWn81b5t3R1320db0XYqW8ErQWl1MtC72468uvHZ/3zme1jQe4lLW5e3g3Sqg
         J/2qfbW7HPNz71i2QMPr2878f+D5WgFJ1ZKMFTM5wd2oZWyU+iCU3DA9PJCFWEdrqz+/
         +EkjhbSyKE6VrnFaCZcocBI1wSkf7XMNFQXAPrYz2DXlwSO3vMqd+MBDLb1/Q51n9A7Z
         nrInKZzCQdnsXrVqgIx8YaYFm/csn3MFDdJgMpWP2rQ2C6186Zdnw9VWhQh5vXQAeNHk
         FQB/ZQ2pmMVxjnZzpc8XkNjkLOFEBevHsOyE/u5vt4OaiY1pWpBLnrwYz1e4kSxUA6iL
         Mbsw==
X-Gm-Message-State: APzg51A1ewnTShx5Rjz3gtZD7RsutWBIkCARqsXnCBsEHmVElWWtbElL
        E/AH6odpgBa+vWfPvNpCNiLU332eDQI=
X-Google-Smtp-Source: ANB0VdZNHEQ7Ax+6CS26WqpZiUGz9Yim1xcVS0yBQWzgTSOg7Ef/q1xhBEO5JDGokcfkouecFdk5fg==
X-Received: by 2002:aca:5155:: with SMTP id f82-v6mr3266692oib.272.1535649809021;
        Thu, 30 Aug 2018 10:23:29 -0700 (PDT)
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id m4-v6sm3685809oic.34.2018.08.30.10.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 10:23:28 -0700 (PDT)
Received: by mail-oi0-f45.google.com with SMTP id r69-v6so16829257oie.3;
        Thu, 30 Aug 2018 10:23:28 -0700 (PDT)
X-Received: by 2002:aca:601:: with SMTP id 1-v6mr3202580oig.291.1535649808387;
 Thu, 30 Aug 2018 10:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180829092746.30674-1-colin.king@canonical.com>
In-Reply-To: <20180829092746.30674-1-colin.king@canonical.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 30 Aug 2018 12:23:16 -0500
X-Gmail-Original-Message-ID: <CADRPPNQxAZi4HahERZZdKDKpauh+pbw+PmDOe_nUXZvJbvJRng@mail.gmail.com>
Message-ID: <CADRPPNQxAZi4HahERZZdKDKpauh+pbw+PmDOe_nUXZvJbvJRng@mail.gmail.com>
Subject: Re: [PATCH] fsl: remove redundant pointer 'priv'
To:     colin.king@canonical.com
Cc:     Roy Pledge <Roy.Pledge@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 4:29 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer 'priv' is being assigned but is never used hence it is
> redundant and can be removed.
>
> Cleans up clang warning:
> variable 'priv' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Merged for next after updated the title prefix.

Thanks!
> ---
>  drivers/soc/fsl/dpio/dpio-driver.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index b60b77bfaffa..e58fcc9096e8 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -50,13 +50,10 @@ static void unregister_dpio_irq_handlers(struct fsl_mc_device *dpio_dev)
>
>  static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
>  {
> -       struct dpio_priv *priv;
>         int error;
>         struct fsl_mc_device_irq *irq;
>         cpumask_t mask;
>
> -       priv = dev_get_drvdata(&dpio_dev->dev);
> -
>         irq = dpio_dev->irqs[0];
>         error = devm_request_irq(&dpio_dev->dev,
>                                  irq->msi_desc->irq,
> --
> 2.17.1
>
