Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C2DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7922086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544779148;
	bh=KmYOS0UOoesLtJPDxUYARt6wMBDyX2HpznfQ9O9yIO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EoNdUXrlv3O92SFLB91FToC7GSDD0+WVAA63Eni65ZMJcdBv+y0hx2wPKJYttqgT/
	 ZHb6bg9d6sKnuofDOJ9hZqhdKg5+Zryeeixa4jIJn+ZGbhZLDJM1Ct75nMbwkiD/XG
	 89n5pMf666w8wZd8/efhO/QuWQY4jJno6xIEq9+8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7922086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeLNJTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:19:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43891 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeLNJTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:19:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so4737109otr.10;
        Fri, 14 Dec 2018 01:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Spa4wT8zH4rPqBGTeLjeu4x5n4zu6G+4YCz1buFUcUQ=;
        b=M+3mOCzG3bPS7/9e+N9EhDDAOMWHwJ/OpET+A0dvYEDr1vU9ymJHD+J+5ViSVCz/bA
         hEaj0oot1plsty9AZCvXPfXxCdAVTl6XjcC2KPyXAZA/eM5RiYaCIqYcVCCVbv9DauW2
         ZLzVUbT6PGaFYT44/PhAo2kwumALQA76r1k9bj2/zDg1Z5+/sV6fFpt/z5DigG0uB7sM
         DEzGSKmB70Dm1vEnlStk5ulTsCqPvAjvDbGaOA00G3W3yEXkfieHS7s7yky09no+ZlRc
         Ok3xQbZilhqD+6pcUqJ1SFcfAb/zxA/xMDIhrTZEZp5S+ih91fwnJ5t+jjZ5BaNTRpdy
         9QNw==
X-Gm-Message-State: AA+aEWbpsDQ4BL2Gm+gniEf5KmndgFt1utwq2jJa8cSP5bv/RvMQLpmG
        N49cjzJJtMmbmEQMKoc5OXTpZtbZnIOuy5hPtf12Sg==
X-Google-Smtp-Source: AFSGD/WfbcTlFm9nrpcjhuFYapujnhsP+5166coXFSs5ac35khcAZ/SPVspBtLBejT5qeia85qqu1QDyUHXVYrStF+U=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr1416775otq.119.1544779145844;
 Fri, 14 Dec 2018 01:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20181214031252.28707-1-okaya@kernel.org> <20181214031252.28707-2-okaya@kernel.org>
In-Reply-To: <20181214031252.28707-2-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Dec 2018 10:18:53 +0100
Message-ID: <CAJZ5v0ji7xSs=1By9x8VAZ1eRkyQdfvO67B+Vg+FajZmJLmi4Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] ACPI: Allow CONFIG_PCI to be unset for reboot
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

On Fri, Dec 14, 2018 at 4:12 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> Make PCI reboot conditional on PCI support being present on the kernel
> configuration.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/reboot.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> index 6fa9c2a4cfe9..d75e637ee36a 100644
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

Why did you add the braces?

> +#ifdef CONFIG_PCI
> +               unsigned int devfn;
> +               struct pci_bus *bus0;
> +
>                 /* The reset register can only live on bus 0. */
>                 bus0 = pci_find_bus(0, 0);
>                 if (!bus0)
> @@ -44,8 +47,9 @@ void acpi_reboot(void)
>                 /* Write the value that resets us. */
>                 pci_bus_write_config_byte(bus0, devfn,
>                                 (rr->address & 0xffff), reset_value);
> +#endif
>                 break;
> -
> +       }
>         case ACPI_ADR_SPACE_SYSTEM_MEMORY:
>         case ACPI_ADR_SPACE_SYSTEM_IO:
>                 printk(KERN_DEBUG "ACPI MEMORY or I/O RESET_REG.\n");
> --
> 2.19.0
>
