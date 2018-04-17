Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeDQRvW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:51:22 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59212 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753351AbeDQRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:51:17 -0400
Date: Tue, 17 Apr 2018 13:51:15 -0400 (EDT)
Message-Id: <20180417.135115.342004798174126821.davem@davemloft.net>
To: sam@mendozajonas.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH RESEND net-next] net/ncsi: Refactor MAC, VLAN filters
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180417042323.27941-1-sam@mendozajonas.com>
References: <20180417042323.27941-1-sam@mendozajonas.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Tue, 17 Apr 2018 14:23:23 +1000

> The NCSI driver defines a generic ncsi_channel_filter struct that can be
> used to store arbitrarily formatted filters, and several generic methods
> of accessing data stored in such a filter.
> However in both the driver and as defined in the NCSI specification
> there are only two actual filters: VLAN ID filters and MAC address
> filters. The splitting of the MAC filter into unicast, multicast, and
> mixed is also technically not necessary as these are stored in the same
> location in hardware.
> 
> To save complexity, particularly in the set up and accessing of these
> generic filters, remove them in favour of two specific structs. These
> can be acted on directly and do not need several generic helper
> functions to use.
> 
> This also fixes a memory error found by KASAN on ARM32 (which is not
> upstream yet), where response handlers accessing a filter's data field
> could write past allocated memory.
 ...
> Reported-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

Applied to net-next, thank you.
