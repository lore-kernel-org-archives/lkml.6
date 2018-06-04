Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeFDJEw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:04:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:50831 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbeFDJEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:04:51 -0400
Message-ID: <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, paulus@samba.org, mpe@ellerman.id.au,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: stewart@linux.vnet.ibm.com
Date: Mon, 04 Jun 2018 19:04:14 +1000
In-Reply-To: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
References: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-04 at 13:47 +0530, Abhishek Goel wrote:
> +       if (of_property_read_string_array(power_mgt,
> +               "ibm,cpu-idle-state-descs", descs, dt_idle_states) < 0) {
> +               of_property_read_string_array(power_mgt,
> +                               "ibm,cpu-idle-state-names", descs, dt_idle_states);
> +               pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-descs in DT\n"
> +                       "Name will be used for description\n");
> +       }
>  
>         /*

Is this a new property ? I'm not fan of adding yet another of those
silly arrays.

I would say this is the right time now to switch over to a node per
state instead, as we discussed with Vaidy.

Additionally, while doing that, we can provide the versioning mechanism
I proposed so we can deal with state specific issues and erratas.

Cheers,
Ben.
