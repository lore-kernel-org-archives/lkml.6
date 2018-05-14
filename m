Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753898AbeENHQ6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:16:58 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:42918 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752988AbeENHQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:16:55 -0400
X-Google-Smtp-Source: AB8JxZpfweBkmGzB5k/2ZFUcWPQk4fP+HUxryXJuhQdYzKKxH6I2UPY1l2tBvJ5UeMB/6QepL7Ar+C819d8e4FOgDEQ=
MIME-Version: 1.0
In-Reply-To: <99B4C6BADD9E3241B25E52B02BA737C54127E3BF@DGGEMA505-MBS.china.huawei.com>
References: <99B4C6BADD9E3241B25E52B02BA737C54127E3BF@DGGEMA505-MBS.china.huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 10:16:54 +0300
Message-ID: <CAHp75VfHfUCNKNun4-bb2BhwV6D9jg2+hzVjrDER+af0SrzqjA@mail.gmail.com>
Subject: Re: reply: [PATCH v3 1/2] PCI: kirin: Add MSI support
To: songxiaowei <songxiaowei@hisilicon.com>
Cc: "chenyao (F)" <chenyao11@huawei.com>,
        Wangbinghui <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, "xuwei (O)" <xuwei5@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "dimitrysh@google.com" <dimitrysh@google.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 4:11 AM, songxiaowei <songxiaowei@hisilicon.com> wrote:

>> > +       int ret;
>> > +
>> > +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
>>
>> > +               pci->pp.msi_irq = platform_get_irq(pdev, 0);
>> > +               if (pci->pp.msi_irq < 0) {
>> > +                       dev_err(&pdev->dev, "failed to get MSI IRQ
>> (%d)\n",
>> > +                               pci->pp.msi_irq);
>>
>> > +                       return -ENODEV;
>>
>> Why shadowing actual error code?
> [songxiaowei]  Sorry, I can't get your point about this, would you explain it for me.

platform_get_irq() returns either correct IRQ number or negative error code.
In the code above you shadow the actual error (as returned by that
call) by -ENODEV. Any reason why?

-- 
With Best Regards,
Andy Shevchenko
