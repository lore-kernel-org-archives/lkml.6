Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309ADC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E842086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="2GIimwLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E842086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeJHNML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:12:11 -0400
Received: from cmta19.telus.net ([209.171.16.92]:54432 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeJHNML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:12:11 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 9OUPggWqQTtUE9OUQgG9qJ; Sun, 07 Oct 2018 23:54:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1538978041; bh=0s2UmhGSOuieXjmaKATjc6wJ+GpUdAn5fpo1W3V22pI=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=2GIimwLZvoBtI9RarOpoWMCCg93vmo6HbFDj6CwccN6OUN/uh45na2Yq2PCYAnHE3
         DnHJQbYMGZEiE1aN7c9zlEeCFmJNrr7mPzrpDDGJPoszRP56oQcEzkN+bDgFMj+58o
         MAualgUVvHH0Qm8OJPD9gdWaOk02M7XTLbDyTmorvfvRykFD/HB9UiKyExraaI561d
         pKtkPWZALdoHytPa3oGQ9YzdHTMklgoLJH0aT8WtuYO4tJOWA5dSrET0eJRLom9rJa
         kw5Dyk6ImCEw3msvCMY4GVOoVMZGLj1t2Jt3bJ7+t2JAE6CTv7tm5yGw0+xSmwBtbv
         5nT6laQIOYfrQ==
X-Authority-Analysis: v=2.3 cv=a6fhCnaF c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=O76VCmqbo-wA:10
 a=p-nOP-kxAAAA:8 a=NEAV23lmAAAA:8 a=FGbulvE0AAAA:8 a=gu6fZOg2AAAA:8
 a=88uDnJHlnOVyJH1CWIsA:9 a=z5oy24peSUVRFuQD:21 a=1_VaRSNZzH3G_4Iu:21
 a=CjuIK1q_8ugA:10 a=oCD-iAR9n-0A:10 a=wCeqiVS-y0sA:10 a=_bFGt9OrMgsA:10
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=XN2wCei03jY4uMu7D0Wg:22
 a=svzTaB3SJmTkU8mK-ULk:22 a=2RSlZUUhi9gRBrsHwhhZ:22 a=fH6ezBh0GlpOJwpmk9fj:22
 a=EE-hDNo6nQ8U3qjUCziE:22 a=NWVoK91CQySWRX1oVYDe:22 a=jB5_y_ff1q3Y1k8i3LqD:22
 a=IeVV3oy9AQTmNaZTXIJc:22 a=HH7FIXwXL_sUf1zzYxQd:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: 7SZZgyy0SivID7SZcgClsv
In-Reply-To: 7SZZgyy0SivID7SZcgClsv
Subject: RE: [PATCH 0/6] cpuidle: menu: Fixes, optimizations and cleanups
Date:   Sun, 7 Oct 2018 22:53:55 -0700
Message-ID: <000301d45ecb$4f002a90$ed007fb0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdRamg7HZHdDvRI/TdOjz6YWxF+3pQCV6iNw
Content-Language: en-ca
X-CMAE-Envelope: MS4wfO/vmeUyAlx2Zzr2fAdqlle7b5CtMSyVo3myQTtA+grm+CvnxTlu4eFYQqStPmSxMiYInpRdhPdT4Ze2lUtS1z46mpEqf9wJoN+UrIbxMBc95vjEKdVg
 cEC7DokxbhkzptXt52s6v9ghTm6wcMEPFbn5zqfmmoy8VRZk/dhrOyvYP1KuHYtdQokEovP0apYztnLNEyGtzLy5nErqUNrXyJ20MOCtQ384sWvRxpQE/FQF
 RN0TpUeyE4qvX2FdMMPLUNYGuWVIQhAHiymCf+ItqZWb10XT9tJrJQcfxo70xT21U8bRvTtqLGV6eOT8A3VoSTYqMyAjZqdUh8LHdkkVTM8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.10.03 23:56 Rafael J. Wysocki wrote:
> On Tue, Oct 2, 2018 at 11:51 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> Hi All,
>>
>> This series fixes a couple of issues with the menu governor, optimizes it
>> somewhat and makes a couple of cleanups in it.  Please refer to the
>> patch changelogs for details.
>>
>> All of the changes in the series are straightforward in my view.  The
>> first two patches are fixes, the rest is optimizations and cleanups.
>
> I'm inclined to take this stuff in for 4.20 if nobody has problems
> with it, so please have a look if you care (and you should, because
> the code in question is run on all tickless systems out there).

Hi Rafael,

I did tests with kernel 4.19-rc6 as a baseline reference and then
with 8 of your patches (&8patches in the graphs legend):

cpuidle: menu: Replace data->predicted_us with local variable
  . as required to get this set of 6 to then apply.
This set of 6 patches.
cpuidle: poll_state: Revise loop termination condition

Recall I also did some testing in late August [1], with
a kernel that was just a few hundred commits before 4.19-rc1.
The baseline is now way different. While I don't know why,
I bisected the kernel and either made a mistake, or it was:

first bad commit: [06e386a1db54ab6a671e103e929b590f7a88f0e3]
Merge tag 'fbdev-v4.19' of https://github.com/bzolnier/linux 

Anyway, and for reference, included on some of the graphs
is the old data from late August (legend name "4.18+3rjw
(Aug test)")

Test 1: A Thomas Ilsche type "powernightmare" test:
(forever ((10 times - variable usec sleep) 0.999 seconds sleep) X 40 staggered threads.
Where the "variable" was from 0.05 to 5 in steps of 0.05, for the first ~200 minutes of the test.
(note: overheads mean that actual loop times are quite different.)
And then from 5 to 50 in steps of 1, for the remaining 100 minutes of the test.
(Shortened by 900 minutes from the way the test was done in August.)
Each step ran for 2 minutes. The system was idle for 1 minute at the start, and a few
minutes at the end of the graphs.

The power and idle statistics graphs are here:
http://fast.smythies.com/linux-pm/k419/k419-pn-sweep-rjw.htm

Observations:

While the graphs are pretty and such, the only significant
difference is the idle state 0 percentages go down a lot
with the 8 patches. However the number of idle state 0
entries per minute goes up. To present the same information
in a different way a trace was done (at 9 Gigabytes in
2 minutes):

&8patches
Idle State 0: Total Entries: 10091412 : time (seconds): 49.447025
Idle State 1: Total Entries: 49332297 : time (seconds): 375.943064
Idle State 2: Total Entries: 311810 : time (seconds): 2.626403

k4.19-rc6
Idle State 0: Total Entries: 9162465 : time (seconds): 70.650566
Idle State 1: Total Entries: 47592671 : time (seconds): 373.625083
Idle State 2: Total Entries: 266212 : time (seconds): 2.278159

Conclusions: Behaves as expected.

Test 2: pipe test 2 CPUs, one core. CPU test:

The average loop times graph is here:
http://fast.smythies.com/linux-pm/k419/k419-rjw-pipe-1core.png

The power and idle statistics graphs are here:
http://fast.smythies.com/linux-pm/k419/k419-rjw-pipe-1core.htm

Conclusions:

Better performance at the cost of more power with
the patch set, but late August had both better performance
and less power.

Overall idle entries and exits are about the same, but way
way more idle state 0 entries and exits with the patch set.

Supporting: trace summary (note: such a heavy load on the trace
system (~6 gigabytes in 2 minutes) costs about 25% in performance):

k4.16-rc6 pipe
Idle State 0: Total Entries: 76638 : time (seconds): 0.193166
Idle State 1: Total Entries: 37825999 : time (seconds): 23.886772
Idle State 2: Total Entries: 49 : time (seconds): 0.007908

&8patches
Idle State 0: Total Entries: 37632104 : time (seconds): 26.097220
Idle State 1: Total Entries: 397 : time (seconds): 0.020021
Idle State 2: Total Entries: 208 : time (seconds): 0.031052

With rjw 8 patch set (1st col is usecs duration, 2nd col
is number of occurrences in 2 minutes):

Idle State: 0  Summary:
0 24401500
1 13153259
2 19807
3 32731
4 802
5 346
6 1554
7 20087
8 1849
9 150
10 9
11 10

Idle State: 1  Summary:
0 29
1 44
2 15
3 45
4 5
5 26
6 2
7 24
8 4
9 21
10 6
11 39
12 15
13 38
14 14
15 27
16 10
17 12
18 1
35 1
89 1
135 1
678 1
991 2
995 3
996 1
997 8
998 1
999 1

Kernel 4.19-rc6 reference:

Idle State: 0  Summary:
0 17212
1 7516
2 34737
3 14763
4 2312
5 74
6 3
7 3
8 3
9 4
10 5
11 5
40 1

Idle State: 1  Summary:
0 36073601
1 1662728
2 67985
3 106
4 22
5 8
6 2214
7 11037
8 7110
9 1156
10 1
11 1
13 2
23 1
29 1
99 1
554 1
620 1
846 1
870 1
936 1
944 1
963 1
972 1
989 1
991 1
993 1
994 1
995 2
996 2
997 6
998 3

Test 3: iperf test:

Method: Be an iperf client to 3 servers at once.
Packets are small on purpose, we want the highest
frequency of packets, not fastest payload delivery.

Performance:

Kernel 4.19: 79.9 + 23.5 + 32.8 = 136.2 Mbits/Sec.
&8patches:   78.6 + 23.2 + 33.0 = 134.8 Mbits/Sec.

Kernel 4.19 average processor package power: 12.73 watts.
&8patches average processor package power: 12.99 watts.

The power and idle statistics graphs are here:
http://fast.smythies.com/linux-pm/k419/k419-iperf.htm

Conclusion:

Marginally less performance and marginally more power
used with the 8 patch set.

Test 4: long idle test

Just under 8 hours of at idle.
(no pretty graphs)

Averages (per minute):

Kernel 4.19:
% time in idle state 0: 1.76811E-05
% time in idle state 1: 0.001501241
% time in idle state 2: 0.002349672
% time in idle state 3: 0.000432757
% time in idle state 4: 100.0047484
Idle state 0 entries: 2.470715835
Idle state 1 entries: 27.84164859
Idle state 2 entries: 26.02169197
Idle state 3 entries: 4.600867679
Idle state 4 entries: 1487.260304
Processor package power: 3.668

&8patches:
% time in idle state 0: 4.76854E-06
% time in idle state 1: 0.000752083
% time in idle state 2: 0.001242119
% time in idle state 3: 0.000408944
% time in idle state 4: 100.0065453
Idle state 0 entries: 4.213483146
Idle state 1 entries: 16.42696629
Idle state 2 entries: 16.75730337
Idle state 3 entries: 4.541573034
Idle state 4 entries: 1464.083146
Processor package power: 3.667

Conclusion: O.K.

Test 5: intel-cpufreq schedutil specific test:

Recall previously there were some significant
improvements with this governor and the idle changes
earlier this year.
(no pretty graphs)

Conclusion: No detectable differences.

(sorry for the lack of detail here.)

[1] https://marc.info/?l=linux-pm&m=153531591826719&w=2

... Doug

 

