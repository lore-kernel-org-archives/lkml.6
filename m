Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C0FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2E020841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2E020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeGaWXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:23:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51612 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbeGaWXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:23:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 574B820875; Tue, 31 Jul 2018 22:41:34 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2C22C207AB;
        Tue, 31 Jul 2018 22:41:24 +0200 (CEST)
Date:   Tue, 31 Jul 2018 22:41:25 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v2 1/6] i2c: designware: use generic table matching
Message-ID: <20180731204125.GA1491@piout.net>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
 <20180731134740.441-2-alexandre.belloni@bootlin.com>
 <44e52856371e4b5c102df8f2efebd527fd26b066.camel@linux.intel.com>
 <0559c93256ae4f59aed278912bcbfd996e279839.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0559c93256ae4f59aed278912bcbfd996e279839.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2018 17:23:04+0300, Andy Shevchenko wrote:
> On Tue, 2018-07-31 at 17:02 +0300, Andy Shevchenko wrote:
> > On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
> > > Switch to device_get_match_data in probe to match the device
> > > specific
> > > data
> > > instead of using the acpi specific function.
> > > 
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Oops. See below.
> 
> > > -	id = acpi_match_device(pdev->dev.driver->acpi_match_table,
> > > &pdev->dev);
> > > -	if (id && id->driver_data)
> > > -		dev->flags |= (u32)id->driver_data;
> 

I'll change that cast to (uintptr_t). Else gcc complains about the size
mismatch on 64 bit platform. I'm letting kbuild play with my branch a
bit before sending v3.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
