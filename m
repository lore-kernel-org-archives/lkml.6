Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeBHJyx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:54:53 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41558 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeBHJyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:54:50 -0500
X-Google-Smtp-Source: AH8x227rY91h+kyFrVSN2obn6brRxBHA+gXWSI0H6thvzB6+W1lDBtlQIYASalEYPs9OrPLoJ3TBThNOVIorSMjNJiQ=
MIME-Version: 1.0
In-Reply-To: <65f2690c-c605-3c66-9d8a-9a882aaf446d@ti.com>
References: <20180207134553.13510-1-brgl@bgdev.pl> <20180207134553.13510-3-brgl@bgdev.pl>
 <65f2690c-c605-3c66-9d8a-9a882aaf446d@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 8 Feb 2018 10:54:49 +0100
Message-ID: <CAMRc=Mf+S3k_wfhUWEx2-39AZx1szkgy-u-bsZQUMiaY06UKww@mail.gmail.com>
Subject: Re: [PATCH 2/7] soc: davinci: new genpd driver
To: Sekhar Nori <nsekhar@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-08 10:30 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Wednesday 07 February 2018 07:15 PM, Bartosz Golaszewski wrote:
>> +     /*
>> +      * DaVinci always uses a single clock for power-management. We assume
>> +      * it's the first one in the clocks property.
>> +      */
>> +     clk = of_clk_get(dev->of_node, 0);
>> +     if (IS_ERR(clk))
>> +             return PTR_ERR(clk);
>
> We already get this today with drivers/base/power/clock_ops.c once
> .con_ids list is dropped from pm_clk_notifier_block (which I think it
> should).
>
> If there is no reason to introduce thus functionality at this stage,
> perhaps we should wait till such a time when its clearly needed?
>
> Thanks,
> Sekhar

If I understand correctly: once we drop the con_ids list, we end up
calling clk_get(dev, NULL) from pm_clk_acquire(), which matches
against the clock with NULL con_id, which may not necessarily be the
first clock in the list.

I'm working on extending the psc driver with the power-domain code (as
suggested by David), which should be much smaller and simplier - how
about that?

Thanks,
Bartosz
