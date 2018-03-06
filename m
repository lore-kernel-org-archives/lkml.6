Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeCFJ2d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:28:33 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:35669 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCFJ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:28:30 -0500
X-Google-Smtp-Source: AG47ELv8Ttu/gMMbE2ROJ/D7JHSyBoHJis+WghRdTKgPN1fmpn0+iZfNoeipOSgOMF0U0k11LCrthVbNRiZrRY++CrM=
MIME-Version: 1.0
In-Reply-To: <1756432.KnKEJ20PhI@aspire.rjw.lan>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan> <1756432.KnKEJ20PhI@aspire.rjw.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 Mar 2018 10:28:29 +0100
X-Google-Sender-Auth: efo0AlnNvHZ1gJoi9V-rT7gizhA
Message-ID: <CAJZ5v0g=Enc1ji-HMt9R+WSh9KPvGsB8saN34xtuVi5UOfcBMQ@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v2 4/6] cpuidle: Return nohz hint from cpuidle_select()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bummer. :-(

On Tue, Mar 6, 2018 at 10:05 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> +       if (drv->states[idx].flags & CPUIDLE_FLAG_POLLING) {
> +               *nohz_ret = false;
> +       } else if (drv->states[idx].target_residency < TICK_USEC) {
> +               /*
> +                * Do not stop the tick if there is at least one more state
> +                * within the tick period range that could be used if longer
> +                * idle duration was predicted.
> +                */
> +               *nohz_ret = first_idx > idx &&
> +                           drv->states[first_idx].target_residency < TICK_USEC;

This is reversed, sent a wrong version of the patch.

I'll resend with this fixed shortly.
