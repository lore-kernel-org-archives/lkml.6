Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4649BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D817217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbfBSBy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:54:56 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57348 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733062AbfBSByz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:54:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 12A91108DDD18;
        Mon, 18 Feb 2019 17:54:55 -0800 (PST)
Date:   Mon, 18 Feb 2019 17:54:54 -0800 (PST)
Message-Id: <20190218.175454.1507185978462723043.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, frank-w@public-files.de, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4.15..v4.19] net: dsa: Fix NPD checking for
 br_vlan_enabled()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190218223011.4824-1-f.fainelli@gmail.com>
References: <20190218223011.4824-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 17:54:55 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 18 Feb 2019 14:30:11 -0800

> It is possible for the DSA slave network device not to be part of a
> bridge, yet have an upper device like a VLAN device be part of a bridge.
> When that VLAN device is enslaved, since it does not define any
> switchdev_ops, we will recurse down to the lower/physical port device,
> call switchdev_port_obj_add() with a VLAN, and here we will check
> br_vlan_enabled() on a NULL dp->bridge_dev, thus causing a NULL pointer
> de-reference.
> 
> This is no longer a problem upstream after commit d17d9f5e5143
> ("switchdev: Replace port obj add/del SDO with a notification").
> 
> Fixes: 2ea7a679ca2a ("net: dsa: Don't add vlans when vlan filtering is disabled")
> Reported-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> David,
> 
> This affects v4.15..v4.19, but not v5.0-rc1 can you still queue this up
> for -stable? Thanks!

Queued up.
