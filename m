Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C058ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E1A21476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E1A21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeJRC2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:28:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35420 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeJRC2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:28:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9CAEF207BF; Wed, 17 Oct 2018 20:31:23 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 69A5920703;
        Wed, 17 Oct 2018 20:31:13 +0200 (CEST)
Date:   Wed, 17 Oct 2018 20:31:14 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: atmel-ssc: Fix section annotation on
 atmel_ssc_get_driver_data
Message-ID: <20181017183114.GZ17341@piout.net>
References: <20181017170901.13119-1-natechancellor@gmail.com>
 <20181017181625.GW17341@piout.net>
 <20181017182031.GA9678@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017182031.GA9678@flashbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2018 11:20:31-0700, Nathan Chancellor wrote:
> On Wed, Oct 17, 2018 at 08:16:25PM +0200, Alexandre Belloni wrote:
> > On 17/10/2018 10:09:02-0700, Nathan Chancellor wrote:
> > > After building the kernel with Clang, the following section mismatch
> > > warning appears:
> > > 
> > > WARNING: vmlinux.o(.text+0x3bf19a6): Section mismatch in reference from
> > > the function ssc_probe() to the function
> > > .init.text:atmel_ssc_get_driver_data()
> > > The function ssc_probe() references
> > > the function __init atmel_ssc_get_driver_data().
> > > This is often because ssc_probe lacks a __init
> > > annotation or the annotation of atmel_ssc_get_driver_data is wrong.
> > > 
> > > Remove __init from atmel_ssc_get_driver_data to get rid of the mismatch.
> > > 
> > 
> > Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > 
> > I would add:
> > 
> > Fixes: 5c86ac695c7e ("ASoC: atmel-ssc: use module_platform_driver macro")
> > 
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > > 
> > > Alternatively, ssc_probe could be marked as __init, I don't think there
> > > is any way for the probe to defer. I decided to go with the more
> > > conservative option first but I'm happy to respin if necessary.
> > > 
> > 
> > A probe function should never be marked __init, unless you ensure there
> > is no way to bind/unbind the driver at runtime.
> > 
> 
> Thank you for the review and that clarification, wasn't able to find
> much regarding __init on probe functions in my research.
> 

You can look for suppress_bind_attrs for more info.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
