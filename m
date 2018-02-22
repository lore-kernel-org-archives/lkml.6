Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933524AbeBVRds (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:33:48 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36635 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933505AbeBVRdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:33:45 -0500
X-Google-Smtp-Source: AG47ELvE93vLmiJBt+K1hT3h1h68jukQck56AiivS7ycux/phZVqxhGizK0vlm+Qzeg2DxFr1tqT5a3ejEEi1pzNrpg=
MIME-Version: 1.0
In-Reply-To: <CANoH8WgoPbhh+OS-HQD5uk3xbedrqHnwufJ9Bj4hSEuuTBkapw@mail.gmail.com>
References: <CANoH8WgoPbhh+OS-HQD5uk3xbedrqHnwufJ9Bj4hSEuuTBkapw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2018 19:33:44 +0200
Message-ID: <CAHp75VfEc0a_Fff1znWVos3rPzCGsvGLGX7NgH_bH96egree7A@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86: Fix Intel Edison module stuck reboot
To: Sebastian Panceac <sebastian@resin.io>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 11:27 AM, Sebastian Panceac <sebastian@resin.io> wrote:
>
> When powering Intel Edison module with 3.3V, the "reboot" command makes the module stuck.
> If the module is powered at a greater voltage, like 4.4V(as the Edison Mini Breakout board does), reboot works OK.
> This patch fixes the reboot problem for Intel Edison powered at 3.3V.

Unfortunately it doesn't explain the root cause. OTOH it seems no one
has any means to find it, no documentation, no person responsible for
Edison firmware responsive.

At least what I would like to mention that this copies a behaviour of
official BSP for Edison, where RESET command applied by default (and
BOOT is enforced by user via kernel command line).

Perhaps someone can dig an internet to see what BOOT SCU command means.

Your patch is mangled. Can you use `git send-email` directly?

> Signed-off-by: Sebastian Panceac <sebastian@resin.io>
> ---
> arch/x86/platform/intel-mid/intel-mid.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
> index 12a2725..d2b2e9f 100644
> --- a/arch/x86/platform/intel-mid/intel-mid.c
> +++ b/arch/x86/platform/intel-mid/intel-mid.c
> @@ -79,7 +79,7 @@ static void intel_mid_power_off(void)
>
> static void intel_mid_reboot(void)
> {
> - intel_scu_ipc_simple_command(IPCMSG_COLD_BOOT, 0);
> + intel_scu_ipc_simple_command(IPCMSG_COLD_RESET, 0);
> }
>
> static unsigned long __init intel_mid_calibrate_tsc(void)
> --
> 2.7.4




-- 
With Best Regards,
Andy Shevchenko
