Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeEVIFc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:05:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16882 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751173AbeEVIF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:05:28 -0400
X-UUID: d5ec1e41e4d84482a8e978fbd1ce0f97-20180522
Message-ID: <1526976323.18877.47.camel@mtkswgap22>
Subject: Re: [PATCH v2 4/7] Bluetooth: Add new quirk for non-persistent
 setup settings
From: Sean Wang <sean.wang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Tue, 22 May 2018 16:05:23 +0800
In-Reply-To: <920B3BE9-3FE8-4AC6-8C5F-63B0E00182AC@holtmann.org>
References: <cover.1526374087.git.sean.wang@mediatek.com>
         <1d6097f538b3182b2876ad48225ecd6e2d1b128c.1526374087.git.sean.wang@mediatek.com>
         <920B3BE9-3FE8-4AC6-8C5F-63B0E00182AC@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-22 at 09:21 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 

[ ... ]

> > -	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
> > +	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
> > +	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> > 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> 
> I am not 100% sure that we want to send the HCI_DEV_SETUP event also multiple times. That is a userspace change that I would need to think about. We need to check create_monitor_event() and see what the btmon trace for this looks like. Can you send me a btmon -w trace.log when this change is active.
> 
> Regards
> 
> Marcel
> 

Sure, I'll send you the trace.log with the change is active.

	Sean
