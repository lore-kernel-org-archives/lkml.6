Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F198C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A43621738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfA1MZQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:25:16 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41663 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1MZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:25:15 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 014A5CF2B7;
        Mon, 28 Jan 2019 13:33:01 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] Bluetooth: btrtl: Restore old logic to assume firmware
 is already loaded
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190127083359.17833-1-kai.heng.feng@canonical.com>
Date:   Mon, 28 Jan 2019 13:25:12 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <01926B42-A666-4C3C-A5EB-53EE4AD92EE8@holtmann.org>
References: <20190127083359.17833-1-kai.heng.feng@canonical.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

> Realtek bluetooth may not work after reboot:
> [   12.446130] Bluetooth: hci0: RTL: rtl: unknown IC info, lmp subver a99e, hci rev 826c, hci ver 0008
> 
> This is a regression introduced by commit 26503ad25de8 ("Bluetooth:
> btrtl: split the device initialization into smaller parts"). The new
> logic errors out early when no matching IC info can be found, in this
> case it means the firmware is already loaded.
> 
> So let's assume the firmware is already loaded when we can't find
> matching IC info, like the old logic did.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201921
> Fixes: 26503ad25de8 ("Bluetooth: btrtl: split the device initialization into smaller parts")
> Cc: stable@vger.kernel.org # 4.19+
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> drivers/bluetooth/btrtl.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

