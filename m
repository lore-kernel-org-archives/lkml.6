Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9A7C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BD72081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544523170;
	bh=8stYEgMD5RkkhsElbhk54+08JK/8VpeUh2ydXdSb4GA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y5M3DqK/epcE2C2AiwiklVV8bF+y/DeadLyn9Exbr/9UJMemrEhya8a+xkI4iu7wh
	 5KLcEKkF9Jy2cLu7Q1nrJbLiikWM86Bfe3+C1gQQNS5DWLvqt63FHcOxyhxE9pntFD
	 MGrsv58JQqRjw3FCNo64E8u+YX0GMxk/Y6ySXJZU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BD72081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeLKKMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:12:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36382 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeLKKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:12:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so13487893otk.3;
        Tue, 11 Dec 2018 02:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oek6EKid2RfGsvU9DoiWaFOn1V2LvxS24Ia1j0J7ydA=;
        b=Fl/V46OphESidghD7Me0L24YTLXvVLWODN9o2PwcfpyzAOPtSJX57ncCeCNNk3lHrU
         pAm3ulpFzRmg+UoHoVWu+0VpGfXGor8ZIiU18WySwncV9yRNmdhm34bObVxSM68z4xSN
         DmhLDwn+1bvEDbu7uZWFnovmQiPxriAfX72afZFWnCF0AtACAgvcHEQg/oPdM9tcdymO
         4Vo4Ly7FqlaoGO6DYkNACTl3kuMs/iTq8HZkkbXkH5Buo9mIYKXrAesz7Ck5Dfw0fZm0
         LsOdDQgqJq5o/ZO1cbbEVThbxPKBsuSADECz3GwSiUmWxPwiljW40jhrksMIOO2iHMFQ
         gUJw==
X-Gm-Message-State: AA+aEWYsN0SvBD84ei20ALNqz1WiCb9OvpDL4sM6gGuWYouVX4VGy9t1
        OQiV12ABDtV9NVxIOZl+1ntNWS6KC+phJrDawDI=
X-Google-Smtp-Source: AFSGD/U23idKC0NK/SJsRqlxNnYRp4BrKQ5ax5FFVGIjLoqK1RPG5OVAQGUp+KbvaIEwTzygneXfitTqgP86QmRcWn4=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr712220otg.139.1544523167923;
 Tue, 11 Dec 2018 02:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20181208214644.5374-1-okaya@kernel.org>
In-Reply-To: <20181208214644.5374-1-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Dec 2018 11:12:36 +0100
Message-ID: <CAJZ5v0jV+UZ7A46Kiyv6JysoFJ=_ts7O_p3z9F1Uze3OwZdh_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: Allow PCI to be disabled for reboot
To:     okaya@kernel.org
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 8, 2018 at 10:47 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> Make PCI reboot conditional on PCI support being present on the kernel
> configuration.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

Same comment as for patch [2/3]: make the subject say clearly that
this is about CONFIG_PCI.

> ---
>  drivers/acpi/reboot.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> index 6fa9c2a4cfe9..9aa367f098a6 100644
> --- a/drivers/acpi/reboot.c
> +++ b/drivers/acpi/reboot.c
> @@ -7,8 +7,6 @@
>  void acpi_reboot(void)
>  {
>         struct acpi_generic_address *rr;
> -       struct pci_bus *bus0;
> -       unsigned int devfn;
>         u8 reset_value;
>
>         if (acpi_disabled)
> @@ -33,6 +31,11 @@ void acpi_reboot(void)
>          * on a device on bus 0. */
>         switch (rr->space_id) {
>         case ACPI_ADR_SPACE_PCI_CONFIG:
> +       {
> +#ifdef CONFIG_PCI
> +               unsigned int devfn;
> +               struct pci_bus *bus0;
> +
>                 /* The reset register can only live on bus 0. */
>                 bus0 = pci_find_bus(0, 0);
>                 if (!bus0)
> @@ -45,7 +48,10 @@ void acpi_reboot(void)
>                 pci_bus_write_config_byte(bus0, devfn,
>                                 (rr->address & 0xffff), reset_value);
>                 break;
> -
> +#else
> +               return;

Why not "break"?

> +#endif
> +       }
>         case ACPI_ADR_SPACE_SYSTEM_MEMORY:
>         case ACPI_ADR_SPACE_SYSTEM_IO:
>                 printk(KERN_DEBUG "ACPI MEMORY or I/O RESET_REG.\n");
> --
