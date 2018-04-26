Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755731AbeDZMkP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:40:15 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41573 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751713AbeDZMkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:40:12 -0400
Date: Thu, 26 Apr 2018 14:40:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Bhadram Varka <vbhadram@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jingju Hou <Jingju.Hou@synaptics.com>
Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
Message-ID: <20180426124007.GC13467@lunn.ch>
References: <20180419160232.519d15be@xhacker.debian>
 <20180419121801.GC17888@lunn.ch>
 <4273f766-a017-b336-7d14-a28901d274b9@nvidia.com>
 <20180426141508.6660a633@xhacker.debian>
 <be2addb5-b3fd-13cb-ad33-f0527931a0d2@nvidia.com>
 <20180426155619.2c5d87d1@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426155619.2c5d87d1@xhacker.debian>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> hmm, so you want a "stick" WOL feature, I dunno whether Linux kernel
> requires WOL should be "stick".

I see two different cases:

Suspend/resume: The WoL state in the kernel is probably kept across
such a cycle. If so, you would expect another suspend/resume to also
work, without needs to reconfigure it.

Boot from powered off: If the interrupt just enables the power supply,
it is possible to wake up after a shutdown. There is no state kept, so
WoL will be disabled in the kernel. So WoL should also be disabled in
the hardware.

    Andrew
