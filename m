Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ACCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C968D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfARJTo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:19:44 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50823 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfARJTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:19:43 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3AAC7CF2C3;
        Fri, 18 Jan 2019 10:27:28 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: hci_uart: Add a local variable to store the
 result of h4_recv_buf()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190111065514.GA26542@myunghoj-Precision-5530>
Date:   Fri, 18 Jan 2019 10:19:41 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <09FCB21A-2184-4CDB-8BF0-75C403DF39F9@holtmann.org>
References: <20190111065514.GA26542@myunghoj-Precision-5530>
To:     Myungho Jung <mhjungk@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Myungho,

> In h4_recv(), if h4_recv_buf() returns error and h4_recv() is
> asynchronously called again before setting rx_skb to NULL, ERR_PTR will
> be dereferenced in h4_recv_buf(). Check return value in a local variable
> before writing to rx_skb.
> 
> Reported-by: syzbot+017a32f149406df32703@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
> drivers/bluetooth/hci_h4.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Can you actually fix all callers of h4_recv_buf since they all suffer from the same issue.

Regards

Marcel

