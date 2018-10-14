Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3203C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876B720652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="cjyFDZZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876B720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeJNOdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 10:33:12 -0400
Received: from cmta17.telus.net ([209.171.16.90]:54715 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbeJNOdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 10:33:12 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id BaGwgBxFHP96wBaGxgmrCC; Sun, 14 Oct 2018 00:53:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1539499991; bh=npQsUs9ixQOs9rinNxVeI+D/f7kY2T6V5b1pbz6LhWk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=cjyFDZZCg3PJaKmNLowExlHstAF46imkAVM0eLQIaqxQxZzXM0ZRYkghGcaZFN1Te
         0lcTFzrUHwkmy1X3tKPcWuYWTirIKHErbReIabZfOOXee57GiB4AhOCvzUTw6LFXa/
         ueSejbKIg9gZqK8TGSFlK07iy1wF0rWkBcovhNJXKiSaSg897EIeA/NqJKIgv7ui44
         h2a5olofDNhZ9/ND+PbE5cbhnkxaeJAPupj3sAlQfeo/cc8aJGC9Xqo8Q/hJjuYBlY
         tih7dwWPXhqXMEZ2Nn4Ow2dwK72Qx7dJ9dUyvJf15UGZjY4RCS6R4xFAlqnU3yTbOI
         Q+hTPtQsXeTvA==
X-Authority-Analysis: v=2.3 cv=G5vN7Os5 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=6QdMcBypsDaUq5qtasoA:9 a=537V9a0rkdFoHQXc:21 a=X7iHTUF-p766b4_K:21
 a=CjuIK1q_8ugA:10 a=BBaMYSUnRWwA:10 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: Ai8Vgb2Sy7Ku3Ai8agzgab
In-Reply-To: Ai8Vgb2Sy7Ku3Ai8agzgab
Subject: RE: [RFC/RFT/[PATCH] cpuidle: New timer events oriented governor for tickless systems
Date:   Sat, 13 Oct 2018 23:53:04 -0700
Message-ID: <000e01d4638a$91a20c60$b4e62520$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdRhphJLOdhLAciBQT6qxf+Za/SVlgBZMYaw
X-CMAE-Envelope: MS4wfK5sCOgHYGYOZzHx6rb/UzhU/zUizP05gLJUywA6wDH+IFXIgRdEZpFltolsi/eQ4E6V7z/+3bVG+jmeQsuJbNUxd89k31N+pg+zld9VunXT1Kqe3SHE
 AUKA13iVvmFk2nKZXX64KkohtDtJXzpw+jJY+gZgmZyWu8mcufXQKpewABhrJ75Zxt2P3aqrDfF1H7x+oFSr19rs3/LLnxarcD4YpOo2ICFQ7o9E0wq4eJk2
 /+Mvbf40cH4bsIl/nm5LzTVwJQG2ZL8HHiAyUBKhcRBo7eQ1kiF2fZTQmRUm5K2IE1PmUSTu4q8unbnT2lE6vE2LswhwzYDpCKwpTRUj6xLGCj6p+FTNE4hH
 BNVXBsYLCii7dEASTqRYY3YwVXRr5RRFIMx/NHO6hCWcPUVOuK8TF/MaIB8/SdME/vB7/dO+slOfNZxw5tICl6NpCguwgaZWJuo4Eo1Nj+QDu7HA9+7q/pQB
 lYyyaxjITHUa7RvH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

I tried your TEO idle governor.

On 2018.10.11 14:02 Rafael J. Wysocki wrote:

...[cut]...

> It has been tested on a few different systems with a number of
> different workloads and compared with the menu governor.  In the
> majority of cases the workloads performed similarly regardless of
> the cpuidle governor in use, but in one case the TEO governor
> allowed the workload to perform 75% better, which is a clear
> indication that some workloads may benefit from using it quite
> a bit depending on the hardware they run on.

Could you supply more detail for the 75% better case, so that
I can try to repeat the results on my system?

...[cut]...

> It is likely to select the "polling" state less often than menu
> due to the lack of the extra latency limit derived from the
> predicted idle duration, so the workloads depending on that
> behavior may be worse off (but less energy should be used
> while running them at the same time).

Yes, and I see exactly that with the 1 core pipe test: Less
performance (~10%), but also less processor package power
(~3%), compared to the 8 patch set results from the other day.

The iperf test (running 3 clients at once) results were similar
for both power and throughput.

> Overall, it selects deeper idle states than menu more often, but
> that doesn't seem to make a significant difference in the majority
> of cases.

Not always, that viscous powernightmare sweep test that I run used
way way more processor package power and spent a staggering amount
of time in idle state 0. [1]. 

... [cut]...

> + * The sleep length is the maximum duration of the upcoming idle time of the
> + * CPU and it is always known to the kernel.  Using it alone for selecting an
> + * idle state for the CPU every time is a viable option in principle, but that
> + * might lead to suboptimal results if the other wakeup sources are more active
> + * for some reason.  Thus this governor estimates whether or not the CPU idle
> + * time is likely to be significantly shorter than the sleep length and selects
> + * an idle state for it in accordance with that, as follows:

There is something wrong here, in my opinion, but I have not isolated exactly where
by staring at the code.
Read on.

... [cut]...

> + * Assuming an idle interval every second tick, take the maximum number of CPU
> + * wakeups regarded as recent to rougly correspond to 10 minutes.
> + *
> + * When the total number of CPU wakeups goes above this value, all of the
> + * counters corresponding to the given CPU undergo a "decay" and the counting
> + * of recent events stars over.
> + */
> +#define TEO_MAX_RECENT_WAKEUPS	(300 * HZ)

In my opinion, there are problems with this is approach:

First, the huge huge range of possible times between decay events,
anywhere from ~ a second to approximately a week.
	In an idle 1000 HZ system, at 2 idle entries per 4 second watchdog event:
	time = 300,000 wakes * 2 seconds/wake = 6.9 days
	Note: The longest single idle time I measured was 3.5 seconds, but that is
	always combined with a shorter one. Even using a more realistic, and
	just now measured, average value of 0.7 idles/second would be 2.4 days.

Second: It leads to unpredictable behaviour, sometimes for a long time, until
the effects of some previous work are completely flushed. And from the first
point above, that previous work might have been days ago. In my case, and while
doing this work, it resulted in non-repeatability of tests and confusion
for awhile. Decay events are basically asynchronous to the actual tasks being
executed. For data to support what I am saying I did the following:
	Do a bunch of times {
		Start the powernightmare sweep test.
		Abort after several seconds (enough time to flush filters
			and prefer idle state 0)
		Wait a random amount of time
		Start a very light work load, but such that the sleep time
			per work cycle is less than one tick
		Observe varying times until idle state 0 is not excessively selected.
			Anywhere from 0 to 17 minutes (the maximum length of test) was observed.
	}

Additional information:

Periodic workflow: I am having difficulty understanding an unexpected high
number of idle entries/exits in steady state (i.e. once things have settled
down and the filters have finally flushed) For example, a 60% work / 40% sleep
at 500 hertz workflow seems to have an extra idle entry exit. Trace excerpt
(edited, the first column is uSeconds since previous):

     140 cpu_idle: state=4294967295 cpu_id=7
    1152 cpu_idle: state=4 cpu_id=7    <<<< The expected ~1200 uSecs of work
     690 cpu_idle: state=4294967295 cpu_id=7  <<<< Unexpected, Expected ~800 uSecs
      18 cpu_idle: state=2 cpu_id=7           <<<< So this extra idle makes up the difference
     138 cpu_idle: state=4294967295 cpu_id=7  <<<< But why is it there?
    1152 cpu_idle: state=4 cpu_id=7     <<<< Repeat
     690 cpu_idle: state=4294967295 cpu_id=7
      13 cpu_idle: state=2 cpu_id=7
     143 cpu_idle: state=4294967295 cpu_id=7
    1152 cpu_idle: state=4 cpu_id=7      <<<< Repeat
     689 cpu_idle: state=4294967295 cpu_id=7
      19 cpu_idle: state=2 cpu_id=7

Now compare with trace data for kernel 4.16-rc6 with the 9 patches
from the other day (which is what I expect to see):

     846 cpu_idle: state=4294967295 cpu_id=7
    1150 cpu_idle: state=4 cpu_id=7    <<<< The expected ~1200 uSecs of work
     848 cpu_idle: state=4294967295 cpu_id=7 <<<< The expected ~800 uSecs of idle
    1152 cpu_idle: state=4 cpu_id=7    <<<< Repeat
     848 cpu_idle: state=4294967295 cpu_id=7
    1151 cpu_idle: state=4 cpu_id=7    <<<< Repeat
     848 cpu_idle: state=4294967295 cpu_id=7
    1152 cpu_idle: state=4 cpu_id=7    <<<< Repeat
     848 cpu_idle: state=4294967295 cpu_id=7
    1152 cpu_idle: state=4 cpu_id=7    <<<< Repeat

Anyway, in the end we really only care about power. So for this test:
Kernel 4.19-rc6 + 9 patches: 9.133 watts
TEO (on top of 4.19-rc7):
At start, high number of idle state 0 entries: 11.33 watts (+24%)
After awhile, it shifted to idle state 1: 10.00 watts (+9.5%)
After awhile, it shifted to idle state 2: 9.67 watts (+5.9%)
That seemed to finally be a steady state scenario (at least for over 2 hours).
Note: it was always using idle state 4 also.

...[snip]...

> +	/* Decay past events information. */
> +	for (i = 0; i < drv->state_count; i++) {
> +		cpu_data->states[i].early_wakeups_old += cpu_data->states[i].early_wakeups;
> +		cpu_data->states[i].early_wakeups_old /= 2;
> +		cpu_data->states[i].early_wakeups = 0;
> +
> +		cpu_data->states[i].hits_old += cpu_data->states[i].hits;
> +		cpu_data->states[i].hits_old /= 2;
> +		cpu_data->states[i].hits = 0;

I wonder if this decay rate is strong enough.

Hope this helps.

... Doug

[1] http://fast.smythies.com/linux-pm/k419/k419-pn-sweep-teo.htm


