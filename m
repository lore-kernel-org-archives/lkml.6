Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC1C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24474216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24474216F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeHHKWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:22:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24438 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726979AbeHHKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:22:45 -0400
X-UUID: 2de9851ef25e41aba5ef103b9622d11c-20180808
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1061670563; Wed, 08 Aug 2018 16:04:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 8 Aug 2018 16:04:07 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 8 Aug 2018 16:04:07 +0800
Message-ID: <1533715447.3472.251.camel@mtkswgap22>
Subject: Re: [PATCH v7 2/3] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 8 Aug 2018 16:04:07 +0800
In-Reply-To: <8AF72CFC-4978-42AD-8ECC-752EB137DD2A@holtmann.org>
References: <cover.1533056925.git.sean.wang@mediatek.com>
         <c92ed10cf16f36d9a3b390e864af92e2dfe7b771.1533056925.git.sean.wang@mediatek.com>
         <1707FFA1-A294-4A95-A3BF-0910CE455232@holtmann.org>
         <1533192799.3472.122.camel@mtkswgap22>
         <FF45A90A-F9F1-47CB-AB1F-1E92BF587FBE@holtmann.org>
         <1533199720.3472.136.camel@mtkswgap22>
         <9526E5D9-50BA-4D57-80F5-083DB7D28AFE@holtmann.org>
         <1533205495.3472.144.camel@mtkswgap22>
         <A6D48D49-52CE-405D-8C5D-C4D54CE67221@holtmann.org>
         <1533303749.3472.160.camel@mtkswgap22>
         <D2336CD2-B69B-4B5B-8125-F0CAD29E3243@holtmann.org>
         <1533319214.3472.187.camel@mtkswgap22>
         <7A3537C5-5940-45AD-AB80-77418CCFE130@holtmann.org>
         <1533652445.3472.230.camel@mtkswgap22>
         <8AF72CFC-4978-42AD-8ECC-752EB137DD2A@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-07 at 17:54 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> >>>> this is even more hackish since the __hci_cmd_sync_ev command is really meant to get a cmd status first before waiting for that event.
> >>>> 
> >>> 
> >>> Understood.
> >>> 
> >>> I've stopped the hack in v8. could we merge v8 first ? and then I will a fix up with __hci_raw_sync_ev that uses the hdev->raw_q instead of __hci_cmd_sync_ev in TODO.
> >> 
> >> so I looked into this a bit more. We actually added __hci_cmd_send for a Qualcomm firmware loader that was doing something similar. So instead of trying to add a yet another command to the core, I actually used that and implemented the wait for vendor event in the driver.
> >> 
> >> You will see my v9 on the mailing list. I also did a bunch of cosmetic minor cleanup and spelling correction. Please test this version. I also make __le16 dlen instead of dlen1 + dlen2 since I think that is what your hardware does.
> > 
> > Only one thing needs to be corrected in v9. that is __be16 is required instead of dlen1 + dlen2. I will fix it up in v10 and the other changes all look good to me.
> > 
> >> If this version of the driver works for you then I am happy to merge it. You can then add support for hdev->set_bdaddr and hdev->set_diag in later patches. I also like to clean up the STP receive handler since it can be done a lot simpler and smaller, but that has to wait.
> >> 
> > 
> > hopefully v10 also can be merged :)
> 
> send me a v10 and I can merge it.
> 
> > I will investigate more about how to add ->set_bdaddr, ->set_diag and STP receive enhancement in later patches.
> > 
> > but so far I have not much idea about how to make STP multiplexer be a independent driver.
> > 
> > my thought is that it would be really better and cleaner a chain of serdev is be used as the base of mtkbtuart. something like
> > 
> > 8250 serial bus <----> STP multiplexer serdev <----> mtkbtuart serdev
> > 
> > however, STP multiplexer serdev is not a real device, that doesn't no request any resource. I think it should not be allowed to be added in a device tree and even in dt-binding document.
> 
> Before we do that, lets get a cleaner parser for it. I just don’t have enough time to wrap my head around this one yet.
> 
> >>>> Are all Mediatek vendor commands this way? Or just the ones for loading the firmware? So only the WMT ones?
> >>>> 
> >>> 
> >>> Only the WMT ones, WMT commands/events are usually used in system controlling, for example, global function on/off, firmware download, reset and so on. most only appear on device initialization
> >> 
> >> Since you never checked the result of the vendor event, I opted for just signaling that it arrived. If they can report success or failure, we need to add some extra code for that.
> >> 
> > 
> > I will consider more WMT event status when I add more Bluetooth devices such as MT7668U usb based Bluetooth which I plan to add the support in later patches in the next weeks 
> 
> Are the USB ones also using STP or are they H:2 based like all the others. What are prominent MT7668U based ones that I could buy?
> 
1.
USB ones don't use any STP framing, which is totally dedicated to the
serial based device.

I don't exactly know what the term H:2 means you mentioned here. I only
know the btusb driver can be reused for M7668U and just only one weird
thing to solve in btusb driver. That is HCI WMT event coming through
control in pipe, not through interrupt pipe :(

And as for the others generic hci/acl/sco data, they all work well as
btusb usually work. I will show you the code to let you exactly know
what I'm meaning instead of just talking :)

2.
Another thing is I think it's better if the core layer can support
__hci_raw_sync_ev-like APIs to allow each transport driver not to care
the details about cmd/event synchronization. If it can be done in this
way, that helps to help WMT cmd/event handling can be put into a
commonplace to allow btmtkuart and btusb for mtk port to have the same
codeshare.

3. 
MT7668U should always be bundled with CE product, I am not really sure
whether it is easy to get from the retailer. Or you really like to want
a sample, maybe I can try to contact with internal people to make it
happen.

	Sean

> Regards
> 
> Marcel
> 


