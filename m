Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965621AbeCADHZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 22:07:25 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38991 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965564AbeCADHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 22:07:23 -0500
X-Google-Smtp-Source: AG47ELvXGO/4/VwqUv8HGsc4chtPDs49ZgioHeeALhLpPnyPZFCFd8apTW/QkOyUdqYN/7SVY/LE5Q==
From: Kevin Hilman <khilman@baylibre.com>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 11/12] PM / AVS: SmartReflex: Prepare to use device tree based probing
Organization: BayLibre
References: <20180223210100.86732-1-tony@atomide.com>
        <20180223210100.86732-12-tony@atomide.com>
Date: Wed, 28 Feb 2018 19:07:19 -0800
In-Reply-To: <20180223210100.86732-12-tony@atomide.com> (Tony Lindgren's
        message of "Fri, 23 Feb 2018 13:00:59 -0800")
Message-ID: <7hr2p41ok8.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> We are currently probing smartreflex with omap_device while we are
> already probing smartreflex related interconnect target module with
> ti-sysc driver and dts data.
>
> Before we can flip things on for ti-sysc, we need to prepare the
> smartreflex driver a bit:
>
> 1. The smartreflex clock is really for the whole interconnect target
>    module. So it may be configured at the parent device level with
>    ti-sysc
>
> 2. With ti-sysc, we have the child device manage interconnect target
>    module directly if pm_runtime_irq_safe() is set and there is only
>    one child. In that case nobody else is going to call pm_runtime_get
>    and put, so we need to add these calls to idle smartreflex properly
>    after probe if not fully configured
>
> 3. With ti-sysc, the parent driver may rebind. So we want to use
>    platform_driver_register() and don't want probe to be __init
>
> Note that this patch depends on the related changes to ti-sysc driver
> and omap_device probing to prevent both ti-sysc and omap_device to
> try to probe smartreflex.
>
> Cc: linux-pm@vger.kernel.org
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

I don't have anything else queued for this driver, so feel free to take
it along with the rest of the series.

Kevin
