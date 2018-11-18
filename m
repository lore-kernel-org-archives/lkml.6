Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B539FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817E72080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817E72080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeKSJFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 04:05:46 -0500
Received: from muru.com ([72.249.23.125]:54426 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbeKSJFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 04:05:45 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1F9A78081;
        Sun, 18 Nov 2018 22:44:11 +0000 (UTC)
Date:   Sun, 18 Nov 2018 14:44:07 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Andrzej Zaborowski <balrogg@gmail.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5912/OMAP310
Message-ID: <20181118224407.GO53235@atomide.com>
References: <20181118201919.14401-1-aaro.koskinen@iki.fi>
 <20181118222043.GA23485@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118222043.GA23485@lenoch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [181118 22:22]:
> Aaro,
> 
> On Sun, Nov 18, 2018 at 10:19:19PM +0200, Aaro Koskinen wrote:
> > Since v2.6.22 or so there has been reports [1] about OMAP MMC being
> > broken on OMAP15XX based hardware (OMAP5912 and OMAP310). The breakage
> > seems to have been caused by commit 46a6730e3ff9 ("mmc-omap: Fix
> > omap to use MMC_POWER_ON") that changed clock enabling to be done
> > on MMC_POWER_ON. This can happen multiple times in a row, and on 15XX
> > the hardware doesn't seem to like it and the MMC just stops responding.
> > Fix by memorizing the power mode and do the init only when necessary.
> 
> I'm going to use this patch as an argument against anybody complaining
> kernel bugs do not get fixed. People just need to teach themselves to
> be patient.

Yup, good to have more usable devices :) And thanks for fixing it:

Acked-by: Tony Lindgren <tony@atomide.com>
