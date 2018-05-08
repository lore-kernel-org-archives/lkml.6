Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755642AbeEHRoz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755587AbeEHRoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:44:34 -0400
X-Google-Smtp-Source: AB8JxZoFf6FqynU0Zvfm4AL5xe5R+2lrzUdvsaNges1yohV4rNPXYHcGKJ3ki73b7XsB7gck5AEINg+3imtuNOhZf6c=
MIME-Version: 1.0
In-Reply-To: <20180508145611.49072-4-giulio.benetti@micronovasrl.com>
References: <20180508145611.49072-1-giulio.benetti@micronovasrl.com> <20180508145611.49072-4-giulio.benetti@micronovasrl.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 8 May 2018 12:44:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKb9aLxjQbOc1PFRQhbVL2a3Ti2oJ8Gm8Ojn0a39LxajA@mail.gmail.com>
Message-ID: <CAL_JsqKb9aLxjQbOc1PFRQhbVL2a3Ti2oJ8Gm8Ojn0a39LxajA@mail.gmail.com>
Subject: Re: [PATCH 4/4] rtc: ds1307: add frequency-test property to check
 calibration on m41txx
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
> On m41txx you can enable open-drain OUT pin to check if calibration is ok.
> Enabling OUT pin with frequency-test bool property, OUT pin will tick
> 512 times faster than 1s tick base.
>
> Enable FT bit on CONTROL register if calibration is active.

A DT is (or should be) a pretty static thing, so I don't think this
belongs. A kernel command line option (via module params) or a
sysfs/debugfs file would make more sense IMO.

Rob
