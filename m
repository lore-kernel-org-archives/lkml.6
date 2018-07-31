Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046E8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A852E20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A852E20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbeGaSoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:44:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54718 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbeGaSoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:44:30 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D9258108D56E1;
        Tue, 31 Jul 2018 10:03:16 -0700 (PDT)
Date:   Tue, 31 Jul 2018 10:03:16 -0700 (PDT)
Message-Id: <20180731.100316.237748978913578486.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        makita.toshiaki@lab.ntt.co.jp
Subject: Re: [PATCH net-next 1/2] virtio-net: correctly update XDP_TX
 counters
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 31 Jul 2018 10:03:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 Jul 2018 17:43:38 +0800

> Commit 5b8f3c8d30a6 ("virtio_net: Add XDP related stats") tries to
> count TX XDP stats in virtnet_receive(). This will cause several
> issues:
> 
> - virtnet_xdp_sq() was called without checking whether or not XDP is
>   set. This may cause out of bound access when there's no enough txq
>   for XDP.
> - Stats were updated even if there's no XDP/XDP_TX.
> 
> Fixing this by reusing virtnet_xdp_xmit() for XDP_TX which can counts
> TX XDP counter itself and remove the unnecessary tx stats embedded in
> rx stats.
> 
> Reported-by: syzbot+604f8271211546f5b3c7@syzkaller.appspotmail.com
> Fixes: 5b8f3c8d30a6 ("virtio_net: Add XDP related stats")
> Cc: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied.
