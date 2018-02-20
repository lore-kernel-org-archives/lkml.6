Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeBTH0A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 02:26:00 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46826 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbeBTHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 02:25:57 -0500
X-Google-Smtp-Source: AH8x227mVqI8OIdttIjr9D9WiolP5RuCwDhLVNI1HY30Kr3PSk1tmX+N2wo61bx6YzIWoJd+GdTO90lbKlcnYnBJXfE=
MIME-Version: 1.0
In-Reply-To: <20180216214002.6209-3-d-gerlach@ti.com>
References: <20180216214002.6209-1-d-gerlach@ti.com> <20180216214002.6209-3-d-gerlach@ti.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Tue, 20 Feb 2018 08:25:16 +0100
Message-ID: <CAOFm3uGUN387rU6xVZf+qndM_s9j=PT+4uuS3JQ=cdSOGm46GA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2+: Introduce low-level suspend code for AM43XX
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Tony Lindgren <tony@atomide.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Keerthy J <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On Fri, Feb 16, 2018 at 10:40 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Although similar to AM33XX, introduce a new low-level asm file for
> suspend containing new context save and restore paths for EMIF and l2
> cache disabling and enabling.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/mach-omap2/sleep43xx.S | 393 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 393 insertions(+)
>  create mode 100644 arch/arm/mach-omap2/sleep43xx.S
>
> diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
> new file mode 100644
> index 000000000000..3a8bfd62a33c
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sleep43xx.S
> @@ -0,0 +1,393 @@
> +/*
> + * Low level suspend code for AM43XX SoCs
> + *
> + * Copyright (C) 2013-2018 Texas Instruments Incorporated - http://www.ti.com/
> + *     Dave Gerlach, Vaibhav Bedia
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

Do you mind using SPDX tags per [1] rather that this fine but long
legalese here and in the whole patch set? Unless you are a legalese
lover of course!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne
