Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30EBC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C9B21A12
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C9B21A12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbeHGBaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:30:25 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:14094 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730444AbeHGBaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:30:25 -0400
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 2CECCDC7;
        Mon,  6 Aug 2018 23:19:03 +0000 (UTC)
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 065728D;
        Mon,  6 Aug 2018 23:19:02 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.34.81.6])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 70A275D;
        Mon,  6 Aug 2018 23:19:01 +0000 (UTC)
Date:   Mon, 6 Aug 2018 17:19:01 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] watchdog: hpwdt: Display module parameters.
Message-ID: <20180806231901.GA32467@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-4-git-send-email-jerry.hoemann@hpe.com>
 <ba07e5f3-282f-0417-236d-57289d33f56c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba07e5f3-282f-0417-236d-57289d33f56c@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 06:13:20PM -0700, Guenter Roeck wrote:
> On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> > Print module parameters when the driver is loaded.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >   drivers/watchdog/hpwdt.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index 8a85ddd..f098371 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -326,8 +326,9 @@ static int hpwdt_init_one(struct pci_dev *dev,
> >   	}
> >   	dev_info(&dev->dev, "HPE Watchdog Timer Driver: %s"
> > -			", timer margin: %d seconds (nowayout=%d).\n",
> > -			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
> > +		", timeout : %d seconds (nowayout=%d) pretimeout=%s.\n",
> > +		HPWDT_VERSION, hpwdt_dev.timeout, nowayout,
> > +		pretimeout ? "on" : "off");
> When touching that, you might as well address
> 
> WARNING: quoted string split across lines


k. Think I'll split into two dev_info calls as line is too long
to fit into 80 chars w/o splitting.


> 
> Why did you add a space before ':' ? Personal preference ?

I think you're referring to "timeout : %d seconds".  Bad editting when
going from "timer margin:" to "timeout :".  I'll fix.

If you referring to the spaces around the ternary operator, that is
in coding-style although checkpatch accepts w/o spaces around the
operators.


> 
> Guenter
> 
> >   	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
> >   		ilo5 = true;
> > 

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
