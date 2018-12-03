Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AA6C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0272087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0272087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbeLCNbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:31:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:56905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeLCNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:31:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 05:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,310,1539673200"; 
   d="scan'208";a="95708227"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 03 Dec 2018 05:30:42 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gToJ6-0001oo-Lb; Mon, 03 Dec 2018 15:30:40 +0200
Date:   Mon, 3 Dec 2018 15:30:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name()
 error values
Message-ID: <20181203133040.GN10650@smile.fi.intel.com>
References: <20181203111309.3709-1-phil.edworthy@renesas.com>
 <20181203111309.3709-2-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203111309.3709-2-phil.edworthy@renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:13:08AM +0000, Phil Edworthy wrote:
> It's not immediately obvious from the code that failure to get a
> clock provider can return either -ENOENT or -EINVAL. Therefore, add
> a comment to highlight this.

> +/*
> + * Beware the return values when np is valid, but no clock provider is found.
> + * If name = NULL, the function returns -ENOENT.
> + * If name != NULL, the function returns -EINVAL. This is because __of_clk_get()

I would start new sentence from new line
(this will emphasize the possible variants)

 * This is ...

 Otherwise looks good to me:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> + * is called even if of_property_match_string() returns an error.
> + */
>  static struct clk *__of_clk_get_by_name(struct device_node *np,
>  					const char *dev_id,
>  					const char *name)
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


