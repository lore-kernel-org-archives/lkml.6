Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeBWKBE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:01:04 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:53207 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbeBWKBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:01:03 -0500
Subject: Re: [PATCH 3/3] ARM: davinci: mark spi_board_info arrays as const
To: Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        Kevin Hilman <khilman@kernel.org>
CC: Neil Armstrong <narmstrong@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180220162519.1498223-1-arnd@arndb.de>
 <20180220162519.1498223-3-arnd@arndb.de>
 <CAK8P3a2gWP-i0X=3dom4aCMfKgmf41a27Huj9919Epnwg26JoA@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <fc760095-ae18-07ef-96de-2e06b16372ae@ti.com>
Date: Fri, 23 Feb 2018 15:30:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2gWP-i0X=3dom4aCMfKgmf41a27Huj9919Epnwg26JoA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 February 2018 10:13 PM, Arnd Bergmann wrote:
> On Tue, Feb 20, 2018 at 5:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> Building with LTO revealed that three spi_board_info arrays are marked
>> __initconst, but not const:
>>
>> arch/arm/mach-davinci/board-dm365-evm.c: In function 'dm365_evm_init':
>> arch/arm/mach-davinci/board-dm365-evm.c:729:30: error: 'dm365_evm_spi_info' causes a section type conflict with 'dm646x_edma_device'
>>  static struct spi_board_info dm365_evm_spi_info[] __initconst = {
>>                               ^
>> arch/arm/mach-davinci/dm646x.c:603:42: note: 'dm646x_edma_device' was declared here
>>  static const struct platform_device_info dm646x_edma_device __initconst = {
>>
>> This marks them const as well, as was originally intended.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I applied this to the fixes branch now.

Thanks Arnd. FWIW now:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Regards,
Sekhar
