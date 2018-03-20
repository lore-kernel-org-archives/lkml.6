Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeCTQAn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:00:43 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56234 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeCTQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:00:40 -0400
Date: Tue, 20 Mar 2018 12:00:36 -0400 (EDT)
Message-Id: <20180320.120036.1999626754164343704.davem@davemloft.net>
To: LIRAN.ALON@ORACLE.COM
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        idan.brown@ORACLE.COM, yuval.shaia@ORACLE.COM
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
From: David Miller <davem@davemloft.net>
In-Reply-To: <5AB12A0E.2060704@ORACLE.COM>
References: <1520953642-8145-1-git-send-email-liran.alon@oracle.com>
        <20180320.104759.796804827689233281.davem@davemloft.net>
        <5AB12A0E.2060704@ORACLE.COM>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liran Alon <LIRAN.ALON@ORACLE.COM>
Date: Tue, 20 Mar 2018 17:34:38 +0200

> I personally don't understand why we should maintain
> backwards-comparability to this behaviour.

The reason is because not breaking things is a cornerstone of Linux
kernel development.

> This feature is not documented to user-mode and I don't see why it
> is legit for the user to rely on it.

Whether it is documented or not is irrelevant.  A lot of our
interfaces and behaviors are not documented or poorly documented
at best.

> In addition, even if we do want to maintain backwards-comparability to
> this behaviour, I think it is enough to have an opt-in flag in
> /proc/sys/net/core/ that when set to 1 will activate the fix in
> dev_forward_skb() provided by this patch. That would also be a very
> simple change to the patch provided here.

Making it opt-in makes it more palatable, that's for sure.
