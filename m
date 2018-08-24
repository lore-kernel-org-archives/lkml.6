Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0B421477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0B421477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeHXWKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:10:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56470 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeHXWKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:10:04 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3AFD2CEF96;
        Fri, 24 Aug 2018 20:41:22 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v1 0/2] Fix for proto races in hci_serdev.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180822120412.20285-1-bgodavar@codeaurora.org>
Date:   Fri, 24 Aug 2018 20:34:16 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F6273EAE-0EC0-4E4F-B8A1-FF8A57DB116D@holtmann.org>
References: <20180822120412.20285-1-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> In recent testing we found that while removing hci_uart, we have seen
> execution of hci_uart_write_work() after calling vendor specific
> proto close. As we are freeing the vendor specific Tx and Rx buffers
> in vendor close, execution of functions i.e. Rx or Tx functions may cause
> a crash.
> 
> we already have a commit for hci_ldisc.c "e508e6026b19" and "048e1bd3a27f"
> to overcome the race condition.
> 
> Changes of v1:
> 
>  * clearing flag HCI_UART_PROTO_READY while mnodule deinit such that
>    we will not have any tractions further on Tx or Rx.
>  * added check of HCI_UART_PROTO_READY while dequeuing an packet.
> 
> 
> Balakrishna Godavarthi (2):
>  Bluetooth: hci_serdev: clear HCI_UART_PROTO_READY to avoid closing
>    proto races
>  Bluetooth: hci_serdev: Add protocol check in hci_uart_dequeue().
> 
> drivers/bluetooth/hci_serdev.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

