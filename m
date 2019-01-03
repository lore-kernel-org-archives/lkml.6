Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74DCC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7845121479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546510072;
	bh=3x6Rwml4HcWsNtfvn0kllCsev71lUh0ItBBiVcqf7SU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GegG0Mlpfc4hsLRyqS9km4ruJVeR8c9bNdhF7MaarIulUne0St47CSrV2wNH8yguH
	 0wiN8f9ZM9U9FLkAwGu57wXAlLkz74JxNL5ndO6lKtIRIOu/uvOGslh+CK4cMVbS2d
	 H19FZyKyR7X0HAn6sKHNe139RAJhOYAPnHjDFHBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfACKHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:07:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43742 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfACKHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:07:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so28935443otr.10;
        Thu, 03 Jan 2019 02:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+CMymQPu4IjqF42Kopf3GFpQQJfyMPBu9inonwKwl3Y=;
        b=C5MGSEiIdFxcdOvLB0ORgrU2CFfZ3zqwvIOFcSfvZq9C+NGNj7KTZV2s3Dxv1EGMDk
         n0cTu1GD2LKjtUiKey7nWz9xdNghMKcy9D9kvgr4yBKtv+quJlJFurbVYUP77S/NfE/n
         9B06EMazyO70TMQMJad/V/MhMhpWUJMDayzk22O1ZLMeIHhHxap/zWCRAngjT97204uU
         tYdO40Lb1DBQ74Bqln02hnA3NRPJtsPxn6eH/J+jrZ+TFdy680NabO07Lwl6nqx2DOzi
         WofVr7/Sf/cmsIKwtgW5vkSxxuqvTDPosX47uvsDH3VjjfqmlCCxF81LcvsjCV7liTFG
         gL0Q==
X-Gm-Message-State: AJcUukdsMQjLqzNxeD/KyYYDi/9YF8r8VZgve0lULFsk6pUZgKQFWPCc
        ydq/fB6RPM/NGVm6n3QEYVlACZlzram9uajNiVrdBw==
X-Google-Smtp-Source: ALg8bN5PRwk5gKxtXmmAbbpH4+0lQg9WH9zQZwulhDGDZTy2QOXH02L0Z/Dj2htlVvdu0MI3IH4uqv7QZ7MlUceMjpo=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr33894281oti.258.1546510070645;
 Thu, 03 Jan 2019 02:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20181230204005.6397-1-okaya@kernel.org>
In-Reply-To: <20181230204005.6397-1-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Jan 2019 11:07:39 +0100
Message-ID: <CAJZ5v0joc+aTU3g6ySgyXa3qPkB1OcPL4EzF5iWZ_t5YZv5SVA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Fix build failure when CONFIG_NLS is set to 'n'
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 9:40 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> Observing link failure as follows when CONFIG_ACPI is set but
> both CONFIG_NLS and CONFIG_PCI are unset.
>
> drivers/acpi/device_sysfs.o: In function `description_show':
> device_sysfs.c:(.text+0x48a): undefined reference to `utf16s_to_utf8s'
>
> This issue has been previously fxed by
> 'commit 8a226e00eeed ("PCI: pci-label: Fix build failure when CONFIG_NLS
> is set to 'm' by allmodconfig")' selecting NLS when ACPI is present.
>
> Now that it is possible to have ACPI without PCI, we need an alternative
> select statement inside the ACPI kconfig.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7b65a807b3dd..90ff0a47c12e 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -10,6 +10,7 @@ menuconfig ACPI
>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>         depends on ARCH_SUPPORTS_ACPI
>         select PNP
> +       select NLS
>         default y if X86
>         help
>           Advanced Configuration and Power Interface (ACPI) support for
> --

Applied, with some changelog modifications.

Thanks!
