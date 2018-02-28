Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeB1JHN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:07:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48198 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeB1JHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:07:12 -0500
Date: Wed, 28 Feb 2018 10:07:27 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ivan Gorinov <ivan.gorinov@intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] x86: devicetree: enable multiprocessing and interrupt
 setting in DT
In-Reply-To: <1519695367.58658.141.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1802281001170.1886@nanos.tec.linutronix.de>
References: <1519695367.58658.141.camel@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1525307994-1519808533=:1886"
Content-ID: <alpine.DEB.2.21.1802281003110.1886@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1525307994-1519808533=:1886
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1802281003111.1886@nanos.tec.linutronix.de>

On Mon, 26 Feb 2018, Ivan Gorinov wrote:

> The x86-specific Device Tree implementation only supported single CPU,
> and IRQ allocation from DT parameters was broken in recent versions.

Was broken is not really informative. Please describe in which way it was
broken.

> 
> This change enables multiprocessing and fixes broken IRQ allocation.

Please split this into two parts:

   1) Fix the broken IRQ mechanics
   2) Enable SMP parsing

> Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> ---
>  arch/x86/kernel/devicetree.c | 41 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index 25de5f6..f885eab 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -130,6 +130,29 @@ static void __init dtb_setup_hpet(void)
>  #endif

patching file arch/x86/kernel/devicetree.c
patch: **** malformed patch at line 25:  #endif

Your patch is white space damaged by your mail client.

See Documentation/process/email-clients.rst:Evolution (GUI)

Thanks,

	tglx
--8323329-1525307994-1519808533=:1886--
