Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1329FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93C524195
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93C524195
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbeGEIbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:31:15 -0400
Received: from muru.com ([72.249.23.125]:50242 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752458AbeGEIbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:31:14 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E1E3A802B;
        Thu,  5 Jul 2018 08:34:11 +0000 (UTC)
Date:   Thu, 5 Jul 2018 01:31:10 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>, stable <stable@vger.kernel.org>,
        Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: Re: [PATCH 1/4] rtc: omap: fix potential crash on power off
Message-ID: <20180705083110.GX112168@atomide.com>
References: <20180704090558.16647-1-johan@kernel.org>
 <20180704090558.16647-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704090558.16647-2-johan@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [180704 09:09]:
> Do not set the system power-off callback and omap power-off rtc pointer
> until we're done setting up our device to avoid leaving stale pointers
> around after a late probe error.
> 
> Fixes: 97ea1906b3c2 ("rtc: omap: Support ext_wakeup configuration")
> Cc: stable <stable@vger.kernel.org>     # 4.9
> Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
