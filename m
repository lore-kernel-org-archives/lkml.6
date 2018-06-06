Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBA52606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeFFSEh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:04:37 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45552 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeFFSEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:04:36 -0400
Date: Wed, 06 Jun 2018 14:04:34 -0400 (EDT)
Message-Id: <20180606.140434.487449157785947369.davem@davemloft.net>
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix terminal retransmission connection ID
 to include the channel
From: David Miller <davem@davemloft.net>
In-Reply-To: <152829355456.15682.4887593676960385184.stgit@warthog.procyon.org.uk>
References: <152829355456.15682.4887593676960385184.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Wed, 06 Jun 2018 14:59:14 +0100

> When retransmitting the final ACK or ABORT packet for a call, the cid field
> in the packet header is set to the connection's cid, but this is incorrect
> as it also needs to include the channel number on that connection that the
> call was made on.
> 
> Fix this by OR'ing in the channel number.
> 
> Note that this fixes the bug that:
> 
> 	commit 1a025028d400b23477341aa7ec2ce55f8b39b554
> 	rxrpc: Fix handling of call quietly cancelled out on server
> 
> works around.  I'm not intending to revert that as it will help protect
> against problems that might occur on the server.
> 
> Fixes: 3136ef49a14c ("rxrpc: Delay terminal ACK transmission on a client call")
> Signed-off-by: David Howells <dhowells@redhat.com>

Applid, thanks David.
