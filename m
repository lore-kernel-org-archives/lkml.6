Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeC0Orp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:47:45 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40738 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbeC0Oro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:47:44 -0400
Date: Tue, 27 Mar 2018 10:47:41 -0400 (EDT)
Message-Id: <20180327.104741.346276694485778787.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 0/2] net: mvpp2: Remove unnecessary dynamic
 allocs
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180326133423.14779-1-maxime.chevallier@bootlin.com>
References: <20180326133423.14779-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Mon, 26 Mar 2018 15:34:21 +0200

> Some utility functions in mvpp2 make use of dynamic alloc to exchange temporary
> objects representing Parser Entries (which are generic filtering entries in the
> PPv2 controller).
> 
> These objects are small (44 bytes each), we can use the stack to exchange them.
> 
> Some previous discussion on this topic showed that the mvpp2_prs_hw_read, which
> initializes a struct mvpp2_prs_entry based on one of its fields, can easily lead
> to erroneous code if we don't zero-out the struct beforehand :
> 
> https://lkml.org/lkml/2018/3/21/739
> 
> To fix this, I propose to rename mvpp2_prs_hw_read into mvpp2_prs_init_from_hw,
> make it zero-out the struct and take the index as a parameter. That's what's
> done in the first patch of the series.
> 
> The second patch is the V3 of
> ("net: mvpp2: Don't use dynamic allocs for local variables"), making use of
> mvpp2_prs_init_from_hw and taking previous comments into account.

Series applied, thank you.
