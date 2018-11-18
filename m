Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56146C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 05:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE2720817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 05:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE2720817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeKRP3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 10:29:17 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41354 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeKRP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 10:29:17 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B5E29148BBD60;
        Sat, 17 Nov 2018 21:10:09 -0800 (PST)
Date:   Sat, 17 Nov 2018 21:10:06 -0800 (PST)
Message-Id: <20181117.211006.376669879094627607.davem@davemloft.net>
To:     sam@mendozajonas.com
Cc:     netdev@vger.kernel.org, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next v4 0/6] net/ncsi: Allow enabling multiple
 packages & channels
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181116045159.4980-1-sam@mendozajonas.com>
References: <20181116045159.4980-1-sam@mendozajonas.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 17 Nov 2018 21:10:09 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Fri, 16 Nov 2018 15:51:53 +1100

> This series extends the NCSI driver to configure multiple packages
> and/or channels simultaneously. Since the RFC series this includes a few
> extra changes to fix areas in the driver that either made this harder or
> were roadblocks due to deviations from the NCSI specification.
> 
> Patches 1 & 2 fix two issues where the driver made assumptions about the
> capabilities of the NCSI topology.
> Patches 3 & 4 change some internal semantics slightly to make multi-mode
> easier.
> Patch 5 introduces a cleaner way of reconfiguring the NCSI configuration
> and keeping track of channel states.
> Patch 6 implements the main multi-package/multi-channel configuration,
> configured via the Netlink interface.
> 
> Readers who have an interesting NCSI setup - especially multi-package
> with HWA - please test! I think I've covered all permutations but I
> don't have infinite hardware to test on.
> 
> Changes in v2:
> - Updated use of the channel lock in ncsi_reset_dev(), making the
> channel invisible and leaving the monitor check to
> ncsi_stop_channel_monitor().
> - Fixed ncsi_channel_is_tx() to consider the state of channels in other
> packages.
> Changes in v3:
> - Fixed bisectability bug in patch 1
> - Consider channels on all packages in a few places when multi-package
> is enabled.
> - Avoid doubling up reset operations, and check the current driver state
> before reset to let any running operations complete.
> - Reorganise the LSC handler slightly to avoid enabling Tx twice.
> Changes in v4:
> - Fix failover in the single-channel case
> - Better handle ncsi_reset_dev() entry during a current config/suspend
> operation.

Series applied.
