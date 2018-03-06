Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753911AbeCFOt1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:49:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38051 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753849AbeCFOtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:49:23 -0500
Date: Tue, 6 Mar 2018 15:49:22 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: at91sam: add 'depends on HAS_IOMEM' to fix unmet
 dependency
Message-ID: <20180306144922.GU3035@piout.net>
References: <1520334491-7078-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520334491-7078-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2018 at 20:08:11 +0900, Masahiro Yamada wrote:
> This config select's MFD_SYSCON, but does not depend on HAS_IOMEM.
> 
> Compile testing on architecture without HAS_IOMEM causes "unmet
> direct dependencies" in Kconfig phase.
> 
> Detected by "make ARCH=score allyesconfig".
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Arnd Bergmann and I discussed how to fix unmet dependency of MFD_SYSCON.
> https://lkml.org/lkml/2018/2/27/284
> 
> We agreed to add 'depends on HAS_IOMEM' to drivers causing
> unmet dependency.
> 
> 
>  drivers/rtc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
