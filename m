Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeC0PrD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:47:03 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:42158 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeC0PrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:47:01 -0400
Date: Tue, 27 Mar 2018 11:47:00 -0400 (EDT)
Message-Id: <20180327.114700.1341444619952240925.davem@davemloft.net>
To: neilb@suse.com
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] rhashtable: improve documentation for
 rhashtable_walk_peek()
From: David Miller <davem@davemloft.net>
In-Reply-To: <152210718418.11435.11573013181393548255.stgit@noble>
References: <152210688405.11435.13010923693146415942.stgit@noble>
        <152210718418.11435.11573013181393548255.stgit@noble>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Tue, 27 Mar 2018 10:33:04 +1100

> The documentation for rhashtable_walk_peek() wrong.  It claims to
> return the *next* entry, whereas it in fact returns the *previous*
> entry.
> However if no entries have yet been returned - or if the iterator
> was reset due to a resize event, then rhashtable_walk_peek()
> *does* return the next entry, but also advances the iterator.
> 
> I suspect that this interface should be discarded and the one user
> should be changed to not require it.  Possibly this patch should be
> seen as a first step in that conversation.
> 
> This patch mostly corrects the documentation, but does make a
> small code change so that the documentation can be correct without
> listing too many special cases.  I don't think the one user will
> be affected by the code change.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Please mention the "one user" explicitly in both locations where
you refer to it in this commit message.

Thank you.
