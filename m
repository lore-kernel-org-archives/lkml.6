Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3F7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1969A2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1969A2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbeGTUTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:19:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34841 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388180AbeGTUTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:19:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2A6C62097D; Fri, 20 Jul 2018 21:29:54 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.220.171])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9C2E120717;
        Fri, 20 Jul 2018 21:29:42 +0200 (CEST)
Date:   Fri, 20 Jul 2018 21:29:41 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [RFC PATCH 4/8] mtd: rawnand: ams-delta: Optimize pointer
 resolution on read/write
Message-ID: <20180720212941.628600da@bbrezillon>
In-Reply-To: <9888773.rgnYII6m0f@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180718235710.18242-5-jmkrzyszt@gmail.com>
        <20180719082538.222396bf@bbrezillon>
        <9888773.rgnYII6m0f@z50>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 20:14:55 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> On Thursday, July 19, 2018 8:25:38 AM CEST Boris Brezillon wrote:
> > On Thu, 19 Jul 2018 01:57:06 +0200
> > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> >   
> > > Further optimize processing speed of read/write callback functions by
> > > resolving private structure pointer only once per callback and passing
> > > it to all subfunctions instead of mtd_info.  
> 
> OK, I'll call it simplification (the code looks more simple after that, doesn't 
> it),

Yep.

> not optimization if you agree.
> 
> Thanks,
> Janusz
> 
> 
> 

