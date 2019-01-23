Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC82C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C09B20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V99Cvedc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfAWHpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:45:15 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36756 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAWHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:45:15 -0500
Received: by mail-vk1-f196.google.com with SMTP id 185so278876vkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 23:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtltT2XEvVsleCWVsz2bMM5dg8L+ESS5bjHsEX7YO14=;
        b=V99Cvedcga1c6hm8PcYW63xTRtWfg0lEm299Hj79zNXR+tHOPxq3KK57m/fkzyhGhi
         N3LK6nxguslxgu4kB1Dh+6zFDSfJnzto++7QxRkMsVe951LhT2fTShmZ4tuZBI9IgBM3
         dpteLTro3CMPCg/uAVty1ivzmyXAukcxjRNEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtltT2XEvVsleCWVsz2bMM5dg8L+ESS5bjHsEX7YO14=;
        b=Mp52ahmwlosxR+T6WUDroST/0YBwBMQ8LgtOFz0dH6K5TDRBlJQnNJsTVMSJW6ZWuj
         V6L2g4EuJGmXPXr9xgkKMB1eUIWQGMa5fx9iJVPW4BBjMH2gj71iZ7becSQR48pKFJ26
         8WEIBK/QzzFKcPgHdKMc4MMVrxFKV4+p7LlJ5egJNpTVq6KCk4vYcF+UZZheaum9J7Co
         gg/3O2CRzDIgdEhe7jxM9dXF7p3H3b6eGw44nTw+m5xIoA5ZAUgmzDSXdIarMJ1GVuNv
         UBTrCvlWm+W1IOB/EbxPzRjYbCEZm2J+qwXTNw33yQHlSGwtN0n/0+aSikg5eWrePJa7
         GqcA==
X-Gm-Message-State: AJcUukeqCiRJvUswlJqXUYd/ICi24yhGECezJrcrF1ZgEgwwKaJPNVmj
        p/NxHZHi2AMrGfRm+a3yeAj4A85T6Bv5hWfD6X/NAw==
X-Google-Smtp-Source: ALg8bN4BgdeFyF90NRfWahV7+RIJxqsX6/kqVn1hys0fiP6zqVuSO+htYXtvRvkw9Rh7md4Fho2LXrJXA1TT/4xXTZE=
X-Received: by 2002:a1f:1c81:: with SMTP id c123mr432595vkc.52.1548229513722;
 Tue, 22 Jan 2019 23:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20190122152151.16139-6-gregkh@linuxfoundation.org>
In-Reply-To: <20190122152151.16139-6-gregkh@linuxfoundation.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Jan 2019 08:44:36 +0100
Message-ID: <CAPDyKFo=6NCiAzwF2mvfuvfCApiegBBnJdPM1EypK8xO38h_DA@mail.gmail.com>
Subject: Re: [PATCH] power: domain: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 at 16:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Doesn't this boils done to whether we want to care to check if memory
allocation failed?

Somewhere down the call chain from debugfs_create_dir(), we end up in
alloc_inode() and it looks like that can fail, no?

Kind regards
Uffe

>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/power/domain.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 500de1dee967..45eafe8cf7dd 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2948,18 +2948,11 @@ static int __init genpd_debug_init(void)
>
>         genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
>
> -       if (!genpd_debugfs_dir)
> -               return -ENOMEM;
> -
> -       d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
> -                       genpd_debugfs_dir, NULL, &summary_fops);
> -       if (!d)
> -               return -ENOMEM;
> +       debugfs_create_file("pm_genpd_summary", S_IRUGO, genpd_debugfs_dir,
> +                           NULL, &summary_fops);
>
>         list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
>                 d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
> -               if (!d)
> -                       return -ENOMEM;
>
>                 debugfs_create_file("current_state", 0444,
>                                 d, genpd, &status_fops);
> --
> 2.20.1
>
