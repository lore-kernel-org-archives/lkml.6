Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940E3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536B1214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536B1214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbeISOQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:16:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:64550 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbeISOQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:16:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 01:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="263887951"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga005.fm.intel.com with SMTP; 19 Sep 2018 01:40:03 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Sep 2018 11:40:02 +0300
Date:   Wed, 19 Sep 2018 11:40:02 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        casey.g.bowman@intel.com,
        "Atwood, Matthew S" <matthew.s.atwood@intel.com>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: intel: Do pin translation in other GPIO
 operations as well
Message-ID: <20180919084002.GR14465@lahna.fi.intel.com>
References: <20180918153621.71984-1-mika.westerberg@linux.intel.com>
 <CACK8Z6F4+N1paQTSWcomnwLpLEHoospSOT3M9bqFQZHHfWmahA@mail.gmail.com>
 <CACK8Z6GfeJQSMN=m9hrFE2DFwpCNjNb57PqGiXFDD19Y=SXgnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6GfeJQSMN=m9hrFE2DFwpCNjNb57PqGiXFDD19Y=SXgnQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 03:14:44PM -0700, Rajat Jain wrote:
> Also consider fixing the checkpatch warning:
> 
>         Errors:
>             * checkpatch.pl errors/warnings
> 
>             WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>             #48: FILE: drivers/pinctrl/intel/pinctrl-intel.c:764:
>             +static int intel_gpio_to_pin(struct intel_pinctrl *pctrl,
> unsigned offset,

Right, it is currently the "convention" used in Intel pinctrl drivers so
I did not want to change that single entry.

We should eventually convert the whole set of Intel pinctrl drivers to
use unsigned int instead of unsigned.
