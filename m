Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeBVQnl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:43:41 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36665 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933197AbeBVQnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:43:39 -0500
X-Google-Smtp-Source: AH8x227WRxAZ/uO86JxCIUe7ROXw4aHuU7TEcDutQemNPU+DpsmJ2e/ZOjpBNNsNyp6n98eKBRHZOeydXFPshEqoGqE=
MIME-Version: 1.0
In-Reply-To: <20180220162519.1498223-3-arnd@arndb.de>
References: <20180220162519.1498223-1-arnd@arndb.de> <20180220162519.1498223-3-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 17:43:38 +0100
X-Google-Sender-Auth: EbxBb-gsB8QUpG71GYYJa2_C0X4
Message-ID: <CAK8P3a2gWP-i0X=3dom4aCMfKgmf41a27Huj9919Epnwg26JoA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: davinci: mark spi_board_info arrays as const
To: arm-soc <arm@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 5:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Building with LTO revealed that three spi_board_info arrays are marked
> __initconst, but not const:
>
> arch/arm/mach-davinci/board-dm365-evm.c: In function 'dm365_evm_init':
> arch/arm/mach-davinci/board-dm365-evm.c:729:30: error: 'dm365_evm_spi_info' causes a section type conflict with 'dm646x_edma_device'
>  static struct spi_board_info dm365_evm_spi_info[] __initconst = {
>                               ^
> arch/arm/mach-davinci/dm646x.c:603:42: note: 'dm646x_edma_device' was declared here
>  static const struct platform_device_info dm646x_edma_device __initconst = {
>
> This marks them const as well, as was originally intended.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I applied this to the fixes branch now.

      Arnd
