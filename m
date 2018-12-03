Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14996C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CB720851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CB720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbeLCIXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:23:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47861 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbeLCIXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:23:20 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 80DA8A7CA58C1;
        Mon,  3 Dec 2018 16:23:15 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Mon, 3 Dec 2018
 16:23:10 +0800
CC:     <wangbinghui@hisilicon.com>, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v1 05/12] usb: dwc3: Add two quirks for Hisilicon Kirin
 Soc Platform
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-6-chenyu56@huawei.com>
 <CAHp75VcbNumAGa8NsYp9tL-ZRP4stApuTFtY1LARHMnJjxA4dw@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <4214e332-dd8d-a6a3-b693-54287b178c80@huawei.com>
Date:   Mon, 3 Dec 2018 16:23:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VcbNumAGa8NsYp9tL-ZRP4stApuTFtY1LARHMnJjxA4dw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/3 16:02, Andy Shevchenko wrote:
> On Mon, Dec 3, 2018 at 5:48 AM Yu Chen <chenyu56@huawei.com> wrote:
>>
>> There are tow quirks for DesignWare USB3 DRD Core of Hisilicon Kirin Soc.
>> 1)SPLIT_BOUNDARY_DISABLE should be set for Host mode
>> 2)A GCTL soft reset should be executed when switch mode
> 
>> +static void dwc3_gctl_core_soft_reset(struct dwc3 *dwc)
>> +{
> 
>> +       int reg;
> 
> u32? int for register value looks confusing a bit.

Yes, it should be u32.
> 
>> +       reg = dwc3_readl(dwc->regs, DWC3_GCTL);
>> +       reg |= (DWC3_GCTL_CORESOFTRESET);
>> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>> +
>> +       reg = dwc3_readl(dwc->regs, DWC3_GCTL);
>> +       reg &= ~(DWC3_GCTL_CORESOFTRESET);
>> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>> +}
> 
>> +       int reg;
> 
> Ditto.
> 

