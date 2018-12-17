Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5309AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA212183E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 01:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="1Bit5Kvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbeLQBxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 20:53:55 -0500
Received: from cmta16.telus.net ([209.171.16.89]:53433 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbeLQBxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 20:53:54 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id Yi6IghyouPTKIYi6JgbQTW; Sun, 16 Dec 2018 18:53:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1545011632; bh=1K/8gVpBMQzGyE/0dbqDoJv3a5/Wq9E2E6iGFt+goDs=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=1Bit5KvsNLyNXr9o9m0HsD5Pyh70NO+4g+JqBIwPFHFXGz01ITq6FuUoHtzKyvbAY
         377za90yepAZL8/aUUWkjYe4ThlrjtcShKHEUSPu1ZnBcZCrPqTlPgXKRKCxyw0Lt2
         Eo1kjqLj4H5LcZhjDIuzKqCOvgfT0ldtu+tt5+4iF0CAJqkzzV4JABR1Lz028z07fv
         VqHmaKVlwfUMUk6u51EN42F4wLzf1ziYOWXcoDtEUw5Z3haFzu46P9QqHsLFOEZ+Sg
         UNXEtfOYBkWCjDLGBEaR1FoUuYE/GSfBNYnK/fWX/8XRUoziZl0CFeuq1emjvdbhd+
         inQDPcwQQjh+A==
X-Authority-Analysis: v=2.3 cv=ScEmicZu c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=ouC0gsByzFIQeUv6Ql4A:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=CjuIK1q_8ugA:10
 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Chen, Hu'" <hu1.chen@intel.com>,
        "'Quentin Perret'" <quentin.perret@arm.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: WgY3gAchapqCWWgY4gdfDg
In-Reply-To: WgY3gAchapqCWWgY4gdfDg
Subject: RE: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor for tickless systems
Date:   Sun, 16 Dec 2018 17:53:41 -0800
Message-ID: <000001d495ab$5c16eea0$1444cbe0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdSRR6W+Msr3sp1wQOOUFEbfomZ2MAEX2lCA
Content-Language: en-ca
X-CMAE-Envelope: MS4wfMcMKI2Fm714FODYGyRc4/FimyeKOeItZwo5z/9QfYgASEfPVqCdbmvE1nIMdXjA8VM2LjEEGzbh6MVy/wi9+W0lUqLaRx48odqziRd1fCLakyOxBv6y
 YLLG4Z8ZvTJr/lEGKPLK10sZYkwS8zhZL7OBxQ/SM9LWkgh+0bBiMOn13rmYsxf+wEk4gYRO1AymjXcgxcWfBhk5T/8e7/Z8srxrziICg/OMmS//w0qUIK08
 un1Ufu8Vy32nd6AA8gxFFPsHgEKDMDbR8qc1NWeqX2YfCjEd97ABkIAJgMB12TbiS+EUkZe5y7ZGmxhD5h6FCHDt58rPT+OF0AHYAoUjVAhu0KmrjL7+yNW5
 6u8+1HacfTSS2uhwG+3FXpYqArv02FsZhZaWn9IP8DVs4hvuhnV4KTMO1nMUcSBHMhU5Qas0S4pVpr+qwvd4HlzQtiildPToMKXDypFC6t3PzFVP23b5bEST
 pYLmDg6Onzyvyfi0jee2YHXG/WLvczlrgwSQ69QoLEG6irGz/x3NeE9jz43DxJLCihvDKI0oiC5roZmr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.12.11 03:50 Rafael J. Wysocki wrote:

...[snip]...

> With this version of the TEO governor I'm observing slight, but consistent
> performance improvements in some different benchmarks on a few different
> systems with respect to menu

Same here.

> and the corresponding power draw differences
> appear to be in the noise.  The idle power doesn't seem to change either.

Same here.

> Also the "above" and "below" metrics (introduced by a separate patch under
> discussion) indicate changes in the "good" direction.

My graphs now include the "above" and "below" metrics.
In particular see Idle State 1 "above" (was too deep) graphs in the links below.
However, performance is up and power about the same, so O.K.
  
> Overall, I like this one, so I may consider dropping the RFC/RFT tag from the
> next submission. :-)
>
> v7 -> v8:
> * Apply the selection rules to the idle deepest state as well as to
>   the shallower ones (the deepest idle state was treated differently
>   before by mistake).
> * Subtract 1/2 of the exit latency from the measured idle duration
>   in teo_update() (instead of subtracting the entire exit latency).
>   This makes the idle state selection be slightly more performance-
>   oriented.

I cherry picked a couple of the mmtests that Giovanni was doing:

Test kernels:

"stock" kernel 4.20-rc5 + a couple of rjw patches. Specifically:

	    2a110ed cpuidle: poll_state: Disregard disable idle states
	    8f09875 cpuidle: Add 'above' and 'below' idle state metrics
	    d6851a5 Documentation: admin-guide: PM: Add cpuidle document
	    2595646 Linux 4.20-rc5

"teov6" above + teov6 patch
"teov7" above + teov7 patch
"teov8" above + teov8 patch

1.) mmtests - netperf-unbound test (UDP):

                                   4.20-rc5               4.20-rc5               4.20-rc5               4.20-rc5
                                      stock                   teo6                   teo7                   teo8
Hmean     send-64         129.64 (   0.00%)      132.45 *   2.17%*      130.55 *   0.71%*      132.87 *   2.49%*
Hmean     send-128        259.53 (   0.00%)      264.90 *   2.07%*      261.61 *   0.80%*      264.94 *   2.09%*
Hmean     send-256        515.24 (   0.00%)      525.41 *   1.97%*      517.41 *   0.42%*      524.88 *   1.87%*
Hmean     send-1024      2041.01 (   0.00%)     2079.22 *   1.87%*     2045.03 *   0.20%*     2077.25 *   1.78%*
Hmean     send-2048      3980.04 (   0.00%)     4071.09 *   2.29%*     4041.15 *   1.54%*     4057.09 *   1.94%*
Hmean     send-3312      6321.90 (   0.00%)     6460.23 *   2.19%*     6395.71 *   1.17%*     6409.09 *   1.38%*
Hmean     send-4096      7695.18 (   0.00%)     7882.81 *   2.44%*     7813.72 *   1.54%*     7832.77 *   1.79%*
Hmean     send-8192     13920.53 (   0.00%)    14146.47 *   1.62%*    13986.72 *   0.48%*    14079.07 *   1.14%*
Hmean     send-16384    24714.99 (   0.00%)    25225.95 *   2.07%*    24896.10 *   0.73%*    25131.52 *   1.69%*
Hmean     recv-64         129.64 (   0.00%)      132.45 *   2.17%*      130.55 *   0.71%*      132.87 *   2.49%*
Hmean     recv-128        259.53 (   0.00%)      264.90 *   2.07%*      261.61 *   0.80%*      264.94 *   2.09%*
Hmean     recv-256        515.24 (   0.00%)      525.41 *   1.97%*      517.41 *   0.42%*      524.88 *   1.87%*
Hmean     recv-1024      2041.01 (   0.00%)     2079.22 *   1.87%*     2045.03 *   0.20%*     2077.25 *   1.78%*
Hmean     recv-2048      3980.04 (   0.00%)     4071.09 *   2.29%*     4041.15 *   1.54%*     4057.09 *   1.94%*
Hmean     recv-3312      6321.88 (   0.00%)     6460.23 *   2.19%*     6395.71 *   1.17%*     6409.09 *   1.38%*
Hmean     recv-4096      7695.15 (   0.00%)     7882.81 *   2.44%*     7813.72 *   1.54%*     7832.75 *   1.79%*
Hmean     recv-8192     13920.52 (   0.00%)    14146.43 *   1.62%*    13986.72 *   0.48%*    14079.07 *   1.14%*
Hmean     recv-16384    24714.99 (   0.00%)    25225.90 *   2.07%*    24896.07 *   0.73%*    25131.49 *   1.69%*

Graphs: http://www.smythies.com/~doug/linux/idle/teo8/net-pref-udp-unbound/index.html
(note: slow upload speed from my server)

2.) mmtests - sockperf-udp-throughput test:

                            4.20-rc5               4.20-rc5               4.20-rc5               4.20-rc5
                               stock                   teo6                   teo7                   teo8
Hmean     14        24.57 (   0.00%)       25.91 *   5.46%*       25.99 *   5.78%*       25.73 *   4.75%*
Hmean     100      175.37 (   0.00%)      185.09 *   5.54%*      185.89 *   6.00%*      184.48 *   5.19%*
Hmean     300      523.81 (   0.00%)      553.47 *   5.66%*      554.70 *   5.90%*      550.16 *   5.03%*
Hmean     500      870.08 (   0.00%)      918.88 *   5.61%*      924.33 *   6.24%*      914.53 *   5.11%*
Hmean     850     1449.44 (   0.00%)     1530.84 *   5.62%*     1535.40 *   5.93%*     1522.53 *   5.04%*

Graphs: http://www.smythies.com/~doug/linux/idle/teo8/sockperf-udp-throughput/index.html
(note: slow upload speed from my server)

The above results tables are also here:
http://www.smythies.com/~doug/linux/idle/teo8/index.html

I wanted to also do the tbench on loopback test, but have not been able to get it working on my system yet.
I'll supply more test results at a later date.

... Doug



