Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeEMSJp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 14:09:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50779 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeEMSJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 14:09:44 -0400
Date: Sun, 13 May 2018 20:09:34 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/io: Define readq()/writeq() to use 64-bit type
In-Reply-To: <20180503102810.59657-1-andriy.shevchenko@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805132007200.1582@nanos.tec.linutronix.de>
References: <20180503102810.59657-1-andriy.shevchenko@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2018, Andy Shevchenko wrote:
>  #ifdef CONFIG_X86_64
>  
> -build_mmio_read(readq, "q", unsigned long, "=r", :"memory")
> -build_mmio_read(__readq, "q", unsigned long, "=r", )
> -build_mmio_write(writeq, "q", unsigned long, "r", :"memory")
> -build_mmio_write(__writeq, "q", unsigned long, "r", )
> +build_mmio_read(readq, "q", unsigned long long, "=r", :"memory")
> +build_mmio_read(__readq, "q", unsigned long long, "=r", )
> +build_mmio_write(writeq, "q", unsigned long long, "r", :"memory")
> +build_mmio_write(__writeq, "q", unsigned long long, "r", )

What's wrong with u64 which we use for expressing io access to a 64bit wide
resource?

Thanks,

	tglx
