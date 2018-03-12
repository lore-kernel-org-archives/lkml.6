Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeCLJXY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:23:24 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35598 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeCLJXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:23:22 -0400
X-Google-Smtp-Source: AG47ELulABYPBFWxvqq+my2Vu7fe2mP4QZS+x4K/Mg2LpR6I3J8rW5u9HxBmCTaBBjCAt6Ulj6/e/ig9kG73BwGbnLU=
MIME-Version: 1.0
In-Reply-To: <7eb3f317a876a6255aeb0abfd0137894ef8b5166.1520727789.git.dvhart@infradead.org>
References: <7eb3f317a876a6255aeb0abfd0137894ef8b5166.1520727789.git.dvhart@infradead.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Mar 2018 11:23:20 +0200
Message-ID: <CAHp75VeYDiv3gR77xjmj1QitmtTyNykXXFJtYyEFL95sgo1L9A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell_smbios: Resolve dependency error on ACPI_WMI
To: Darren Hart <dvhart@infradead.org>
Cc: Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 2:28 AM, Darren Hart <dvhart@infradead.org> wrote:
> Similarly to DCDBAS for DELL_SMBIOS_SMM, if DELL_SMBIOS_WMI is enabled,
> DELL_SMBIOS becomes dependent on ACPI_WMI. Update the depends line to
> prevent a configuration where DELL_SMBIOS=y and either backend
> dependency =m. Update the comment accordingly.

> +# The DELL_SMBIOS driver depends on ACPI_WMI and/or DCDBAS if those
> +# backends are selected. The "depends" line prevents a configuration
> +# where DELL_SMBIOS=y while either of those dependencies =m.
>  #
>  config DELL_SMBIOS
>         tristate "Dell SMBIOS driver"
> -       depends on DCDBAS || DCDBAS=n
> +       depends on (DCDBAS || DCDBAS=n) && (ACPI_WMI || ACPI_WMI=n)

A nit: Perhaps separate depends on line for those two?

-- 
With Best Regards,
Andy Shevchenko
