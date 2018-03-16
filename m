Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932890AbeCPAug (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 20:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932227AbeCPAuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 20:50:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14D1204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 16 Mar 2018 08:49:34 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Bai Ping <ping.bai@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: imx: select ARM_CPU_SUSPEND for CPU_IDLE as well
Message-ID: <20180316004933.GN26859@dragon>
References: <20180315151345.3089601-1-arnd@arndb.de>
 <20180315151345.3089601-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315151345.3089601-2-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 04:13:19PM +0100, Arnd Bergmann wrote:
> The cpuidle support calls cpu_suspend(), which is compiled conditionally,
> and fails to link unless something selects CONFIG_ARM_CPU_SUSPEND.
> 
> arch/arm/mach-imx/cpuidle-imx6sx.o: In function `imx6sx_enter_wait':
> cpuidle-imx6sx.c:(.text+0x6c): undefined reference to `cpu_suspend'
> 
> This adds an explicit select statement here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Shawn Guo <shawnguo@kernel.org>
