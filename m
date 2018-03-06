Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbeCFNVT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:21:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40165 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752936AbeCFNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:21:18 -0500
Message-ID: <1520342476.3375.9.camel@pengutronix.de>
Subject: Re: [PATCH] reset: imx7: add 'depends on HAS_IOMEM' to fix unmet
 dependency
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Date: Tue, 06 Mar 2018 14:21:16 +0100
In-Reply-To: <1520334911-9752-1-git-send-email-yamada.masahiro@socionext.com>
References: <1520334911-9752-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Tue, 2018-03-06 at 20:15 +0900, Masahiro Yamada wrote:
> This config select's MFD_SYSCON, but does not depend on HAS_IOMEM.
> 
> Compile testing on architecture without HAS_IOMEM causes "unmet
> direct dependencies" in Kconfig phase.
> 
> Detected by "make ARCH=score allyesconfig".
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thank you, applied to reset/next.

> 
> ---
> 
> Arnd Bergmann and I discussed how to fix unmet dependency of MFD_SYSCON.
> https://lkml.org/lkml/2018/2/27/284
> 
> We agreed to add 'depends on HAS_IOMEM' to drivers causing
> unmet dependency.

Agreed, RESET_TI_SYSCON already does the same. Thanks for the context.

regards
Philipp
