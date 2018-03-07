Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754524AbeCGRZo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:25:44 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54482 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeCGRZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:25:43 -0500
Date: Wed, 07 Mar 2018 12:25:41 -0500 (EST)
Message-Id: <20180307.122541.1396477885969641264.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: santosh@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, garsilva@embeddedor.com
Subject: Re: [PATCH] cxgb3: remove VLA
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180306053934.GA17162@embeddedgus>
References: <20180306053934.GA17162@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 5 Mar 2018 23:39:34 -0600

> In preparation to enabling -Wvla, remove VLA and replace it
> with dynamic memory allocation.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

All of these lengths are limited by the encoding of the field in the
VPD, which is a u8, and thus 255 bytes.

Please just change the 'len' argument to these functions to a u8 and
use a 256 byte buffer on the stack.

Thanks.
