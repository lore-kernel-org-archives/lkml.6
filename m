Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeFDUG7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:06:59 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51960 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeFDUG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:06:57 -0400
Date: Mon, 04 Jun 2018 16:06:56 -0400 (EDT)
Message-Id: <20180604.160656.1908177448752194104.davem@davemloft.net>
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix handling of call quietly cancelled out
 on server
From: David Miller <davem@davemloft.net>
In-Reply-To: <152798865948.5814.10196893914153717731.stgit@warthog.procyon.org.uk>
References: <152798865948.5814.10196893914153717731.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Sun, 03 Jun 2018 02:17:39 +0100

> Sometimes an in-progress call will stop responding on the fileserver when
> the fileserver quietly cancels the call with an internally marked abort
> (RX_CALL_DEAD), without sending an ABORT to the client.
> 
> This causes the client's call to eventually expire from lack of incoming
> packets directed its way, which currently leads to it being cancelled
> locally with ETIME.  Note that it's not currently clear as to why this
> happens as it's really hard to reproduce.
> 
> The rotation policy implement by kAFS, however, doesn't differentiate
> between ETIME meaning we didn't get any response from the server and ETIME
> meaning the call got cancelled mid-flow.  The latter leads to an oops when
> fetching data as the rotation partially resets the afs_read descriptor,
> which can result in a cleared page pointer being dereferenced because that
> page has already been filled.
 ...
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied, thanks David.
