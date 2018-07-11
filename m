Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC10208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fepgWUoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC10208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbeGKNKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732420AbeGKNKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:10:34 -0400
Received: from dragon (unknown [45.56.152.98])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE3C520883;
        Wed, 11 Jul 2018 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531314379;
        bh=FKrBwaf1p1HB6lp8gsCNHGiQareVgfRal/+baTn8+Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fepgWUoBsh/VjEYmIWZSpOXVdXDBMRKgF9EyMZIrFneAvm4Znd0VAWFhf+077sl7L
         Egdd7/f41JabaBYYvTv/W0y11Ce0Q9S7PvgubnjeY1Fk9KtqLKg2+tgyrZ9vBUo33Q
         7FrmLdR1oD3uUtEj3Hd79w1MkeKzVwADTQAnnGkc=
Date:   Wed, 11 Jul 2018 21:05:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: call imx6sx_cpuidle_init() conditionally for
 6sll
Message-ID: <20180711130543.GI6959@dragon>
References: <20180709155130.2126597-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709155130.2126597-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:51:17PM +0200, Arnd Bergmann wrote:
> The imx6sl platform has two different cpuidle implementations,
> and fails to link if we only want one of the two:
> 
> arch/arm/mach-imx/mach-imx6sl.o: In function `imx6sl_init_late':
> mach-imx6sl.c:(.init.text+0x12): undefined reference to `imx6sx_cpuidle_init'
> 
> This makes the call into reference conditional on the configuration.
> 
> Fixes: e7fa1fb39b11 ("ARM: imx: add cpu idle support for i.MX6SLL")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I had already sent a related patch earlier, but missed this second
> problem then.

Applied both, thanks.
