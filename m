Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbeENHkd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:40:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752391AbeENHk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:40:29 -0400
From: songxiaowei <songxiaowei@hisilicon.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: "chenyao (F)" <chenyao11@huawei.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, "xuwei (O)" <xuwei5@huawei.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "dimitrysh@google.com" <dimitrysh@google.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>
Subject: =?utf-8?B?562U5aSNOiByZXBseTogW1BBVENIIHYzIDEvMl0gUENJOiBraXJpbjogQWRk?=
 =?utf-8?Q?_MSI_support?=
Thread-Topic: reply: [PATCH v3 1/2] PCI: kirin: Add MSI support
Thread-Index: AdPrH5Q8xBT++ws5TAyeUvElIhaCS///4c0A//92hiA=
Date: Mon, 14 May 2018 07:40:17 +0000
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C54127E490@DGGEMA505-MBS.china.huawei.com>
References: <99B4C6BADD9E3241B25E52B02BA737C54127E3BF@DGGEMA505-MBS.china.huawei.com>
 <CAHp75VfHfUCNKNun4-bb2BhwV6D9jg2+hzVjrDER+af0SrzqjA@mail.gmail.com>
In-Reply-To: <CAHp75VfHfUCNKNun4-bb2BhwV6D9jg2+hzVjrDER+af0SrzqjA@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E7f6Xg004427

Hi Andy Shevchenko

> -----邮件原件-----
> 发件人: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> 发送时间: 2018年5月14日 15:17
> 收件人: songxiaowei <songxiaowei@hisilicon.com>
> 抄送: chenyao (F) <chenyao11@huawei.com>; Wangbinghui
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
> 主题: Re: reply: [PATCH v3 1/2] PCI: kirin: Add MSI support
> 
> On Mon, May 14, 2018 at 4:11 AM, songxiaowei <songxiaowei@hisilicon.com>
> wrote:
> 
> >> > +       int ret;
> >> > +
> >> > +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> >>
> >> > +               pci->pp.msi_irq = platform_get_irq(pdev, 0);
> >> > +               if (pci->pp.msi_irq < 0) {
> >> > +                       dev_err(&pdev->dev, "failed to get MSI IRQ
> >> (%d)\n",
> >> > +                               pci->pp.msi_irq);
> >>
> >> > +                       return -ENODEV;
> >>
> >> Why shadowing actual error code?
> > [songxiaowei]  Sorry, I can't get your point about this, would you explain it
> for me.
> 
> platform_get_irq() returns either correct IRQ number or negative error code.
> In the code above you shadow the actual error (as returned by that
> call) by -ENODEV. Any reason why?
> 
[songxiaowei] I guess the reason is that she wanted to keep the same with other hosts,
           So, you'd like to use "return pci->pp.msi_irq " instead of " return -ENODEV ".
> --
> With Best Regards,
> Andy Shevchenko

Thanks a lot,
Xiaowei.
