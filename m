Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754800AbeCRUfF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:35:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59698 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754626AbeCRUfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:35:03 -0400
Date: Sun, 18 Mar 2018 16:35:01 -0400 (EDT)
Message-Id: <20180318.163501.2001276876693998811.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, l.stach@pengutronix.de,
        fugang.duan@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: fec: Fix unbalanced PM runtime calls
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180318194952.31411-1-f.fainelli@gmail.com>
References: <20180318194952.31411-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 18 Mar 2018 12:49:51 -0700

> When unbinding/removing the driver, we will run into the following warnings:
> 
> [  259.655198] fec 400d1000.ethernet: 400d1000.ethernet supply phy not found, using dummy regulator
> [  259.665065] fec 400d1000.ethernet: Unbalanced pm_runtime_enable!
> [  259.672770] fec 400d1000.ethernet (unnamed net_device) (uninitialized): Invalid MAC address: 00:00:00:00:00:00
> [  259.683062] fec 400d1000.ethernet (unnamed net_device) (uninitialized): Using random MAC address: f2:3e:93:b7:29:c1
> [  259.696239] libphy: fec_enet_mii_bus: probed
> 
> Avoid these warnings by balancing the runtime PM calls during fec_drv_remove().
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thank you.

Queue this up for -stable?
