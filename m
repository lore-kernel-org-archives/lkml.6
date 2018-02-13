Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965140AbeBMO6Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:58:25 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:39788 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965029AbeBMO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:58:24 -0500
Date: Tue, 13 Feb 2018 09:58:20 -0500 (EST)
Message-Id: <20180213.095820.761578588685460710.davem@davemloft.net>
To: fthain@telegraphics.com.au
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v4 02/13] net/8390: Fix msg_enable patch snafu
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LNX.2.21.1802131419540.8@nippy.intranet>
References: <f697da2b2513e025688f6c48088536060575a249.1518397634.git.fthain@telegraphics.com.au>
        <20180212.103956.1262868827217051631.davem@davemloft.net>
        <alpine.LNX.2.21.1802131419540.8@nippy.intranet>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Tue, 13 Feb 2018 16:03:09 +1100 (AEDT)

> I think you have overlooked those modules which offer no way to set 
> p->msg_enable, i.e. ax88796, axnet_cs, etherh, hydra, mac8390, mcf8390, 
> pcnet_cs and zorro8390.

Then that's a bug, we have a very simple easy to implement interface
for setting this (ethtool).

And by adding the simple hook, you will make these older drivers
easier to debug for the few people still using them.
