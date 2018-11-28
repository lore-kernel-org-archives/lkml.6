Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32CAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895DF2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="imxy1095"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895DF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeK2KXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:23:35 -0500
Received: from cmta17.telus.net ([209.171.16.90]:32816 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbeK2KXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:23:35 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id S97pg2UrqP96wS97qgqERD; Wed, 28 Nov 2018 16:20:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1543447217; bh=RsdwzVRUQmxQl0PIxf8EcPck3Hjt8EI3nCbF8p3GG3U=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=imxy1095dPTycu0B3VTd/fGeL4Rd6RhDYOzdamz+vZkM8O5b+Epw85jCrINYp3LIw
         WrrKEBibvAjFx6fKVcL3URwdgGF2X0XBa6xXKczEH7zrBjRRkmYp0neH6kiId3+FGa
         /W+v6nLeNi8m1aPzJfbeUJo+76JqbAQVxcVrMOhypZRpI/ygLfu4AqvWrVxDlHopfF
         lG7qwzrWP0kNP8WliXohmcux64ofTmb/ddtZi69nFtw/78rPZPi7iZ3Sr7VkGtEUEU
         KgpsNIYBDGQDv5XSWEsJWKgTnMLpTmbhWLBqFQYSDOIyN2InhcttitzDgBXSy3hN4+
         YZyKbKvPI/iEw==
X-Authority-Analysis: v=2.3 cv=G5vN7Os5 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=GhQS4BH7p4rc-h-6rWMA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=CjuIK1q_8ugA:10
 a=wWQHr837BUsA:10 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: Q8oEgsq1aDhAwQ8oJg8ZUI
In-Reply-To: Q8oEgsq1aDhAwQ8oJg8ZUI
Subject: RE: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor for tickless systems
Date:   Wed, 28 Nov 2018 15:20:07 -0800
Message-ID: <002c01d48770$eba6efa0$c2f4cee0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdSDGEuEn5NKr78+TzWlxEKC0bSkgwCygVAw
X-CMAE-Envelope: MS4wfK7A4hPsKhO+qg07Guwt0pLxd6lyUiZW7bIURSHr0KpteGBTeafQ9iyVyWGy9t58R8M90lwOdiRmM7Sra4B11nvBiitMbs1PZvE7XZjMi3nat+MR6JF5
 lBnsYD6m+VN7PirD+rOblbLPf24Yx6LSJvzk9UXJZUtflIH201+8yX545iHXMcUswxyQIzPW5upa00gASzpPdw1F3kAkQlRp62E6vptEMexLeaPG4qSRkHk6
 L4sf783qPs6/dZ5rvYp3XkEWOTPriQ7yp8heuosz7GWU311AJYwHBw4ydXLxHM6aq2KJOl/+7h4bRWksO8aNWaxVOjzQGWiR4zVIFPvfKlUmghU9PaZFxEQk
 YvYjOJ7UiJJhH/uu0FchZn5lx3WIA/nr4ISBR2ICSRkfeZ+FSINMpTzPoZH3X6fur8pmYsqetL4KB3rTmOOE/vDOnomGq5zhYVT74/SCeGokE1C9g9+S8W1U
 XXn8orvu1A0/FUjs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.11.23 02:36 Rafael J. Wysocki wrote:

v5 -> v6:
 * Avoid applying poll_time_limit to non-polling idle states by mistake.
 * Use idle duration measured by the governor for everything (as it likely is
   more accurate than the one measured by the core).

-- above missing-- (see follow up e-mail from Rafael)

 * Rename SPIKE to PULSE.
 * Do not run pattern detection upfront.  Instead, use recent idle duration
   values to refine the state selection after finding a candidate idle state.
 * Do not use the expected idle duration as an extra latency constraint
   (exit latency is less than the target residency for all of the idle states
   known to me anyway, so this doesn't change anything in practice).

Hi Rafael,

I did some minimal testing on teov6, using kernel 4.20-rc3 as my baseline
reference kernel.

Test 1: Phoronix bdench test, all options: 1, 6, 12, 48, 128, 256 clients.

Note: because it uses the disk, the dbench test is somewhat non-repeatable.
However, if particular attention is paid to not doing anything else with
the disk between tests, then it seems to be repeatable to within about 6%.

Anyway no significant difference observed between kernel 4.20-rc3 and the
same with the teov6 patch.

Test 2: Pipe test, non cross core. (And idle state 0 test, really)
I ran 4 pipe tests, 1 for each of my 4 cores, @2 CPUs per core.
Thus, pretty much only idle state 0 was ever used.
Processor package power was similar for both kernels.
teov6 entered/exited idle state 0 about 60,984 times/second/cpu.
-rc3 entered/exited idle state 0 about 62,806 times/second/cpu.
There was a difference in percentage time spent in idle state 0,
with kernel 4.20-rc3 spending 0.2441% in idle state 0 verses
teov6 at 0.0641%.

For throughput, teov6 was 1.4% faster.

Test 3: was an attempt to sweep through a preference for
all idle states.

40 threads were launched with nothing to do except sleep
for a variable duration of 1 to 500 uSec, each step was
run for 1 minute. With 1 minute idle before the test and a few
minutes idle after, the total test duration was about 505 minutes.
Recall that when one asks for a short sleep of 1 uSec, they actually
get about 50 uSec, due to overheads. So I use 40 threads in an attempt
to get the average time between wakeup events per CPU down somewhat.

The results are here:
http://fast.smythies.com/linux-pm/k420/k420-pn-sweep-teo6-2.htm

I might try to get some histogram information at a later date.

... Doug


