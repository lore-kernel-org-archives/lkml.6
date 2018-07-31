Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E75C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EEB20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EEB20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbeGaQeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:34:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:51590 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732268AbeGaQeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:34:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 07:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,427,1526367600"; 
   d="scan'208";a="77077434"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2018 07:53:18 -0700
Message-ID: <1cbe4c184a0a6db1fc5401dbd8bd3a9f6bf22527.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/6] i2c: designware: use generic table matching
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Date:   Tue, 31 Jul 2018 17:53:17 +0300
In-Reply-To: <20180731143059.GV28585@piout.net>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
         <20180731134740.441-2-alexandre.belloni@bootlin.com>
         <44e52856371e4b5c102df8f2efebd527fd26b066.camel@linux.intel.com>
         <0559c93256ae4f59aed278912bcbfd996e279839.camel@linux.intel.com>
         <20180731143059.GV28585@piout.net>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 16:30 +0200, Alexandre Belloni wrote:
> On 31/07/2018 17:23:04+0300, Andy Shevchenko wrote:
> > On Tue, 2018-07-31 at 17:02 +0300, Andy Shevchenko wrote:
> > > On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
 
> > > > +	dev->flags |= (u32)device_get_match_data(&pdev->dev);
> > > > +
> > 
> > And since it would be changed anyway, can you actually move this
> > line
> > closet to  if (has_acpi_companion()) one ?
> > 
> 
> I need that value to be set before calling of_configure though.

AFAICS, you added those lines later, so, it would be something like

dev->flags |= ...

if (of_node)
 of_configure()
if (has_acpi_companion())
 acpi_configure()

Would it work for you?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
