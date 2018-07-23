Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E313ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8B620779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8B620779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbeGWRHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:07:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59648 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387989AbeGWRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:07:53 -0400
Received: from [192.168.0.117] (188.146.236.198.nat.umts.dynamic.t-mobile.pl [188.146.236.198])
        by mail.holtmann.org (Postfix) with ESMTPSA id C406ECEEB2;
        Mon, 23 Jul 2018 18:12:52 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] bluetooth: btusb: Replace GFP_ATOMIC with GFP_KERNEL in
 inject_cmd_complete()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180723033851.8141-1-baijiaju1990@gmail.com>
Date:   Mon, 23 Jul 2018 18:05:55 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F636E201-BDBC-4D4E-9930-974C40831F03@holtmann.org>
References: <20180723033851.8141-1-baijiaju1990@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jia-Ju,

> inject_cmd_complete() is only called by btusb_send_frame_intel(), 
> which is set to hdev->send, and hdev->send() is never 
> called in atomic context.
> 
> inject_cmd_complete() calls bt_skb_alloc() with GFP_ATOMIC, 
> which is not necessary.
> GFP_ATOMIC can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> I also manually check the kernel code before reporting it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

