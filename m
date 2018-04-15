Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeDOMAA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 08:00:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40148 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeDOL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 07:59:56 -0400
X-Google-Smtp-Source: AIpwx49Ea1DclLvht/qii4jyWcG3VZFvHWpFqI2OuYqeGZLUw6yjEDbbnJvYpa/G1GVS7n27EiVsZtO7itzBkfSpW0I=
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL=i1mXSW-x2CRAHoyAxG+QtGL1YLGwpJdpQbizrqzv-w@mail.gmail.com>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
 <1523531671-27491-12-git-send-email-ulf.hansson@linaro.org> <CAL_JsqL=i1mXSW-x2CRAHoyAxG+QtGL1YLGwpJdpQbizrqzv-w@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 15 Apr 2018 13:59:55 +0200
Message-ID: <CAPDyKFo8wMetVmUBok_PmhZ6tHLKKn0_23j3PRfyBmXzeMF4VA@mail.gmail.com>
Subject: Re: [PATCH v7 11/26] of: base: Add of_get_cpu_state_node() to get
 idle states for a CPU node
To: Rob Herring <robh+dt@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 April 2018 at 17:05, Rob Herring <robh+dt@kernel.org> wrote:
> On Thu, Apr 12, 2018 at 6:14 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The CPU's idle state nodes are currently parsed at the common cpuidle DT
>> library, but also when initializing back-end data for the arch specific CPU
>> operations, as in the PSCI driver case.
>>
>> To avoid open-coding, let's introduce of_get_cpu_state_node(), which takes
>> the device node for the CPU and the index to the requested idle state node,
>> as in-parameters. In case a corresponding idle state node is found, it
>> returns the node with the refcount incremented for it, else it returns
>> NULL.
>>
>> Moreover, for ARM, there are two generic methods, to describe the CPU's
>> idle states, either via the flattened description through the
>> "cpu-idle-states" binding [1] or via the hierarchical layout, using the
>> "power-domains" and the "domain-idle-states" bindings [2]. Hence, let's
>> take both options into account.
>>
>> [1]
>> Documentation/devicetree/bindings/arm/idle-states.txt
>> [2]
>> Documentation/devicetree/bindings/arm/psci.txt
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/of/base.c  | 35 +++++++++++++++++++++++++++++++++++
>>  include/linux/of.h |  8 ++++++++
>>  2 files changed, 43 insertions(+)
>
> Some reason you didn't add my Reviewed-by from v6?

No, I was just sloppy. My apologies!

Kind regards
Uffe
