Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7BCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEA120866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbxQFVOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEA120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeJPVmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:42:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43603 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeJPVmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:42:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id q41-v6so25692508qtq.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GbGhX6sHSV23Grz6FVp5g23P7JfBj1mSGNji9fqc/A=;
        b=fbxQFVORaqMROf0NDV+zGR7NKho01mkJ0aHn2FtNA59cVRxBskW9Mz9m0wsIUvffLj
         fvpyMnXd6pjpYlCRedmZ4Hmn60AXwet19i5+iL6A7r/q5BGXZ5VWwynJPHqMEZCJpu5m
         tXdNn9JZNcRk1fOGvWMJToEKYjny9cn1eVe4Mqom08tvg+EXlAo6O/PHqiCwgeJLd4Cd
         3fg1/Hlk4zpObMaR++FFuQDhlcXL8vo2c7lzGhYMGAN8J0XC7t8gk/nRKf8/HeJsSNTd
         MDxgzNMfD0ixeYnyc0dKY37MxMi6gj5T+kO8Nw+qX0XuMyHA3fjc6/GBBNIXMC5uFOlB
         EItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GbGhX6sHSV23Grz6FVp5g23P7JfBj1mSGNji9fqc/A=;
        b=V2ae1JdrQ2hZ+1fH/L680ULeo/1iS09HvlMAYiJsKrbM6Mbly3eqppm5A3pzOrJ+Qx
         DEjNflIP5qOYaSV2O48cjRsjuNUhfKAKcMFBAR0E/QL8HohfGbObmn0qQD8BgHYtZllC
         Ly6tMPbHtsz2vlI5aYgtqaHRk482vwVDhL1pXHYgzLNmqf83STYWpxG29uD4w5s0ErDN
         fh1WQ0kTEwBG0d26panzrnwNytubLEgGczBlr+VM3mWNKRtPlZaCi3HI+l7MM0ZGVp1B
         /JhlPgaTlox3uJI8L4dVWVWT8hRje7d2whTOq/b1YOreOgISiaqR3f40vYgBwg+yzp/9
         QtEQ==
X-Gm-Message-State: ABuFfoiDuvaCVCdOQbTjB493BQHz4aJ+a1q4mt9vRFkGiNQ3QHr5tm9l
        8xwIUEuq+bJSwI3JFNV60WAXwIn3+rGb3c+Pl9I=
X-Google-Smtp-Source: ACcGV60FHv+39bcB204+vagy0bQnqXNbB1OzJLREycm030/0O43EXUFZ1AYzVm/INH1lR6vKMBm2vVyFMGt2zpavrGw=
X-Received: by 2002:ac8:6784:: with SMTP id b4-v6mr20683361qtp.373.1539697918458;
 Tue, 16 Oct 2018 06:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016072250eucas1p1a763670c8509d20a6e6847eadb246817@eucas1p1.samsung.com>
 <20181016072244.1216-1-a.hajda@samsung.com> <20181016072244.1216-4-a.hajda@samsung.com>
In-Reply-To: <20181016072244.1216-4-a.hajda@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Oct 2018 16:51:47 +0300
Message-ID: <CAHp75VeZEtG7f3WmgvLrirReSwgbOQDp1qiBZ47652poMw8BUQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drivers: use probe_err function in obvious cases
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> The patch replaces obviously matching code with probe_err function.
> There are many more places where probe_err could be used.
> The patch shows how the new function should be used, and how it
> improves the code.

> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -824,9 +824,7 @@ static int pca953x_probe(struct i2c_client *client,
>         reg = devm_regulator_get(&client->dev, "vcc");
>         if (IS_ERR(reg)) {
>                 ret = PTR_ERR(reg);
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(&client->dev, "reg get err: %d\n", ret);
> -               return ret;
> +               return probe_err(&client->dev, ret, "reg get err: %d\n", ret);

No need to assign ret above.
As I mentioned, better to print a value for everyone.

>         }

Please, split it at least one patch per subsystem.

-- 
With Best Regards,
Andy Shevchenko
