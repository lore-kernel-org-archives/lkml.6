Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbeE3RbJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:31:09 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45026 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeE3RbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:31:07 -0400
Date: Wed, 30 May 2018 13:31:04 -0400 (EDT)
Message-Id: <20180530.133104.1841137099094945800.davem@davemloft.net>
To: jasowang@redhat.com
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost_net: flush batched heads before trying to
 busy polling
From: David Miller <davem@davemloft.net>
In-Reply-To: <1527574699-13047-1-git-send-email-jasowang@redhat.com>
References: <1527574699-13047-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 May 2018 14:18:19 +0800

> After commit e2b3b35eb989 ("vhost_net: batch used ring update in rx"),
> we tend to batch updating used heads. But it doesn't flush batched
> heads before trying to do busy polling, this will cause vhost to wait
> for guest TX which waits for the used RX. Fixing by flush batched
> heads before busy loop.
> 
> 1 byte TCP_RR performance recovers from 13107.83 to 50402.65.
> 
> Fixes: e2b3b35eb989 ("vhost_net: batch used ring update in rx")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.
