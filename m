Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeBPHWw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 02:22:52 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56259 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753594AbeBPHWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 02:22:50 -0500
X-Google-Smtp-Source: AH8x227Xt84UvuIWAWB5zp+utSKpGgA7xBkkW1M/V9NqcFtrFtt6ZWJ/CJUyaGJHrwQbaV74bTjfUg==
Date: Fri, 16 Feb 2018 08:22:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        marcus.folkesson@gmail.com
Subject: Re: [PATCH v3 01/11] watchdog/hpwdt: Remove legacy NMI sourcing.
Message-ID: <20180216072246.uifaj22wvqevc7er@gmail.com>
References: <20180215234400.5022-1-jerry.hoemann@hpe.com>
 <20180215234400.5022-2-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215234400.5022-2-jerry.hoemann@hpe.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jerry Hoemann <jerry.hoemann@hpe.com> wrote:

> Gen8 and prior Proliant systems supported the "CRU" interface
> to firmware.  This interfaces allows linux to "call back" into firmware
> to source the cause of an NMI.  This feature isn't fully utilized
> as the actual source of the NMI isn't printed, the driver only
> indicates that the source couldn't be determined when the call
> fails.
> 
> With the advent of Gen9, iCRU replaces the CRU. The call back
> feature is no longer available in firmware.  To be compatible and
> not attempt to call back into firmware on system not supporting CRU,
> the SMBIOS table is consulted to determine if it is safe to
> make the call back or not.
> 
> This results in about half of the driver code being devoted
> to either making CRU calls or determing if it is safe to make
> CRU calls.  As noted, the driver isn't really using the results of
> the CRU calls.
> 
> As the CRU sourcing of the NMI isn't required for handling the
> NMI, remove the legacy (pre Gen9) NMI sourcing and the DMI code to
> determine if the system had the CRU interface.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 490 +----------------------------------------------
>  1 file changed, 8 insertions(+), 482 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
