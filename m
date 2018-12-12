Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CEBC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9ADF20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9ADF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeLLW1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:27:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52554 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbeLLW1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:27:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 993AA20743; Wed, 12 Dec 2018 23:27:10 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4ECD820723;
        Wed, 12 Dec 2018 23:27:10 +0100 (CET)
Date:   Wed, 12 Dec 2018 23:27:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: DT for 4.21
Message-ID: <20181212222710.GK19816@piout.net>
References: <20181211171112.GA30925@piout.net>
 <20181212210553.jk4uznjimi37fd7p@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212210553.jk4uznjimi37fd7p@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2018 13:05:53-0800, Olof Johansson wrote:
> On Tue, Dec 11, 2018 at 06:11:12PM +0100, Alexandre Belloni wrote:
> > Arnd, Olof,
> > 
> > Here is the DT pull request for 4.21. The clock DT binding switch has
> > been in -next for a while and doesn't seem to have any issue.
> > 
> > This is based on the 4.20 fixes branch that you alredy pulled.
> > 
> > The following changes since commit 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14:
> > 
> >   ARM: dts: at91: sama5d2: use the divided clock for SMC (2018-11-21 11:50:32 +0100)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.21-dt
> > 
> > for you to fetch changes up to d8007306f6ad18f2ba0dcad68ffe9b2fd1d56bfb:
> > 
> >   ARM: dts: at91: nattis: initialize the BLON pin as output-low early (2018-11-21 12:24:50 +0100)
> > 
> > ----------------------------------------------------------------
> > AT91 DT for 4.21
> > 
> >  - Switch most platforms to the new clock binding
> >  - Small improvement for Axentia nattis
> 
> Merged, but how does this affect downstream users who have out-of-tree DTS
> files that include the SoC dtsi? Seems like lots of stuff would break.
> 

A few may break indeed. However, there are very few clocks that are
actually exported out of the SoC (2 to 4) and they are very rarely used
(usually only one to clock an audio codec).
The other affected dts are the boards using the flexcom and my opinion
is that we should probably get the flexcom stuff back in the dtsi
anyway..

So yes, some out of tree board dts may break but they are pretty easy to
fix. Also, the DT ABI compatibility is not broken so I don't expect too
much breakage overall.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
