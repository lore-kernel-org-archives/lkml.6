Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB5C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB69920C10
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB69920C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeHSVOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 17:14:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33546 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeHSVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 17:14:02 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0B2B2144B7E67;
        Sun, 19 Aug 2018 11:01:44 -0700 (PDT)
Date:   Sun, 19 Aug 2018 11:01:43 -0700 (PDT)
Message-Id: <20180819.110143.87031394726154238.davem@davemloft.net>
To:     jian-hong@endlessm.com
Cc:     hkallweit1@gmail.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: Re: [PATCH v2 net] r8169: don't use MSI-X on RTL8106e
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180817050735.3367-1-jian-hong@endlessm.com>
References: <20180815062110.16155-1-jian-hong@endlessm.com>
        <20180817050735.3367-1-jian-hong@endlessm.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 19 Aug 2018 11:01:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>
Date: Fri, 17 Aug 2018 13:07:35 +0800

> Found the ethernet network on ASUS X441UAR doesn't come back on resume
> from suspend when using MSI-X.  The chip is RTL8106e - version 39.
 ...
> Here is the ethernet controller in detail:
 ...
> Falling back to MSI fixes the issue.
> 
> Fixes: 6c6aa15fdea5 ("r8169: improve interrupt handling")
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
> Changes in v2:
>   - Make the commit message shorter
>   - Add "Fixes" tag in the commit message

I'm going to apply this for now, and queue it up for -stable.

If we hear back from Realtek on something we can do to make MSI-X
work on these chips, we can deal with it as a follow-up.

Thanks.
