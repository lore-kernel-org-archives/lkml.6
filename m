Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeCVTnR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:43:17 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60122 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeCVTnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:43:11 -0400
Date: Thu, 22 Mar 2018 15:43:08 -0400 (EDT)
Message-Id: <20180322.154308.1553892464667808498.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2] net: mvpp2: Don't use dynamic allocs for
 local variables
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180322201453.706b0ab8@bootlin.com>
References: <20180321151400.6658-1-maxime.chevallier@bootlin.com>
        <20180322.144709.550558706036978967.davem@davemloft.net>
        <20180322201453.706b0ab8@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Thu, 22 Mar 2018 20:14:53 +0100

> Hello David,
> 
> On Thu, 22 Mar 2018 14:47:09 -0400 (EDT),
> David Miller <davem@davemloft.net> wrote :
> 
>> From: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> Date: Wed, 21 Mar 2018 16:14:00 +0100
>> 
>> In order to be an equivalent change you must bzero out this 'pe'
>> object on the stack.  You are only initializing the index member
>> before passing it into other functions.
> 
> I agree that this is unclear, but the functions I pass these objects to
> only need the index field to be set, and will fill the rest of the
> object according to the underlying HW representation (these objects
> mirror the HW configuration).
> 
> I can see that this is confusing, we might want to make the
> mvpp2_prs_hw_read function more explicit about this.
> 
> Would comments explaning this be enough, or should I try another way to
> make this cleaner ?

Please bzero the object as I have asked you to.

Today the function doesn't care about any input members other than
member, but in the future it might, and this is a bug waiting to
happen.

It is never good to pass partially initialized variables into
another piece of code.
