Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E24DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45FF20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="K4Z5kRRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45FF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeLCQYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:24:14 -0500
Received: from cmta17.telus.net ([209.171.16.90]:59910 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbeLCQYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:24:14 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id Tr0ngcYo5P96wTr0ogEjtd; Mon, 03 Dec 2018 09:24:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1543854243; bh=AiaTQMQBvGccLcI4ClF8lUxZi5gSyNyV8P7FgwDTRMg=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=K4Z5kRRo1XAEOyJeVeg9JR0eEFl+NqoVxQwLK5QlaIP7a1Dx1bkT3qtsDtUh5DmJV
         k5gHq36n2HmgPn/z2Yhvbj/R/0bPnUjrZCYIjQj+5uTlqSqp7OsHXhmKGaJJ8JXQ7G
         ptdq3CIoa+VWZMLq6wIlY3QiEY25XKv6dvA5e0BsWXuCzHP6KLygJW6Bz8tsCqVPWO
         +vscQ+4nIuCp6Igi0293sP702wcdNcba9q/hWjWledQbdNkyjgLtOQ6HOIrvJNFbEm
         bHxr8C/YNCcifSKdOxeDE8SJpmKRqSM5RD/xuZUABe80UqLXCoQvrNbhZUrMmDUMFk
         8Ex91adLx7Ylw==
X-Authority-Analysis: v=2.3 cv=G5vN7Os5 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=OuBNrd82AAAA:20
 a=6DtfcGF9F9tOB7LjX30A:9 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "Doug Smythies" <dsmythies@telus.net>
References: <42865872.dmYH3PmblP@aspire.rjw.lan> T62Cgz3BqpqCWT62HgcJvj
In-Reply-To: T62Cgz3BqpqCWT62HgcJvj
Subject: RE: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor for tickless systems
Date:   Mon, 3 Dec 2018 08:23:56 -0800
Message-ID: <001a01d48b24$9aa38c00$cfeaa400$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdSJgCnCYoJejtieTwSToCb137fwhQBnN0WQ
X-CMAE-Envelope: MS4wfHBuJfh2V9xeKhJ0qhgqeB4DSRARinAeoitl3Nzgy0RYJujgBbP48LVT5viwU3JyTAB8UDYYKYe3assPoCeJlm+tVyAGNOoU+IrKwrObkTa2GeXxpeNE
 LUq8+34iaDrdzOTjqr7bx2rVomT3A7t9TcXE8JpBZr9BQnE+02a8bc9EVj+BumAZwCfbFVQ2zoCvMHOiHxuvYw9vsIe6M8Z1lsTlVIgwGXX0pZNb+g6oGPoM
 fGjWRjtT+Qqn26mpvsqk8+bD3clNA09lWxhghFqJ8eaSX/yg3EsPpAtkx8LL0vfn3/QLhyZA093mc7lW7A60bxbMW81xp/litHcWGg/1150jDfxEToS97sfH
 Kf3J+HuLDyo1YC4LzHZUjF5+f/8fsdE6pzL4DMYZmoG6n+FEr/0H+JRXsgvl5Ao3rAMIbxQ3NEhjMbmixWwsyIfrfTTfo7xKGC+9qAzVyqKry6yIJknoLIEu
 fhfPz1nta20W6USv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giovanni,

Perhaps I should go off-list for this, not sure.

I had the thought that I should be able to get similar
results as your "8x-SKYLAKE-UMA" on my test computer,
i7-2600K. Or that at least it was worth trying, just
to see. I couldn't find the same or similar test
on Phoronix, and my attempts to do similar, for example,
with iperf, didn't show differences between the baseline
kernel and one with the teov6 patch.

So I tried the test set you referenced [1]:

On 2018.12.01 06:18 Giovanni Gherdovich wrote:
...
> * netperf on loopback over TCP
>    * global-dhp__network-netperf-unbound

I assume this means that I am supposed to do:

cp config-global-dhp__network-netperf-unbound config

from the configs directory. Anyway that config file
looks correct. Then:

./run-mmtests.sh --no-monitor 3.0-nomonitor

...

> * sockperf on loopback over UDP, mode "throughput"
>    * global-dhp__network-sockperf-unbound

Similarly (from the appropriate directories): 

cp config-global-dhp__network-sockperf-unbound config
./run-mmtests.sh --no-monitor 3.0-nomonitor

My issue is that I do not understand the output or how it
might correlate with your tables.

I get, for example:

   3    1   1     0.13s     0.68s     0.80s  1003894.302 1003779.613
   3    1   1     0.16s     0.64s     0.80s  1008900.053 1008215.336
   3    1   1     0.14s     0.66s     0.80s  1009630.439 1008990.265
...

But I don't know what that means, nor have I been able to find
a description anywhere.

In the README file, I did see that for reporting I am 
somehow supposed to use compare-kernels.sh, but
I couldn't figure that out.

By the way, I am running these tests as a regular user, but
they seem to want to modify:

/sys/kernel/mm/transparent_hugepage/enabled

which requires root privilege. I don't really want to mess
with that stuff for these tests.
 
> [1] https://github.com/gormanm/mmtests

Can you help me to produce meaningful results to compare with
your results?

... Doug


