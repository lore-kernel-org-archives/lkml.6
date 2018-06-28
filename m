Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B4AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F31A25811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F31A25811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932246AbeF1DGU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:06:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27293 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752610AbeF1DGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:06:18 -0400
X-UUID: 976c98b87fa54939b2a0233404fe0f52-20180628
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1259776088; Thu, 28 Jun 2018 11:06:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 28 Jun 2018 11:06:13 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 11:06:13 +0800
Message-ID: <1530155173.29697.48.camel@mtkswgap22>
Subject: Re: [PATCH v4 6/7] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 28 Jun 2018 11:06:13 +0800
In-Reply-To: <CAHp75VedHLw52J_ymh3iYf2w=r8d+Kqg=fJZmBGnaCrEbNEPdQ@mail.gmail.com>
References: <cover.1530004712.git.sean.wang@mediatek.com>
         <48215a1276c36af7ad581c3d83759fe9f55e3c4b.1530004712.git.sean.wang@mediatek.com>
         <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
         <CAHp75VedHLw52J_ymh3iYf2w=r8d+Kqg=fJZmBGnaCrEbNEPdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 20:04 +0300, Andy Shevchenko wrote:
> On Wed, Jun 27, 2018 at 7:59 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Jun 27, 2018 at 8:43 AM,  <sean.wang@mediatek.com> wrote:
> >> From: Sean Wang <sean.wang@mediatek.com>
> >>
> >
> >> +config BT_HCIBTUART_MTK
> >> +       tristate "MediaTek HCI UART driver"
> >> +       depends on BT_HCIBTUART
> >
> >> +       default y
> >
> > Perhaps it's an overkill for users which would like to have less
> > amount on stuff in kernel.
> >

Sure, the default y will be removed

> >
> >> +#include <asm/unaligned.h>
> >> +#include <linux/atomic.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/firmware.h>
> >> +#include <linux/module.h>
> >> +#include <linux/pm_runtime.h>
> >> +#include <linux/serdev.h>
> 
> Perhaps alphabetically ordered?
> 

They seem already in alphabetically ordered

> + blank line.
> 

A blank line will be added here

> >
> >> +#include <net/bluetooth/bluetooth.h>
> >> +#include <net/bluetooth/hci_core.h>
> 
> >> +       /* Enable the power domain and clock the device requires. */
> >> +       pm_runtime_enable(dev);
> >> +       err = pm_runtime_get_sync(dev);
> >> +       if (err < 0)
> >> +               goto err_pm2;
> 
> Should be err_pm1 here.

Label err_pm1 and err_pm2 can be swapped for the readability and this
doesn't have any effect on the logic.

> Yes, that's correct.
> 
> >> +err_pm1:
> >> +       pm_runtime_put_sync(dev);
> >> +err_pm2:
> >> +       pm_runtime_disable(dev);
> 
> >> +#define MTK_WMT_CMD_SIZE       (MTK_WMT_HDR_SIZE + MTK_STP_HDR_SIZE + \
> >> +                                MTK_STP_TLR_SIZE + HCI_ACL_HDR_SIZE)
> 
> It would look slightly better if you start on new line like
> #define FOO \
>  (BAR + BAZ)
> 

Thanks for your pointing out. I also found that the macro is not being
used by anyone, it can be removed freely.

> >> +struct mtk_stp_hdr {
> >> +       __u8 prefix;
> >> +       __u8 dlen1:4;
> >> +       __u8 type:4;
> 
> >> +       __u8 dlen2:8;
> 
> u8 already 8 bit.
> 

the superfluous :8 for dlen2 will be removed

> >> +       __u8 cs;
> >> +} __packed;
> 


