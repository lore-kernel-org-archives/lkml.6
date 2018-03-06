Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbeCFCFN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:05:13 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:44400 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeCFCFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:05:11 -0500
X-Google-Smtp-Source: AG47ELvrPVGWQSn+fwPNEjH3we2bhTJ8ESpKVcwAdVoYswPdbKLRgh6XW52lgALkaw7L8RCMWMpKtQ==
MIME-Version: 1.0
In-Reply-To: <5A9DF59E.60900@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
 <20180301101837.27969-14-jeffy.chen@rock-chips.com> <CAAFQd5D2SY2RV9HLTeTQigfnVCkF9wDq74_+t3OV2YEb9wJtqg@mail.gmail.com>
 <5A9DF59E.60900@rock-chips.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 6 Mar 2018 11:04:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DCGgFWvpfFgkP-L+4WC9HRyqtCHiTUGRpA5PGx-QgpLg@mail.gmail.com>
Message-ID: <CAAFQd5DCGgFWvpfFgkP-L+4WC9HRyqtCHiTUGRpA5PGx-QgpLg@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 13/14] iommu/rockchip: Add runtime PM support
To: JeffyChen <jeffy.chen@rock-chips.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricky Liang <jcliang@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>, simon xue <xxm@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        open@263.net,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>, list@263.net:IOMMU DRIVERS
        <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy,

On Tue, Mar 6, 2018 at 10:57 AM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> Hi Tomasz,
>
> Thanks for your reply.
>
> On 03/05/2018 09:49 PM, Tomasz Figa wrote:
>>>
>>> >  struct rk_iommudata {
>>> >+       struct device_link *link; /* runtime PM link from IOMMU to
>>> > master */
>>
>> Kerneldoc comment for the struct could be added instead.
>
> i saw this in the kerneldoc:
>
> * An MMU device exists alongside a busmaster device, both are in the same
>   power domain.  The MMU implements DMA address translation for the
> busmaster
>   device and shall be runtime resumed and kept active whenever and as long
>   as the busmaster device is active.  The busmaster device's driver shall
>   not bind before the MMU is bound.  To achieve this, a device link with
>   runtime PM integration is added from the busmaster device (consumer)
>   to the MMU device (supplier).  The effect with regards to runtime PM
>   is the same as if the MMU was the parent of the master device.
>
>
> maybe we can use something like:
> device link with runtime PM integration from the master (consumer) to the
> IOMMU (supplier).

Sorry, I meant that kerneldoc comment style could be used to document
this struct.

https://www.kernel.org/doc/html/v4.15/doc-guide/kernel-doc.html#writing-kernel-doc-comments

Best regards,
Tomasz
