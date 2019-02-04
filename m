Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066D6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7D9214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfBDOxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:53:21 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39391 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfBDOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:53:20 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id A2062CF173;
        Mon,  4 Feb 2019 16:01:06 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: Fix decrementing reference count twice in
 releasing socket
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190203005634.GA19908@myunghoj-Precision-5530>
Date:   Mon, 4 Feb 2019 15:53:16 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <131B7D29-1085-4DDC-8DC9-A2ABE533BEC4@holtmann.org>
References: <20190203005634.GA19908@myunghoj-Precision-5530>
To:     Myungho Jung <mhjungk@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Myungho,

> When releasing socket, it is possible to enter hci_sock_release() and
> hci_sock_dev_event(HCI_DEV_UNREG) at the same time in different thread.
> The reference count of hdev should be decremented only once from one of
> them but if storing hdev to local variable in hci_sock_release() before
> detached from socket and setting to NULL in hci_sock_dev_event(),
> hci_dev_put(hdev) is unexpectedly called twice. This is resolved by
> referencing hdev from socket after bt_sock_unlink() in
> hci_sock_release().
> 
> Reported-by: syzbot+fdc00003f4efff43bc5b@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
> net/bluetooth/hci_sock.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

