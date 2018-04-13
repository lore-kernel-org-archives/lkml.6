Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeDMPFl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbeDMPFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:05:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AF221795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AIpwx4/U8UvljI9fRl4lc+HWyPnQKC1M/lBcmoQL36NB9HifEioAz6QbYkkf4GO0LD7L2cjpOm5t4nk0nRlNmvJ+eM8=
MIME-Version: 1.0
In-Reply-To: <1523531671-27491-12-git-send-email-ulf.hansson@linaro.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org> <1523531671-27491-12-git-send-email-ulf.hansson@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 13 Apr 2018 10:05:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL=i1mXSW-x2CRAHoyAxG+QtGL1YLGwpJdpQbizrqzv-w@mail.gmail.com>
Message-ID: <CAL_JsqL=i1mXSW-x2CRAHoyAxG+QtGL1YLGwpJdpQbizrqzv-w@mail.gmail.com>
Subject: Re: [PATCH v7 11/26] of: base: Add of_get_cpu_state_node() to get
 idle states for a CPU node
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
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

On Thu, Apr 12, 2018 at 6:14 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The CPU's idle state nodes are currently parsed at the common cpuidle DT
> library, but also when initializing back-end data for the arch specific CPU
> operations, as in the PSCI driver case.
>
> To avoid open-coding, let's introduce of_get_cpu_state_node(), which takes
> the device node for the CPU and the index to the requested idle state node,
> as in-parameters. In case a corresponding idle state node is found, it
> returns the node with the refcount incremented for it, else it returns
> NULL.
>
> Moreover, for ARM, there are two generic methods, to describe the CPU's
> idle states, either via the flattened description through the
> "cpu-idle-states" binding [1] or via the hierarchical layout, using the
> "power-domains" and the "domain-idle-states" bindings [2]. Hence, let's
> take both options into account.
>
> [1]
> Documentation/devicetree/bindings/arm/idle-states.txt
> [2]
> Documentation/devicetree/bindings/arm/psci.txt
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Lina Iyer <ilina@codeaurora.org>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/of/base.c  | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/of.h |  8 ++++++++
>  2 files changed, 43 insertions(+)

Some reason you didn't add my Reviewed-by from v6?

Rob
