Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030727AbeEYWbp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 18:31:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55820 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030698AbeEYWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 18:31:41 -0400
X-Google-Smtp-Source: ADUXVKIHNeE9SOuyIOSe7CUjNqX3/vAmmkHusdlZM4XhwJrEBD248Ot9E+0qZltWxgARfGTvzA+1bg==
Date: Fri, 25 May 2018 15:26:49 -0700
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: stm32: Don't select DMA unconditionally on
 STM32MP157C
Message-ID: <20180525222649.adxut6t7w53ugykx@localhost>
References: <20180525160926.150713-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525160926.150713-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 06:09:13PM +0200, Arnd Bergmann wrote:
> The patch that enabled these had no useful changelog that explains
> why it is done, and it causes a build warning:
> 
> WARNING: unmet direct dependencies detected for STM32_DMA
>   Depends on [n]: DMADEVICES [=n] && (ARCH_STM32 [=y] || COMPILE_TEST [=y])
>   Selected by [y]:
>   - MACH_STM32MP157 [=y] && ARCH_STM32 [=y] && ARCH_MULTI_V7 [=y]
> 
> Generally, platforms should not select arbitrary drivers, so let's
> just revert that change.
> 
> Fixes: de6037fa207f ("ARM: stm32: Select DMA, DMAMUX and MDMA support on STM32MP157C")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to next/soc now.


-Olof
