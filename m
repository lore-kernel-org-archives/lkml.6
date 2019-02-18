Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D965F214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfBRMzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:55:33 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51072 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBRMzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:55:32 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5602BCF2C7;
        Mon, 18 Feb 2019 14:03:24 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Initialize hci_dev before open()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190206175416.4627-1-jcline@redhat.com>
Date:   Mon, 18 Feb 2019 13:55:30 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+257790c15bcdef6fe00c@syzkaller.appspotmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <37BAD6CD-1A0C-4DF2-95E0-2D75D7A75DB8@holtmann.org>
References: <20190206175416.4627-1-jcline@redhat.com>
To:     Jeremy Cline <jcline@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

> The hci_dev struct hdev is referenced in work queues and timers started
> by open() in some protocols. This creates a race between the
> initialization function and the work or timer which can result hdev
> being dereferenced while it is still null.
> 
> The syzbot report contains a reliable reproducer which causes a null
> pointer dereference of hdev in hci_uart_write_work() by making the
> memory allocation for hdev fail.
> 
> To fix this, ensure hdev is valid from before calling a protocol's
> open() until after calling a protocol's close().
> 
> Reported-by: syzbot+257790c15bcdef6fe00c@syzkaller.appspotmail.com
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 21 ++++++++++++++-------
> 1 file changed, 14 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

