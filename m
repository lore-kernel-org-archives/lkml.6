Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbeFDL1r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:27:47 -0400
Received: from ozlabs.org ([203.11.71.1]:58065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbeFDL1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:27:45 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
In-Reply-To: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
Date: Mon, 04 Jun 2018 21:27:40 +1000
Message-ID: <87fu22bxlf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> The commit 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of
> snooze to deeper idle state") introduced a timeout for the snooze idle
> state so that it could be eventually be promoted to a deeper idle
> state. The snooze timeout value is static and set to the target
> residency of the next idle state, which would train the cpuidle
> governor to pick the next idle state eventually.
>
> The unfortunate side-effect of this is that if the next idle state(s)
> is disabled, the CPU will forever remain in snooze, despite the fact
> that the system is completely idle, and other deeper idle states are
> available.

That sounds like a bug, I'll add?

Fixes: 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state")
Cc: stable@vger.kernel.org # v4.2+

cheers
