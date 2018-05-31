Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbeEaFIS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 01:08:18 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43177 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeEaFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 01:08:15 -0400
X-Google-Smtp-Source: ADUXVKKRHGUwkq282VpWArv0qfA7hWrw8z8TfngxauT2rBsqwqnU1YEWNvG/LhkcxM2+meAL99upwPO79PMQg2MlswU=
MIME-Version: 1.0
In-Reply-To: <20180521181704.GA19646@jordon-HP-15-Notebook-PC>
References: <20180521181704.GA19646@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 31 May 2018 10:38:13 +0530
Message-ID: <CAFqt6zZdb5+32CvvU_4Pmb1u-d15-iAFb3ab0ftBLP95257Z-Q@mail.gmail.com>
Subject: Re: [PATCH v2] char: agp: Change return type to vm_fault_t
To: airlied@linux.ie, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 11:47 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler. For now,
> this is just documenting that the function returns a
> VM_FAULT value rather than an errno. Once all instances are
> converted, vm_fault_t will become a distinct type.
>
> Ref-> commit 1c8f422059ae ("mm: change return type to
> vm_fault_t") was added in 4.17-rc1 to introduce the new
> typedef vm_fault_t. Currently we are making change to all
> drivers to return vm_fault_t for page fault handlers. As
> part of that char/agp driver is also getting changed to
> return vm_fault_t type from fault handler.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  drivers/char/agp/alpha-agp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
> index 53fe633..c9bf2c2 100644
> --- a/drivers/char/agp/alpha-agp.c
> +++ b/drivers/char/agp/alpha-agp.c
> @@ -11,7 +11,7 @@
>
>  #include "agp.h"
>
> -static int alpha_core_agp_vm_fault(struct vm_fault *vmf)
> +static vm_fault_t alpha_core_agp_vm_fault(struct vm_fault *vmf)
>  {
>         alpha_agp_info *agp = agp_bridge->dev_private_data;
>         dma_addr_t dma_addr;
> --
> 1.9.1
>

Any comment for this patch ?
