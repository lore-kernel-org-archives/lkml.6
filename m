Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B083DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75340208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75340208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754395AbeGIHCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:02:21 -0400
Received: from muru.com ([72.249.23.125]:50694 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754093AbeGIHCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:02:20 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B24948022;
        Mon,  9 Jul 2018 07:05:21 +0000 (UTC)
Date:   Mon, 9 Jul 2018 00:02:16 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omapfb: rename omap2 module to omap2fb.ko
Message-ID: <20180709070216.GE112168@atomide.com>
References: <20180706123528.2729378-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706123528.2729378-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [180706 12:39]:
> In a kernel configuration with both CONFIG_FB_OMAP=m and CONFIG_FB_OMAP2=m,
> Kbuild fails to point out that we have two modules with the same name (omapfb.ko),
> but instead fails with a cryptic error message like:
> 
> ERROR: "omapfb_register_panel" [drivers/video/fbdev/omap/lcd_osk.ko] undefined!
> 
> This can now happen when building a randconfig kernel with CONFIG_ARCH_OMAP1,
> as the omap1 fbdev driver depends on that, whiel the omap2 fbdev driver can
> now be built anywhere with CONFIG_COMPILE_TEST.
> 
> The solution is to rename one of the two modules, so for consistency with
> the directory naming I decided to rename the omap2 version to omap2fb.ko.

Sounds good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
