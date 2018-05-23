Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933265AbeEWOSr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932564AbeEWOSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:18:45 -0400
X-Google-Smtp-Source: AB8JxZqHr626pFna/tlOlybH4mpv5g7RQYbKa1seSTHoPEvzUoLYOsnHM/sBsoU3wpd7UJI0eTmrsIO4RvEcSchfEng=
MIME-Version: 1.0
In-Reply-To: <20180523054846.zn7gftt6aqyibd26@vireshk-i7>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <1526751291-17873-2-git-send-email-tdas@codeaurora.org> <20180522193139.GA21623@rob-hp-laptop>
 <20180523054846.zn7gftt6aqyibd26@vireshk-i7>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 May 2018 09:18:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL7VdSjerOioc5cSOyKAAXJuVnPJqp_WbTtwr11UUxq=A@mail.gmail.com>
Message-ID: <CAL_JsqL7VdSjerOioc5cSOyKAAXJuVnPJqp_WbTtwr11UUxq=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Taniya Das <tdas@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 12:48 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-05-18, 14:31, Rob Herring wrote:
>> On Sat, May 19, 2018 at 11:04:50PM +0530, Taniya Das wrote:
>> > +           freq-domain-0 {
>> > +                   compatible = "cpufreq";
>> > +                   reg = <0x17d43920 0x4>,
>> > +                        <0x17d43110 0x500>,
>> > +                        <0x17d41000 0x4>;
>> > +                   reg-names = "perf_base", "lut_base", "en_base";
>> > +                   qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3>;
>
> I was thinking, can't we add platform specific properties in the CPU
> nodes ? If yes, then we can point the phandle of fw node from the CPUs
> and this awkward list can go away.

Yes, that's fine. That would be more like OPP binding in that the CPU
points to the OPP table rather than the OPP pointing to the CPUs.

With that, you can get rid of the child nodes completely. Just make
the parent reg property N sets of 3 addresses for N domains.

Rob
