Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A01C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BE020883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vaHnIFYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BE020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbeGLIuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:50:16 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42218 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeGLIuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:50:15 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so54347810oib.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0oLKNLvbtt4M5cmDqij/V3Z0/38n4hnXPd1c76xLDo=;
        b=vaHnIFYAcMh63nSIdU/9S3MefjNsPxg8cwn4rZGjb4k5HYLm7V3ZDyGV7C2HJsugSH
         1oVqCMeTSW5Vry8zJYKewg5U91BT+HXPswsCiB6fEHn45qDUKMgvPjydcvmN8SosdecC
         dh0Ejr5trZyZ83Eozk0aIp4xVt242luldqx6vR1QD8Esn52EmykveYnp/JrtLBjL44Qe
         iLR3xdMQYcotvs7ljMcXwsykTePZwE2JHr/swnCImxKDxx+t/SQ+VD/i+su6pGKIJ3Um
         gBly4wKL0UtPQq/xcpsnKlP272zjosYpFhev/XIRT1Sw9K5euKNiJy3Wsl5p3MKYOMMR
         /cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0oLKNLvbtt4M5cmDqij/V3Z0/38n4hnXPd1c76xLDo=;
        b=SQl5le0t5bGh5UPdx+gVYAi4/lpeKPyGPvcneun47NbhuHI3PWBQevhTsqXdY3jsGi
         i0NGcmsXiUCtqAQEkgFVwI5KpLPTnZPa2cZyydUCNQJJTt235qCkbKrYCFcI2PlR/i80
         dn0gCCFuulPyLSMCdizSyw9Rc053ZHoPaHn4/KVu/JQ1/P0N2f//OLF9M0xuzeBC0Gck
         gjQgFjKcc6oQ+aeMo68Pg9TNc40e/fwWrEyBguc/zWpfgXxD91k9dbhPjLyb6TfN6F0O
         ZgxJLovR/LxqZoivayk0sqgu3NeFbgGpvHHcMMHmOnnBP8yzCX7jH1jZ+FaJCnQrxji2
         MaFA==
X-Gm-Message-State: AOUpUlEzKqMQB4SmcSHFA3fN/YWX3KkTEUzxNloVGtYJBJNiyyop7MRi
        xO1QXDQkx+Uj9hAtDT0QrV5+C1jvAdxas5kIvh1ayw==
X-Google-Smtp-Source: AAOMgpdGumOq5nzaRl1lTQupC3i8c4mmcSnF5ti1RNrUUvicYWfpFlovKl+ASxHy2sy5u4kau82uMT5KoV2tWHpl0QI=
X-Received: by 2002:aca:e2d3:: with SMTP id z202-v6mr1364424oig.121.1531384899312;
 Thu, 12 Jul 2018 01:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 Jul 2018 01:41:28 -0700
Message-ID: <CAFd5g47nBCbF0mcYqEnQkDpz0Dhh0F0S1-wEL_yBHgs1b3yE5w@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: Adjust spinlock scope in the irq handler
To:     jae.hyun.yoo@linux.intel.com
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 2:40 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This patch adjusts spinlock scope to make it wrap the whole irq
> handler using a single lock/unlock which covers both master and
> slave handlers.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 60e4d0e939a3..9f02aa959a3e 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -234,7 +234,6 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
>         bool irq_handled = true;
>         u8 value;
>
> -       spin_lock(&bus->lock);
>         if (!slave) {
>                 irq_handled = false;
>                 goto out;
> @@ -325,7 +324,6 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
>         writel(status_ack, bus->base + ASPEED_I2C_INTR_STS_REG);
>
>  out:
> -       spin_unlock(&bus->lock);
>         return irq_handled;
>  }
>  #endif /* CONFIG_I2C_SLAVE */
> @@ -389,7 +387,6 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>         u8 recv_byte;
>         int ret;
>
> -       spin_lock(&bus->lock);
>         irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>         /* Ack all interrupt bits. */
>         writel(irq_status, bus->base + ASPEED_I2C_INTR_STS_REG);
> @@ -547,22 +544,29 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 dev_err(bus->dev,
>                         "irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>                         irq_status, status_ack);
> -       spin_unlock(&bus->lock);
>         return !!irq_status;
>  }
>
>  static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  {
>         struct aspeed_i2c_bus *bus = dev_id;
> +       bool ret;
> +
> +       spin_lock(&bus->lock);
>
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>         if (aspeed_i2c_slave_irq(bus)) {
>                 dev_dbg(bus->dev, "irq handled by slave.\n");
> -               return IRQ_HANDLED;
> +               ret = true;
> +               goto out;
>         }
>  #endif /* CONFIG_I2C_SLAVE */
>
> -       return aspeed_i2c_master_irq(bus) ? IRQ_HANDLED : IRQ_NONE;
> +       ret = aspeed_i2c_master_irq(bus);
> +
> +out:
> +       spin_unlock(&bus->lock);
> +       return ret ? IRQ_HANDLED : IRQ_NONE;
>  }
>
>  static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
> --
> 2.17.1
>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
