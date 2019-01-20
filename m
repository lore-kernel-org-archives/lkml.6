Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC26C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1139520883
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfATAHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 19:07:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59474 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfATAHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 19:07:24 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 767BE14BEE7E3;
        Sat, 19 Jan 2019 16:07:23 -0800 (PST)
Date:   Sat, 19 Jan 2019 16:07:23 -0800 (PST)
Message-Id: <20190119.160723.1130861899371541485.davem@davemloft.net>
To:     mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] virtio_net: bulk free tx skbs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190118041842.24067-1-mst@redhat.com>
References: <20190118041842.24067-1-mst@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 19 Jan 2019 16:07:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 17 Jan 2019 23:20:07 -0500

> Use napi_consume_skb() to get bulk free.  Note that napi_consume_skb is
> safe to call in a non-napi context as long as the napi_budget flag is
> correct.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thanks.
