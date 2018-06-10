Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wkN/L7x7HVvSXwAAmS7hNA
	; Sun, 10 Jun 2018 19:27:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B285D60795; Sun, 10 Jun 2018 19:27:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3F9726070A;
	Sun, 10 Jun 2018 19:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F9726070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753766AbeFJT1y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 15:27:54 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41374 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753721AbeFJT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 15:27:53 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 84C35136AA24D;
        Sun, 10 Jun 2018 12:27:52 -0700 (PDT)
Date: Sun, 10 Jun 2018 12:27:52 -0700 (PDT)
Message-Id: <20180610.122752.586267370739308245.davem@davemloft.net>
To: jasowang@redhat.com
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost_net: remove VHOST_NET_F_VIRTIO_NET_HDR
 support
From: David Miller <davem@davemloft.net>
In-Reply-To: <1528429842-22835-1-git-send-email-jasowang@redhat.com>
References: <1528429842-22835-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 10 Jun 2018 12:27:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Jun 2018 11:50:42 +0800

> This feature bit is duplicated with VIRTIO_F_ANY_LAYOUT, this means if
> a userpsace want to enable VRITIO_F_ANY_LAYOUT,
> VHOST_NET_F_VIRTIO_NET_HDR will be implied too. This is wrong and will
> break networking. Fixing this by safely removing
> VHOST_NET_F_VIRTIO_NET_HDR support. There should be very few or even
> no userspace can use this. Further cleanups could be done for
> -net-next for safety.
> 
> In the future, we need a vhost dedicated feature set/get ioctl()
> instead of reusing virtio ones.
> 
> Fixes: 4e9fa50c6ccbe ("vhost: move features to core")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I don't see this discussion as resolved yet so I'll mark this
as Deferred in patchwork.

Thanks.
