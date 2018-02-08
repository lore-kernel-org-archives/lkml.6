Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBHCsE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 21:48:04 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:39410 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeBHCsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 21:48:02 -0500
Date: Wed, 07 Feb 2018 21:47:59 -0500 (EST)
Message-Id: <20180207.214759.2013654644874294782.davem@davemloft.net>
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix received abort handling
From: David Miller <davem@davemloft.net>
In-Reply-To: <151793545229.24105.9015810583725369029.stgit@warthog.procyon.org.uk>
References: <151793545229.24105.9015810583725369029.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Tue, 06 Feb 2018 16:44:12 +0000

> AF_RXRPC is incorrectly sending back to the server any abort it receives
> for a client connection.  This is due to the final-ACK offload to the
> connection event processor patch.  The abort code is copied into the
> last-call information on the connection channel and then the event
> processor is set.
> 
> Instead, the following should be done:
 ...
> Fixes: 3136ef49a14c ("rxrpc: Delay terminal ACK transmission on a client call")
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied, thanks David.
