Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeCOIoa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:44:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeCOIo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:44:26 -0400
Date: Thu, 15 Mar 2018 09:44:21 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>, Stephen Boyd <sboyd@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH] [v2] y2038: introduce struct __kernel_old_timeval
In-Reply-To: <20180314220452.3453973-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1803150943130.1525@nanos.tec.linutronix.de>
References: <CAK8P3a1PGEk2WDQU8i7H64Cw4dmYaJ-6vPLzW_2o23PTgm74JA@mail.gmail.com> <20180314220452.3453973-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Arnd Bergmann wrote:
>  
>  /*
> + * legacy timeval structure, only embedded in structures that
> + * traditionally used 'timeval' to pass time intervals (not absolute
> + * times). Do not add new users. If user space fails to compile
> + * here, this is probably because it is not y2038 safe and needs to
> + * be changed to use another interface.
> + */
> +struct __kernel_old_timeval {
> +	__kernel_long_t tv_sec;			/* seconds */
> +	__kernel_long_t tv_usec;		/* microseconds */

Please don't use these horrible tail comments. If you want to document the
obvious, then please use proper kernel doc.

Thanks,

	tglx
