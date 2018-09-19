Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC144C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573552146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573552146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbeISItx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbeISItx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:49:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E82288302;
        Wed, 19 Sep 2018 03:14:06 +0000 (UTC)
Received: from localhost (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98DA060851;
        Wed, 19 Sep 2018 03:14:02 +0000 (UTC)
Date:   Tue, 18 Sep 2018 20:14:01 -0700 (PDT)
Message-Id: <20180918.201401.955097214067299890.davem@redhat.com>
To:     antoine.tenart@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net] net: mvpp2: fix a txq_done race condition
From:   David Miller <davem@redhat.com>
In-Reply-To: <20180918145847.11318-1-antoine.tenart@bootlin.com>
References: <20180918145847.11318-1-antoine.tenart@bootlin.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 19 Sep 2018 03:14:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Tue, 18 Sep 2018 16:58:47 +0200

> When no Tx IRQ is available, the txq_done() routine (called from
> tx_done()) shouldn't be called from the polling function, as in such
> case it is already called in the Tx path thanks to an hrtimer. This
> mostly occurred when using PPv2.1, as the engine then do not have Tx
> IRQs.
> 
> Fixes: edc660fa09e2 ("net: mvpp2: replace TX coalescing interrupts with hrtimer")
> Reported-by: Stefan Chulski <stefanc@marvell.com>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied and queued up for -stable.
