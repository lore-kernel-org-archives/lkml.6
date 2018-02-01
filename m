Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBAOpg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:45:36 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:43890 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeBAOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:45:32 -0500
Date: Thu, 01 Feb 2018 09:45:31 -0500 (EST)
Message-Id: <20180201.094531.310132736141169083.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: hswong3i@gmail.com, hlhung3i@gmail.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, garsilva@embeddedor.com
Subject: Re: [PATCH] tcp_lp: use 64-bit arithmetic instead of 32-bit
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180201002407.GA1608@embeddedgus>
References: <20180201002407.GA1608@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 31 Jan 2018 18:24:07 -0600

> Cast to s64 some variables and a macro in order to give the
> compiler complete information about the proper arithmetic to
> use. Notice that these elements are used in contexts that
> expect expressions of type s64 (64 bits, signed).
> 
> Currently such expression are being evaluated using 32-bit
> arithmetic.
> 
> Addresses-Coverity-ID: 200687
> Addresses-Coverity-ID: 200688
> Addresses-Coverity-ID: 200689
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Sorry, I'm not applying this, the domain of the input values
means that the calculation cannot overflow.
