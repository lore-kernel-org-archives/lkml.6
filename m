Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E85C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109DF21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546860007;
	bh=CpkwQypqJLf8+mw7ieIP15Lo/LTashoizqYLkmqdaZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xoHl1K1YUgKW8IEQRoURO/84LwIymEvhKxRxAmLk6QDOsal+wUICOx9kM7Ja1HyVq
	 UenTyfv9ybPVPbhLMGmxHMpvis1LJ7cI5s/gw4/PnADagxYSsPPio4HWO4ejH5gf6t
	 MuyJw45QyXH6LAaMs8B4Yy0UB1X5mLLE51m0tNeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfAGLUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:20:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39111 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfAGLUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:20:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so3469oia.6;
        Mon, 07 Jan 2019 03:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsnpR7L5piNDsetzHRFxu3Y/Rpc3Nwh3tVWgrBWg5/k=;
        b=gA5LBE43mZplsua7hE3+2PyZ+2NIJFExme2ojCFDngqr1GBYrjhZzcjT08xH4SzKVq
         uRpn4wv4ZnSn6oGZ5MbIIsW7cte9eHD7/oRyEQ9LpLzfKKCc6L6YTKqH/4qU0r4fpJgr
         sxJ8rPyjTKGzulVU6ZglXybmDHyMtbYdOoT8XKv6Yv+GFmGPxG9GR2HoTvOZt7Lxk1I6
         wxgGgixhDdMQF2wfV/1VD+dkknRtG5X5/HwRmo5lwEjofL04KXmGY6UsuFPBNCCoJiUT
         aTxxBVLHE/bbPqTsfFda3jTd9KW8aJ2P6o1N9xu2XatXm5zntYmVfaBXzYbN/VH/Os+g
         Qx9A==
X-Gm-Message-State: AJcUukdGVWwe/ecRU/l3FpjJZuK8sMAASVXuUHrkiqGUPyf0cfIzOxvS
        rzF0SBDkn/KpHWKfKqplZ/oBvz21zxs1fjRmpAo=
X-Google-Smtp-Source: ALg8bN7Gs7zZdnhV3ep3IjU7RMR7QUMAXsHVhaGIdWZ/daqDGyYGNkoYMab2pW8h6PVrxyxQy15Xaxy6jtgKzeBHrHQ=
X-Received: by 2002:aca:e715:: with SMTP id e21mr24700732oih.76.1546860002234;
 Mon, 07 Jan 2019 03:20:02 -0800 (PST)
MIME-Version: 1.0
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-8-okaya@kernel.org>
In-Reply-To: <20190105100606.6673-8-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jan 2019 12:19:51 +0100
Message-ID: <CAJZ5v0gst1ZDgG-uP9GUUB1ziPnqhfArio3um=wCQjfbeH2_iw@mail.gmail.com>
Subject: Re: [PATCH v6 07/11] drivers: thermal: int3406_thermal: Make PCI
 dependency explicit
To:     Sinan Kaya <okaya@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. Need CONFIG_PCI to be set in order to be able to use
> this driver.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/thermal/intel/int340x_thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
> index 0582bd12a239..fba1976d5f8d 100644
> --- a/drivers/thermal/intel/int340x_thermal/Kconfig
> +++ b/drivers/thermal/intel/int340x_thermal/Kconfig
> @@ -31,7 +31,7 @@ if INT340X_THERMAL
>
>  config INT3406_THERMAL
>         tristate "ACPI INT3406 display thermal driver"
> -       depends on ACPI_VIDEO
> +       depends on ACPI_VIDEO && PCI
>         help
>           The display thermal device represents the LED/LCD display panel
>           that may or may not include touch support. The main function of
> --

Rui, any objections here?  And for the [11/11]?
