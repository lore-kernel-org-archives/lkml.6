Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6437C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FEE2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FEE2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbeJLA36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:29:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:36745 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbeJLA36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:29:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 10:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="80687194"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2018 10:01:49 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gAeLM-0004iL-Ip; Thu, 11 Oct 2018 20:01:48 +0300
Date:   Thu, 11 Oct 2018 20:01:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Petr Mladek <pmladek@suse.com>, "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] lib/vsprintf: Hash remaining raw addresses
Message-ID: <20181011170148.GM15943@smile.fi.intel.com>
References: <20181011084249.4520-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011084249.4520-1-geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 10:42:46AM +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> There are still two format specifiers that print unhanced kernel
> addresses, potentially leaking sensitive information regarding the
> kernel layout in memory.
> 
> This patch series fixes this by printing hashed addresses instead.

Looks nice!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>     
> Changes compared to v1:
>   - Get rid of the forward declaration for ptr_to_id(),
>   - Add Reviewed-by.
> 
> Thanks!
> 
> Geert Uytterhoeven (3):
>   lib/vsprintf: Prepare for more general use of ptr_to_id()
>   lib/vsprintf: Hash legacy clock addresses
>   lib/vsprintf: Hash printed address for netdev bits fallback
> 
>  Documentation/core-api/printk-formats.rst |   5 +-
>  lib/vsprintf.c                            | 216 +++++++++++-----------
>  2 files changed, 110 insertions(+), 111 deletions(-)
> 
> -- 
> 2.17.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

-- 
With Best Regards,
Andy Shevchenko


