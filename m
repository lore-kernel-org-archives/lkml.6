Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeERRwA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:52:00 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48176 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeERRvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:51:54 -0400
Date: Fri, 18 May 2018 13:51:52 -0400 (EDT)
Message-Id: <20180518.135152.51730771671749217.davem@davemloft.net>
To: andrea.greco.gapmilano@gmail.com
Cc: tobin@apporbit.com, a.greco@4sigma.it, m.grzeschik@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] arcnet: com20020: Add com20020 io mapped version
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAPoXtQJJ-Fv6dBWxFs+r+B-+jhQAF+AxdqDg9g55AwSyBJ0U6g@mail.gmail.com>
References: <20180517130529.2684-1-andrea.greco.gapmilano@gmail.com>
        <20180517.163113.2110198960037727630.davem@davemloft.net>
        <CAPoXtQJJ-Fv6dBWxFs+r+B-+jhQAF+AxdqDg9g55AwSyBJ0U6g@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Date: Fri, 18 May 2018 14:18:41 +0200

> In com20020.c found this:
> /* FIXME: do this some other way! */
> if (!dev->dev_addr[0])
> dev->dev_addr[0] = arcnet_inb(ioaddr, 8);
> 
> NODE-ID, must be univoque, for all arcnet network.
> My previews idea was take random value but, this could create a
> collision over network.
> 
> A possible solution is:
> In case of collision com20020 set a bit in status register.
> Then peak a new NODE-ID and repeat this while correct NODE-ID is found.
> 
> Other ideas is pass it via DTS.
> But suppose have 2 same product in same network, same address same problem.
> For this reason i prefer left standard driver behavior.
> 
> Other ideas for solve this ?

Is there no way to obtain a unique value from the device?

If having a unique ID to talk on the ARCNET is so critical, there must
be some way to properly allocation and use a unique ID.

I guess this must be a general problem with this driver already.

You still need to address the issue of 'dev' being leaked on probe
error paths.

Thank you.
