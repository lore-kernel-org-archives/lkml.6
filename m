Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F967C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559C82086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcNWtioe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559C82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeLKQoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:44:23 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38765 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeLKQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:44:23 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so4867916ith.3;
        Tue, 11 Dec 2018 08:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwyPkcVNlLZnkFsH0IBvFgeaelucitRwz/cnxhMyq00=;
        b=OcNWtioevuvc/8nzGgqOOYaIHMqoBT6YJ2NyNbql7RMuuxhL4oV92ktm8oRmQnUeIG
         wu+lLgmvB9xMGXFdQsHo8M2mx3yzMuu2aqVH3iec43sjq6rrdbM2cEGBu5pw3bfMPnXE
         m3gXAzkzLSipA7Njzg8vduGttGwauGeMi3MGnkoFa0iBjSoQWuJ4lfDEshT+KDbTBz20
         uswk+V0hIyoh40gz15/V25colYk6DlMJ5dVylZU5NRN3fhBYBhESBBcaylxHsR6U83qp
         TIHpswi79HBhZWqQX3MD8RU2zYCizeJYDdZ6ynCTDzUqZnQ+ggrITAvsleIPYG2nEg23
         PiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwyPkcVNlLZnkFsH0IBvFgeaelucitRwz/cnxhMyq00=;
        b=qFzEIfVpQ38Z9fV0yhdph44OB8WMsETkP2UQWHrbzDLKw3h6yKjUqLSVS7HXilMdMk
         GHzWO7fQoRh5wuRXSVfmBwvxG90NPw1ymPHSeBAm050JEV1Hi4wMcu6x09/yz8ba+HaR
         yhSHqnmXZ5O4OISvejrFnvTnm8ITeyMeRx5tMhA5iJH9HFVAwXtH76WeTMvQlRe+bh7v
         Z8fWf8m3VirSexNHM5PJ0I8jCOp6BcJUwkQ+fGrEfxViyYgjjXiiRFDi0D6jSmJiB4lZ
         r5iEQgpp78dAsd2xeSi0n0jHGSn8H4Vs891xnMGRh/AVzrl8tGD32g7GaP2idoMWRRq7
         KfSA==
X-Gm-Message-State: AA+aEWZHH1CVTMeLsDJ3bdsXbSyxs37M7UvcpZrLBEThJDQPoCjkh3Ks
        /PP9RgyacGheyWJzuSzRQjlt7tKCLGEmxufqnXY=
X-Google-Smtp-Source: AFSGD/X4y0pidDxX9ZH+JY5Xsua9IQ/rzkuT99x+4G01MX0m+PX+crm4EEO57sDth6obt0Ty02P5KX6ZJWvl5R5g/Bg=
X-Received: by 2002:a24:a701:: with SMTP id a1mr2731659itf.7.1544546661714;
 Tue, 11 Dec 2018 08:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com> <20181210210310.12677-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181210210310.12677-5-wsa+renesas@sang-engineering.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Tue, 11 Dec 2018 11:44:01 -0500
Message-ID: <CAC=U0a2cvdhAdBPyowR3i=wpnONDHjBWMZ56D_pJYfhYL=DTbg@mail.gmail.com>
Subject: Re: [RFC/RFT 04/10] i2c: brcmstb: use core helper to mark adapter suspended
To:     wsa+renesas@sang-engineering.com
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        hdegoede@redhat.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 4:03 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Rejecting transfers should be handled by the core.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>

> ---
>  drivers/i2c/busses/i2c-brcmstb.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
> index 826d32049996..05c822e5a3f6 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -170,7 +170,6 @@ struct brcmstb_i2c_dev {
>         struct bsc_regs *bsc_regmap;
>         struct i2c_adapter adapter;
>         struct completion done;
> -       bool is_suspended;
>         u32 clk_freq_hz;
>         int data_regsz;
>  };
> @@ -467,9 +466,6 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
>         int xfersz = brcmstb_i2c_get_xfersz(dev);
>         u32 cond, cond_per_msg;
>
> -       if (dev->is_suspended)
> -               return -EBUSY;
> -
>         /* Loop through all messages */
>         for (i = 0; i < num; i++) {
>                 pmsg = &msgs[i];
> @@ -689,10 +685,7 @@ static int brcmstb_i2c_suspend(struct device *dev)
>  {
>         struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
> -       i2c_dev->is_suspended = true;
> -       i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
> -
> +       i2c_mark_adapter_suspended(&i2c_dev->adapter, true);
>         return 0;
>  }
>
> @@ -700,10 +693,8 @@ static int brcmstb_i2c_resume(struct device *dev)
>  {
>         struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
>         brcmstb_i2c_set_bsc_reg_defaults(i2c_dev);
> -       i2c_dev->is_suspended = false;
> -       i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
> +       i2c_mark_adapter_suspended(&i2c_dev->adapter, false);
>
>         return 0;
>  }
> --
> 2.11.0
>
