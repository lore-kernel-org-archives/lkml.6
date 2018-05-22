Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeEVUQi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:16:38 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41229 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbeEVUQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:16:37 -0400
Date: Tue, 22 May 2018 22:16:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Wiesinger <lists@wiesinger.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26
Message-ID: <20180522201632.GB4396@lunn.ch>
References: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Planned network structure will be as with 4.7.x kernels:
> 
> br0 <=> eth0.101 <=> eth0 (vlan 101 tagged) <=> lan 1-lan4 (vlan 101
> untagged pvid)
> 
> br1 <=> eth0.102 <=> eth0 (vlan 102 tagged) <=> wan (vlan 102 untagged pvid)

Do you even need these vlans?

Are you doing this for port separation? To keep lan1-4 traffic
separate from wan? DSA does that by default, no vlan needed.

So you can just do

ip link add name br0 type bridge
ip link set dev br0 up
ip link set dev lan1 master br0
ip link set dev lan2 master br0
ip link set dev lan3 master br0
ip link set dev lan4 master br0

and use interface wan directly, no bridge needed.

    Andrew
