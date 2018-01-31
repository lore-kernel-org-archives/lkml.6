Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932158AbeAaPdF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:33:05 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:44920 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932126AbeAaPdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:33:02 -0500
Date: Wed, 31 Jan 2018 10:33:00 -0500 (EST)
Message-Id: <20180131.103300.1736696032660575093.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, garsilva@embeddedor.com
Subject: Re: [PATCH] tcp_nv: fix potential integer overflow in tcpnv_acked
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180131042147.GA13245@embeddedgus>
References: <20180131042147.GA13245@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 30 Jan 2018 22:21:48 -0600

> Add suffix ULL to constant 80000 in order to avoid a potential integer
> overflow and give the compiler complete information about the proper
> arithmetic to use. Notice that this constant is used in a context that
> expects an expression of type u64.
> 
> The current cast to u64 effectively applies to the whole expression
> as an argument of type u64 to be passed to div64_u64, but it does
> not prevent it from being evaluated using 32-bit arithmetic instead
> of 64-bit arithmetic.
> 
> Also, once the expression is properly evaluated using 64-bit arithmentic,
> there is no need for the parentheses and the external cast to u64.
> 
> Addresses-Coverity-ID: 1357588 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
