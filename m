Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeBUTYk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:24:40 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38745 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBUTYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:24:38 -0500
X-Google-Smtp-Source: AH8x224NICg3GNt1j4ZHMrHodK42/0pO9TM4A0xGrxP/8comJPU1F2PKlCdNPEerY+IjY/EiN7JF65uRchru99rTfd8=
MIME-Version: 1.0
In-Reply-To: <20180221090715.2853-1-christian.koenig@amd.com>
References: <20180221090715.2853-1-christian.koenig@amd.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 21:24:37 +0200
Message-ID: <CAHp75VcmvgSjC2BqxVBPO26xicVUOQ0UDU7=3QMo81917pW4hQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: stop crashing in pci_release_resource v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LJOiZv009290

On Wed, Feb 21, 2018 at 11:07 AM, Christian König
<ckoenig.leichtzumerken@gmail.com> wrote:
> Is it entirely possible that the BIOS wasn't able to assign resources to
> a device. In this case don't crash in pci_release_resource() when we try
> to resize the resource.
>
> v2: keep printing the info that we try to release the BAR
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Christian König <christian.koenig@amd.com>
> CC: stable@vger.kernel.org
> ---
>  drivers/pci/setup-res.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index e815111f3f81..c0f091614805 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -402,6 +402,10 @@ void pci_release_resource(struct pci_dev *dev, int resno)
>         struct resource *res = dev->resource + resno;
>
>         dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);
> +
> +       if (!res->parent)
> +               return;
> +
>         release_resource(res);
>         res->end = resource_size(res) - 1;
>         res->start = 0;
> --
> 2.14.1
>



-- 
With Best Regards,
Andy Shevchenko
