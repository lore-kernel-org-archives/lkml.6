Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F29CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF792084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfAVItV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:49:21 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40814 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfAVItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:49:19 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6ABC9CEEB3;
        Tue, 22 Jan 2019 09:57:03 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: hci_uart: Check if socket buffer is ERR_PTR in
 h4_recv_buf()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190122083323.GA22508@myunghoj-Precision-5530>
Date:   Tue, 22 Jan 2019 09:49:15 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F686949E-7FDE-4AE1-8021-CA024E89A9A0@holtmann.org>
References: <20190122083323.GA22508@myunghoj-Precision-5530>
To:     Myungho Jung <mhjungk@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Myungho,

> h4_recv_buf() callers store the return value to socket buffer and
> recursively pass the buffer to h4_recv_buf() without protection. So,
> ERR_PTR returned from h4_recv_buf() can be dereferenced, if called again
> before setting the socket buffer to NULL from previous error. Check if
> skb is ERR_PTR in h4_recv_buf().
> 
> Reported-by: syzbot+017a32f149406df32703@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
> drivers/bluetooth/h4_recv.h | 4 ++++
> drivers/bluetooth/hci_h4.c  | 4 ++++
> 2 files changed, 8 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

