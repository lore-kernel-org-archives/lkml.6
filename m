Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 839F8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3701F20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3701F20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932820AbeFLJ6o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:58:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25498 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932639AbeFLJ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:58:41 -0400
X-UUID: 27c43e1bc87f4bc2a83a95aa03e6352f-20180612
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1485087371; Tue, 12 Jun 2018 17:58:38 +0800
Received: from MTKMBS06N1.mediatek.inc (172.21.101.129) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 12 Jun 2018 17:58:36 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 12 Jun 2018 17:58:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 12 Jun 2018 17:58:36 +0800
Message-ID: <1528797516.21593.46.camel@mtkswgap22>
Subject: Re: [PATCH v2 4/7] Bluetooth: Add new quirk for non-persistent
 setup settings
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 12 Jun 2018 17:58:36 +0800
In-Reply-To: <DC3FE66E-C3FD-455F-8592-E927604086CD@holtmann.org>
References: <cover.1526374087.git.sean.wang@mediatek.com>
         <1d6097f538b3182b2876ad48225ecd6e2d1b128c.1526374087.git.sean.wang@mediatek.com>
         <920B3BE9-3FE8-4AC6-8C5F-63B0E00182AC@holtmann.org>
         <1526976323.18877.47.camel@mtkswgap22> <1527057423.4607.3.camel@mtkswgap22>
         <B82BB5F4-E197-4915-A543-C5FF9A5A41F1@holtmann.org>
         <1527084544.4607.8.camel@mtkswgap22>
         <37400FCE-8F9A-433B-8E3A-DE9CBEB469D7@holtmann.org>
         <1527175805.4607.103.camel@mtkswgap22>
         <DC3FE66E-C3FD-455F-8592-E927604086CD@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-30 at 08:26 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> >>>>>> 

[ ... ]

> >>> * Unknown packet (code 14 len 30)                                      0.641509
> >>>       01 00 00 00 02 00 01 0e 00 01 00 00 00 10 62 6c  ..............bl
> >>>       75 65 74 6f 6f 74 68 64 00 00 00 00 00 00        uetoothd......  
> >>> * Unknown packet (code 14 len 30)                                      0.641592
> >>>       02 00 00 00 02 00 01 0e 00 01 00 00 00 10 62 74  ..............bt
> >>>       6d 6f 6e 00 00 00 00 00 00 00 00 00 00 00        mon...........  
> >>> * Unknown packet (code 16 len 7)                                [hci0] 6.536771
> >>>       01 00 00 00 05 00 01                             .......         
> >>> = Open Index: 00:00:46:76:22:01                                 [hci0] 6.717019
> >>> = Index Info: 00:00:46:76:22:01 (MediaTek, Inc.)                [hci0] 6.717030
> >> 
> >> can you try with the latest BlueZ 5.49 or git version. Seems it actually stumbles over the extra packet here. Fun fact is that I can not get a backtrace to pin-point the issue in btmon and why it crashes.
> >> 
> > 
> > I had less experience updating user land BlueZ, but I can try it as possible and see whether Unknown packets still are present at newest version BlueZ. Hopefully I don't misunderstand your point here. 
> 
> please use the latest btmon and check if it can read your trace.
> 

sure, I'll have a try with the latest btmon.

> >>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.741093
> >>>       02 01 01 00 00                                   .....           
> >>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.742088
> >>>       02 01 01 00 00                                   .....           
> >>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.743102
> >>>       02 01 01 00 00                                   .....           


[ ... ]

> >>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.814708
> >>>       02 01 01 00 00                                   .....           
> >>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.815705
> >>>       02 01 01 00 00                                   .....           
> >>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.816378
> >>>       02 01 01 00 00                                   .....           
> >> 
> >> Why do I see only HCI events here? Is this event conveying any useful information. It is kinda complicated that this is 0xe4 event code which is actually reserved for future use by the Bluetooth SIG. Are there any accompanying HCI commands for this and they just not make it into btmon?
> >> 
> > 
> > I have made all vendor HCI commands go through BlueZ core in v2 patch. 
> > 
> > And for these HCI events, they are all corresponding to vendor ACL data, applied only to firmware setup packets, but they're not being sent via BlueZ core, so they are not being logged in btmon.
> > 
> > As for its event, where heading 0xe4 refers to a vendor event and is used on notification of that either vendor ACL data or vendor HCI command have been done.
> 
> I would prefer if everything goes via the Bluetooth core since then we have it all properly scheduled. Sending things down the ACL data path however if kinda funky. Does your hardware accept sending command both via ACL data and as HCI command? If so, then I would prefer sending them as HCI commands since the speed improvement you think you are getting is neglectable on Linux (I have been down that path). This seems to be a pure optimization when Windows is driving the device.
> 

firmware people said the device can support firmware download as HCI commands. According to my test, this way indeed works so I will improve the part in the next version.


> And the vendor event 0xe4 is really only received during firmware download? It is not ever received during normal operation?
> 

0xe4 is only received during chip initialization.

I also thought 0xe4 is a poor definition for vendor event and already have notified firmware people should pick 0xff as its vendor event id in the future.

but for now, unfortunately, 0xe4 cannot be changed on the device, the only way is to add a workaround in RX path as below to allow btmon can recognize these bad events properly. 

int mtk_btuart_hci_frame(struct hci_dev *hdev, struct sk_buff *skb)
{
        struct hci_event_hdr *hdr = (void *)skb->data;

        /* Fix up the vendor event id with HCI_VENDOR_PKT instead of
         * 0xe4 so that btmon can parse the kind of vendor event properly.
         */
        if (hdr->evt == 0xe4)
                hdr->evt = HCI_VENDOR_PKT;

        /* Each HCI event would go through the core. */
        return hci_recv_frame(hdev, skb);
}


> > 
> >> 
> >> 
> >>> < HCI Command: Vendor (0x3f|0x006f) plen 5                      [hci0] 6.816413
> >>>       01 07 01 00 04                                   .....           
> >>>> HCI Event: Unknown (0xe4) plen 5                              [hci0] 6.816536
> >>>       02 07 01 00 00                                   .....           

[ ... ]

> >>>         Encapsulated PDU
> >>>         Erroneous Data Reporting
> >>>         Non-flushable Packet Boundary Flag
> >>>         Link Supervision Timeout Changed Event
> >>>         Inquiry TX Power Level
> >>>         Enhanced Power Control
> >>>         Extended features
> >>> < HCI Command: Read Local Version Info.. (0x04|0x0001) plen 0  [hci0] 10.865987
> >>>> HCI Event: Vendor (0xff) plen 9                              [hci0] 10.866259
> >>>       29 19 09 17 20 48 07 11 00                       )... H…       
> >> 
> >> Is this meant to happen here?
> >> 
> > 
> > If event received is not expected as the specification defines, I think it's probably incorrect.
> > 
> > But it requires more discussion with firmware people to make it clearer.
> 
> Please check and let them decode what this event means.
> 

it's just debugging purpose information listing built-time something
like that and will be removed in the firmware.

> > 
> >>>> HCI Event: Command Complete (0x0e) plen 12                   [hci0] 10.866372
> >>>     Read Local Version Information (0x04|0x0001) ncmd 1
> >>>       Status: Success (0x00)
> >>>       HCI version: Bluetooth 4.2 (0x08) - Revision 4359 (0x1107)
> >>>       LMP version: Bluetooth 4.2 (0x08) - Subversion 2329 (0x0919)
> >>>       Manufacturer: MediaTek, Inc. (70)
> >>> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0               [hci0] 10.866391
> >>>> HCI Event: Command Complete (0x0e) plen 10                   [hci0] 10.866539

[ ... ]

> >>>         LE Add Device To Resolving List (Octet 34 - Bit 3)
> >>>         LE Remove Device From Resolving List (Octet 34 - Bit 4)
> >>>         LE Clear Resolving List (Octet 34 - Bit 5)
> >>>         LE Read Resolving List Size (Octet 34 - Bit 6)
> >>>         LE Read Peer Resolvable Address (Octet 34 - Bit 7)
> >>>         LE Read Local Resolvable Address (Octet 35 - Bit 0)
> >>>         LE Set Address Resolution Enable (Octet 35 - Bit 1)
> >>>         LE Set Resolvable Private Address Timeout (Octet 35 - Bit 2)
> >>>         LE Read Maximum Data Length (Octet 35 - Bit 3)
> >>>         Octet 35 - Bit 4 
> >>>         Octet 35 - Bit 5 
> >>>         Octet 35 - Bit 6 
> >>>         Octet 35 - Bit 7 
> >>>         Octet 36 - Bit 0 
> >> 
> >> So you support the PHY commands, but do not indicate support LE 2M or LE Coded? Also these are Bluetooth 5.0 commands.
> >> 
> > 
> > To be honest. When I ported the device into Bluez core, a unexpected event for LE read local feature would cause a fail at Bluez core, so I made a hack on Bluez core  
> > 
> > to allow that I can keeping bring up the device without be blocked by the issue most probably from firmware.
> > 
> > Below code snippet is the only thing I added to avoid a fail at Bluez core to bring up the device.
> > 
> > @@ -927,6 +927,8 @@ static void hci_cc_le_read_local_features(struct hci_dev *hdev,
> >                return;
> > 
> >        memcpy(hdev->le_features, rp->features, 8);
> > +       hdev->le_features[0] = 0;
> > +       hdev->le_features[1] = 0;
> > }
> 
> Send me the trace where you didn’t clear the feature bits and I check what is going on. I doubt that we have a bug, but maybe some of the commands are optional and we should add an appropriate check. Or you guys need to fix your firmware. A new btmon should decode all bits properly.
> 

okay, I'll have a follow-up.

> Regards
> 
> Marcel
> 


