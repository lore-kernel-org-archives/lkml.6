Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeEMXQL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 19:16:11 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:37668 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeEMXQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 19:16:09 -0400
X-Google-Smtp-Source: AB8JxZqWXs3UBJpjzT5i5L5lf6/GkaPB5Y5BpS2hDqlmKY+O4Ozer1fAGdBmxGLpkFALgxeLcR8nMtXPUKdti5PyZ1I=
MIME-Version: 1.0
In-Reply-To: <1526030149-23985-2-git-send-email-chenyao11@huawei.com>
References: <1526030149-23985-1-git-send-email-chenyao11@huawei.com> <1526030149-23985-2-git-send-email-chenyao11@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 02:16:08 +0300
Message-ID: <CAHp75VfqfnTw6PkQq_sGeTe+RpV6iqNEf5JV1TQgpNhMk=VyeA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: kirin: Add MSI support
To: Yao Chen <chenyao11@huawei.com>
Cc: songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>, dimitrysh@google.com,
        guodong.xu@linaro.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 12:15 PM, Yao Chen <chenyao11@huawei.com> wrote:
> Add support for MSI.


> +       int ret;
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {

> +               pci->pp.msi_irq = platform_get_irq(pdev, 0);
> +               if (pci->pp.msi_irq < 0) {
> +                       dev_err(&pdev->dev, "failed to get MSI IRQ (%d)\n",
> +                               pci->pp.msi_irq);

> +                       return -ENODEV;

Why shadowing actual error code?

> +               }
> +               ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
> +                                      kirin_pcie_msi_irq_handler,
> +                                      IRQF_SHARED | IRQF_NO_THREAD,
> +                                      "kirin_pcie_msi", &pci->pp);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "failed to request MSI IRQ %d\n",
> +                               pci->pp.msi_irq);
> +                       return ret;
> +               }

It would be easy to read and maintain if this would be a separate function.

> +       }



-- 
With Best Regards,
Andy Shevchenko
