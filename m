Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A8FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2999720811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="5F/9RpJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2999720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLKH2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:28:16 -0500
Received: from cmta17.telus.net ([209.171.16.90]:36660 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeLKH2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:28:16 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id WcSfgdL0SP96wWcSggwQ7d; Tue, 11 Dec 2018 00:28:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1544513294; bh=CVpunYFypL/dXiyjG9R9gzj4K4lgYzkFiiwy2UAzYyE=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=5F/9RpJoXyVUdxml5XvA/fodUx92Tj9HZsTBRZjw0yhiTeV+/4hcfyxHnhJn3WWm5
         T2f+q856LoEekCxVvJ5raAnZ8LFrcWBVgXlJdc/jg6yP0UeayLLEqIrI/TMoX2Hkhf
         I5MG6lOJO04EmlFG88zxDZYw6WC/uJ7GT1VLCD2FSOj56Y/vLesKhXOVTzOgfVF9bt
         pL1bvs+o4b0cCipEM/qaMEmkSEDAdx7CXF9WJIaQ+nBccmX2d1+gGy3tKzmx5fwOBm
         NWqnItXKTqR4EOpErlugmgKgBLjwa0fRxBBCiSIkiUX0bO6NvMIOpJ82Zwn6IWAK8y
         gtJ/VqCUIUJZQ==
X-Authority-Analysis: v=2.3 cv=G5vN7Os5 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=JfrnYn6hAAAA:8
 a=j_xubRRabc_gLPjOC1IA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'open list:DOCUMENTATION'" <linux-doc@vger.kernel.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "Doug Smythies" <dsmythies@telus.net>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <20181210122104.GL5289@hirez.programming.kicks-ass.net> <CAJZ5v0j-a6cHayRtcsUPbUTBT0iBSUvmcUy6pfSSvUVcTMBxbw@mail.gmail.com> WUOsgxly2wifMWUOxgv0We
In-Reply-To: WUOsgxly2wifMWUOxgv0We
Subject: RE: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
Date:   Mon, 10 Dec 2018 23:28:07 -0800
Message-ID: <003401d49123$13627710$3a276530$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdSQ2u+9QZn0bxubQISdP83AHOeGqAARHUkw
Content-Language: en-ca
X-CMAE-Envelope: MS4wfC33gNEF43A6YSw0pX/n+IeerjIUSXbDcDusVBnW+qrmWiQiKxZtEuoW9qt38DIJZpL6Fe7dfay05A3bOPn6rB+wua9/yslg8OuvigUbli+qBWf0DZyt
 l6UjzQjYaBxSPRaTRERa6Y7Dn4z11vb3P9zxb4GtTvDt/hEozTnWT19YgJ9lfrOecP7UfcYPHjFePlrHDq95gE4icUv9hEHv1e4BQXWiaKF+g5qGhy0Gyw/B
 DidzH4wMfzWOkIclJg+F/UVRDHK1LMXmC0Ifq07u64Wtipwz8545+jXLO2zzGbeGbj5vQqI4e5PdcXnAxIq4GVUN6WWmfnWllZdQjkgLomAlgpC1+QxOHy7X
 HlxVxPMXoYh3D0lHyPSsfMnv356Ltz47Y+ALgW5jGwaM7PYjvEK/Prs1Blghp4dGNx78dQwKNPmPS0G+miKvIeJY6INWByVJfpjCstvpXnU35s72g3Z0ima4
 HKVlPJOAEefnUdVV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.12.10 02:52 Peter Zijlstra wrote:
>On Mon, Dec 10, 2018 at 10:36:40PM +0100, Rafael J. Wysocki wrote:
>> On Mon, Dec 10, 2018 at 1:21 PM Peter Zijlstra <peterz@infradead.org> wrote:

>>> Would not a tracepoint be better?; then there is no overhead in the
>>> normal case where nobody gives a crap about these here numbers.
>> 
>> There is an existing tracepoint that in principle could be used to
>> produce this information, but it is such a major PITA in practice that
>> nobody does that.  Guess why. :-)
>
> Sounds like you need to ship a convenient script or something :-)

For the histogram plots of idle durations that I sometimes provide, trace
is used. It is more work to do it the trace way. Very often, when the rate
of idle state entries/ exits is high, turning on trace influences the system
under test significantly. Also, even if I allocate the majority of my memory
to the trace buffer (i.e. 15 of my 16 gigabytes), I can only acquire a few 
minutes of trace data before filling the buffer.

Some of my tests run for hours, and these new counters provide a way to acquire
potentially useful (I don't have enough experience with them yet to know how useful)
information, while having no influence on the system under test because
I only take samples once per minute, or sometimes 4 times per minute.

>> Also, the "usage" and "time" counters are there in sysfs, so why not these two?

I agree, how are these two counters any different?

In about a week or so, I'll have some test data comparing 4.20-rc5 with teov6
teov7 along with the idle data (graphs) that I usually provide and also these
new counters.

... Doug


