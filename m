Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62798C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9E8218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfBFHG5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:06:57 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45660 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFHG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:06:56 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2900DCF2A4;
        Wed,  6 Feb 2019 08:14:45 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3 0/2] Bluetooth: Add NULL check for tiocmget() and
 tiocmset()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190206063533.GA7402@myunghoj-Precision-5530>
Date:   Wed, 6 Feb 2019 08:06:54 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <AD78221A-2ABE-4BC2-A63A-F706FD5BC2FE@holtmann.org>
References: <cover.1549346039.git.mhjungk@gmail.com>
 <0D421861-FCD6-4AFF-8A0F-DBEE520DB64B@holtmann.org>
 <20190206063533.GA7402@myunghoj-Precision-5530>
To:     Myungho Jung <mhjungk@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Myungho,

>>> tiocmget() and tiocmset() operations are optional and some tty drivers
>>> like pty miss the operations. Add NULL checks to prevent from
>>> dereference.
>>> 
>>> Myungho Jung (2):
>>> Bluetooth: hci_ath: Add NULL check for tiocmget() and tiocmset() in
>>>   ath_setup()
>>> Bluetooth: hci_ldisc: Add NULL check for tiocmget() and tiocmset() in
>>>   hci_uart_set_flow_control()
>>> 
>>> drivers/bluetooth/hci_ath.c   | 6 ++++++
>>> drivers/bluetooth/hci_ldisc.c | 4 ++++
>>> 2 files changed, 10 insertions(+)
>> 
>> why are we not enforcing the availability of these in the hci_uart_tty_open?
> 
> Are the operations required on any HCI UART drivers? For now, I found only 5
> drivers (ath, bcm, intel, mrvl, and qca) are explicitly calling them. So, I'm
> not sure whether it breaks any existing code with other drivers if returning
> error in open().

the H:4 spec requires setting flow control. In some cases this is done by the hciattach or btattach utility, but it still means that it is required. So failing on TTYs that don’t support it is just fine.

Regards

Marcel

