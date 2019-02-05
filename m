Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE4AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361802175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfBENzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:55:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:34410 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBENzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:55:52 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id B5495CF26A;
        Tue,  5 Feb 2019 15:03:40 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3 0/2] Bluetooth: Add NULL check for tiocmget() and
 tiocmset()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <cover.1549346039.git.mhjungk@gmail.com>
Date:   Tue, 5 Feb 2019 14:55:50 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0D421861-FCD6-4AFF-8A0F-DBEE520DB64B@holtmann.org>
References: <cover.1549346039.git.mhjungk@gmail.com>
To:     Myungho Jung <mhjungk@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Myungho,

> tiocmget() and tiocmset() operations are optional and some tty drivers
> like pty miss the operations. Add NULL checks to prevent from
> dereference.
> 
> Myungho Jung (2):
>  Bluetooth: hci_ath: Add NULL check for tiocmget() and tiocmset() in
>    ath_setup()
>  Bluetooth: hci_ldisc: Add NULL check for tiocmget() and tiocmset() in
>    hci_uart_set_flow_control()
> 
> drivers/bluetooth/hci_ath.c   | 6 ++++++
> drivers/bluetooth/hci_ldisc.c | 4 ++++
> 2 files changed, 10 insertions(+)

why are we not enforcing the availability of these in the hci_uart_tty_open?

Regards

Marcel

