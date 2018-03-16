Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeCPAtq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 20:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752640AbeCPAto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 20:49:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA40821742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 16 Mar 2018 08:48:45 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Bai Ping <ping.bai@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: imx: fix imx6sll-only build
Message-ID: <20180316004843.GM26859@dragon>
References: <20180315151345.3089601-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315151345.3089601-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 04:13:18PM +0100, Arnd Bergmann wrote:
> When selecting SOC_IMX6SLL but not SOC_IMX6SL, we get a link error:
> 
> arch/arm/mach-imx/mach-imx6sl.o: In function `imx6sl_init_late':
> mach-imx6sl.c:(.init.text+0x14): undefined reference to `imx6sl_cpuidle_init'
> 
> This adds the missing line to the Makefile to also build the cpuidle
> support that we need here.
> 
> Fixes: dee5dee2a5b2 ("ARM: imx: Add basic msl support for imx6sll")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Shawn Guo <shawnguo@kernel.org>
