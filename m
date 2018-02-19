Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbeBSQLn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:11:43 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:60922 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbeBSQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:11:40 -0500
Date: Mon, 19 Feb 2018 11:11:38 -0500 (EST)
Message-Id: <20180219.111138.1929929854473154523.davem@davemloft.net>
To: parri.andrea@gmail.com
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        john.fastabend@gmail.com, edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH] ptr_ring: Remove now-redundant
 smp_read_barrier_depends()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1518779173-30812-1-git-send-email-parri.andrea@gmail.com>
References: <1518779173-30812-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com>
Date: Fri, 16 Feb 2018 12:06:13 +0100

> Because READ_ONCE() now implies smp_read_barrier_depends(), the
> smp_read_barrier_depends() in __ptr_ring_consume() is redundant;
> this commit removes it and updates the comments.
> 
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Ok, if READ_ONCE() does a barrier now, this change makes sense.

Applied to net-next, thank you.
