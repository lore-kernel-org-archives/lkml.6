Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A628C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C67217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeLSGDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:03:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49656 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeLSGDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:03:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2AE0412640B5A;
        Tue, 18 Dec 2018 22:03:45 -0800 (PST)
Date:   Tue, 18 Dec 2018 22:03:44 -0800 (PST)
Message-Id: <20181218.220344.197132278908226283.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     jdmason@kudzu.us, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxge: ensure data0 is initialized in when fetching
 firmware version information
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181218151947.31406-1-colin.king@canonical.com>
References: <20181218151947.31406-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 22:03:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 18 Dec 2018 15:19:47 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently variable data0 is not being initialized so a garbage value is
> being passed to vxge_hw_vpath_fw_api and this value is being written to
> the rts_access_steer_data0 register.  There are other occurrances where
> data0 is being initialized to zero (e.g. in function
> vxge_hw_upgrade_read_version) so I think it makes sense to ensure data0
> is initialized likewise to 0.
> 
> Detected by CoverityScan, CID#140696 ("Uninitialized scalar variable")
> 
> Fixes: 8424e00dfd52 ("vxge: serialize access to steering control register")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
