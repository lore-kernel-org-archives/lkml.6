Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeCPL5z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:57:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55515 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeCPL5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:57:54 -0400
Date: Fri, 16 Mar 2018 12:57:50 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] y2038: introduce struct __kernel_old_timeval
In-Reply-To: <20180315161739.576085-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1803161256190.1598@nanos.tec.linutronix.de>
References: <20180315161739.576085-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Arnd Bergmann wrote:
> diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
> index 4ed5bd3a3145..94adfae599e0 100644
> --- a/include/uapi/linux/time.h
> +++ b/include/uapi/linux/time.h
> @@ -50,6 +50,18 @@ struct __kernel_timespec {
>  #endif
>

This does neither apply against mainline nor against tip/timers/core

That #endif is nowhere ....

>  /*
> + * legacy timeval structure, only embedded in structures that
> + * traditionally used 'timeval' to pass time intervals (not absolute
> + * times). Do not add new users. If user space fails to compile
> + * here, this is probably because it is not y2038 safe and needs to
> + * be changed to use another interface.
> + */
> +struct __kernel_old_timeval {
> +	__kernel_long_t tv_sec;
> +	__kernel_long_t tv_usec;
> +};
