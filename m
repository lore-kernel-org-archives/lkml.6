Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeCVJ3V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:29:21 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42404 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbeCVJ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:29:17 -0400
X-Google-Smtp-Source: AG47ELuF97R5WIZEn+hQpdxT9dfUbAkDFy5di6CdM+Jr7Z9QXr4iOEu3KxI9DEoT82GsCHXCH2QTbroxLjn7PO4zKLY=
MIME-Version: 1.0
In-Reply-To: <b9de2027d02bd092049e022c3749f230611c8970.1513926033.git.viresh.kumar@linaro.org>
References: <cover.1513926033.git.viresh.kumar@linaro.org> <b9de2027d02bd092049e022c3749f230611c8970.1513926033.git.viresh.kumar@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Mar 2018 10:29:15 +0100
Message-ID: <CAPDyKFoeAnCcG-0S_uFoXOBD1eppysRv=8zBXvxS13BUba9UJw@mail.gmail.com>
Subject: Re: [PATCH 2/7] PM / OPP: Implement of_dev_pm_opp_find_required_opp()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 December 2017 at 08:26, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> A device's DT node or its OPP nodes can contain a phandle to other
> device's OPP node, in the "required-opp" property.
>
> This patch implements a routine to find that required OPP from the node
> that contains the "required-opp" property.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

[...]

> +++ b/include/linux/pm_opp.h
> @@ -309,6 +309,7 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
>  void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
>  int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
> +struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np);

I find the name of the exported function a bit "too" self-explainable,
opp...opp. :-)

However it's consistent with the existing APIs.

[...]

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
