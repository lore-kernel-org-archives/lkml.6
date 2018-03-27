Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeC0Pto (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:49:44 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:42198 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbeC0Ptn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:49:43 -0400
Date: Tue, 27 Mar 2018 11:49:41 -0400 (EDT)
Message-Id: <20180327.114941.997071660018188736.davem@davemloft.net>
To: neilb@suse.com
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rhashtable: allow a walk of the hash table without
 missing objects.
From: David Miller <davem@davemloft.net>
In-Reply-To: <152210718430.11435.5761213978298714527.stgit@noble>
References: <152210688405.11435.13010923693146415942.stgit@noble>
        <152210718430.11435.5761213978298714527.stgit@noble>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Tue, 27 Mar 2018 10:33:04 +1100

> In many cases where the walker needs to drop out of RCU protection,
> it will take a reference to the object and this can prevent it from
> being removed from the hash table.  In those cases, the last-returned
> object can still be used as a cursor.  rhashtable cannot detect
> these cases itself.

Merely having an elevated reference count does not explicitly prevent
the object from being removed from the hash table.

This invariant might hold for the particular user of the rhashtable
instance, but it is not always the case.
