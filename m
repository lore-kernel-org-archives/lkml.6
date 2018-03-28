Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeC1K4p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:56:45 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33298 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeC1K4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:56:43 -0400
X-Google-Smtp-Source: AIpwx49m8hjQZahSUUVE5wij0Mrx8mbfZPncPKjbII9VZtuoyR5F1g4RTBNGbUJQrX2DrVvK5eiOfZM1OSjZrOhVm4A=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iRjj5DEKU1m2_y96WRBNu6U1w=GSADRxWXfVDN9K+edQ@mail.gmail.com>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <2249320.0Z4q8AXauv@aspire.rjw.lan>
 <6462e44a-e207-6b97-22bf-ad4aed69afc2@tu-dresden.de> <4198010.6ArFqS34NK@aspire.rjw.lan>
 <CAJZ5v0j5mEaQSAiW4ynitM1ee=sqkpc8G_tZ40RYUgyavXXhqQ@mail.gmail.com>
 <b904266b-b5bb-587d-334a-844a70341f8d@tu-dresden.de> <CAJZ5v0iRjj5DEKU1m2_y96WRBNu6U1w=GSADRxWXfVDN9K+edQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Mar 2018 12:56:42 +0200
X-Google-Sender-Auth: E4dtRLTrDWr1jlLEFyWtHz_v7tw
Message-ID: <CAJZ5v0h40DDZ5da7CS4702Z=D3bY7SsOhbUqPR44qVKU0E4D4A@mail.gmail.com>
Subject: Re: [RFT][PATCH v7 6/8] sched: idle: Select idle state before
 stopping the tick
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 12:37 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Mar 28, 2018 at 10:38 AM, Thomas Ilsche
> <thomas.ilsche@tu-dresden.de> wrote:
>> On 2018-03-28 10:13, Rafael J. Wysocki wrote:
>>>

[cut]

>
> So I do
>
> $ for cpu in 0 1 2 3; do taskset -c $cpu sh -c 'while true; do usleep
> 500; done' & done
>
> which is a shell kind of imitation of the above and I cannot see this
> issue at all.
>
> I count the number of times data->next_timer_us in menu_select() is
> greater than TICK_USEC and while this "workload" is running, that
> number is exactly 0.
>
> I'll try with a C program still.

And with a C program I see data->next_timer_us greater than TICK_USEC
while it is running, so let me dig deeper.
