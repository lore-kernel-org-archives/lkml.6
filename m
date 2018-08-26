Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1697C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 00:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9055B20A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 00:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9055B20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeHZENm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 00:13:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60616 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeHZENm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 00:13:42 -0400
Received: from localhost (50-243-110-91-static.hfc.comcastbusiness.net [50.243.110.91])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8F29D14600CE7;
        Sat, 25 Aug 2018 17:33:04 -0700 (PDT)
Date:   Sat, 25 Aug 2018 17:33:03 -0700 (PDT)
Message-Id: <20180825.173303.2089439798101856039.davem@davemloft.net>
To:     geert@linux-m68k.org
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, arnd@arnd.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Revert "net: stmmac: fix build failure due to
 missing COMMON_CLK dependency"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180822132723.30047-1-geert@linux-m68k.org>
References: <20180822132723.30047-1-geert@linux-m68k.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 25 Aug 2018 17:33:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Aug 2018 15:27:23 +0200

> This reverts commit bde4975310eb1982bd0bbff673989052d92fd481.
> 
> All legacy clock implementations now implement clk_set_rate() (Some
> implementations may be dummies, though).
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Arnd Bergmann <arnd@arnd.de>
> Acked-by: Jose Abreu <joabreu@synopsys.com>
> ---
> Marked "RFC", as this depends on "m68k: coldfire: Normalize clk API" and
> "MIPS: AR7: Normalize clk API".
> 
> v2:
>   - Add Acked-by,
>   - Dropped RFC state, as all dependencies are now upstream:
>       - commit eec85fa9d98a889e ("m68k: coldfire: Normalize clk API"),
>       - commit 6b5939d2e528525a ("MIPS: AR7: Normalize clk API").

Applied, thank you.
