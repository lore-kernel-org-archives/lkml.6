Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbeCOVNA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:13:00 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40181 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbeCOVM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:12:58 -0400
X-Google-Smtp-Source: AG47ELsXsha+YnvT4AFSt/tOGi3QuVLQOW/nC/OY/s7OgClDqXxEjl4YN0b8Mkamsnqb98Erv6Za+R5ex1tVxgJ/0+s=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jGi_ewnJXxwuY1-y6Ti64Y601A4DQuDhtMJ+riYPJpzA@mail.gmail.com>
References: <2352117.3UUoYAu18A@aspire.rjw.lan> <3550231.xNMJN5JcLx@aspire.rjw.lan>
 <20180315181858.GA14983@lerouge> <CAJZ5v0jGi_ewnJXxwuY1-y6Ti64Y601A4DQuDhtMJ+riYPJpzA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Mar 2018 22:12:57 +0100
X-Google-Sender-Auth: wwgJvZrBNaLUp54AVCmRmI7kf7A
Message-ID: <CAJZ5v0hGsXV8HTKC8iS0pD6VLoe8pDutos7NhWPU+wid_q7Now@mail.gmail.com>
Subject: Re: [RFT][PATCH v4 3/7] sched: idle: Do not stop the tick before cpuidle_idle_call()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Thu, Mar 15, 2018 at 9:41 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Mar 15, 2018 at 7:19 PM, Frederic Weisbecker
> <frederic@kernel.org> wrote:
>> On Mon, Mar 12, 2018 at 10:53:25AM +0100, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Make cpuidle_idle_call() decide whether or not to stop the tick.
>>>
>>> First, the cpuidle_enter_s2idle() path deals with the tick (and with
>>> the entire timekeeping for that matter) by itself and it doesn't need
>>> the tick to be stopped beforehand.
>>
>> Not sure you meant timekeeping either :)
>
> Yeah, I meant nohz.

Well, not really. :-)

It is the entire timekeeping this time, as it can be suspended
entirely in that code path.
