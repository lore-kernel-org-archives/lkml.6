Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeCPFw1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:52:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34184 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbeCPFwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:52:25 -0400
X-Google-Smtp-Source: AG47ELsZbNEte0/OL9T6j9W1knVsjghpTYeGQEkjDwJEaJ6DmJlNLGMjJcVcq1wwYAiZFVCGbFeAiPMOh5Ub3QGRWf0=
MIME-Version: 1.0
References: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com> <1521155412-29229-3-git-send-email-tmaimon77@gmail.com>
In-Reply-To: <1521155412-29229-3-git-send-email-tmaimon77@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 16 Mar 2018 05:52:14 +0000
Message-ID: <CAFd5g44NOFRmQbDJfRLw_SwsHwVB-hxsUYMYSmkqeyRKmXqSqQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm: npcm: Enable L2 Cache in NPCM7xx
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Patrick Venture <venture@google.com>,
        Avi Fishman <avifishman70@gmail.com>, Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nancy Yuen <yuenn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 4:16 PM Tomer Maimon <tmaimon77@gmail.com> wrote:

> Enable L2 Cache in Nuvoton NPCM7xx BMC.

> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>   arch/arm/mach-npcm/npcm7xx.c | 2 ++
>   1 file changed, 2 insertions(+)

> diff --git a/arch/arm/mach-npcm/npcm7xx.c b/arch/arm/mach-npcm/npcm7xx.c
> index 5f7cd88103ef..c5f77d854c4f 100644
> --- a/arch/arm/mach-npcm/npcm7xx.c
> +++ b/arch/arm/mach-npcm/npcm7xx.c
> @@ -17,4 +17,6 @@ static const char *const npcm7xx_dt_match[] = {
>   DT_MACHINE_START(NPCM7XX_DT, "NPCM7XX Chip family")
>          .atag_offset    = 0x100,
>          .dt_compat      = npcm7xx_dt_match,
> +       .l2c_aux_val    = 0x0,
> +       .l2c_aux_mask   = ~0x0,

You need to limit this to the specific bit(s) you want to set and verify
that
the l2c driver does not already manage that bit appropriately and that it
can
not be specified via the dtsi.

We discussed this a little while ago with Rob here:
https://www.spinics.net/lists/arm-kernel/msg613372.html

>   MACHINE_END
> --
> 2.14.1


Cheers
