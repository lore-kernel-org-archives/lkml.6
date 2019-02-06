Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D89C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DC4218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfBFVky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:40:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36618 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfBFVku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:40:50 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B72691401292D;
        Wed,  6 Feb 2019 13:40:49 -0800 (PST)
Date:   Wed, 06 Feb 2019 13:40:49 -0800 (PST)
Message-Id: <20190206.134049.2075883825221593917.davem@davemloft.net>
To:     thierry.reding@gmail.com
Cc:     hkallweit1@gmail.com, andrew@lunn.ch, joe@perches.com,
        eric.dumazet@gmail.com, pauldzim@gmail.com, mkubecek@suse.cz,
        nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] r8169: Avoid pointer aliasing
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190206123018.24802-2-thierry.reding@gmail.com>
References: <20190206123018.24802-1-thierry.reding@gmail.com>
        <20190206123018.24802-2-thierry.reding@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Feb 2019 13:40:50 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed,  6 Feb 2019 13:30:18 +0100

> From: Thierry Reding <treding@nvidia.com>
> 
> Read MAC address 32-bit at a time and manually extract the individual
> bytes. This avoids pointer aliasing and gives the compiler a better
> chance of optimizing the operation.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied.
