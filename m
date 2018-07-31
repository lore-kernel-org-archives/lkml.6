Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC417C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2820844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD2820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbeGaTB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:01:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51211 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729636AbeGaTB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:01:59 -0400
X-UUID: e408040b80bb4ac29565c482f6e376c4-20180801
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 870809930; Wed, 01 Aug 2018 01:20:29 +0800
Received: from MTKMBS06N2.mediatek.inc (172.21.101.130) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 1 Aug 2018 01:20:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 1 Aug 2018 01:20:28 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 1 Aug 2018 01:20:28 +0800
Message-ID: <1533057628.3472.99.camel@mtkswgap22>
Subject: Re: [PATCH v6 3/4] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 1 Aug 2018 01:20:28 +0800
In-Reply-To: <F3DB341C-1C80-49EA-A99E-836C34C5DC06@holtmann.org>
References: <cover.1532060309.git.sean.wang@mediatek.com>
         <f3a064f86c1da4664a231a40c6cf038cccc758da.1532060309.git.sean.wang@mediatek.com>
         <60024004-779E-4E1A-8E1B-799339595A27@holtmann.org>
         <1532966985.3472.54.camel@mtkswgap22>
         <F83B6E35-B0D7-4050-A112-251BDFB9C998@holtmann.org>
         <1533028552.3472.95.camel@mtkswgap22>
         <F3DB341C-1C80-49EA-A99E-836C34C5DC06@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 12:32 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> >>> All suggestions seem reasonable for me in order to make code style aligned with the other drivers and code better to read,
> >>> and it looks like no any big problem, so I'll start to work on the next version immediately.
> >> 
> >> no rush, but if you can get this back to me quickly, we might be still able to get this driver included.
> >> 
> >>> And I also add a few explanations inline about questions about the diagnostic packet and how hci->shutdown is being made.
> >>> 
> >>> On Mon, 2018-07-30 at 15:40 +0200, Marcel Holtmann wrote:
> > 
> > 
> > [ ... ]
> > 
> >>>> Do we want these as HCI vendor events. Or actually as vendor / diagnostic packets. There is a hci_recv_diag.
> >>>> 
> >>> 
> >>> These are actually Hci vendor events. not for diagnostic purpose. They hdr->evt == 0xe4 are all the part of chip initialization.
> >> 
> >> Ok, then leave it as is.
> >> 
> >>> 
> >>>> So let me ask this a different way, do you have support for LMP / LL tracing in your chips? If yes, then how is that enabled and how does it work? Or any general debug data that can be switched on. That is what we have a diagnostic channel for that is also fed into btmon.
> >>>> 
> >>> 
> >>> I'm not really sure about them because I didn't see any diagnostic packets handling in vendor driver.
> >> 
> >> You can see examples for this in btusb.c, hci_bcm.c and bpa10x.c where the hardware has a side channel. In case of Broadcom, they are LL or LMP trace packets, but it could be also debug messages or something else. Other vendors use HCI vendor events for that which is also fine. Just wanted to know what it is.
> >> 
> >> And if your hardware supports LL or LMP traces to be enabled, then implement hdev->set_diag() callback. You can then enable it via /sys/kernel/debug/bluetooth/hci0/vendor_diag
> >> 
> > 
> > Thanks for sharing the information to me.
> > 
> > If I get the permission and details about adding support for these debug trace packets, I am willing to add them.
> > 
> >>> 
> >>>>> +
> >>>>> +	/* Each HCI event would go through the core. */
> >>>>> +	return hci_recv_frame(hdev, skb);
> >>>>> +}
> >>>>> +
> > 
> > [ ... ]
> > 
> >>>>> +
> >>>>> +static int mtk_btuart_shutdown(struct hci_dev *hdev)
> >>>>> +{
> >>>>> +	struct mtk_btuart_dev *bdev = hci_get_drvdata(hdev);
> >>>>> +	struct device *dev = &bdev->serdev->dev;
> >>>>> +	u8 param = 0x0;
> >>>>> +
> >>>>> +	/* Disable the device. */
> >>>>> +	mtk_hci_wmt_sync(hdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param), &param);
> >>>>> +
> >>>>> +	/* Shutdown the clock and power domain the device requires. */
> >>>>> +	clk_disable_unprepare(bdev->clk);
> >>>>> +	pm_runtime_put_sync(dev);
> >>>>> +	pm_runtime_disable(dev);
> >>>> 
> >>>> Don’t these belong into ->close method? And the enable ones into ->open? I really think that ->setup and ->shutdown should just do HCI commands and leave the others to ->open and ->close. Since ->open and ->close are suppose to set up and terminate the transport.
> >>>> 
> >>> 
> >>> Yes, ->open and ->close are already done just for setup and terminate the transport. I've noted the part during earlier version discussion. 
> >>> 
> >>> Because mt7622 is a SoC integrating Bluetooth hardware inside, these operations for clk* and pm clk_* and pm_*  you saw here are all for controlling clocks and powers Bluetooth circuits requires on the SoC, not for the transports.
> >>> 
> >>> As for clocks for the transport, they're already being taken care of by the serial driver.
> >> 
> >> With transport, I meant the Bluetooth transport. So I really thing they belong into ->open and ->close. Within ->setup and ->shutdown, I would just expect HCI commands.
> >> 
> > 
> > At the moment, it's not easy that clk_* and pm_*  are moved to ->open and ->close
> > 
> > because firmware download would depend on the full cycle of hardware power down and then up.
> > 
> > And another advantage is that when users call hdev down and the up, the device can do the real hardware reset, not just the software reset via hci command.
> 
> But when you call down/up cycle, then you will go through ->close and ->open. So I don’t see the problem here.
> 
> With the quirk for always calling ->setup, you get the ->open + ->setup on hdev up and ->shutdown + ->close on hdev down.
> 

Yes, it seems no any problem. really thanks point out me with patience

So I've moved these clk_* and pm_* operations into ->open and ->close in newer v7.

> Regards
> 
> Marcel
> 


