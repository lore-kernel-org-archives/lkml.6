Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeDENth (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:49:37 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:42095 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeDENte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:49:34 -0400
X-Google-Smtp-Source: AIpwx48r5giZ3KtVlgs9IVSZ3haDHUp96muCiOrl9Xg+HGf78mSJCNKFbrW+t2AEBsYd7NJWniKayxrgSKhAdCciFgk=
MIME-Version: 1.0
In-Reply-To: <20180405124757.GQ4082@hirez.programming.kicks-ass.net>
References: <1736751.LdhZHb50jq@aspire.rjw.lan> <6542020.eHGLEK9V0J@aspire.rjw.lan>
 <20180405124757.GQ4082@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Apr 2018 15:49:32 +0200
X-Google-Sender-Auth: NommpsFV3CvO7hjTnq6wgH8K7ek
Message-ID: <CAJZ5v0h2c5RtUxwF2z3Gjy8O2RSBaD7wN3CxUXrg57jH57_xoA@mail.gmail.com>
Subject: Re: [PATCH v9 10/10] cpuidle: menu: Avoid selecting shallow states
 with stopped tick
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

On Thu, Apr 5, 2018 at 2:47 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Apr 04, 2018 at 10:50:36AM +0200, Rafael J. Wysocki wrote:
>> +     if (tick_nohz_tick_stopped()) {
>> +             /*
>> +              * If the tick is already stopped, the cost of possible short
>> +              * idle duration misprediction is much higher, because the CPU
>> +              * may be stuck in a shallow idle state for a long time as a
>> +              * result of it.  In that case say we might mispredict and try
>> +              * to force the CPU into a state for which we would have stopped
>> +              * the tick, unless the tick timer is going to expire really
>> +              * soon anyway.
>
> Wait what; the tick was stopped, therefore it _cannot_ expire soon.
>
> *confused*
>
> Did you mean s/tick/a/ ?

Yeah, that should be "a timer".
