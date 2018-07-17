Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B71AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215F12075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215F12075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGQMoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:44:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:42788 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbeGQMoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:44:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 05:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="54990250"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2018 05:11:51 -0700
Message-ID: <5a1846aa7c03cc889f072d1aab6967ff254b49de.camel@linux.intel.com>
Subject: Re: [PATCH 1/5] i2c: designware: factorize setting SDA hold time
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Date:   Tue, 17 Jul 2018 15:11:50 +0300
In-Reply-To: <20180717114837.21839-2-alexandre.belloni@bootlin.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
         <20180717114837.21839-2-alexandre.belloni@bootlin.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> Factorize setting the SDA hold time in a new function
> i2c_dw_set_sda_hold_time() that is used for both master and slave
> mode.
> 
> This conveniently pulls the fix for the spurious warning from commit
> 7a20e707aae2 ("i2c: designware: suppress unneeded SDA hold time
> warnings")
> in slave mode.

Isn't this a duplication of 

commit 1080ee7e28e1cea86310739e5dd4612868768aed
Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date:   Tue Jun 19 14:23:22 2018 +0300

    i2c: designware: Move SDA hold time configuration to common code

?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
