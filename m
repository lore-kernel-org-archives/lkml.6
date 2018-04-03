Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755004AbeDCIN0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:13:26 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:41229 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754872AbeDCINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:13:23 -0400
X-Google-Smtp-Source: AIpwx4/cbHSI8llioyybLQjsmU/NpxNkQo379OY5V2Nm5M38Ti1Wh6fT1mdavEGfk4CeKoyil1RzTZ9+Ytk7G844etk=
MIME-Version: 1.0
In-Reply-To: <1522693621-3124-1-git-send-email-agk@godking.net>
References: <1522693621-3124-1-git-send-email-agk@godking.net>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 3 Apr 2018 11:13:22 +0300
Message-ID: <CAHp75VcOCCnJ-qXKJXbY=qAQDs+Z-bHcC_UgH=3R+JRQ8WOaLw@mail.gmail.com>
Subject: Re: [PATCH] Add Second Fan Support for Thinkpad P50
To: Alexander Kappner <agk@godking.net>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 9:27 PM, Alexander Kappner <agk@godking.net> wrote:
> The Thinkpad P50 has 2 fans. Add the 2FAN quirk so the tpacpi driver
> properly reports both fan speeds.
> Because the P50 doesn't report the version of its EC controller, we need to
> identify it by BIOS version (N1).

I have pushed it with changes discussed to my review and testing queue, thanks!

I'm not sure if you were about to send a new version (no need
anymore), though for the next time, please be familiar with
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst
(in particular, section 8).

And additional information, we are using special prefixes for our
subsystem, i.e.
"platform/x86: $DRIVER_NAME: ".

> Signed-off-by: Alexander Kappner <agk@godking.net>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d5eaf3b1..ebdc300 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8699,16 +8699,24 @@ static const struct attribute_group fan_attr_group = {
>           .ec = TPID(__id1, __id2),             \
>           .quirks = __quirks }
>
> +#define TPACPI_FAN_QL_BIOS(__id1, __id2, __quirks)     \
> +       { .vendor = PCI_VENDOR_ID_LENOVO,       \
> +         .bios = TPID(__id1, __id2),           \
> +         .ec = TPACPI_MATCH_ANY,               \
> +         .quirks = __quirks }
> +
>  static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>         TPACPI_FAN_QI('1', 'Y', TPACPI_FAN_Q1),
>         TPACPI_FAN_QI('7', '8', TPACPI_FAN_Q1),
>         TPACPI_FAN_QI('7', '6', TPACPI_FAN_Q1),
>         TPACPI_FAN_QI('7', '0', TPACPI_FAN_Q1),
>         TPACPI_FAN_QL('7', 'M', TPACPI_FAN_2FAN),
> +       TPACPI_FAN_QL_BIOS('N', '1', TPACPI_FAN_2FAN) // Thinkpad P50 has 2 fans
>  };
>
>  #undef TPACPI_FAN_QL
>  #undef TPACPI_FAN_QI
> +#undef TPACPI_FAN_QL_BIOS
>
>  static int __init fan_init(struct ibm_init_struct *iibm)
>  {
> --
> 2.1.4
>



-- 
With Best Regards,
Andy Shevchenko
