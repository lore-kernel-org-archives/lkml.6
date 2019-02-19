Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7D9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5032A2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfBSVNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:13:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:28115 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725829AbfBSVNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:13:35 -0500
X-UUID: c147d20144254d9da419c9643ce8f7e5-20190220
X-UUID: c147d20144254d9da419c9643ce8f7e5-20190220
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1704607133; Wed, 20 Feb 2019 05:13:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 05:13:22 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 05:13:22 +0800
Message-ID: <1550610802.8245.1.camel@mtkswgap22>
Subject: Re: [PATCH 0/6]Bluetooth: mediatek: add support for MediaTek
 MT7663U and MT7668U UART devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 20 Feb 2019 05:13:22 +0800
In-Reply-To: <B7EBA86E-B6C2-4301-BA01-004EA83A50A9@holtmann.org>
References: <cover.1550184473.git.sean.wang@mediatek.com>
         <B7EBA86E-B6C2-4301-BA01-004EA83A50A9@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 98A3CAF5D64E85FAF0BAE40E263515CF4456794E36B4038D6C812BCE94E377172000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

I will follow it up. Thank for your help!

	Sean


On Mon, 2019-02-18 at 14:10 +0100, Marcel Holtmann wrote:
> Hi Sean,
> 
> > This adds the support of enabling MT7668U and MT7663U UART based Bluetooth
> > function running on the top of btmtkuart driver.
> > 
> > We are through several patches to reach the goal and also wish applied
> > the same flow in MediaTek btusb [1] for the transport independence.
> > Once [1] and the series is being merged and then in next step I will
> > consider to add a btmtk.c to hold these independent operations among
> > various transport reused by MediaTek UART, USB and SDIO-based Bluetooth.
> > 
> > Firstly,
> > in patch 1/6 to update the dt-binding document for the kind of devices.
> > in patch 2/6, 3/6 to fix the common error issues in the current code.
> > in Patch 4/6, 5/6 to add the general flow which MT7622 and even MT7663U and
> > MT7668U USB devices also utilize.
> > 
> > Finally, in patch 6/6 to add the specific setups for MediaTek UART-based
> > Bluetooth and enable MT7663U and MT7668U device.
> > 
> > [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html 
> > 
> > Sean Wang (6):
> >  dt-bindings: net: bluetooth: add support for MediaTek MT7663U and
> >    MT7668U UART devices
> >  Bluetooth: mediatek: trivial typo fix
> >  Bluetooth: mediatek: fix up an error path to restore bdev->tx_state
> >  Bluetooth: mediatek: pass a pointer to mtk_hci_wmt_sync
> >  Bluetooth: mediatek: update the common setup between MT7622 and other
> >    devices
> >  Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART
> >    devices
> > 
> > .../bindings/net/mediatek-bluetooth.txt       |  64 +++
> > drivers/bluetooth/btmtkuart.c                 | 538 ++++++++++++++++--
> > 2 files changed, 569 insertions(+), 33 deletions(-)
> 
> please re-send 1/6 and 6/6 when the DT changes are ACKed by Rob.
> 
> Regards
> 
> Marcel
> 


