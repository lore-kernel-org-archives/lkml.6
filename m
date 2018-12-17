Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1C3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5072133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I0FyCN4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeLQVOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:14:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58372 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeLQVOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xv9R1Asq4kEgfFCTtrXG0S4Xh7eOlzNzos1JZWNF1H8=; b=I0FyCN4eVCfx2zW9cAgqtLF7AY
        5R13wuEY3TxpTT1OYPMt/2iWjzARcGhZnElO8i9Onvm5RLye7ECxNDP3CJuGgak4KEu4ukYDFBjCI
        yC8QPtQpgIh6UqeKGIOe+4CgxCRkxWoD8yjpzlQfAAQOvhmSdQF1Lgpc7lM0nMuitH59NNMumjqwc
        FE7HGJkrpX/Myk4cSC+4OZr+fUfaS69jyxv5PGCW97h4A0ijMSWvZt4pxhYgJ07xGn4kM4Gk5lDTT
        uwK6lkE2bThI7BPae09KHbjvRMhUQVfKAlDk0DGWaqQRXP4rRo0c9aHT9VU1HflNJdOgEnLmMtKY7
        NmEGU0nA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZ0DZ-0003yF-R8; Mon, 17 Dec 2018 21:14:26 +0000
Subject: Re: [PATCH 1/1] docs: Revamp tainted-kernels.rst to make it more
 comprehensible
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181217152043.9989-1-linux@leemhuis.info>
 <20181217152043.9989-2-linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b834144e-b95d-4513-4bc4-1114e1facdc9@infradead.org>
Date:   Mon, 17 Dec 2018 13:14:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181217152043.9989-2-linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 7:20 AM, Thorsten Leemhuis wrote:
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/tainted-kernels.rst | 105 ++++++++++++++++--
>  1 file changed, 96 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index 28a869c509a0..aabd307a178a 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -1,10 +1,102 @@
>  Tainted kernels
>  ---------------
>  
> -Some oops reports contain the string **'Tainted: '** after the program
> -counter. This indicates that the kernel has been tainted by some
> -mechanism.  The string is followed by a series of position-sensitive
> -characters, each representing a particular tainted value.
> +The kernel will mark itself as 'tainted' when something occurs that
> +might be relevant later when investigating problems. Don't worry
> +yourself too much about this, most of the time it's not a problem to run
> +a tainted kernel; the information is mainly of interest once someone
> +wants to investigate some problem, as its real cause might be the event
> +that got the kernel tainted. That's why the kernel will remain tainted
> +even after you undo what caused the taint (i.e. unload a proprietary
> +kernel module), to indicate the kernel remains not trustworthy. That's
> +also why the kernel will print the tainted state when it noticed

                                                            notices

> +ainternal problem (a 'kernel bug'), a recoverable error ('kernel oops')

   an internal

> +or a nonrecoverable error ('kernel panic') and writes debug information
> +about this to the logs ``dmesg`` outputs. It's also possible to check
> +the tainted state at runtime through a file in ``/proc/``.
> +
> +
> +Tainted flag in bugs, oops or panics messages
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +You find the tainted state near the top after the list of loaded
> +modules.  The state is part of the line that begins with mentioning CPU
> +('CPU:'), Process ID ('PID:'), and a shorted name of the executed

                                        shortened

> +command ('Comm:') that triggered the event. When followed by **'Not
> +tainted: '** the kernel was not tainted at the time of the event; if it
> +was, then it will print **'Tainted: '** and characters either letters or
> +blanks. The meaning of those characters is explained in below table. The

                                                        in the table below. The

> +output for example might state '``Tainted: P   WO``' when the kernel got
> +tainted earlier because a proprietary Module (``P``) was loaded, a
> +warning occurred (``W``), and an externally-built module was loaded
> +(``O``). To decode other letters use below table.

                                    use the table below.

> +
> +
> +Decoding tainted state at runtime
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +At runtime, you can query the tainted state by reading
> +``/proc/sys/kernel/tainted``. If that returns ``0``, the kernel is not
> +tainted; any other number indicates the reasons why it is. You might
> +find that number in below table if there was only one reason that got

                    in the table below                          for the

> +the kernel tainted. If there were multiple reasons you need to decode

   kernel to be tainted.                      reasons,

> +the number, as it is a bitfield, where each bit indicates the absence or
> +presence of a particular type of taint. You can use the following python
> +command to decode::
> +
> +	$ python3 -c 'from pprint import pprint; from itertools import zip_longest; pprint(list(zip_longest(range(1,17), reversed(bin(int(open("/proc/sys/kernel/tainted").read()))[2:]),fillvalue="0")))'
> +	[(1, '1'),
> +	 (2, '0'),
> +	 (3, '0'),
> +	 (4, '0'),
> +	 (5, '0'),
> +	 (6, '0'),
> +	 (7, '0'),
> +	 (8, '0'),
> +	 (9, '0'),
> +	 (10, '1'),
> +	 (11, '0'),
> +	 (12, '0'),
> +	 (13, '1'),
> +	 (14, '0'),
> +	 (15, '0'),
> +	 (16, '0')]
> +
> +In this case ``/proc/sys/kernel/tainted`` contained ``4609``, as the
> +kernel got tainted because a proprietary Module (Bit 1) got loaded, a
> +warning occurred (Bit 10), and an externally-built module got loaded
> +(Bit 13). To decode other bits use below table.

                                  use the table below.

> +
> +
> +Table for decoding tainted state
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +===  ===  ======  ========================================================
> +Bit  Log     Int  Reason that got the kernel tainted
> +===  ===  ======  ========================================================
> + 1)  G/P       0  proprietary module got loaded
> + 2)  _/F       2  module was force loaded
> + 3)  _/S       4  SMP kernel oops on a officially SMP incapable processor
> + 4)  _/R       8  module was force unloaded
> + 5)  _/M      16  processor reported a Machine Check Exception (MCE)
> + 6)  _/B      32  bad page referenced or some unexpected page flags
> + 7)  _/U      64  taint requested by userspace application
> + 8)  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
> + 9)  _/A     256  ACPI table overridden by user
> +10)  _/W     512  kernel issued warning
> +11)  _/C    1024  staging driver got loaded
> +12)  _/I    2048  workaround for bug in platform firmware in use
> +13)  _/O    4096  externally-built ("out-of-tree") module got loaded
> +14)  _/E    8192  unsigned module was loaded
> +15)  _/L   16384  soft lockup occurred
> +16)  _/K   32768  Kernel live patched
> +===  ===  ======  ========================================================
> +
> +Note: To make reading easier ``_`` is representing a blank in this
> +table.
> +
> +More detailed explanation for tainting
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>   1)  ``G`` if all modules loaded have a GPL or compatible license, ``P`` if
>       any proprietary module has been loaded.  Modules without a
> @@ -52,8 +144,3 @@ characters, each representing a particular tainted value.
>  
>   16) ``K`` if the kernel has been live patched.
>  
> -The primary reason for the **'Tainted: '** string is to tell kernel
> -debuggers if this is a clean kernel or if anything unusual has
> -occurred.  Tainting is permanent: even if an offending module is
> -unloaded, the tainted value remains to indicate that the kernel is not
> -trustworthy.
> 

thanks for the update.

-- 
~Randy
