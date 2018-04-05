Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeDENwZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:52:25 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:39051 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbeDENwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:52:23 -0400
X-Google-Smtp-Source: AIpwx49SgiLz9qc561m1+ZerVNH5k83ZlSJ41hFCJk3FNHKWPYWI9MQoK30Sjm3h2ItwX7FVak15RxvqOgkGJ77PaMI=
MIME-Version: 1.0
In-Reply-To: <20180405123219.GP4082@hirez.programming.kicks-ass.net>
References: <1736751.LdhZHb50jq@aspire.rjw.lan> <5752796.zf5UeYB95r@aspire.rjw.lan>
 <20180405123219.GP4082@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Apr 2018 15:52:22 +0200
X-Google-Sender-Auth: HKdNM2ADLTximE-bjF168EO8HEU
Message-ID: <CAJZ5v0hHafjXS_erX_mRda_ZNj5LHXVQPthOO2F5zpBDAoQXsA@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] cpuidle: menu: Refine idle state selection for
 running tick
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 2:32 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Apr 04, 2018 at 10:49:34AM +0200, Rafael J. Wysocki wrote:
>> +     data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
>> +             unsigned int delta_next_us = ktime_to_us(delta_next);
>
> We really should be looking at removing all that us nonsense from the
> idle code, but that'll be another series.

Right.
