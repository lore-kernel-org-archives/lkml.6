Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888F7C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597302087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597302087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJIVWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:22:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:56464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbeJIVWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:22:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B35FAD4C;
        Tue,  9 Oct 2018 14:05:41 +0000 (UTC)
Date:   Tue, 9 Oct 2018 16:05:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/3] lib/vsprintf: Hash legacy clock addresses
Message-ID: <20181009140540.mz77x5a7bfmupxbb@pathway.suse.cz>
References: <20181008110504.25449-1-geert+renesas@glider.be>
 <20181008110504.25449-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008110504.25449-3-geert+renesas@glider.be>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-10-08 13:05:03, Geert Uytterhoeven wrote:
> On platforms using the Common Clock Framework, "%pC" prints the clock's
> name. On legacy platforms, it prints the unhashed clock's address,
> potentially leaking sensitive information regarding the kernel layout in
> memory.
> 
> Avoid this leak by printing the hashed address instead.  To distinguish
> between clocks, a 32-bit unique identifier is as good as an actual
> pointer value.
> 
> Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

It makes sense.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
