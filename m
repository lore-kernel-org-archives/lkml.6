Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D4AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F01F20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="faqctQH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfAWMti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:49:38 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37493 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfAWMti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:49:38 -0500
Received: by mail-vs1-f68.google.com with SMTP id n13so1213786vsk.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 04:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fg8tm4ujmdwme+GYgwItmtfVDjIcodldM6MBnJ+XuhY=;
        b=faqctQH+kG/xc39NIpC8/AZk1cU5SDeLRNYS8e1AwKdIZpX3qFkBRHw+a629T/IIdt
         SnPcVv0uNGwU6jyuHyNrs6WwNmZZ0sXCImuEPF7/8FYmZ0DHvqf3wN9nq3tkMYV/A6En
         aWV6NOnBtSJZzobHd5oZoSC+pmYChw8SqWhuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fg8tm4ujmdwme+GYgwItmtfVDjIcodldM6MBnJ+XuhY=;
        b=R1YftJ7lVcIyB4cbh83JDjRyWQXP03m7/DSGl/yhWxYovTC9+phQtiJQ98ta4F5nKY
         2HhFPRJLM86goK7md1D6fdBkcespOKmWFrxi9djLfeUvqRPYN0EvzJnRo6WZT4uGPINC
         kbThcAn856BxPWqGKL0rqaY9dInU0tMVg0OonbRh0zNhKYZU1C6IO5zORqj3SYJHbKWq
         H3kMMs8BJ4Nl50Glh9BlanqTYKdKJtcMTh9j43qCFgxfpENv4LhPxWBKJ6MZSfeEWJSZ
         BpH9sCXWU3+4ZACeo4qEefY1VovMTqAhXl5dVVmWFSuQmaxtyPn/nzR+zmrUp83HLLul
         axOA==
X-Gm-Message-State: AJcUukcWi5DQgXsxE/VQaHxqYEzN19MxI4aCIC/JHX8pzEDBLwfDsjSm
        YNGk/01w9ahj+wnVSoMr04j4FGstV33VqvSlY5OQqg==
X-Google-Smtp-Source: ALg8bN5E+XntigXtqrr+hkOUW5i89svT1sDE+osBsMg87NtF5kZUIijSMVDo/7ghk7P6KH4Doga6skjmObZM9SYUUDw=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr774169vsi.191.1548247776934;
 Wed, 23 Jan 2019 04:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20190122152151.16139-6-gregkh@linuxfoundation.org>
In-Reply-To: <20190122152151.16139-6-gregkh@linuxfoundation.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Jan 2019 13:49:00 +0100
Message-ID: <CAPDyKFrLn=gTz80sw5f4W=0W86p9Ktj3Zo1b+4R-YZd-sbRNzA@mail.gmail.com>
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
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

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
