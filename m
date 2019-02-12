Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B54C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F5721773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipt9SgAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbfBLQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:17:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42682 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfBLQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:17:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so5300410oto.9;
        Tue, 12 Feb 2019 08:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUjVbFTvRaFD0nlwVLDWky32ZcoWdJruLY07EK4hgtQ=;
        b=ipt9SgAfPZoCZ/5vc4+43b1JpM/vO+BtHfDcs7KF9SjQCkvDifqMZP0jr23I89wfVX
         L4iWXYpVhp9Ou2jU2IpmdwXT2WTTAKbSs3qzRqpGwbK2QARwxnVsFspK2LLA3uAc6OHO
         FIyIabs2MEGfLpW98gz144gVQa6PbaTtcyqPhR9ijytTw3bQIbM+SmZnNO4g+heFA2Ko
         tgYvEAyo3T8k6A0NsNRtDQHpwYVM3wM1XzxdiEShHr++jCMkEyhmIh6o/FBpsASJvWMD
         gKgPo8ny3iAOmnygBl96q1YsqAyLdaJrUjxeab7o+8Pcg7IT4QH9rpObpwKMwuFoHLua
         FQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUjVbFTvRaFD0nlwVLDWky32ZcoWdJruLY07EK4hgtQ=;
        b=Q1lXfqQWE9kD37IbhWRc1x+hKLH4yXVeXJhcwGzdSNnzr5U8MQQlWUfGL7lEP/hBbe
         kOo1t4xQ0t2YXvngrQ7VImPQhi4ZdaxtXeet73AY/9x2UD11MP3jtQaU037OfYqzFsz0
         7U4XEdsllmY3qi/6wS9buoe1E+Q9NJp5cHrWPejSzGN7SPYf87adAjy/rlAkYF/1NswY
         0Ie5uWF7FMJiCIoC32RjGk0bq4i0sTHd8k0viM5LQBtR6+hVz1ceIaFoaqKNiarysHbH
         LYpS+f+DxWxmoRobsmBpgcmeoBP/+beu6ugb7asFB3ZqLs5AbwN1O5NIlpydhptwVxyG
         hzNA==
X-Gm-Message-State: AHQUAuaTR/wKu5mETmTtO3wo2YzVP+LLp1hOLJkPXySyBrgQE6mzTQQZ
        wZwlNIUci0q0+AuTGjP+dexvgKuNuhqke64T73kzGA==
X-Google-Smtp-Source: AHgI3IZZm+cawXjS4J3sllA33iHJ1nOifHLNojPMh/1PXxbYHqCumsDVVfOFm4pVR+EVCEH1vlTAuo3JBXFL6SEOVkY=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr4876625otp.225.1549988229921;
 Tue, 12 Feb 2019 08:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20190212161450.17167-1-TheSven73@gmail.com>
In-Reply-To: <20190212161450.17167-1-TheSven73@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 12 Feb 2019 11:16:58 -0500
Message-ID: <CAGngYiXOfL1MpTcpki-=h=bm0RMKBg0+65p2tCRmBSucnG5mVg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ds2782: fix possible use-after-free on remove
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:14 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> In remove(), use cancel_delayed_work_sync() to cancel the
> delayed work. Otherwise there's a chance that this work
> will continue to run until after the device has been removed.
>
> While we're here, fix the deallocation order in remove(),
> to correspond to the inverse of the probe() allocation
> order. This guarantees that any remaining work can run
> to completion with all driver structures still intact.
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  drivers/power/supply/ds2782_battery.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
> index 019c58493e3d..5853a66ff246 100644
> --- a/drivers/power/supply/ds2782_battery.c
> +++ b/drivers/power/supply/ds2782_battery.c
> @@ -321,15 +321,14 @@ static int ds278x_battery_remove(struct i2c_client *client)
>         struct ds278x_info *info = i2c_get_clientdata(client);
>
>         power_supply_unregister(info->battery);
> +       cancel_delayed_work_sync(&info->bat_work);
>         kfree(info->battery_desc.name);
> +       kfree(info);
>
>         mutex_lock(&battery_lock);
>         idr_remove(&battery_id, info->id);

argh, just a minute !

>         mutex_unlock(&battery_lock);
>
> -       cancel_delayed_work(&info->bat_work);
> -
> -       kfree(info);
>         return 0;
>  }
>
> --
> 2.17.1
>
