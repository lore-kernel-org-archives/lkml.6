Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2980FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB38D217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550487637;
	bh=VbCWF5PD6twpl6D4liF3/fy0J9FlxUVHzJHSfTnzW0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0kKf1bmt9YZjm4QHh3hqK5r3Obbi1nGudZDMzK2aq41I8zAlHSYqfh1vkQrQPhWlw
	 poi7jto3aZecy/00fCf/6Oe+6kXVFiAA89Y51ijr0EJD7ZvA4NqL81nhoduTB2wSJd
	 eoQjDGtOP6NLWBy1cOYySwbbnR871mY8Nj+T7wiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfBRLAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729584AbfBRLAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:00:34 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD8D217F5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550487633;
        bh=VbCWF5PD6twpl6D4liF3/fy0J9FlxUVHzJHSfTnzW0c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NO0mmMassg6rNARU4bUxUAR0a8JXU3Q8hQtuNy+AXhzkqpUuGm0SmuydYOiBxh7vs
         +jDn5W5E+G4nGy5ZTu4Jym1IqV0nH+ExJxxwDwktNbsbtAImIBtuXLY0W7i1JbOU3i
         lZdeI2vXmLgjYuAQB4RQeYubMmJmSZZ7GsFwm6eA=
Received: by mail-lj1-f169.google.com with SMTP id g11-v6so13993641ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 03:00:32 -0800 (PST)
X-Gm-Message-State: AHQUAuZGpRHWs1R4dCA36FSmLovd9NNtxrovpa8LbiJHSh8vL82Ya7g+
        8L1AsWN5odmpnQbsiv+ZUrKg4cilod9TnPT2ZsY=
X-Google-Smtp-Source: AHgI3IZyXxGiFszMQskqfo2BYmbUE7QKR2Ow4LKHScIIkJUxlRvqCrOK+uirUFBwKJKWyVqUnch3Y9KfOMY9D5qHgjI=
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr13954100lji.112.1550487631171;
 Mon, 18 Feb 2019 03:00:31 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190215144828epcas2p267aae592d0ebaaaa297ba1543463c204@epcas2p2.samsung.com>
 <20190215144809.28007-1-s.nawrocki@samsung.com> <20190215144809.28007-2-s.nawrocki@samsung.com>
In-Reply-To: <20190215144809.28007-2-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 18 Feb 2019 12:00:19 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfF7+Qp1DLR_YJJOXH-YMQqWbxr0Hp=cKU+7mc9oKTUtA@mail.gmail.com>
Message-ID: <CAJKOXPfF7+Qp1DLR_YJJOXH-YMQqWbxr0Hp=cKU+7mc9oKTUtA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: samsung: i2s: Fix multiple "IIS multi" devices initialization
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 at 15:48, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On some SoCs (e.g. Exynos5433) there are multiple "IIS multi audio
> interfaces" and the driver will try to register there multiple times
> same platform device for the secondary FIFO, which of course fails
> miserably.  To fix this we derive the secondary platform device name
> from the primary device name. The secondary device name will now
> be <primary_dev_name>-sec instead of fixed "samsung-i2s-sec".
>
> The fixed platform_device_id table entry is removed as the secondary
> device name is now dynamic and device/driver matching is done through
> driver_override.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c    | 49 +++++++++++++++++++++++++-------------
>  sound/soc/samsung/odroid.c |  2 +-
>  2 files changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index e36c44e2f1bb..4a6dd86459bc 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1339,20 +1339,34 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
>  /* Create platform device for the secondary PCM */
>  static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
>  {
> -       struct platform_device *pdev;
> +       struct platform_device *pdev_sec;
> +       const char *devname;
>         int ret;
>
> -       pdev = platform_device_register_simple("samsung-i2s-sec", -1, NULL, 0);
> -       if (!pdev)
> +       devname = devm_kasprintf(&priv->pdev->dev, GFP_KERNEL, "%s-sec",
> +                                dev_name(&priv->pdev->dev));
> +       if (!devname)
>                 return -ENOMEM;
>
> -       ret = device_attach(&pdev->dev);
> +       pdev_sec = platform_device_alloc(devname, -1);
> +       if (!pdev_sec)
> +               return -ENOMEM;
> +
> +       pdev_sec->driver_override = "samsung-i2s";
> +
> +       ret = platform_device_add(pdev_sec);
>         if (ret < 0) {
> -               dev_info(&pdev->dev, "device_attach() failed\n");
> +               platform_device_put(pdev_sec);
>                 return ret;
>         }
>
> -       priv->pdev_sec = pdev;
> +       priv->pdev_sec = pdev_sec;
> +
> +       ret = device_attach(&pdev_sec->dev);
> +       if (ret < 0) {
> +               dev_info(&pdev_sec->dev, "device_attach() failed\n");

Don't you need here platform_device_unregister()?

Best regards,
Krzysztof
