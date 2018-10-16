Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1FAC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFFC2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="thDiejC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFFC2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJPKsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:48:41 -0400
Received: from cmta19.telus.net ([209.171.16.92]:58542 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbeJPKsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:48:40 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id CFangdIUmTtUECFaogvZwn; Mon, 15 Oct 2018 21:00:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1539658831; bh=t1gOsh75WUxcZYvjc07vOycHBwroG3MAnWujiwR0v1Y=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=thDiejC0QiD1JrRYuX4uWKNrMkaUxAo3VKFJIEL5Z83DIGpWNf5RvY0JVP/2qL0+D
         ZZuE2R1k86MABC+x93cUewIaxcZEW+OrbfSEGky8Yd7KQm0wdwug1BxIBo52+f0nKk
         dld1dr5nqVOobl6m+pgJdzc9X+ZU2TKq9vdVBjNqN2SON+SIIH5HuwZlqj+o2MG6Ex
         9Zm+iNO2ozCYJ9Qs11BMiQf8XviGg2oR94FYjc5+C7fVWlWt51oc43qkvllR/QmTAq
         zO1Gwm73waHO25TUxHq/vEcvCxziVweQk6H70i+gEOhcRuwTaDxxmsNgzUKgbFPxfg
         17GFaY3XSfgjg==
X-Authority-Analysis: v=2.3 cv=a6fhCnaF c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8
 a=FGbulvE0AAAA:8 a=gu6fZOg2AAAA:8 a=4c1hVEeGUr2z-EoRigYA:9 a=QEXdDO2ut3YA:10
 a=BBaMYSUnRWwA:10 a=5DLwxePbAi8A:10 a=oCD-iAR9n-0A:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=7715FyvI7WU-l6oqrZBK:22 a=svzTaB3SJmTkU8mK-ULk:22
 a=2RSlZUUhi9gRBrsHwhhZ:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <000e01d4638a$91a20c60$b4e62520$@net> BxfmgI8c1ivIDBxfngUxWV
In-Reply-To: BxfmgI8c1ivIDBxfngUxWV
Subject: RE: [RFC/RFT/[PATCH] cpuidle: New timer events oriented governor for tickless systems
Date:   Mon, 15 Oct 2018 20:00:19 -0700
Message-ID: <001101d464fc$65623c60$3026b520$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdRkW//69sOuXx+MRCCqbhBsESk+UAAlZb7A
X-CMAE-Envelope: MS4wfFVg3LF5I7UEE53ZDcMWan1YtdwUd9X1fZIece3cwteUN1KTLLak7keC3zRmkAhrKblcAgKZoWVq2Rh6Gs4Cnl/AicXMhtzHxxM31ny/4STPCm9+gMfg
 fExPmAouyxMXGHVSg51wXnBNPUZjLzPvsbcfpO7g9vBG2jeEH630D6rxmvCiN+kGNacL4UpydzoG+/8DXeVCGS93wjN6I4K+7BOWInKbv1Bn3+B/V6hvhR1L
 GouLH6HpPsLZ0KARSlOgXa0ddwZ7rs93otBgMijz5R8Yc0lHX8qQMkqhFByFUP3BPCUIFiS5VCwmXa6lpE+ngPNXelvpsEpVHHaM1+1pU1FimL4p/tHuOBYZ
 FajVYAhNHHJwZVTmX6rK+MRm0Sy1ZiJW/N/9Iqmh+hrAvm38ftnz3CP5vMK/MLjbKUP9zZU89P+9HoQbSmywAfB+mC++PHg4QXXFBBv9H15IELu767sUL5sw
 JA2Fl6BYtsTQRpSoShvVMxFvGOaK0NCcdVmo5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.10.15 00:52 Rafael J. Wysocki wrote:
> On Sun, Oct 14, 2018 at 8:53 AM Doug Smythies <dsmythies@telus.net> wrote:
>> On 2018.10.11 14:02 Rafael J. Wysocki wrote:
>
> ...[cut]...
>
>>> Overall, it selects deeper idle states than menu more often, but
>>> that doesn't seem to make a significant difference in the majority
>>> of cases.
>>
>> Not always, that viscous powernightmare sweep test that I run used
>> way way more processor package power and spent a staggering amount
>> of time in idle state 0. [1].
>
> Can you please remind me what exactly the workload is in that test?

The problem with my main test computer is that I have never had a good
way to make it use idle state 0 and/or idle state 1 a significant amount,
while not setting the need-resched flag. Due to the minimum overheads
involved, in a tight loop c program calling nanosleep with an only 1
nanosecond argument, will result in about 50 (44 to 57 measured)
microseconds, or much too long to invoke idle state 0 or 1 (at least
on my test computer). So, for my 8 CPU older model i7-2600K, the idea
is to spin out 40 threads doing short sleeps in an attempt to pile up
events such that the shallower idle states are invoked more often.

Why 40 threads, one might wonder? This was many months ago now, but
I tested quite a number of threads, and 40 seemed to provide the
most interesting results for this type of work. I have not rechecked
it since (probably should).

For the testing I did in August for this:

"[PATCH] cpuidle: menu: Retain tick when shallow state is selected"
[2].
The thinking was to sweep through a wide range of sleep times,
and see if anything odd shows up. The test description is copied
here:

In [2] Doug wrote:
> Test 1: A Thomas Ilsche type "powernightmare" test:
> (forever ((10 times - variable usec sleep) 0.999 seconds sleep) X 40 staggered
> threads. Where the "variable" was from 0.05 to 5 in steps of 0.05, for the first ~200
> minutes of the test. (note: overheads mean that actual loop times are quite
> different.) And then from 5 to 500 in steps of 1, for the remaining 1000 minutes of
> the test. Each step ran for 2 minutes. The system was idle for 1 minute at the start,
> and a few minutes at the end of the graphs.
> While called "kernel 4.18", the baseline was actually from mainline at head =
> df2def4, or just after Rafael's linux-pm "pm-4.19-rc1-2" merge.
> (actually after the next acpi merge).
> Reference kernel = df2def4 with the two patches reverted.

However, that description was flawed, because there actually was never
a long sleep (incompetence on my part, but it doesn't really matter).
That test was 1200 minutes, and is worth looking at [3].
Notice how, as the test progresses, a migration through the idle
states can be observed, just as expected.

The next old reference of this test was the 8 patch set on top of
Kernel 4.19-rc6 [4], from a week ago. However, I shortened the test
by 900 minutes. Why? Well, there is only so much time in a day.

So now, back to the test this thread is about [1]. It might be
argued that maybe the TEO governor should be spending more time
in idle state 0 near the start of test, as the test shows. Trace
data does, maybe, support such an argument, but I haven't had
time to dig into it.

I also wonder if some of the weirdness later in the test is
repeatable or not (re: discussion elsewhere on this thread,
now cut, about lack of repeatability). However, I have not
had time to repeat the test.

Hope this helps, and sorry for any confusion and this long e-mail.
 
... Doug

[1] http://fast.smythies.com/linux-pm/k419/k419-pn-sweep-teo.htm
[2] https://marc.info/?l=linux-pm&m=153531591826718&w=2
[3] http://fast.smythies.com/linux-pm/k418-pn-sweep-rjw.htm
[4] http://fast.smythies.com/linux-pm/k419/k419-pn-sweep-rjw.htm
   

