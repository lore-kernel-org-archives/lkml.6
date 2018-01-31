Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeAaPdT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:33:19 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:44942 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932162AbeAaPdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:33:17 -0500
Date: Wed, 31 Jan 2018 10:33:15 -0500 (EST)
Message-Id: <20180131.103315.923448806673096482.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: pshelar@ovn.org, netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, garsilva@embeddedor.com
Subject: Re: [PATCH] openvswitch: meter: Use 64-bit arithmetic instead of
 32-bit
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180131045533.GA15485@embeddedgus>
References: <20180131045533.GA15485@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 30 Jan 2018 22:55:33 -0600

> Add suffix LL to constant 1000 in order to give the compiler
> complete information about the proper arithmetic to use. Notice
> that this constant is used in a context that expects an expression
> of type long long int (64 bits, signed).
> 
> The expression (band->burst_size + band->rate) * 1000 is currently
> being evaluated using 32-bit arithmetic.
> 
> Addresses-Coverity-ID: 1461563 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
