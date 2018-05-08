Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755037AbeEHRkt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754386AbeEHRkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:40:47 -0400
X-Google-Smtp-Source: AB8JxZqFdXBVnLgtSv+8XVIHarjK4rO4eYJjmU/TvXnQ2GEWy6bZ09YySLUtTNC7nW4vu2yqI8fM82Pzt3bFlr0YPzY=
MIME-Version: 1.0
In-Reply-To: <20180508145611.49072-3-giulio.benetti@micronovasrl.com>
References: <20180508145611.49072-1-giulio.benetti@micronovasrl.com> <20180508145611.49072-3-giulio.benetti@micronovasrl.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 8 May 2018 12:40:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKa7AF4x5440aVtCsCcvbTS85o-dRT8+Ka6QB=8zK2NzA@mail.gmail.com>
Message-ID: <CAL_JsqKa7AF4x5440aVtCsCcvbTS85o-dRT8+Ka6QB=8zK2NzA@mail.gmail.com>
Subject: Re: [PATCH 3/4] rtc: ds1307: add calibration of_ for mt41txx chips.
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 8, 2018 at 9:56 AM, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
> m41txx chips can hold a calibration value to get really near to real
> tick value.

Typo in the subject.

> Add calibration property(ranging between (-31) and 31), so on every probe
> calibration value will be written to rtc.
> This is because ic could loose supply due to low battery.
>
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../devicetree/bindings/rtc/rtc-ds1307.txt    |  2 ++

Put all the binding changes in separate patch (or maybe 2: new
compatible and new properties).

>  drivers/rtc/rtc-ds1307.c                      | 33 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
> index ce6469c1a516..d3d70a5495c5 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
> @@ -34,6 +34,8 @@ Optional properties:
>  - trickle-diode-disable : ds1339, ds1340 and ds 1388 only
>         Do not use internal trickle charger diode
>         Should be given if internal trickle charger diode should be disabled
> +- calibration: m41t0, m41t00, m41t11 only

Needs a vendor prefix.

Calibration of what and what are the units?

> +       Set calibration value to correct external bias, ranging between (-31) and 31.
>
>  Example:
>         rtc1: ds1339@68 {
