Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F1DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FB92081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FB92081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbeKGRgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 12:36:54 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36087 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeKGRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:36:54 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1gKIsA-0006rM-9f; Wed, 07 Nov 2018 09:07:34 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1gKIs9-0000fA-K9; Wed, 07 Nov 2018 09:07:33 +0100
Date:   Wed, 7 Nov 2018 09:07:33 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubifs: CONFIG_UBIFS_FS_AUTHENTICATION should depend on
 UBIFS_FS
Message-ID: <20181107080733.ojderb7dkvwtpl2i@pengutronix.de>
References: <20181105082540.21205-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105082540.21205-1-geert@linux-m68k.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:06:01 up 147 days, 17:15, 120 users,  load average: 0.48, 0.79,
 0.49
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 09:25:40AM +0100, Geert Uytterhoeven wrote:
> Instead of adding yet another dependency on UBIFS_FS, wrap the whole
> block of ubifs config options in a single "if UBIFS_FS".
> 
> Fixes: d8a22773a12c6d78 ("ubifs: Enable authentication support")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  fs/ubifs/Kconfig | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

I would have sent a similar patch with taking the easier way out of just
adding another "depends on UBIFS_FS". This one is nicer though.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
