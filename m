Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbeEWMbh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:31:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47700 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbeEWMbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:31:34 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v2 4/7] Bluetooth: Add new quirk for non-persistent setup
 settings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1527057423.4607.3.camel@mtkswgap22>
Date: Wed, 23 May 2018 14:31:30 +0200
Cc: Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B82BB5F4-E197-4915-A543-C5FF9A5A41F1@holtmann.org>
References: <cover.1526374087.git.sean.wang@mediatek.com>
 <1d6097f538b3182b2876ad48225ecd6e2d1b128c.1526374087.git.sean.wang@mediatek.com>
 <920B3BE9-3FE8-4AC6-8C5F-63B0E00182AC@holtmann.org>
 <1526976323.18877.47.camel@mtkswgap22> <1527057423.4607.3.camel@mtkswgap22>
To: Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

>> 
>> [ ... ]
>> 
>>>> -	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
>>>> +	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
>>>> +	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>>>> 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
>>> 
>>> I am not 100% sure that we want to send the HCI_DEV_SETUP event also multiple times. That is a userspace change that I would need to think about. We need to check create_monitor_event() and see what the btmon trace for this looks like. Can you send me a btmon -w trace.log when this change is active.
>>> 
>>> Regards
>>> 
>>> Marcel
>>> 
>> 
>> Sure, I'll send you the trace.log with the change is active.
>> 
>> 	Sean
>> 
> 
> 
> Attached trace.log was captured when I inputted commands power on and
> then off in bluetoothctl.

the trace.log is somehow mangled. Something is not fully correct. Can you read it with btmon -r trace.log?

Regards

Marcel
