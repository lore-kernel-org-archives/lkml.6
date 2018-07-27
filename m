Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28260C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A5120671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvz9VLOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A5120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbeG0UFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:05:22 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34895 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbeG0UFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:05:21 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so10783214oik.2;
        Fri, 27 Jul 2018 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvoKxNm4GfxkJ69Ax0JAA83cBZXDTLjhrJV0QXsh1cI=;
        b=Xvz9VLOm3t8hc+bK4+SRZDhJZmi5U5wiYKEr7F7sNracm6SlP4beXD7ZbNyt0h7029
         2J+wkYYxuF1V6s4m2NMDN8vwz9wGWTbYpfzLg84e+pyr4p7TD9qUNUsxHgwjVEXd2LXa
         VQc4X+OQUuRi89AtvbEiXhteKydhBB7kHFSp/YdtO82MgWAYT73lj20MEqu+2VEQ3ypl
         j2sL16EOCuNZ+FTn9hppII6UzXT6nTY9wi26OT3elTVaNq1ZJht43iHuctWbtNhkVjjv
         uYvkql0DBDfizcOYRlAUtGL/W//4N5qvyagCNnPCpl+FsxNlo5zEmFsQYVBJkj1uOaDH
         bp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvoKxNm4GfxkJ69Ax0JAA83cBZXDTLjhrJV0QXsh1cI=;
        b=orA0Smo7yJk+pmL4WPKVUY0gGqWsSPiH2ldm1Tej6RYbImRcBKjbit2q+Ai5SD3RMV
         l0ugzWii8znwCga83Xut6IWwqPP8wN7tUOlXj3VXTjjyhyloVyQvT0vFDqF0POBMRldZ
         zKBqhpwtGQZ8SVKp2AZuxRaw+QlwSQhqwTB1xuAtrFOoD9Zg4UEcYUIX54AaUQFY+d4w
         dsFAwl5D1dAPESMeEzaB9vZB76ZHt2qQ2iXIQG+fKHek9bb7SvF+16peuuSjQylykj00
         kmgpZC6hFEfzxNnnMKKmJJMg3dACRTohWkfoW/4b6nMFA++XykdjrfWcl8+MKdONE/AU
         KLmA==
X-Gm-Message-State: AOUpUlFMj/epI6ArOEQQUh7QWM8Tst5LiJii112Kzm1zjJ0//Fvnzp6d
        40cloSEYS1wj8xs+nQWfefM4917nYmIk1pLzWlk=
X-Google-Smtp-Source: AAOMgpeWdudGuu2Lf/yDeylKTM5LiHkee+3xcBOpvOY9qOCUJzDB/bcFrF8EPfcNOt7jBNu4Y0MFQgarNxWIXbikFCQ=
X-Received: by 2002:a54:4406:: with SMTP id k6-v6mr8260661oiw.34.1532716931716;
 Fri, 27 Jul 2018 11:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180727135157.13051-1-vasilyev@ispras.ru>
In-Reply-To: <20180727135157.13051-1-vasilyev@ispras.ru>
From:   adam radford <aradford@gmail.com>
Date:   Fri, 27 Jul 2018 11:42:00 -0700
Message-ID: <CAHtARFGRBk_1yG3sfZetCOKmoKegwEK5uH1Rco5-K4ussyMVxQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: 3ware: fix return 0 on the error path of probe
To:     vasilyev@ispras.ru
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 6:52 AM Anton Vasilyev <vasilyev@ispras.ru> wrote:
>
> tw_probe() returns 0 in case of fail of tw_initialize_device_extension(),
> pci_resource_start() or tw_reset_sequence() and releases resources.
> twl_probe() returns 0 in case of fail of twl_initialize_device_extension(),
> pci_iomap() and twl_reset_sequence().
> twa_probe() returns 0 in case of fail of tw_initialize_device_extension(),
> ioremap() and twa_reset_sequence().
>
>
> The patch adds retval initialization for these cases.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
>  drivers/scsi/3w-9xxx.c | 6 +++++-
>  drivers/scsi/3w-sas.c  | 3 +++
>  drivers/scsi/3w-xxxx.c | 2 ++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
> index 99ba4a770406..27521fc3ef5a 100644
> --- a/drivers/scsi/3w-9xxx.c
> +++ b/drivers/scsi/3w-9xxx.c
> @@ -2038,6 +2038,7 @@ static int twa_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
>
>         if (twa_initialize_device_extension(tw_dev)) {
>                 TW_PRINTK(tw_dev->host, TW_DRIVER, 0x25, "Failed to initialize device extension");
> +               retval = -ENOMEM;
>                 goto out_free_device_extension;
>         }
>
> @@ -2060,6 +2061,7 @@ static int twa_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
>         tw_dev->base_addr = ioremap(mem_addr, mem_len);
>         if (!tw_dev->base_addr) {
>                 TW_PRINTK(tw_dev->host, TW_DRIVER, 0x35, "Failed to ioremap");
> +               retval = -ENOMEM;
>                 goto out_release_mem_region;
>         }
>
> @@ -2067,8 +2069,10 @@ static int twa_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
>         TW_DISABLE_INTERRUPTS(tw_dev);
>
>         /* Initialize the card */
> -       if (twa_reset_sequence(tw_dev, 0))
> +       if (twa_reset_sequence(tw_dev, 0)) {
> +               retval = -ENOMEM;
>                 goto out_iounmap;
> +       }
>
>         /* Set host specific parameters */
>         if ((pdev->device == PCI_DEVICE_ID_3WARE_9650SE) ||
> diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
> index cf9f2a09b47d..40c1e6e64f58 100644
> --- a/drivers/scsi/3w-sas.c
> +++ b/drivers/scsi/3w-sas.c
> @@ -1594,6 +1594,7 @@ static int twl_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
>
>         if (twl_initialize_device_extension(tw_dev)) {
>                 TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1a, "Failed to initialize device extension");
> +               retval = -ENOMEM;
>                 goto out_free_device_extension;
>         }
>
> @@ -1608,6 +1609,7 @@ static int twl_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
>         tw_dev->base_addr = pci_iomap(pdev, 1, 0);
>         if (!tw_dev->base_addr) {
>                 TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1c, "Failed to ioremap");
> +               retval = -ENOMEM;
>                 goto out_release_mem_region;
>         }
>
> @@ -1617,6 +1619,7 @@ static int twl_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
>         /* Initialize the card */
>         if (twl_reset_sequence(tw_dev, 0)) {
>                 TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1d, "Controller reset failed during probe");
> +               retval = -ENOMEM;
>                 goto out_iounmap;
>         }
>
> diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
> index f6179e3d6953..961ea6f7def8 100644
> --- a/drivers/scsi/3w-xxxx.c
> +++ b/drivers/scsi/3w-xxxx.c
> @@ -2280,6 +2280,7 @@ static int tw_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
>
>         if (tw_initialize_device_extension(tw_dev)) {
>                 printk(KERN_WARNING "3w-xxxx: Failed to initialize device extension.");
> +               retval = -ENOMEM;
>                 goto out_free_device_extension;
>         }
>
> @@ -2294,6 +2295,7 @@ static int tw_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
>         tw_dev->base_addr = pci_resource_start(pdev, 0);
>         if (!tw_dev->base_addr) {
>                 printk(KERN_WARNING "3w-xxxx: Failed to get io address.");
> +               retval = -ENOMEM;
>                 goto out_release_mem_region;
>         }
>
> --
> 2.18.0
>

Anton,

3w-9xxx: twa_probe() initializes retval at the top of the function:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/3w-9xxx.c#n2007

so does 3w-xxxx: tw_probe():

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/3w-xxxx.c#n2253

so does 3w-sas: twl_probe():

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/3w-sas.c#n1562

so I think your patch isn't needed...

-Adam
