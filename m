Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031236AbeCAOUT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:20:19 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:40335 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031049AbeCAOUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:20:17 -0500
X-Google-Smtp-Source: AG47ELsNirq2zDfII6Udo8IN9ggXL8xEakH0SHPhQ7PI7xgM/DQJvaGmdKKNr29b6zVp6oHYtyA7wl2rj6f9dPWz6Ag=
MIME-Version: 1.0
In-Reply-To: <1519872334.58658.188.camel@intel.com>
References: <1519872334.58658.188.camel@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 16:20:15 +0200
Message-ID: <CAHp75Vf7+UN=GXbEa_jce-kGbBtc1Bg7GTz9ancmyprwLOQdsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86: devicetree: enable multiprocessing in DT
To: Ivan Gorinov <ivan.gorinov@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 4:45 AM, Ivan Gorinov <ivan.gorinov@intel.com> wrote:
> Adding code to register processors described in Device Tree.
> APIC ID is specified in 'intel-apic_id' propery as used in U-Boot.
> First address specified in 'reg' is used as default APIC ID.

> +       version = GET_APIC_VERSION(apic_read(APIC_LVR));
> +       for_each_node_by_type(dn, "cpu") {
> +               prop = of_get_property(dn, "intel,apic-id", NULL);
> +               if (prop) {
> +                       apic_id = be32_to_cpup(prop);
> +               } else {
> +                       ret = of_address_to_resource(dn, 0, &r);

> +                       if (WARN_ON(ret))

Wouldn't be too much?

Options:
- add _ONCE
- convert to plain pr_warn()

> +                               continue;
> +                       apic_id = r.start;
> +               }
> +               generic_processor_info(apic_id, version);
> +       }


-- 
With Best Regards,
Andy Shevchenko
