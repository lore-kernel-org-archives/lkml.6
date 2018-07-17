Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDA2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526B120C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526B120C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbeGQOv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:51:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:48141 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731574AbeGQOv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:51:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 07:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="72088441"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2018 07:18:33 -0700
Message-ID: <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms@verge.net.au>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Tue, 17 Jul 2018 17:18:32 +0300
In-Reply-To: <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
         <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
         <20180717120737.bipotpki3yhn6klf@verge.net.au>
         <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
         <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 12:42 +0000, Phil Edworthy wrote:

> > While your point sounds valid (don't remember how clk_get() is
> > implemented), NULL is also OK to have.
> 
> Ok as in there is no bus clock, right?
> So it should be:
>  if (!IS_ERR_OR_NULL (dev->busclk))

Nope, NULL is no error case for optional clock.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
