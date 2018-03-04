Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932604AbeCDXiQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 18:38:16 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:45246 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbeCDXiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 18:38:13 -0500
Date: Sun, 04 Mar 2018 18:38:11 -0500 (EST)
Message-Id: <20180304.183811.344767417258525977.davem@davemloft.net>
To: jasowang@redhat.com
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        brouer@redhat.com, john.fastabend@gmail.com
Subject: Re: [PATCH net V2] virtio-net: re enable XDP_REDIRECT for
 mergeable buffer
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
References: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri,  2 Mar 2018 17:29:14 +0800

> XDP_REDIRECT support for mergeable buffer was removed since commit
> 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in receive_mergeable()
> case"). This is because we don't reserve enough tailroom for struct
> skb_shared_info which breaks XDP assumption. So this patch fixes this
> by reserving enough tailroom and using fixed size of rx buffer.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - do not add duplicated tracepoint when redirection fails

Applied to net-next, thanks Jason.
