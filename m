Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965036AbeCGUYB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:24:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964783AbeCGUX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:23:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469312177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELuHN89PZI9hlQqtuAaQiBtBwHJqRrmwc6S/msUQW+5yC/vOdj7BcaYGN77W9lSSBWxq/V78xwm+O6xiqPG8Vws=
MIME-Version: 1.0
In-Reply-To: <3a0359afad71abc0c0d682bfcd0dd66055f5d7e5.1520450752.git.ivan.gorinov@intel.com>
References: <cover.1520450752.git.ivan.gorinov@intel.com> <3a0359afad71abc0c0d682bfcd0dd66055f5d7e5.1520450752.git.ivan.gorinov@intel.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 7 Mar 2018 14:23:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=CPRxCMzTyxhPvSXiT2MNQdfc1tmzXD0utikqqCp+Bw@mail.gmail.com>
Message-ID: <CAL_JsqJ=CPRxCMzTyxhPvSXiT2MNQdfc1tmzXD0utikqqCp+Bw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] of: Documentation: Add x86 local APIC ID property
To: Ivan Gorinov <ivan.gorinov@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 1:47 PM, Ivan Gorinov <ivan.gorinov@intel.com> wrote:
> Current x86 Device Tree implementation does not support multiprocessing.
> Add new "intel,apic-id" property to allow using CPU descriptions
> in Device Tree data provided by the U-Boot loader.
> Address specified in 'reg' to be used as default local APIC ID
> to avoid breaking existing systems with DTB provided by firmware.

Is there some reason to not always use reg? For when the numbering of
cpus and timers is different?

Of course, we do have the situation on ARM with the GIC that the GIC
CPU IDs may be
>
> Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> ---
>  Documentation/devicetree/bindings/x86/ce4100.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
> index b49ae59..d15de48 100644
> --- a/Documentation/devicetree/bindings/x86/ce4100.txt
> +++ b/Documentation/devicetree/bindings/x86/ce4100.txt
> @@ -14,11 +14,17 @@ The CPU node
>                 compatible = "intel,ce4100";
>                 reg = <0>;
>                 lapic = <&lapic0>;

Isn't this enough? I can't tell because whatever this points to has no
binding documentation.

You could perhaps extend it and add a cell with the id value.

> +               intel,apic-id = <0>;
>         };
>
>  The reg property describes the CPU number. The lapic property points to
>  the local APIC timer.
>
> +Optional properties:
> +
> +- intel,apic-id: local APIC ID.
> +  The address specified in "reg" is used as default local APIC ID.
> +
>  The SoC node
>  ------------
>
> --
> 2.7.4
>
