Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755365AbeDPOEK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:04:10 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41534 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeDPOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:04:09 -0400
Date: Mon, 16 Apr 2018 10:04:07 -0400 (EDT)
Message-Id: <20180416.100407.1760752634367706398.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net] net: mvpp2: Fix TCAM filter reserved range
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180416080723.15593-1-maxime.chevallier@bootlin.com>
References: <20180416080723.15593-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Mon, 16 Apr 2018 10:07:23 +0200

> Marvell's PPv2 controller has a Packet Header parser, which uses a
> fixed-size TCAM array of filter entries.
> 
> The mvpp2 driver reserves some ranges among the 256 TCAM entries to
> perform MAC and VID filtering. The rest of the TCAM ids are freely usable
> for other features, such as IPv4 proto matching.
> 
> This commit fixes the MVPP2_PE_LAST_FREE_TID define that sets the end of
> the "free range", which included the MAC range. This could therefore allow
> some other features to use entries dedicated to MAC filtering,
> lowering the number of unicast/multicast addresses that could be allowed
> before switching to promiscuous mode.
> 
> Fixes: 10fea26ce2aa ("net: mvpp2: Add support for unicast filtering")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied, thanks.
