Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeCYOjk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 10:39:40 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:40868 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbeCYOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 10:39:28 -0400
Date: Sun, 25 Mar 2018 11:38:27 -0300
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770
To: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Message-Id: <1521988707.2054.0@smtp.crapouillou.net>
In-Reply-To: <20180322102606.GE13126@saruman>
References: <20180317201109.2000-1-paul@crapouillou.net>
        <20180322102606.GE13126@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2PEdjEW018700

Hi,

Le jeu. 22 mars 2018 à 7:26, James Hogan <jhogan@kernel.org> a écrit :
> On Sat, Mar 17, 2018 at 09:11:09PM +0100, Paul Cercueil wrote:
>>  Since the UART addresses are the same across all Ingenic SoCs, we 
>> just
>>  use a #ifdef CONFIG_MACH_INGENIC instead of checking for indifidual
>>  Ingenic SoCs.
> 
> s/indifidual/individual/
> 
>>  --- a/arch/mips/boot/compressed/uart-16550.c
>>  +++ b/arch/mips/boot/compressed/uart-16550.c
>>  @@ -18,9 +18,9 @@
>>   #define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))
>>   #endif
>> 
>>  -#if defined(CONFIG_MACH_JZ4740) || defined(CONFIG_MACH_JZ4780)
>>  -#include <asm/mach-jz4740/base.h>
>>  -#define PORT(offset) (CKSEG1ADDR(JZ4740_UART0_BASE_ADDR) + (4 * 
>> offset))
>>  +#if CONFIG_MACH_INGENIC
> 
> I think you meant #ifdef there.
> 
> Cheers
> James

Oops. Will fix in V2.

-Paul
