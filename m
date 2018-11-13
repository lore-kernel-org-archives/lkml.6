Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79638C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363FC22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363FC22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbeKMKXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:23:49 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36430 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:23:49 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 859D014C88120;
        Mon, 12 Nov 2018 16:28:16 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:26:44 -0800 (PST)
Message-Id: <20181112.162644.2177457459131295892.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][net-next] net: phy: check if advertising is zero using
 linkmode_empty
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181112234556.5291-1-colin.king@canonical.com>
References: <20181112234556.5291-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 12 Nov 2018 16:28:16 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon, 12 Nov 2018 23:45:56 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> A recent change modified variable advertising from a u32 to a link mode
> array and left the u32 zero comparison, so essential we now have an array
> being compared to null which is not the intention. Fix this by using the
> call to linkmode_empty to check if advertising is all zero.
> 
> Detected by CoverityScan, CID#1475424 ("Array compared against 0")
> 
> Fixes: 3c1bcc8614db ("net: ethernet: Convert phydev advertize and supported from u32 to link mode")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
