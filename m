Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeENBLV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 21:11:21 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:42467 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751739AbeENBLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 21:11:20 -0400
From: songxiaowei <songxiaowei@hisilicon.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "chenyao (F)" <chenyao11@huawei.com>
CC: Wangbinghui <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, "xuwei (O)" <xuwei5@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "dimitrysh@google.com" <dimitrysh@google.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>
Subject: reply: [PATCH v3 1/2] PCI: kirin: Add MSI support
Thread-Topic: reply: [PATCH v3 1/2] PCI: kirin: Add MSI support
Thread-Index: AdPrH5Q8xBT++ws5TAyeUvElIhaCSw==
Date: Mon, 14 May 2018 01:11:10 +0000
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C54127E3BF@DGGEMA505-MBS.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.52.233]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E1BSwL003004

Hi, Andy Shevchenko

Yao is on maternity leave, and I'll take over the job after discussing with her.

> -----邮件原件-----
> 发件人: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> 发送时间: 2018年5月14日 7:16
> 收件人: chenyao (F) <chenyao11@huawei.com>
> 抄送: songxiaowei <songxiaowei@hisilicon.com>; Wangbinghui
> <wangbinghui@hisilicon.com>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>;
> Bjorn Helgaas <bhelgaas@google.com>; xuwei (O) <xuwei5@huawei.com>;
> Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>; linux-pci@vger.kernel.org; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; linux-arm Mailing List
> <linux-arm-kernel@lists.infradead.org>; devicetree
> <devicetree@vger.kernel.org>; dimitrysh@google.com;
> guodong.xu@linaro.org; Suzhuangluan <suzhuangluan@hisilicon.com>; Kongfei
> <kongfei@hisilicon.com>
> 主题: Re: [PATCH v3 1/2] PCI: kirin: Add MSI support
> 
> On Fri, May 11, 2018 at 12:15 PM, Yao Chen <chenyao11@huawei.com> wrote:
> > Add support for MSI.
> 
> 
> > +       int ret;
> > +
> > +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> 
> > +               pci->pp.msi_irq = platform_get_irq(pdev, 0);
> > +               if (pci->pp.msi_irq < 0) {
> > +                       dev_err(&pdev->dev, "failed to get MSI IRQ
> (%d)\n",
> > +                               pci->pp.msi_irq);
> 
> > +                       return -ENODEV;
> 
> Why shadowing actual error code?
[songxiaowei]  Sorry, I can't get your point about this, would you explain it for me.
> 
> > +               }
> > +               ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
> > +                                      kirin_pcie_msi_irq_handler,
> > +                                      IRQF_SHARED |
> IRQF_NO_THREAD,
> > +                                      "kirin_pcie_msi", &pci->pp);
> > +               if (ret) {
> > +                       dev_err(&pdev->dev, "failed to request MSI
> IRQ %d\n",
> > +                               pci->pp.msi_irq);
> > +                       return ret;
> > +               }
> 
> It would be easy to read and maintain if this would be a separate function.
[songxiaowei] Yes, a separate function will be better, and I'll fix it.
> 
> > +       }
> 
> 
> 
> --
> With Best Regards,
> Andy Shevchenko

Thanks a lot,

Best Regards,
Xiaowei Song
