Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeC0PoF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:44:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:42100 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbeC0PoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:44:04 -0400
Date: Tue, 27 Mar 2018 11:44:02 -0400 (EDT)
Message-Id: <20180327.114402.619275306009710582.davem@davemloft.net>
To: dave@stgolabs.net
Cc: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, dbueso@suse.de
Subject: Re: [PATCH 5/6] net/ipv4: Update ip_tunnel_metadata_cnt static key
 to modern api
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180326210929.5244-6-dave@stgolabs.net>
References: <20180326210929.5244-1-dave@stgolabs.net>
        <20180326210929.5244-6-dave@stgolabs.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>
Date: Mon, 26 Mar 2018 14:09:28 -0700

> No changes in refcount semantics -- key init is false; replace
> 
> static_key_slow_inc|dec   with   static_branch_inc|dec
> static_key_false          with   static_branch_unlikely
> 
> Added a '_key' suffix to i2c_trace_msg, for better self
> documentation.

I see no reference to i2c_trace_msg in this patch.
