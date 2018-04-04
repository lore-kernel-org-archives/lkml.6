Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbeDDPH4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:07:56 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:39910 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbeDDPHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:07:55 -0400
Date: Wed, 04 Apr 2018 11:07:53 -0400 (EDT)
Message-Id: <20180404.110753.1310108334071287240.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: Broadcom drivers sparse fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180402225856.4351-1-f.fainelli@gmail.com>
References: <20180402225856.4351-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon,  2 Apr 2018 15:58:54 -0700

> This patch series fixes the same warning reported by sparse in bcmsysport and
> bcmgenet in the code that deals with inserting the TX checksum pointers:
> 
> drivers/net/ethernet/broadcom/bcmsysport.c:1155:26: warning: cast from restricted __be16
> drivers/net/ethernet/broadcom/bcmsysport.c:1155:26: warning: incorrect type in argument 1 (different base types)
> drivers/net/ethernet/broadcom/bcmsysport.c:1155:26:    expected unsigned short [unsigned] [usertype] val
> drivers/net/ethernet/broadcom/bcmsysport.c:1155:26:    got restricted __be16 [usertype] protocol
> 
> This patch fixes both issues by using the same construct and not swapping
> skb->protocol but instead the values we are checking against.

Series applied, thanks Florian.
