Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeB1Krp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:47:45 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34223 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeB1Kro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:47:44 -0500
X-Google-Smtp-Source: AG47ELvxEJG7TUtsTH6tu8NcRXD6p4j5Drl5O8aWbTvZ23LFlzNRUJ/EJX22wKI7TBoIlHmmjsSLi+YCrfrDUwRAec4=
MIME-Version: 1.0
In-Reply-To: <1519810849-15131-1-git-send-email-sebastian@resin.io>
References: <CAHp75Vfdqky9HK9ddUk8+3OuU5pSDhg+9_ychW2ysb+bzAR4Yw@mail.gmail.com>
 <1519810849-15131-1-git-send-email-sebastian@resin.io>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 12:47:42 +0200
Message-ID: <CAHp75VeANMZ58R6qj4Ue8xyvmALFFNaUG0XPS=AVMK8HHjFVvQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] x86: Fix Intel Edison module stuck reboot
To: Sebastian Panceac <sebastian@resin.io>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 11:40 AM, Sebastian Panceac <sebastian@resin.io> wrote:
> When powering Intel Edison module with 3.3V, the "reboot" command makes
> the module stuck.
> If the module is powered at a greater voltage, like 4.4V (as the Edison
> Mini Breakout board does), reboot works OK.
>
> This patch copies the behaviour from the official Intel Edison BSP,
> where "IPCMSG_COLD_RESET" message was sent to SCU by default at
> reboot time.
>
> In the official BSP, sending the "IPCMSG_COLD_BOOT" message instead of
> "IPCMSG_COLD_RESET" was possible, by using a kernel command
> line parameter.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Sebastian Panceac <sebastian@resin.io>
> ---
>
> Hi,
>
> I submitted again the patch, after taking into consideration Andy's suggestions.
>
> Regards!
>
>  arch/x86/platform/intel-mid/intel-mid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
> index 2c67bae..fb1df94 100644
> --- a/arch/x86/platform/intel-mid/intel-mid.c
> +++ b/arch/x86/platform/intel-mid/intel-mid.c
> @@ -79,7 +79,7 @@ static void intel_mid_power_off(void)
>
>  static void intel_mid_reboot(void)
>  {
> -       intel_scu_ipc_simple_command(IPCMSG_COLD_BOOT, 0);
> +       intel_scu_ipc_simple_command(IPCMSG_COLD_RESET, 0);
>  }
>
>  static unsigned long __init intel_mid_calibrate_tsc(void)
> --
> 2.7.4



-- 
With Best Regards,
Andy Shevchenko
