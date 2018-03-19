Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbeCSLW4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:22:56 -0400
Received: from foss.arm.com ([217.140.101.70]:51470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932804AbeCSLWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:22:55 -0400
Date: Mon, 19 Mar 2018 11:23:02 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: fix undefined reference to 'printk'
Message-ID: <20180319112302.GA11021@arm.com>
References: <CAKv+Gu-6s1tqBzAEgL63WxXrc9SuF2C9PtADqmEcUKWxP8eZUw@mail.gmail.com>
 <20180313125309.3662792-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313125309.3662792-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 01:52:36PM +0100, Arnd Bergmann wrote:
> The printk symbol was intended as a generic address that is always
> exported, however that turned out to be false with CONFIG_PRINTK=n:
> 
> ERROR: "printk" [arch/arm64/kernel/arm64-reloc-test.ko] undefined!
> 
> This changes the references to memstart_addr, which should be there
> regardless of configuration.
> 
> Fixes: a257e02579e4 ("arm64/kernel: don't ban ADRP to work around Cortex-A53 erratum #843419")
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: fix changelog as pointed out by Ard
> 
>  arch/arm64/kernel/reloc_test_core.c | 2 +-
>  arch/arm64/kernel/reloc_test_syms.S | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Cheers, I've picked this up now. Sorry for the delay.

Will
