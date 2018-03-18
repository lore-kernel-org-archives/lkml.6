Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbeCRMwL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:52:11 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40695 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754210AbeCRMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:02 -0400
X-Google-Smtp-Source: AG47ELsH8O/Atyl5ZlkssmjIHu//Ijc/FONc9SqXuNhXEwgBiX/KbLCksIzHswpcS961bBSGzWw5CA==
Date: Sun, 18 Mar 2018 07:51:59 -0500
From: Rob Herring <robh@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 11/25] of: base: Add of_get_cpu_state_node() to get
 idle states for a CPU node
Message-ID: <20180318023811.izvvsjqzb3awqwpy@rob-hp-laptop>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
 <1521046715-30683-12-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521046715-30683-12-git-send-email-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 05:58:21PM +0100, Ulf Hansson wrote:
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

I'd prefer not to add this here, but don't have a better suggestion. If 
more cpu related functions are added, I'd like to move them to a 
separate file in drivers/of/, but that can wait.

Reviewed-by: Rob Herring <robh@kernel.org>
