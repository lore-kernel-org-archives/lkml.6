Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754643AbeCGSXT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:23:19 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:55234 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeCGSXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:23:16 -0500
Date: Wed, 07 Mar 2018 13:23:13 -0500 (EST)
Message-Id: <20180307.132313.862901353807914148.davem@davemloft.net>
To: jeremy.linton@arm.com
Cc: netdev@vger.kernel.org, steve.glendinning@shawell.net,
        matt.sealey@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: smsc911x: Fix unload crash when link is up
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180306150006.31512-1-jeremy.linton@arm.com>
References: <20180306150006.31512-1-jeremy.linton@arm.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Linton <jeremy.linton@arm.com>
Date: Tue,  6 Mar 2018 09:00:06 -0600

> The smsc911x driver will crash if it is rmmod'ed while the netdev
> is up like:
> 
> Call trace:
 ...
> This is caused by the mdiobus being unregistered/free'd
> and the code in phy_detach() attempting to manipulate mdio
> related structures from unregister_netdev() calling close()
> 
> To fix this, we delay the mdiobus teardown until after
> the netdev is deregistered.
> 
> Reported-by: Matt Sealey <matt.sealey@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Applied, thanks.
