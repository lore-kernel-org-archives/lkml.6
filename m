Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C023C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FE5218D2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545601526;
	bh=I6dJyPwyfojPLO85Z72OvFBLdjztGpeYPNQrzA1e0yY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uf7XceeXZZaZpvJD8LicBg2eQ9l7dgfTdeI9IZP6nUxwxjSctkC8C+BNLPLQuOdpu
	 dKJFNIKoxPD15qIRI1WQk2MmCZVa4uQkO+2B48khaso5/Inv8iM9IEX5cI3kp2KKTr
	 0BVpqfT82cRNRonRozqYdkLx3+c2fU5HHMW81MC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbeLWVpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 16:45:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38757 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeLWVpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 16:45:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so9657963otl.5;
        Sun, 23 Dec 2018 13:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7REuJJn7dlPKhCCTzOW5v1EZbU97OAb1PXju5deatI=;
        b=jx3MQuSett8KtZ+fLMHoS3BqfYXuvWNq8uVRFFDD0UZwRW/e19T7+5CxNMDETd9pde
         +zwEaMqWYZ+cPy2ttpkfQqsBC/aBg2+bizC3PspKXz4f47DVC4cYzHSXzImkXC/E4/iv
         v3j58j302HWfoGeMfp09vAh8vEcqIOUrnRhp1fhOmX8F6LOI9Zdn46mFpS7MVfV6weqm
         qKXTfGV4KN9jqh+Hj6xavdsWX+jjd420WITVtlZF1wfGWOl4k2eJNnLJhptAOX7IKEmq
         YyRnT0oWk1Hu/ZyDdekP1kO8zAkrkZWMgU0tSnClz6CFfm2gcuHHZXYPBK5I+/hMcdR0
         V/3g==
X-Gm-Message-State: AJcUukedN0ooBN0KLnDdmQnWXqNRxp+qLRkSVQPF4SYHphHmO30cfGPA
        TTS69AXq/QK8qbMdHFNgpAcsTsdliPOCudSzxpkDZA==
X-Google-Smtp-Source: ALg8bN4262LTi8MjtGlOHd5dqMCjBvdPuWSwDhdU6baKDFB0YQBI3K5j3YTjyXWz9gOrxVSw56Y14+jme/bkprvoVeU=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr6825241otf.124.1545601524326;
 Sun, 23 Dec 2018 13:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20181222090720.19234-1-okaya@kernel.org> <20181222090720.19234-2-okaya@kernel.org>
In-Reply-To: <20181222090720.19234-2-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 23 Dec 2018 22:45:09 +0100
Message-ID: <CAJZ5v0hiBT5Zg5+sQekgjvcOVgfQsXcRutkTNEOEeAFHYYRz4A@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] ACPI / LPSS: Add guards against CONFIG_PCI
To:     okaya@kernel.org
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 6:49 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> We can now compile ACPI without PCI support. If code depends on CONFIG_PCI,
> it needs to explicitly guard that piece.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/acpi_lpss.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 5f94c35d165f..4148abcdf9ef 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -534,8 +534,11 @@ static struct device *acpi_lpss_find_device(const char *hid, const char *uid)
>         dev = bus_find_device(&platform_bus_type, NULL, &data, match_hid_uid);
>         if (dev)
>                 return dev;
> -
> +#ifdef CONFIG_PCI
>         return bus_find_device(&pci_bus_type, NULL, &data, match_hid_uid);
> +#else
> +       return NULL;
> +#endif
>  }

No.

Please make this driver depend on PCI instead.

>
>  static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
