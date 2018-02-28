Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752395AbeB1Jku (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:40:50 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44753 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbeB1Jkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:40:46 -0500
X-Google-Smtp-Source: AG47ELtQKCn+PUINI8UrYMVrlKF6gBmHvfVW2S4uZjUefH0se6nDWGCtA7aQFwnmADZKDX5+ixBvuRNJHwYyye1T1pI=
MIME-Version: 1.0
In-Reply-To: <20180227231952.GA9001@embeddedor.com>
References: <20180227231952.GA9001@embeddedor.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 11:40:45 +0200
Message-ID: <CAHp75Vfy_fRP7nEbSOG32S78Wc4s4ci+Mmh2AJzgrizp7y3j-Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Change type of threshold_ns variable to u32
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 1:19 AM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> It seems that the expression threshold_us * 1000 will never exceed the
> 32-bit limits [1]. So changing the type of threshold_ns from u64 to u32
> seems sensible [2].
>
> [1] https://marc.info/?l=linux-kernel&m=151855021100725&w=2
> [2] https://marc.info/?l=linux-kernel&m=151976318924615&w=2
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Addresses-Coverity-ID: 1462501
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/pci/pcie/aspm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 57feef2..8633fc4 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -322,7 +322,7 @@ static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 scale, u32 val)
>
>  static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
>  {
> -       u64 threshold_ns = threshold_us * 1000;
> +       u32 threshold_ns = threshold_us * 1000;
>
>         /* See PCIe r3.1, sec 7.33.3 and sec 6.18 */
>         if (threshold_ns < 32) {
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
