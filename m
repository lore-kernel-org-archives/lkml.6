Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C1DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226542086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226542086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeJLSMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:12:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:49994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726665AbeJLSMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:12:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BF41AD66;
        Fri, 12 Oct 2018 10:40:25 +0000 (UTC)
Date:   Fri, 12 Oct 2018 12:40:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] lib/vsprintf: Hash printed address for netdev
 bits fallback
Message-ID: <20181012104024.7kzqyyhcjrnwljtd@pathway.suse.cz>
References: <20181011084249.4520-1-geert+renesas@glider.be>
 <20181011084249.4520-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011084249.4520-4-geert+renesas@glider.be>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-10-11 10:42:49, Geert Uytterhoeven wrote:
> The handler for "%pN" falls back to printing the raw pointer value when
> using a different format than the (sole supported) special format
> "%pNF", potentially leaking sensitive information regarding the kernel
> layout in memory.
> 
> Avoid this leak by printing the hashed address instead.
> Note that there are no in-tree users of the fallback.
> 
> Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

I have pushed this patch into printk.git,
branch for-4.20-vsprintf-hash-fixes.

Best Regards,
Petr
