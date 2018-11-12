Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54370C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268EB223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268EB223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbeKMBuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:50:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57997 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMBuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:50:18 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gMEZd-0000Yj-Nl; Mon, 12 Nov 2018 16:56:25 +0100
Message-ID: <1542038185.4011.5.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/4] Correct dma pool for imx-sdma
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Mon, 12 Nov 2018 16:56:25 +0100
In-Reply-To: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
References: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Am Dienstag, den 06.11.2018, 03:40 +0000 schrieb Robin Gong:
> This patch set to correct dma pool used in the commit fe5b85c656bc
> ("dmaengine: imx-sdma: alloclate bd memory from dma pool")
> because all bds should be contiguous in memory in multi bds case
> for sdma, but dma pool can't statify it and cause transfer failure
> then.Thank Lucas for the making things on the right way.
> 
> This patch set is v3 based on Lucas's V1/V2, the main refine:
>   --fix the issue I reported in V1 but Lucas workaround it by improper
>     way in V2.
>   --add vchan_synchronize() to kill tasklet in virt-dma internal.
>   --refine name: use sdma_disable_channel_async instead of
>     sdma_disable_channel_with_delay since no delay indeed for
>     device_terminate_all.
> Please refer to below link for more information:
> https://patchwork.kernel.org/patch/10601111

Thanks for taking care of those. I've tested them on my board and
things seem to work fine for all my use-cases.

I think those patches should get a CC to stable 4.19. I guess Vinod can
add this when applying the patchset.

Regards,
Lucas
