Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeCNPAu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:00:50 -0400
Received: from cmta20.telus.net ([209.171.16.93]:46510 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeCNPAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:00:48 -0400
X-Authority-Analysis: v=2.2 cv=Pr98V0E3 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=gu6fZOg2AAAA:8
 a=2cg7-5FeuwDfEq1i-yIA:9 a=CjuIK1q_8ugA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: w74pegSSBpApsw74ueHlNx
In-Reply-To: w74pegSSBpApsw74ueHlNx
Subject: RE: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Wed, 14 Mar 2018 08:00:44 -0700
Message-ID: <000f01d3bba5$3cba5a00$b62f0e00$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdO7ne+4zbK4uNEUQPizGgVG9Sn9lwAAajUw
X-CMAE-Envelope: MS4wfBJPUpGkl0zljGhgwQKKJcyvgJ8hC0/qaEn44j9Zk8+RAcouiUt1tiz09KsFXmvxDAsWS4ozMxhIoyxK8mypn1aJzGZo5WJ+vJ59wP4FFrmHp8GsyzAw
 bHrbZAXuRJwmvcUQ//F7sJ24LBSEJ/FrTGxti7NvZl0fZCjjlMwa/mF0Zc0MXIdX8CY6P3YhEZl2nlW0KT+Xe1pFif3R8vYhJ1XVuQcpHu96mAVLBcRmOkDz
 w+tTiIplYRg3zesXJ86/1rkxR/0ygZZAhL2x05+f/wfL8qcFaMPtnQw3J0A6aPXC6RIZDCc6nHjU3ubjDN+zmhftX2gHBvn3p2dp5wZrUWc6ZN/BdOcwdNy/
 Da0OgsxaE7vnzCgD9bpArN6NjkxnSrnkR+FA1CeMfzWv8kfeHRCpx5z+aAIRvJMaDCJ0/vYdzG+tSgVrhWW3NE6Hq3NIiRYGOTQiEwG9O4vqQB7uzUVXnUBm
 NQg/VtYDZnYIMH4443iQvT8/PcJ7XT4fsrzfTxpYcc9vrWrZSWtQi0G2ilI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.14 07:09 Rafael J. Wysocki wrote:

... [snip]...

> v2 -> v3: Use local_clock() for time measurements and drop the
>          counter, since that should be lightweight enough (as
>          suggested by Peter).

I have been testing the latest of everything for a couple of days
now, and everything continues to be great.

Note that I was using a POLL_IDLE_TIME_CHECK_COUNT of 1 anyhow, because
I specifically wanted to test the worst case time through the loop.
i.e. I wanted any potential issue to be 1000 times more likely to find.
My problem is that I don't know of a good test for this specifically.

I'll switch to this V3, along with V4 of the "sched/cpuidle: Idle loop
rework" 7 patch set.

As for energy savings for just this patch only, I would refer readers
to my previous test results from late November, [1], as I haven't
re-done those Phoronix tests yet, but I don't expect the results to
differ much.

[1] https://marc.info/?l=linux-pm&m=151154499710125&w=2

... Doug
