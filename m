Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F929C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E5E21A38
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="LgCq2F6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E5E21A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=linux-watchdog.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbeHFRs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:48:28 -0400
Received: from www.linux-watchdog.org ([185.87.125.42]:45946 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbeHFRs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:48:28 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Aug 2018 13:48:27 EDT
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 41ADF4067D; Mon,  6 Aug 2018 17:14:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 41ADF4067D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1533568449;
        bh=JneeQ9cHGl0czOiKgt44QH2jJYFKtX0Ag3QIkfxVXXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgCq2F6YumO65J+sWPyVPemnMl4EQgsnC2dP1atY7b6qEssSD/z8HdWjR4A4XT39h
         8LFQUTiYUrgrcBcEDI+7N/+96GXBPZBISulnBdAGWeaiusnBAyR/j0IWlORwhwH++E
         ZmhFuNGjCaBvcbvvgrZWkvlwG9JvWE+88IyHrxyo=
Date:   Mon, 6 Aug 2018 17:14:09 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: linux-next: Tree for Aug 3 (watchdog/menz69_wdt.c)
Message-ID: <20180806151409.GA12969@www.linux-watchdog.org>
References: <20180803192942.6975df0c@canb.auug.org.au>
 <9d17144d-6f19-781f-8abc-1ee1c6f840bd@infradead.org>
 <20180803164024.tfujwvz2s6ekvjpv@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180803164024.tfujwvz2s6ekvjpv@linux-x5ow.site>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

> On Fri, Aug 03, 2018 at 08:39:48AM -0700, Randy Dunlap wrote:
> > On 08/03/2018 02:29 AM, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20180802:
> > > 
> > 
> > Hi,
> > 
> > On i386 randconfig with COMPILE_TEST=y and MCB not enabled, I see:
> > 
> > drivers/watchdog/menz69_wdt.o: In function `men_z069_remove':
> > menz69_wdt.c:(.text+0xa6): undefined reference to `mcb_release_mem'
> > drivers/watchdog/menz69_wdt.o: In function `men_z069_probe':
> > menz69_wdt.c:(.text+0xdb): undefined reference to `mcb_request_mem'
> > menz69_wdt.c:(.text+0x14a): undefined reference to `mcb_release_mem'
> > drivers/watchdog/menz69_wdt.o: In function `men_z069_driver_init':
> > menz69_wdt.c:(.init.text+0x15): undefined reference to `__mcb_register_driver'
> > drivers/watchdog/menz69_wdt.o: In function `men_z069_driver_exit':
> > menz69_wdt.c:(.exit.text+0x9): undefined reference to `mcb_unregister_driver'
> > 
> > 
> > The Kconfig for MENZ069_WATCHDOG says:
> > config MENZ069_WATCHDOG
> > 	tristate "MEN 16Z069 Watchdog"
> > 	depends on MCB || COMPILE_TEST
> > 	select WATCHDOG_CORE
> > 
> > Looks to me like the driver really depends on MCB, unless someone wants
> > to add stubs in <linux/mcb.h>.
> 
> *doh* looks like a copy & paste error. Wim can you fold that one in
> (or stage to your tree)?

Added in my tree.

Kind regards,
Wim.

> >From ae045015849cd15fd180e20f44d364e7a37c39c6 Mon Sep 17 00:00:00 2001
> From: Johannes Thumshirn <jthumshirn@suse.de>
> Date: Fri, 3 Aug 2018 18:35:17 +0200
> Subject: [PATCH] watchdog: fix dependencies  of menz69_wdt.o
> 
> Currently menz69_wdt.ko has a dependency on MCB or COMPILE_TEST. But
> it actually needs symbols exported by MCB so the || COMPILE_TEST is
> wrong.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index df55d65bbb1c..5ea8909a41f9 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -163,7 +163,7 @@ config MENF21BMC_WATCHDOG
>  
>  config MENZ069_WATCHDOG
>  	tristate "MEN 16Z069 Watchdog"
> -	depends on MCB || COMPILE_TEST
> +	depends on MCB
>  	select WATCHDOG_CORE
>  	help
>  	  Say Y here to include support for the MEN 16Z069 Watchdog.
> -- 
> 2.16.4
> 
> 
> 
> -- 
> Johannes Thumshirn                                          Storage
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
> Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
