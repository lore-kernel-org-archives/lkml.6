Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A8BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070D6205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070D6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbeKTE25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:28:57 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:51978 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbeKTE24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:28:56 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-71-135-nat.elisa-mobile.fi [85.76.71.135])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 192AD3000C;
        Mon, 19 Nov 2018 20:04:18 +0200 (EET)
Date:   Mon, 19 Nov 2018 20:04:18 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        linux-mmc@vger.kernel.org, Andrzej Zaborowski <balrogg@gmail.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5912/OMAP310
Message-ID: <20181119180418.GD16897@darkstar.musicnaut.iki.fi>
References: <20181118201919.14401-1-aaro.koskinen@iki.fi>
 <ffdad271-943c-f4e7-8ec9-2af5769798a4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffdad271-943c-f4e7-8ec9-2af5769798a4@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 19, 2018 at 11:58:32AM +0200, Peter Ujfalusi wrote:
> On 2018-11-18 22:19, Aaro Koskinen wrote:
> > Tested on OMAP15XX/OMAP310 (Palm TE), OMAP1710 (Nokia 770)
> > and OMAP2420 (Nokia N810).
> 
> Do you know if the DMA is enabled for the MMC? It might not work via
> DMAengine.

DMA is enabled for MMC, and works OK on all of these devices.

A.
