Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D622C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D7A21A28
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B2KfE8B9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D7A21A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbeHHV2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:28:47 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46818 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHHV2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:28:47 -0400
Received: by mail-ua0-f196.google.com with SMTP id u11-v6so3539500uan.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BLEj3A2Trr3CkHOoUXW3G/yF12RLPiYx3koUcWlSXQ=;
        b=B2KfE8B9+KCR50/AI78JX9RYqFhTaa1XsruTboXuMjzBTi5e0QyPR67mnDQ8j7by0m
         8H3FpBoJT+IJ81FFsCq47TON4sPNssonajHcxiAVBDBuYH541ttp1xCqlfdgNNY1DC3z
         /wUeTHbdCtuIuXyghXdmCoPAWDR2B0iQ0XOCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BLEj3A2Trr3CkHOoUXW3G/yF12RLPiYx3koUcWlSXQ=;
        b=Lvq3FQQDfn3Us0Iw50nbRyW/PLquU3PJquNY0hgu4/ge6tHTf34aTbk/lwgDqKOIoW
         hZVQzIbyS500PF+WvdvHAJtKbsAJTKNTmSDPj2x+yNtNTygI1CedzltKn1VJuo6679TI
         KDihSDBc8jL0Oo05MRG8Q+uDuV0wXjqk0F+ECaajvelPEnc7ZoB240ijDnrl1kMgfKpA
         YxhGgLItxEY/UH87enKTNixZ9Bv83Oecq+Ls7dYWpV8ekCvCnjtupDb1vOdr/OHSFUHd
         N1XU7GTGO8SD4LV+2cXRA7Orf05lYo6hZ0d2tqsgDhuk9I/VSESFQONUWpmQp6Ayc9i5
         IcAw==
X-Gm-Message-State: AOUpUlHcVQzL/HKzmdLs4E6t8w4EywZJXPRNeMI10iCWWnWnBtxdKJP2
        BelcZHCT3479Zt+JJjq7zCa+ABn3Ui8NLVLe6DnBIAXr
X-Google-Smtp-Source: AA+uWPzGUu8lXWnIZV7bAN+WZXr7eUCCem8A6jI377lKK0dCQhWOHdBm+YpGW/zTu3xpFtMVX8o3salJChECJ7IkIXw=
X-Received: by 2002:a1f:308d:: with SMTP id w135-v6mr2648476vkw.1.1533755264041;
 Wed, 08 Aug 2018 12:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180808172414.29983-1-swboyd@chromium.org> <20180808172414.29983-3-swboyd@chromium.org>
In-Reply-To: <20180808172414.29983-3-swboyd@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 8 Aug 2018 12:07:30 -0700
Message-ID: <CAODwPW_sP2=w-qRmVTAm+HCgomxj7C1Z_tLtLzUy-eSp8QrZeA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] firmware: coreboot: Collapse platform drivers into
 bus core
To:     swboyd@chromium.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org,
        Sudeep.Holla@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +config GOOGLE_COREBOOT_TABLE_ACPI
> +       tristate
> +       default GOOGLE_COREBOOT_TABLE

I don't think this helps in upgrading (as your commit message says)
unless you also keep the 'select GOOGLE_COREBOOT_TABLE' here, right?

> -int coreboot_table_init(struct device *dev, void __iomem *ptr)
> +static int coreboot_table_init(struct device *dev, void __iomem *ptr)

nit: There's little reason to keep coreboot_table_init() a separate
function now. Could maybe compact the code a little more if you merge
it into probe()? (Also could then do the signature sanity check before
trusting the length values to map the whole thing, which is probably a
good idea.)

>         if (ptr_header) {
>                 bus_unregister(&coreboot_bus_type);
>                 iounmap(ptr_header);

Could ptr_header be handled by devm now, somehow? Also, don't you have
two bus_unregister() now (here and in coreboot_exit())? Or is that
intentional?

> +static struct platform_driver coreboot_table_driver = {
> +       .probe = coreboot_table_probe,
> +       .remove = coreboot_table_remove,
> +       .driver = {
> +               .name = "coreboot_table",
> +               .acpi_match_table = ACPI_PTR(cros_coreboot_acpi_match),
> +               .of_match_table = of_match_ptr(coreboot_of_match),

Who takes precedence if they both exist? Will we have two
coreboot_table busses? (That would probably not be so good...)
