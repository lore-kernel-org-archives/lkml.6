Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8077EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E82021473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfdgr/EV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbfA3Pnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:43:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46037 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfA3Pnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:43:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so11562653pfd.12;
        Wed, 30 Jan 2019 07:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkWcEhfUSaW3+qq2QeySS+iZcEjyvZo8uXYJm1mSdpo=;
        b=kfdgr/EVYnERKR4XZeInirT0flpg3zeEXsmvhuOivw1msNdthZFrAuUtDlGp4TUYq2
         Cx4NEXGTJNAicqol2w2L4jXZCgPnURnBFAwxpMl0+B6C/K0Gi+VyihV1kdSIUdNJRjsV
         +EbgRGYpryM7yd7zLKYn80gRTeXUxFXZfa33UklMJwn/QK0A+3NH36k7jzn7Mw/+Gvrr
         IX4UIon1L5Ef3tr82mhPRtSmKDGfN9nAIMJZA6r8HQTrTDnXL7ASd6jS5OEMoOOvNCI2
         L9buf8aUf10yQP0jWrh6D66AOA5uwccZTq9HDetIjS/nmgY3gmQtKADky3amEc0fPo0D
         0VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkWcEhfUSaW3+qq2QeySS+iZcEjyvZo8uXYJm1mSdpo=;
        b=oEvpCeqKNyOsMVtmPIH2h65VxDb3GPsT0wrne9zXo0qlsbyid2m6gdfhB1D2xJWpL1
         NvC8XDQkCjGJ7jTlaLspXdJslTsfp/eKKp0YnUUEiKkyOtcqmY/62JAm3As3RM566FlK
         NXMUd2mcIuaWSlluQ7rzQOZ/Fb5GEvNK7HaqaKZJ0tEp/c4tvjdISVGT1FntH6JDEEDu
         +6m/OJUj+JkMO/HnTumLFr/J+FRgiWpN+pcVxGjuW3LhpG4LaUqHXJ0jRuAn1p8ckWbQ
         80ZXD6IbfrI3zZ/7lzhoqFqFazsKLCae1Raqnh35zh4RUZWbXk/LtvGoglWEuY6PJG4j
         02+A==
X-Gm-Message-State: AJcUukelX2zt+kduZ6ygfP73OD3QG6taPubAEq+B7XdkzozXALMUC54Y
        reNQ6RuZMq532r+yfDD8tzSJKz6PAG42H835fkg=
X-Google-Smtp-Source: ALg8bN6Al14ylPiAEMTooOFoosKabogLtocrAd2N8f8lp1Px9yc8zp1oMC6KYQH6PfOmJGO4yWhLLQ0r3Cng3WFXXoo=
X-Received: by 2002:a63:f615:: with SMTP id m21mr28500777pgh.428.1548863026673;
 Wed, 30 Jan 2019 07:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20190130151424.28140-1-2pi@mok.nu>
In-Reply-To: <20190130151424.28140-1-2pi@mok.nu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Jan 2019 17:43:34 +0200
Message-ID: <CAHp75VfHDN7Q1YjFd7XM8tFpCcPphaDm0fvOaxHzko5AvF6jEw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: wmi: fix potential null pointer dereference
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 5:15 PM Mattias Jacobsson <2pi@mok.nu> wrote:
>
> In the function wmi_dev_match() the variable id is dereferenced without
> first performing a NULL check. The variable can for example be NULL if
> a WMI driver is registered without specifying the id_table field in
> struct wmi_driver.
>
> Add a NULL check and return that the driver can't handle the device if
> the variable is NULL.
>

Good for me, thanks!

> Fixes: 844af950da94 ("platform/x86: wmi: Turn WMI into a bus driver")
> Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
> ---
>  drivers/platform/x86/wmi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index bea35be68706..b0f3d8ecd898 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -768,6 +768,9 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
>         struct wmi_block *wblock = dev_to_wblock(dev);
>         const struct wmi_device_id *id = wmi_driver->id_table;
>
> +       if (id == NULL)
> +               return 0;
> +
>         while (id->guid_string) {
>                 uuid_le driver_guid;
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
