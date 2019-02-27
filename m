Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B22C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A832083D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfB0UkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:40:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48878 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfB0UkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:40:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D626E12106D63;
        Wed, 27 Feb 2019 12:40:21 -0800 (PST)
Date:   Wed, 27 Feb 2019 12:40:19 -0800 (PST)
Message-Id: <20190227.124019.281722845670775310.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 0/8] net: Remove switchdev_ops
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190227194432.725-1-f.fainelli@gmail.com>
References: <20190227194432.725-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Feb 2019 12:40:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 27 Feb 2019 11:44:24 -0800

> This patch series completes the removal of the switchdev_ops by
> converting switchdev_port_attr_set() to use either the blocking
> (process) or non-blocking (atomic) notifier since we typically need to
> deal with both depending on where in the bridge code we get called from.
> 
> This was tested with the forwarding selftests and DSA hardware.
> 
> Ido, hopefully this captures your comments done on v1, if not, can you
> illustrate with some pseudo-code what you had in mind if that's okay?
> 
> Changes in v3:
> 
> - added Reviewed-by tags from Ido where relevant
> - added missing notifier_to_errno() in net/bridge/br_switchdev.c when
>   calling the atomic notifier for PRE_BRIDGE_FLAGS
> - kept mlxsw_sp_switchdev_init() in mlxsw/
> 
> Changes in v2:
> 
> - do not check for SWITCHDEV_F_DEFER when calling the blocking notifier
>   and instead directly call the atomic notifier from the single location
>   where this is required

Series applied, thanks Florian.

I'll push this out after my build tests complete.
