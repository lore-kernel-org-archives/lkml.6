Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3808C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA24B20875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA24B20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbeGKO1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:27:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:33885 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387949AbeGKO1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:27:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 07:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="73957147"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2018 07:23:15 -0700
Message-ID: <d2ba8f992c272543d689d87006e99c3bcf343605.camel@linux.intel.com>
Subject: Re: [PATCH v4 3/3] serial: 8250_dw: add fractional divisor support
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Date:   Wed, 11 Jul 2018 17:23:13 +0300
In-Reply-To: <20180711144125.7d4e6a73@xhacker.debian>
References: <20180710110942.5b0a016e@xhacker.debian>
         <20180710111516.13b8c570@xhacker.debian>
         <8c5b6bbbde12b0836e1f833c86b805a817596654.camel@linux.intel.com>
         <20180711144125.7d4e6a73@xhacker.debian>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 14:41 +0800, Jisheng Zhang wrote:
> On Tue, 10 Jul 2018 19:19:21 +0300 Andy Shevchenko wrote:

> > > +/*
> > > + * divisor = div(I) + div(F)
> > > + * "I" means integer, "F" means fractional
> > > + * quot = div(I) = clk / (16 * baud)
> > > + * frac = div(F) * 2^dlf_size
> > > + *
> > > + * let rem = clk % (16 * baud)
> > > + * we have: div(F) * (16 * baud) = rem
> > > + * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) /
> > > (16
> > > * baud)
> > > + */

> > > +	quot = p->uartclk / (16 * baud);
> > > +	rem = p->uartclk % (16 * baud);
> > > +	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, 16 * baud

> My python coding skill is limited. So I wrote a simple c program to
> do the check for common clks and baudrate combination. All passed. I
> paste the code here:
> 

OK, I wrote test case in Python:
https://gist.github.com/andy-shev/5e980f1d752617ba814725248556ac19

Looks good to me.

Please, send v6 and assume my Reviewed-by for entire series.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
