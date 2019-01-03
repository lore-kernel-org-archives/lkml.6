Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D77C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8AA208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlKy865G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfACUF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:05:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36046 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfACUF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:05:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so16349323plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZK2+45qPInifFT6wUVRnlWcgArDYRxqmdLAVW6fKLxA=;
        b=nlKy865GDxuSBhLGyb34fZ54adW3tzoVVx1DuOd6IFKNdoNuKjw0FWzT+XqGBR3ZZt
         HM+VI/i0WNYL13+TOUIRfbYRLBpbO5GB4UyURSPfrRWNThD7LfnFun2xEtP4NQn+MRak
         sAwFApe1tfrjDXtq3m35nIrJ74yDjziitWrKsUcWEvAxlAMvIogPQ/qkrzqOkQmFbcjd
         VNkDPbqQo3oQPpqV/fzrdv2iKnpQn0TieDXFxx/svQKLelu668jevCzvAskSR0CQXiFA
         S2Fqc11cLoK/G8w173PR0LARSi6Xx31EyoTkvT9aQDqfGKJYScngicTARwpjEkUOJ87C
         EmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZK2+45qPInifFT6wUVRnlWcgArDYRxqmdLAVW6fKLxA=;
        b=dp3hiQUETbSupR+6qxfvSygqq23/2y8ELoSPkcC36tYt5LMxQ+dIo+f0ZwwSH+p7cn
         U2M018t0eowwNyjQ4dnT3f+cve7cLPAaSe0L2bzJCTDrP4ovVvpvoUTwti1DH88gKBgO
         wgm8aPUwo2bXE6i/10syHTVJGBfdnFZ0T/R34EleP+NMSIZEnAd3Gip61w43UawY/ov0
         vJufhUCUshpOlw8m/40oAhDF7EmBpd5+/0/Fan4q7gIWopoC9t8CU/nvWMatNUKY8oW4
         eqH6hXrF9mVzMFt/Ay4qXtlK9wS8Mr5KiJ9gan3DJTN7mOa8JVOXUv4VVHk+Ad2VeNBA
         vYFA==
X-Gm-Message-State: AJcUukdD8JXVGttwqyNDix0bbGXZt26g1K/eY9hi+eVZbzXFbdd5jC51
        5R0vPVQoGJ8E8WLFIopE+AyT2inb5r34fCBfXy0=
X-Google-Smtp-Source: ALg8bN6p8fGb7p84LVM/WP5nvclP+gh79AaiMYW/s2BCiNrTna6YXBtYjciB/AkGesOuYguNgnDPFuY3rhbU0HvFe6k=
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr48848590pls.12.1546545924776;
 Thu, 03 Jan 2019 12:05:24 -0800 (PST)
MIME-Version: 1.0
References: <1545282888-38059-1-git-send-email-peng.hao2@zte.com.cn> <1545282888-38059-2-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1545282888-38059-2-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 3 Jan 2019 22:05:12 +0200
Message-ID: <CAHp75VcohyNtL-cYAwN1jjBmgh4A8dVsB6RSkA60AFAD00WSuA@mail.gmail.com>
Subject: Re: [PATCH RESEND V5 2/3] misc/pvpanic : add pci interface for pvpanic
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 6:57 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Support pvpanic as a pci device in guest kernel.
>

After my vacation followed by holidays I hardly remember what I suggested.
Looking to this code I would recommend to split it in a way how it's
done for ChipIdea USB driver, for example.
(drivers/usb/chipidea if I'm not mistaken)

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> [Use pcim_* API. - Andy]
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index f84ed30..c30bf62 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -13,9 +13,12 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>
> +#define PCI_VENDOR_ID_REDHAT             0x1b36
> +#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0101
>  static void __iomem *base;
>
>  #define PVPANIC_PANICKED        (1 << 0)
> @@ -172,12 +175,76 @@ static int pvpanic_mmio_remove(struct platform_device *pdev)
>         .remove = pvpanic_mmio_remove,
>  };
>
> +#ifdef CONFIG_PCI
> +static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
> +       { PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC),},
> +       {}
> +};
> +
> +static int pvpanic_pci_probe(struct pci_dev *pdev,
> +                            const struct pci_device_id *ent)
> +{
> +       int ret;
> +
> +       ret = pcim_enable_device(pdev);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
> +       if (ret)
> +               return ret;
> +
> +       base = pcim_iomap_table(pdev)[0];
> +
> +       atomic_notifier_chain_register(&panic_notifier_list,
> +                                      &pvpanic_panic_nb);
> +       return 0;
> +}
> +
> +static void pvpanic_pci_remove(struct pci_dev *pdev)
> +{
> +       atomic_notifier_chain_unregister(&panic_notifier_list,
> +                                        &pvpanic_panic_nb);
> +}
> +
> +static struct pci_driver pvpanic_pci_driver = {
> +       .name =         "pvpanic-pci",
> +       .id_table =     pvpanic_pci_id_tbl,
> +       .probe =        pvpanic_pci_probe,
> +       .remove =       pvpanic_pci_remove,
> +};
> +
> +static int pvpanic_register_pci_driver(void)
> +{
> +       return pci_register_driver(&pvpanic_pci_driver);
> +}
> +
> +static void pvpanic_unregister_pci_driver(void)
> +{
> +       pci_unregister_driver(&pvpanic_pci_driver);
> +}
> +#else
> +static int pvpanic_register_pci_driver(void)
> +{
> +       return 0;
> +}
> +
> +static void pvpanic_unregister_pci_driver(void) {}
> +#endif
> +
>  static int __init pvpanic_mmio_init(void)
>  {
> +       int r1, r2;
> +
>         if (acpi_disabled)
> -               return platform_driver_register(&pvpanic_mmio_driver);
> +               r1 = platform_driver_register(&pvpanic_mmio_driver);
> +       else
> +               r1 = pvpanic_register_acpi_driver();
> +       r2 = pvpanic_register_pci_driver();
> +       if (r1 && r2) /* all drivers register failed */
> +               return 1;
>         else
> -               return pvpanic_register_acpi_driver();
> +               return 0;
>  }
>
>  static void __exit pvpanic_mmio_exit(void)
> @@ -186,6 +253,7 @@ static void __exit pvpanic_mmio_exit(void)
>                 platform_driver_unregister(&pvpanic_mmio_driver);
>         else
>                 pvpanic_unregister_acpi_driver();
> +       pvpanic_unregister_pci_driver();
>  }
>
>  module_init(pvpanic_mmio_init);
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
