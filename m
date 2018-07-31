Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5FBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9E120870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9E120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbeGaP6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:58:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:65082 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732255AbeGaP6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:58:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 07:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,427,1526367600"; 
   d="scan'208";a="250488534"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jul 2018 07:17:47 -0700
Message-ID: <6e7a3b340635f73e3c748b97184b181b7698b978.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/6] Add support for MSCC Ocelot i2c
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
Date:   Tue, 31 Jul 2018 17:17:47 +0300
In-Reply-To: <20180731134740.441-1-alexandre.belloni@bootlin.com>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
> Hi,
> 
> Because the designware IP was not able to handle the SDA hold time
> before
> version 1.11a, MSCC has its own implementation. Add support for it and
> then add
> i2c on ocelot boards.
> 
> I would expect patches 1 to 4 to go through the i2c tree and 5-6
> through
> the mips tree once patch 4 has been reviewed by the DT maintainers.
> 

Thanks for an update, looks quite nice!
I gave my tags wherever it is appropriate.

> Changes in v2:
>  - removed first patch as a similar one is in i2c-next

>  - rebase on top of i2c-next

It seems you also took my patches which are not yet in i2c/for-next.

>  - Added two patches to implement ideas from Andy
> 
> Alexandre Belloni (6):
>   i2c: designware: use generic table matching
>   i2c: designware: move #ifdef CONFIG_OF to the top
>   i2c: designware: allow IP specific sda_hold_time
>   i2c: designware: add MSCC Ocelot support
>   mips: dts: mscc: Add i2c on ocelot
>   mips: dts: mscc: enable i2c on ocelot_pcb123
> 
>  .../bindings/i2c/i2c-designware.txt           |  9 ++-
>  arch/mips/boot/dts/mscc/ocelot.dtsi           | 18 ++++++
>  arch/mips/boot/dts/mscc/ocelot_pcb123.dts     |  6 ++
>  drivers/i2c/busses/i2c-designware-common.c    |  2 +
>  drivers/i2c/busses/i2c-designware-core.h      |  4 ++
>  drivers/i2c/busses/i2c-designware-platdrv.c   | 62 +++++++++++++++---
> -
>  6 files changed, 87 insertions(+), 14 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
