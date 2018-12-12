Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE95C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF3520839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544607106;
	bh=SzMf4gQeGOQzJazUYPNxXcV44QWFcAPsf62gqFQ3tHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yD3N844gT5CQ7ri9r71yxIk8gX8BrloA9Dd/uc0yNv4cuTvH7eI8sujZrjRKN4iM7
	 G6f0lQEuOwa9TI581wOSt2xkS/ASwMe+1tU5KPfQ4VRXsrk3xirccmBH3yMlliDfpm
	 /XDjvUf1c69YQj0xYq0RUGM0N5fk4G9wTajbXacc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF3520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeLLJbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:31:45 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34673 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeLLJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:31:45 -0500
Received: by mail-oi1-f194.google.com with SMTP id h25so14538538oig.1;
        Wed, 12 Dec 2018 01:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05VLTdi3PzttDbNF4sXM5Pfu+mA0PVgW5X6Uy4h0vkI=;
        b=Hf6EDTBC8YlKA2JUI4dys4QYFUBYS5Pa9CTAp1uibsoI5QrScBYUyds6nPh5WyI8dw
         wUcTe1mDx64nukUT3wZWX1dVkT/BJjB0EihNocyl6RwHAuEpgcZievbG0REabtLw5UZG
         +sEoL3D0/HcNkgmzIoYYIg8kx4csJszWMic4NcO1mDvh1G0R3a36le84v8L2G9XfRuuu
         8SK2yYXB8nBQQ9d3mxhMbGB6mqEtXkjSNA/QGYYUbav4/OVvBTRgzMU6We08mJ9Bihv+
         OyYIlTUbMV2TMPsK+Z9ahGQVbIVTGfBQVZgJIveuQwaZGdBImzRtNx5T4Py+f5mWaK5q
         GFPQ==
X-Gm-Message-State: AA+aEWbRCvuS5qrqcu69JSBEPiO/89hS/QbLsQm2pXm3x6MJ0HoxIUn1
        xhYlQ12h7my86MUR6NDj+yazvH7Hd5bQubQl6Gk=
X-Google-Smtp-Source: AFSGD/Vxh7A6fA5PS0L1XcQ0ZguP8uB2el6eX3HfdAOhhIU7Zp9aw9BpnBXN2frwjv3eDI/JXQBFs9L6mmZqEWhUiL4=
X-Received: by 2002:aca:b642:: with SMTP id g63mr745699oif.195.1544607101741;
 Wed, 12 Dec 2018 01:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20181212052846.32370-1-okaya@kernel.org> <20181212052846.32370-3-okaya@kernel.org>
In-Reply-To: <20181212052846.32370-3-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Dec 2018 10:31:30 +0100
Message-ID: <CAJZ5v0gCQdAA3ppMhwobniOaCbEknhGie1hbO1QyOjqvCq194A@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] ACPI / OSL: Stub out acpi_os_read_pci_configuration
 when CONFIG_PCI is unset
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

On Wed, Dec 12, 2018 at 6:29 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> Getting ready to allow PCI to be disabled with ACPI enabled. Stub out
> acpi_os_read_pci_configuration function that depend on PCI.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/osl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index b48874b8e1ea..3e82b50ba811 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -773,6 +773,7 @@ acpi_status
>  acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
>                                u64 *value, u32 width)
>  {
> +#ifdef CONFIG_PCI
>         int result, size;
>         u32 value32;
>
> @@ -799,6 +800,9 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
>         *value = value32;
>
>         return (result ? AE_ERROR : AE_OK);
> +#else
> +       return pr_warn_once("CONFIG_PCI is disabled\n") ? AE_SUPPORT : AE_OK;

What about saying "PCI configuration space access is not supported" instead?

> +#endif
>  }
>
>  acpi_status
> --
