Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F525C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 12:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BBB21A4A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 12:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx52JRJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfBPMLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 07:11:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38959 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfBPMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 07:11:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id f132so6165326pfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 04:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3inEuc3vq6iYNxm48hepY3BrHA/UGJiKttjcak8yvRs=;
        b=dx52JRJzLjor/AHQNda/+I/yCuLpISuD1Reeyk91eRg+RKs1Q04vU/UpYGuM9QfstF
         2RMnb7OfHc7Ocd80Ec6UCjka/Fq6UQutitMwM1keUEZR4MexWprLmpaBcYeqY5HL9XM2
         XrWTu9JrqXwDGE+k/TuDkiFAQNSVywVF72IktJ4skLR4kjHX1qBbMnIxOWTJBSb842it
         71yt/+PWALkB15M+4C6l7xg5FyUpQI6JdoMLCLtCw6mDCvTihTptkqlRv/iPCEU2t/0T
         bAsHb1D7w0XjPDteAyIC3ETxgcvh6Jqq3D9lhKzQl5NuUnmnMIYN7iiq+A/1kXJqm3/E
         XCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3inEuc3vq6iYNxm48hepY3BrHA/UGJiKttjcak8yvRs=;
        b=HBWWUK7T3cKybFo+COJZsJcD+gXSlMBG9nBeUMCaMY1FYFwBmPIQclA6rYbv+Au/Yi
         0798xy7WBaExeLCSxJLygKDiawwkHU6WMkHZKKhZaddOq4t44I+Ta09rQQvcoG0bZkEo
         CdxgiwGMgffdxJkapV1yFO2cjh00eMsomGe/ojQRZMlZjxW+sG888khxtKSNqzEHUXjl
         peHbMvJJBN4GIhqac7LzknXXIq/lJ4kNVqb48hXh4jPvpAagBV9YieuSG5XBu8YIWFOJ
         PtU0E/r4qxo/+SQCV6lzMTWNFjundtunHIf1vAYjnQi9X9gDVNqadiftU5D7LYajtdxb
         MAbw==
X-Gm-Message-State: AHQUAuap0uLcNp2+M/XKMCnK8/aZ1rkpr3VsK2DvEPbQHAe/SdFCVe9K
        Falv3VhW21qSSE5TOSisJG/tFuCd4BpMPQBu1D4=
X-Google-Smtp-Source: AHgI3IbGcrqEZuuSMXqHg97uZba0Dxs1TroJ+b1QNiKx4yqY/BBSvxqdNcVwDTInQAZSeJS9n3N5s7XsbuZLUUZKkqM=
X-Received: by 2002:a63:d450:: with SMTP id i16mr13594929pgj.246.1550319106776;
 Sat, 16 Feb 2019 04:11:46 -0800 (PST)
MIME-Version: 1.0
References: <1550335843-108902-1-git-send-email-peng.hao2@zte.com.cn> <1550335843-108902-4-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1550335843-108902-4-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Feb 2019 14:11:34 +0200
Message-ID: <CAHp75Vfj1k8CZN4mZPibAq9CUrUSaKhEwY_X98Yk6NfeRweARQ@mail.gmail.com>
Subject: Re: [PATCH V5 3/4] misc/pvpanic: Avoid initializing multiple pvpanic devices
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 10:29 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Avoid initializing multiple pvpanic devices when configure multiple
> pvpanic device driver type. Make sure that only one pvpanic device
> is working.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic/pvpanic.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index ccadec0..fbb5038 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -15,10 +15,13 @@
>  #include <linux/types.h>
>
>  static struct {
> +       struct mutex lock;
>         struct platform_device *pdev;
>         void __iomem *base;
>         bool is_ioport;
> -} pvpanic_data;
> +} pvpanic_data = {
> +       .lock = __MUTEX_INITIALIZER(pvpanic_data.lock),
> +};
>
>  #define PVPANIC_PANICKED        (1 << 0)
>
> @@ -50,6 +53,12 @@ int pvpanic_add_device(struct device *dev, struct resource *res)
>         struct platform_device *pdev;
>         int ret;
>
> +       mutex_lock(&pvpanic_data.lock);
> +       if (pvpanic_data.pdev) {
> +               mutex_unlock(&pvpanic_data.lock);
> +               return -EEXIST;
> +       }
> +
>         pdev = platform_device_alloc("pvpanic", -1);
>         if (!pdev)
>                 return -ENOMEM;
> @@ -64,9 +73,11 @@ int pvpanic_add_device(struct device *dev, struct resource *res)
>         if (ret)
>                 goto err;
>         pvpanic_data.pdev = pdev;

OK, mutex basically protects pdev member in pvpanic_data. What about
->remove() stage?

> +       mutex_unlock(&pvpanic_data.lock);
>
>         return 0;
>  err:
> +       mutex_unlock(&pvpanic_data.lock);
>         platform_device_put(pdev);
>         return ret;
>  }
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
