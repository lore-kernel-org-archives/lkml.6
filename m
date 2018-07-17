Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991CAECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518302083C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518302083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbeGQNDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:03:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38310 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731314AbeGQNDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:03:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7267E20765; Tue, 17 Jul 2018 14:31:18 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4315B207B4;
        Tue, 17 Jul 2018 14:31:08 +0200 (CEST)
Date:   Tue, 17 Jul 2018 14:31:08 +0200
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
Subject: Re: [PATCH 1/5] i2c: designware: factorize setting SDA hold time
Message-ID: <20180717123108.GA23935@piout.net>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
 <20180717114837.21839-2-alexandre.belloni@bootlin.com>
 <5a1846aa7c03cc889f072d1aab6967ff254b49de.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a1846aa7c03cc889f072d1aab6967ff254b49de.camel@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2018 15:11:50+0300, Andy Shevchenko wrote:
> On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> > Factorize setting the SDA hold time in a new function
> > i2c_dw_set_sda_hold_time() that is used for both master and slave
> > mode.
> > 
> > This conveniently pulls the fix for the spurious warning from commit
> > 7a20e707aae2 ("i2c: designware: suppress unneeded SDA hold time
> > warnings")
> > in slave mode.
> 
> Isn't this a duplication of 
> 
> commit 1080ee7e28e1cea86310739e5dd4612868768aed
> Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Date:   Tue Jun 19 14:23:22 2018 +0300
> 
>     i2c: designware: Move SDA hold time configuration to common code
> 
> ?
> 

Indeed, I was on 4.18-rc1, not -next.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
