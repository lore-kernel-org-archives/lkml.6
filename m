Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CF6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E89420844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWE01wiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E89420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbeHAPPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:15:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35001 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389217AbeHAPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:15:13 -0400
Received: by mail-it0-f66.google.com with SMTP id q20-v6so9317355ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z4X27xPlOHVle2VFkWx36s5HOu7wG2DiXBnwVVvFhlg=;
        b=iWE01wiIhoKqNQ/Tg+6IP8JR4ddS3PmM4cRsOVwQjIj/ChqiV53X0LY0kGr8eFFkKo
         /E2Up16SAB6lspHlkTdCrmoKXVq3UEDpxa2AXy5pu2Ew+UcVtc86cf8f0ZnsUbGn7fGG
         JLxFrOpQiLt71pTBw7gGSPCleCcgqUQ+hcqq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z4X27xPlOHVle2VFkWx36s5HOu7wG2DiXBnwVVvFhlg=;
        b=mRovt8/OMiyzlRK87RoCpMDk1WrSMc0W0x9HdsHgFgMgFV7HKtSeoWbQuP8YOvhu0e
         c8GCOqqKW8z/4fUuLPZxdljoX3QF/HjOOIDSGDP4SJAt3vGLLuDmEAQF6PtdB82d0+/U
         mmf64HaCSDEcvJtqCr8H5aUJ5h7VPBqWUGacLwx9tpzPlPgWA2qzRZ8noxnNit2j7M03
         Hu9G47h/fuvM1L6mDSjFIrN+bIWpGuAKodT0yh/8RaMuU4bv/Gr3B5sVFacGgT5VMmv0
         WRMv3V6o0SNNeJ5NxJNckHm1o7LKYSZLIkfAe3GPEqrvejGAVsqwKKxNpSE2WzDOIqPH
         wjIA==
X-Gm-Message-State: AOUpUlFazGwRSIfeGYvG115CGXOn3J4OOlP0diLJlE2nXKaD0iF90ifu
        ZqMFl7z6nB1C5Mwykv+CwePpO91lW+p5i1WQNx/xvg==
X-Google-Smtp-Source: AAOMgpez+GFtONlZchtCzKR0R0jyPB3wvZSNumxOHuRKasIaRooGxgNTi58toerOa0lchj6cm4YijIcE1OEna4mlY2Q=
X-Received: by 2002:a24:4524:: with SMTP id y36-v6mr3506882ita.97.1533130165116;
 Wed, 01 Aug 2018 06:29:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 06:29:24 -0700 (PDT)
In-Reply-To: <20180731061721.15831-5-kai.heng.feng@canonical.com>
References: <20180731061721.15831-1-kai.heng.feng@canonical.com> <20180731061721.15831-5-kai.heng.feng@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Aug 2018 15:29:24 +0200
Message-ID: <CAPDyKFp0ut38EountRQ7pJPXGCQPZzzMroyBz6GAh25DJGMwkA@mail.gmail.com>
Subject: Re: [PATCH 4/5] memstick: rtsx_usb_ms: Support runtime power management
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Bauer.Chen" <bauer.chen@realtek.com>, ricky_wu@realtek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> -#ifdef CONFIG_PM_SLEEP
> -static int rtsx_usb_ms_suspend(struct device *dev)
> +#ifdef CONFIG_PM
> +static int rtsx_usb_ms_runtime_suspend(struct device *dev)
>  {
>         struct rtsx_usb_ms *host = dev_get_drvdata(dev);
>         struct memstick_host *msh = host->msh;
>
> -       dev_dbg(ms_dev(host), "--> %s\n", __func__);
> -
> +       host->suspend = true;
>         memstick_suspend_host(msh);

I missed this one. Does this really work? To me, this looks like doing
things upside-down.

To suspend the host, you first need to runtime resume it, because
mmc_suspend_host() calls into one of the host ops and my touch the
device, right?

If you want to suspend the host (actually the naming is wrong, as it's
about suspending/power-iff the memstick card), that should be done via
when the memstick core finds that the card is removed or during system
wide suspend.

> +
>         return 0;
>  }
>
> -static int rtsx_usb_ms_resume(struct device *dev)
> +static int rtsx_usb_ms_runtime_resume(struct device *dev)
>  {
>         struct rtsx_usb_ms *host = dev_get_drvdata(dev);
>         struct memstick_host *msh = host->msh;
>
> -       dev_dbg(ms_dev(host), "--> %s\n", __func__);
> -
>         memstick_resume_host(msh);

According to the above, this seems not correct to me.

> +       host->suspend = false;
> +       schedule_delayed_work(&host->poll_card, 100);
> +
>         return 0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
>

[...]

Kind regards
Uffe
