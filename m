Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4558CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C2520827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="QwlXSaGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C2520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbeKHCfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:35:36 -0500
Received: from cmta20.telus.net ([209.171.16.93]:57463 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbeKHCfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:35:36 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id KRFWgjkwOVltLKRFXgPdv6; Wed, 07 Nov 2018 10:04:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1541610261; bh=tu8Ssuiu+NXtVJdalQqYTtsZninnOPWtYWp2jzzAJls=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=QwlXSaGPWUwC2RTU+0Qdo/0DOiFy5t2Vj5j64ZujMtN0BXMCccUW2gYUEHrRVyhYe
         TvANYkZ58Q1zn4OFbBTmrGWsmQ2fz1OU4MSxPOmT4b7M9q+EgN7O6pk2uundnXR9Lr
         Eiafc2NHxu31KJcDJeAdp80/BF1FGlLrh+JOvLF/OkRierAz5ODYb7AF4zgfl/siel
         f1Bunsj/jTu8iGD+HZVv4GA17Bd29PHpO9YpCq0ZRFwgL8uYpFv4TMhLbz9BQGibDp
         xm7h7zKkcD7UQ3oewo1v96StZcaaXf/Spila4CjtMKLuAuXoz69McBquRa8UAGi60I
         C7MDhsSqAUMzg==
X-Authority-Analysis: v=2.3 cv=d60kNirE c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=gu6fZOg2AAAA:8
 a=FGbulvE0AAAA:8 a=iN15FHMp_3KkhuB6-PYA:9 a=CjuIK1q_8ugA:10 a=5JIPC4SmUL4A:10
 a=eM4ghy-HDjkA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
 a=2RSlZUUhi9gRBrsHwhhZ:22 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: JLIjge0NMDhAwJLIogChPj
In-Reply-To: JLIjge0NMDhAwJLIogChPj
Subject: RE: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor for tickless systems
Date:   Wed, 7 Nov 2018 09:04:12 -0800
Message-ID: <000001d476bb$ec964520$c5c2cf60$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdR0W8vD4oREAbGoTFqO9uyL0vrNhgCWrS2w
X-CMAE-Envelope: MS4wfMmcUveOHpGm1O0kPJ+EksIg6JNnfGtP4RqcTo8c4uYY2UjxxlPANPjqXfMZ+5PAQfwrEwa094cj881h/E0qVzX1ZkSA1FUlYtDotesnj70hgKzDvpos
 0F7rCFA10/Ab6aj2u+gwr0+1jLh4DWWiH7UaXslqh+DJo2zQCwqidyEIfnhxiOlLEmvuZnuCd1S32a7mKBvcA4cxUmf+tP79SyfMVvatq7pFPXE7GBkOtni4
 X68gND87jIWruOkVAEH9jx4sleiNYeR6oHFD5wZzMiXcRTGs0/9OJoxWnuwdWYh6FZ6raXohhGDI8arjkA2xjh8ZqOxL6l/oZH4zaX2xYtlQ+Rvzw1+/9BsO
 oi+QF4Q3NK9WLzme0ML73kxVc5h1yKehg6jknfNUW2id0XWsVrSNJ9LmgLBu/yklrkM0teb6pdrj1ICGjDeU5DGEKlJ5+T9K+nCQrCyz9g2+b2QeatrDR6KB
 YkGKI32V1mj/NVJh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.11.04 08:31 Rafael J. Wysocki wrote:

> v2 -> v3:
> * Simplify the pattern detection code and make it return a value
>	lower than the time to the closest timer if the majority of recent
>	idle intervals are below it regardless of their variance (that should
>	cause it to be slightly more aggressive).
> * Do not count wakeups from state 0 due to the time limit in poll_idle()
>    as non-timer.
>
> Note: I will be mostly offline tomorrow, so this goes slightly early.
> I have tested it only very lightly, but it is not so much different from
> the previous one.
> 
> It requires the same additional patches to apply as the previous one too.

Even though this v3 has now been superseded by v4, I completed some test
work in progress for v3 anyhow.

The main reason to complete the work, and write up, was because, and for my
own interest as much as anything, I wanted to specifically test for the
influence of running trace on the system under test.
Reference: https://marc.info/?l=linux-kernel&m=154145580925439&w=2

The Phoronix dbench test was run under the option to run all
the tests, instead of just one number of clients. This was done
with a reference/baseline kernel of 4.20-rc1, and also with this
TEO version 3 patch. The tests were also repeated with trace
enabled for 5000 seconds. Idle information and processor
package power were sampled once per minute in all test runs.

The results are:
http://fast.smythies.com/linux-pm/k420/k420-dbench-teo3.htm
http://fast.smythies.com/linux-pm/k420/histo_compare.htm

Conclusion: trace has negligible effect, until the system gets
severely overloaded.

There are some odd long idle durations with TEOv3 for idle
states 1, 2, and 3 that I'll watch for with v4 testing.

Other information:
Processor: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz
The kernels were 1000 Hz.
Idle latency/residency info:
STATE: state0   DESC: CPUIDLE CORE POLL IDLE    NAME: POLL      LATENCY: 0      RESIDENCY: 0
STATE: state1   DESC: MWAIT 0x00        NAME: C1        LATENCY: 2      RESIDENCY: 2
STATE: state2   DESC: MWAIT 0x01        NAME: C1E       LATENCY: 10     RESIDENCY: 20
STATE: state3   DESC: MWAIT 0x10        NAME: C3        LATENCY: 80     RESIDENCY: 211
STATE: state4   DESC: MWAIT 0x20        NAME: C6        LATENCY: 104    RESIDENCY: 345

... Doug
 

