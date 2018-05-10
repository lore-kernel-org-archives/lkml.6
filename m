Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756703AbeEJGpx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 02:45:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22757 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753497AbeEJGpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 02:45:51 -0400
X-UUID: 3d9d347426f341eeb08de49e37d37b2b-20180510
Message-ID: <1525934741.18877.38.camel@mtkswgap22>
Subject: Re: [PATCH v1 6/7] Bluetooth: hci_mediatek: Add protocol support
 for MediaTek serial devices
From: Sean Wang <sean.wang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Thu, 10 May 2018 14:45:41 +0800
In-Reply-To: <6033F916-F103-4F07-9912-695B5B49F30F@holtmann.org>
References: <cover.1522736996.git.sean.wang@mediatek.com>
         <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
         <A7391E5D-2945-415B-8AB1-8DFBF2E65878@holtmann.org>
         <1525762084.14468.20.camel@mtkswgap22>
         <D474053D-6910-4B04-8B98-59B96FEB86BC@holtmann.org>
         <1525767775.18877.22.camel@mtkswgap22>
         <6033F916-F103-4F07-9912-695B5B49F30F@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-08 at 13:18 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> >>>>> +

[ ... ]

> > 
> > I'm happy to do with btmon. just the environment with buildroot the BT
> > running on seems there's a missing support for btmon. I can start to use
> > btmon once I change the environment to Debian.
> > 
> >> So all the MTK vendor commands respond with a vendor event? Or are there some that do the standard command status/complete handling?
> >> 
> > 
> > yes, mtk controller after mt7622 (included), its MTK vendors command
> > (opcode 0xfc6f) always respond with a vendor event id 0xe4. And they
> > don't do any standard status/complete handling.


> then we need to figure out where the __hci_cmd_sync_ev causes a problem. Since normally that should just work for you.
> 

Okay. I will look into more about the issue after I finished the v2
based on btuart driver. By the way, I've ported the btmon to my board,
these vendor commands/events reported via btmon looks like below shown
up

> HCI Event: Unknown (0xe4) plen 5
 [hci0] 11.213593
        02 01 01 00 00                                   .....

> HCI Event: Unknown (0xe4) plen 5
 [hci0] 11.214272
        02 01 01 00 00                                   .....

< HCI Command: Vendor (0x3f|0x006f) plen 5
 [hci0] 11.214318
        01 07 01 00 04                                   .....

> HCI Event: Unknown (0xe4) plen 5
 [hci0] 11.214438
        02 07 01 00 00                                   .....

< HCI Command: Vendor (0x3f|0x006f) plen 6
 [hci0] 13.229379
        01 06 02 00 00 01                                ......

> HCI Event: Unknown (0xe4) plen 5
 [hci0] 13.307729
        02 06 01 00 00                                   .....


> > BTW, mtk controller before mt7622, such as mt7623, its MTK vendor
> > command always go with completely specific format, not with hci format.
> 
> What does that mean? Do you have an example?
> 

what I meant is that these vendor commands and events applied on old
SoCs prior to MT7622 always use completely proprietary format rather
than any BT packet to setup the BT controller.

for example:
- vendor command 
01 06 02 00 00 01 

- vendor event
02 06 01 00 00

> Regards
> 
> Marcel
> 
