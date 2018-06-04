Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeFDRWS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:22:18 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:50192 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeFDRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:22:16 -0400
Date: Mon, 04 Jun 2018 13:22:12 -0400 (EDT)
Message-Id: <20180604.132212.983793538169890618.davem@davemloft.net>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        nicolas.dichtel@6wind.com, tom@herbertland.com, dsahern@gmail.com,
        idosch@idosch.org
Subject: Re: [PATCH net v3] ipv6: omit traffic class when calculating flow
 hash
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180604095619.7D9C1A09F0@unicorn.suse.cz>
References: <687af1bc-a1f9-c0d2-dd3a-eeef3a2bf9b4@gmail.com>
        <20180604095619.7D9C1A09F0@unicorn.suse.cz>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>
Date: Mon, 4 Jun 2018 11:36:05 +0200

> Some of the code paths calculating flow hash for IPv6 use flowlabel member
> of struct flowi6 which, despite its name, encodes both flow label and
> traffic class. If traffic class changes within a TCP connection (as e.g.
> ssh does), ECMP route can switch between path. It's also inconsistent with
> other code paths where ip6_flowlabel() (returning only flow label) is used
> to feed the key.
> 
> Use only flow label everywhere, including one place where hash key is set
> using ip6_flowinfo().
> 
> Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")
> Fixes: f70ea018da06 ("net: Add functions to get skb->hash based on flow structures")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---
> v2: introduce and use an inline helper as suggested by David Ahern
> v3: keep the cast out of the helper to make future cleanup easier

Applied and queued up for -stable, thank you.
