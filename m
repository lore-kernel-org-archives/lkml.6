Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeD3Cz5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 22:55:57 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:54730 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeD3Cz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 22:55:56 -0400
Date: Sun, 29 Apr 2018 22:55:54 -0400 (EDT)
Message-Id: <20180429.225554.2165914401649980919.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, rmk@armlinux.org.uk,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        nikita.yoush@cogentembedded.com, vivien.didelot@savoirfairelinux.com,
        Nisar.Sayed@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next 0/5] Support for PHY test modes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180428003237.1536-1-f.fainelli@gmail.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 27 Apr 2018 17:32:30 -0700

> This patch series adds support for specifying PHY test modes through
> ethtool and paves the ground for adding support for more complex
> test modes that might require data to be exchanged between user and
> kernel space.
> 
> As an example, patches are included to add support for the IEEE
> electrical test modes for 100BaseT2 and 1000BaseT. Those do not
> require data to be passed back and forth.
> 
> I believe the infrastructure to be usable enough to add support for
> other things like:
> 
> - cable diagnostics
> - pattern generator/waveform generator with specific pattern being
>   indicated for instance
> 
> Questions for Andrew, and others:
> 
> - there could be room for adding additional ETH_TEST_FL_* values in order to
>   help determine how the test should be running
> - some of these tests can be disruptive to connectivity, the minimum we could
>   do is stop the PHY state machine and restart it when "normal" is used to exit
>   those test modes
> 
> Comments welcome!

Generally, no objection to providing this in the general manner you
have implemented it via ethtool.

I think in order to answer the disruptive question, you need to give
some information about what kind of context this stuff would be
used in, and if in those contexts what the user expectations are
or might be.

Are these test modes something that usually would be initiated with
the interface down?
