Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D7CC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 19:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C42208B8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 19:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="FI/o0UM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C42208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeHZXUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 19:20:46 -0400
Received: from cmta17.telus.net ([209.171.16.90]:60458 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeHZXUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 19:20:46 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id u0qVfkIfGLmeUu0qWfTAUj; Sun, 26 Aug 2018 13:37:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1535312235; bh=6lOnGN9GyNKJYdQrT6x9tGgLryVAic8V7PVjlXZPoYA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=FI/o0UM1keixZQVB3YMMfxl9w8q6ykKaFHghiwOSG9gCwSk4d5t9CjTVIdvUFmQIn
         mnCxXYsTLqKgG4O8Oa1LtEpamOVVJVVXwKOFqAZ2bUQMgpCy39rEXrTERsR3WJWicR
         uqonqHe367vyMiKp7P3xtF8BPb39ldExjW9yToROHWbBwDopqs6EWsrr5G5lWQf3d5
         /oNT+2J/idWNBLPLS4sAOM65VidzxMF4IMNXu2JdtKsa2jdAjy0GhXp4p/GtAS7PG1
         z+I40ehRPCRDqGSBojqe65ZdH4wXz4LhhG79U93p7M3N90suoYludZE8H6YGD7FG3p
         WS1m+vZaq1VqQ==
X-Authority-Analysis: v=2.3 cv=ING29TnG c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=O76VCmqbo-wA:10
 a=aatUQebYAAAA:8 a=QyXUC8HyAAAA:8 a=FGbulvE0AAAA:8 a=gu6fZOg2AAAA:8
 a=RQB35MKzeMY9OjtUgiEA:9 a=QEXdDO2ut3YA:10 a=IDo41p8BC2IA:10
 a=iq8WHSR1OGAA:10 a=5DLwxePbAi8A:10 a=XUPwaq2ENRcA:10 a=OYrdJcPLPnMA:10
 a=46HeQFaYVjEA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
 a=7715FyvI7WU-l6oqrZBK:22 a=svzTaB3SJmTkU8mK-ULk:22 a=2RSlZUUhi9gRBrsHwhhZ:22
 a=fH6ezBh0GlpOJwpmk9fj:22 a=EE-hDNo6nQ8U3qjUCziE:22 a=NWVoK91CQySWRX1oVYDe:22
 a=IeVV3oy9AQTmNaZTXIJc:22 a=HH7FIXwXL_sUf1zzYxQd:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'Leo Yan'" <leo.yan@linaro.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <34910476.pgRhNDWo5t@aspire.rjw.lan> <000701d43bc1$5e0c2c50$1a2484f0$@net> tWdkfsxwM1azttWdlfI2Eq
In-Reply-To: tWdkfsxwM1azttWdlfI2Eq
Subject: RE: [PATCH] cpuidle: menu: Retain tick when shallow state is selected
Date:   Sun, 26 Aug 2018 12:37:09 -0700
Message-ID: <000001d43d74$306e1b50$914a51f0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdQ8Zdhe90KmwzHNR/SycCVMT3lTKAATni+Q
Content-Language: en-ca
X-CMAE-Envelope: MS4wfOBM2EBdTv877nqLMGIi0HSsgcQKurELSEl7C59zrw0Vv175d2qnQRxEuxEb+riMuGpTKAX9pTrYcpNOrEzJ2DyWagFjNAE20ePDEJLHoxsxgbpYgzG/
 NLB2GJl0VAZcMezWjl6YFKuArf2yawAr740KnemFS3An8MYxioXeIbFUTyUn3actMoFr6a6gLKaw2QNZ9za4Ce1kIqIfB5otqxyq9hZMB4l4Q1glUrjPXKSf
 96F6Z0Zxv5Uw7Ju2iIWu0zrJU8SoBSzJfIZ5YWIB8WMTVAb6hwnOqAdxSg4Q1ZNiIa0ADvGufSr3YmJBpWdksbBIKIPwlHiaMNzm+NLOKJFN9VwkQb806lG9
 8y4WOKPgiR1IKAk0ccGIbIaS9pKPSY92sXUwf7PjywuAIFTW/mVxSv4QTU4MaZbxZgjFMoYs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.08.25 04:22 Rafael J. Wysocki wrote:
> On Fri, Aug 24, 2018 at 5:52 PM Doug Smythies <dsmythies@telus.net> wrote:
>> On 2018.08.24 02:44 Rafael J. Wysocki wrote:
>>> On Tuesday, August 21, 2018 10:44:10 AM CEST Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> The case addressed by commit 5ef499cd571c (cpuidle: menu: Handle
>>>> stopped tick more aggressively) in the stopped tick case is present
>>>> when the tick has not been stopped yet too.
>>
>> ... [snip] ...
>>
>>>> Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
>>
>> ... [snip] ...
>>
>>> Due to the lack of objections, I'm inclined to queue this up.
>>
>> I have been following these threads.
>> Recall that I was involved, over a period of months, in the original
>> "powernightmare" stuff.
>> I have revived my tests (and wish I had left myself better notes), and
>> am establishing a baseline before adding and trying this patch.
>> My baseline is actually two tests with and without the previous two patches (the ones
>> that were just sent a couple of days ago in "More power management updates for v4.19-rc1".
>> I might have those results in some presentable form by later today (it looks O.K.)
>> Results with this patch will take another couple of days.
>
> Thanks Doug, much appreciated!

Test 1: A Thomas Ilsche type "powernightmare" test:
(forever ((10 times - variable usec sleep) 0.999 seconds sleep) X 40 staggered threads.
Where the "variable" was from 0.05 to 5 in steps of 0.05, for the first ~200 minutes of the test.
(note: overheads mean that actual loop times are quite different.)
And then from 5 to 500 in steps of 1, for the remaining 1000 minutes of the test.
Each step ran for 2 minutes. The system was idle for 1 minute at the start, and a few
minutes at the end of the graphs.
While called "kernel 4.18", the baseline was actually from mainline at head = df2def4,
or just after Rafael's linux-pm "pm-4.19-rc1-2" merge.
(actually after the next acpi merge).
Reference kernel = df2def4 with the two patches reverted.

Test 1.1 compares baseline reference and the two patches added.
Summary: Nothing of note.
Results: http://fast.smythies.com/linux-pm/k418-pn-sweep.htm 
Differences: http://fast.smythies.com/linux-pm/k418-pn-sweep-differences.htm
Note: the title in the last graph in each link above is mislabelled.

Test 1.2 compares baseline reference and the three patches added (the two at 
df2def4 plus the one of this thread).
Summary: Nothing of note.
Results: http://fast.smythies.com/linux-pm/k418-pn-sweep-rjw.htm
Differences: http://fast.smythies.com/linux-pm/k418-pn-sweep-rjw-differences.htm

Side note: There is an interesting, slight, power bump at about the 
260 minute point of the tests. Perhaps for further investigation some other day.

Test 2: pipe test 2 CPUs, one core. CPU test.

Recall this was one of the more interesting tests with the original "powernightmare"
work, and in the end, back then, both energy was saved and performance improved.

The average loop times graph is here:
http://fast.smythies.com/linux-pm/k418-rjw-pipe-1core.png
with the average loop times:
Baseline:		4.83 uSec
+ 2 rjw patches:	4.69 uSec
+ 3 rjw patches:	4.80 uSec

The power and idle statistics graphs are here:
http://fast.smythies.com/linux-pm/k418-rjw-pipe-1core.htm

Test 3: 100% load on CPU 7 test.

Recall this was another of the more interesting tests last time, but
had more to do with idle state 0 than anything else.

The performance seems to stay within a 1% window, with the 3 patches
being about 1% faster than the 2 patches and the baseline somewhere
in the middle.

The power and idle statistics graphs are here:
http://fast.smythies.com/linux-pm/k418-rjw-100.htm

From observing at the test 2 and test 3 results, it looks as
though there are indeed "powernightmares" in the baseline kernel.
This was not the situation at the end of the original work, 
"V9" for anybody that recalls. I don't know when they got
re-introduced, and didn't look.

While these don't add up to much extra energy for my processor,
they might be more significant for other processors.

I revived my "powernightmare" trace post processor assessment
program, and re-did some 100% Single load tests (20 minute trace):
(recall that the "is it a 'powernigthmare' or not" threshold
is rather arbitrary [1]. However, and for what is being done here,
it should be greater than a tick time, which it is for my 1000Hz
kernel.)

1.) Reference or baseline kernel:

Idle State 0: Total Entries: 458 : PowerNightmares: 0 : Not PN time (seconds): 0.016160 : PN time: 0.000000 : Ratio: 0.000000
Idle State 1: Total Entries: 950 : PowerNightmares: 33 : Not PN time (seconds): 0.084723 : PN time: 3.172124 : Ratio: 37.441120
Idle State 2: Total Entries: 456 : PowerNightmares: 3 : Not PN time (seconds): 0.142255 : PN time: 0.396037 : Ratio: 2.783994
Idle State 3: Total Entries: 218 : PowerNightmares: 1 : Not PN time (seconds): 0.095584 : PN time: 0.214608 : Ratio: 2.245229

2.) + 2 rjw patches:

Idle State 0: Total Entries: 481 : PowerNightmares: 0 : Not PN time (seconds): 0.014849 : PN time: 0.000000 : Ratio: 0.000000
Idle State 1: Total Entries: 734 : PowerNightmares: 0 : Not PN time (seconds): 0.046496 : PN time: 0.000000 : Ratio: 0.000000
Idle State 2: Total Entries: 534 : PowerNightmares: 0 : Not PN time (seconds): 0.133086 : PN time: 0.000000 : Ratio: 0.000000
Idle State 3: Total Entries: 145 : PowerNightmares: 0 : Not PN time (seconds): 0.054476 : PN time: 0.000000 : Ratio: 0.000000

3.) + 3 rjw patches:

Idle State 0: Total Entries: 369 : PowerNightmares: 0 : Not PN time (seconds): 0.010182 : PN time: 0.000000 : Ratio: 0.000000
Idle State 1: Total Entries: 800 : PowerNightmares: 0 : Not PN time (seconds): 0.122816 : PN time: 0.000000 : Ratio: 0.000000
Idle State 2: Total Entries: 1041 : PowerNightmares: 0 : Not PN time (seconds): 0.233984 : PN time: 0.000000 : Ratio: 0.000000
Idle State 3: Total Entries: 269 : PowerNightmares: 0 : Not PN time (seconds): 0.114399 : PN time: 0.000000 : Ratio: 0.000000

4.) The old kernel 4.16+V9 patch set (sanity check):

Idle State 0: Total Entries: 265 : PowerNightmares: 0 : Not PN time (seconds): 0.009892 : PN time: 0.000000 : Ratio: 0.000000
Idle State 1: Total Entries: 708 : PowerNightmares: 0 : Not PN time (seconds): 0.091070 : PN time: 0.000000 : Ratio: 0.000000
Idle State 2: Total Entries: 712 : PowerNightmares: 0 : Not PN time (seconds): 0.212778 : PN time: 0.000000 : Ratio: 0.000000
Idle State 3: Total Entries: 421 : PowerNightmares: 0 : Not PN time (seconds): 0.230097 : PN time: 0.000000 : Ratio: 0.000000

[1] https://marc.info/?l=linux-kernel&m=152156611814576&w=2  (formatting a mess)

... Doug


