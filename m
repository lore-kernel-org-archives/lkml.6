Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD312C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792B42086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="6IEbMn4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792B42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=telus.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbeLMQV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:21:26 -0500
Received: from cmta19.telus.net ([209.171.16.92]:45501 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbeLMQVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:21:25 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id XTjkgApiQTtUEXTjlgB0Hj; Thu, 13 Dec 2018 09:21:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1544718083; bh=ijHCCznavQKU+kGngDuPh7hp8ApKECrHsnR4SP8T924=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=6IEbMn4VBCiYdzXlWQwRcUrRQ8CrMt78UwcdM2irxlAEem3ebjNEUuBdBSh6jJldK
         uNgPvxvdXAaIEwn7AvWahC3jIyV2VU8t37cxTtOIePFlz9UoL6MuBcngTGNkXicfdm
         0RVfVn+3qH+JBE4CBD9OfQlJ2gs61cfNugYyjHAONhExU8CvmX5Vyqy1vsJDhUc0WI
         JCgJjsrDCEKwo+yj92zWnQN5hYJnqWMMmdebP1wrP+QupXLALkRcD16YH9hfCg+6fd
         8h3u/lKVwY2Ac0D++tPGuOjATFFyqkenl9S8Fg9ZcyMWhQ11Pq++i9OpvvrZCTXDEO
         fGNEVGg9SYt5g==
X-Authority-Analysis: v=2.3 cv=a6fhCnaF c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=iQT1cQ1TT91TDHW7ZZEA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=FOppCqAxHePfreZ6:21 a=Vs2E80nf5gLWMOdh:21
 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Paul Menzel'" <pmenzel@molgen.mpg.de>
Cc:     <linux-pm@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Len Brown'" <lenb@kernel.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <000701d4926f$533eb270$f9bc1750$@net> <a4321c48-e9df-1a2a-cfbd-bac07a9c65d8@molgen.mpg.de> <CAJZ5v0gUDzy8vV=JajDHZJi2F0FyHUkFfYbbJhMioUa5XoKuqA@mail.gmail.com> XQJBgte7nsc7nXQJGgJNBR
In-Reply-To: XQJBgte7nsc7nXQJGgJNBR
Subject: RE: intel_pstate: Lowest frequency not reached with Intel i7-6700
Date:   Thu, 13 Dec 2018 08:21:18 -0800
Message-ID: <001f01d492ff$e2b6e5e0$a824b1a0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdSS4ThGrxyQlOqmSe6EmQT5+bKFyAAHAsMQ
X-CMAE-Envelope: MS4wfE6l3RCWtvtgBmsLCskkW0svmfNDmYry9OY0gdOvrh0UYcBrz3ByeKwCis/gjC+QLgczXF+AEWCtfKV4maQshYAuLl0QnTKjkGgvvHt9v1TFNKloUT4V
 l2BR5160//zNvYksektXtr4GSzoVAcBhs66j82kw3SPIIRh0RTBJIexGOU+m65euLwoy08C1/FKM3W0JxDmC2u3ciL8iBtWjcL9Th2zh/ROW2y/x6mcoPhtr
 sftEFqZ0FwZ2L/qo9SFrgsDWzkGu4aAepNMWfjJEyg080G3ydbGJ3CrpcjpLcW36aATUgzC5Nk3mqTNTNa2y3g6xP2Id50HGYptffo0y1xh56GPF/XnBqQwO
 nkzQp1VnM9ZhIaCYOGCMj/gcflHiHA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.12.13 04:42 Paul Menzel wrote:
> On 12/13/18 11:39, Rafael J. Wysocki wrote:
>> On Thu, Dec 13, 2018 at 10:54 AM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>>> On 12/13/18 00:06, Doug Smythies wrote:
>>>> On 2018.12.12 13:40 Paul Menzel wrote:
>>>>
>>>>> Using *powersave* as P-state selection algorithm, on an idle =
system
>>>>
>>>> Define "idle system".
>>>> If your computer is running a GUI, or is even a server without a =
GUI
>>>> but with many services running, then "idle" really isn't.
>>>> Below is from my test server, with many services disabled, so
>>>> "idle" really is quite "idle"
>>>>
>>>> doug@s15:~/temp$ sudo turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt --interval 15
>>>> Busy%   Bzy_MHz PkgTmp  PkgWatt
>>>> 0.01    1608    27      3.71
>>>> 0.01    1619    27      3.71
>>>> 0.01    1600    28      3.71
>>>> 0.01    1600    28      3.70
>>>>
>>>> Note that p state 16 (1600 MHz) is the minimum for my older =
i7-2600k
>>>> processor.
>>>
>>> The thing is, on an Intel Kaby Lake laptop with Ubuntu 18.10 and =
GNOME
>>> running, it goes down to the lowest listed frequency.
>
> Checking the numbers again, I was mistaken. The lowest possible =
frequency
> of the Intel Kaby Lake i7-7500U in that laptop is 400 MHz, and it is
> going down to 600 MHz. Busy% from turbostat is 0.3 to 0.4.
>
>> Kaby Lake has hardware-managed P-states (HWP) which is a different =
mechanism.
>
> Isn=E2=80=99t HWP also available for the 6th generation?
>
>    $ dmesg | grep intel_pstate
>    [    2.092456] intel_pstate: Intel P-state driver initializing
>    [    2.094820] intel_pstate: HWP enabled

Yes, you have HWP. I do not have HWP. I don't think HWP or not is
particularly relevant to this discussion.

>>>>> Shouldn=E2=80=99t it go down until 800 MHz?
>>>>
>>>> We would need some actual busy information, turbostat is the
>>>> recommended tool, to know for sure.
>>>
>>> Here you go.
>>>
>>> ```
>>> tools/power/x86/turbostat> sudo ./turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt --interval 15
>>> Busy%    Bzy_MHz    PkgTmp    PkgWatt
>>> 3.59    1167    31    1.68
>>> 3.21    903    31    1.34
>>> 3.21    906    31    1.34
>>> 3.27    901    31    1.35
>>> 8.23    2715    30    2.32  =E2=86=90 stopping GDM (systemctl stop =
gdm)
>>> 2.95    915    30    1.18
>>> 2.91    906    30    1.18
>>> 2.92    903    30    1.17
>>> 2.90    900    29    1.17
>>> 2.89    903    29    1.18
>>> 2.91    903    30    1.18
>>> 2.89    903    29    1.18
>>> 2.89    900    29    1.18
>>> 2.90    903    30    1.18
>>> 2.90    903    29    1.17
>>> 2.90    903    29    1.17
>>> 2.90    900    29    1.16
>>> 2.90    903    29    1.14
>>> 2.90    903    28    1.11
>>> 2.90    903    29    1.10
>>> 2.91    900    29    1.16
>>> 2.91    903    29    1.14
>>> 2.90    903    29    1.12
>>> 2.90    903    29    1.16
>>> 2.90    900    28    1.17
>>> 2.92    903    29    1.16
>>> 2.90    903    29    1.16
>>> 2.90    903    29    1.16
>>> ```
>>>
>>> 800 MHz should be enough to keep GDM running, shouldn=E2=80=99t it?
>>=20
>> Well, depending.
>>=20
>>> Otherwise only SSH was running.
>>=20
>> There obviously is something that causes it to stay at 900 MHz.

Agreed. Clearly some more stuff was using some CPU.
The resulting requested CPU frequency is also highly dependent on
the frequency of the load. Example:

doug@s15:~/csv-plot$ sudo turbostat --Summary --quiet --show =
Busy%,Bzy_MHz,PkgTmp,PkgWatt --interval 60
Busy%   Bzy_MHz PkgTmp  PkgWatt
0.08    2567    27      3.77  <<< Note the high active CPU frequency =
with virtually no load.
0.01    1600    26      3.69
0.01    1600    27      3.70
0.83    1600    30      4.18
1.80    1600    30      4.59  <<< This load is at 435 Hertz work / sleep =
frequency
1.80    1600    32      4.59
0.74    3033    27      4.49  <<< This load is at 1 Hertz work / sleep =
frequency
0.76    3380    27      4.63
0.76    3384    28      4.62
0.38    3356    28      4.16
0.01    1615    28      3.71
0.01    1609    27      3.70

>
> It=E2=80=99s not obvious to me, but you have more experience. =
It=E2=80=99d expect
> to at least one core(?) to go down to 800 MHz and not all to stay
> at 900 MHz.

There is only PLL (Phase Locked Loop). The highest requested vote
for CPU frequency wins. CPUs in deep idle do not get a vote.

>> Please check max_perf_pct, min_perf_pct and num_pstates under
>> /sys/devices/system/cpu/intel_pstate/ .
>
>    /sys/devices/system/cpu/intel_pstate> cat max_perf_pct min_perf_pct =
num_pstates
>    100
>    20
>    33
>
>> Also cpuinfo_max_freq, cpuinfo_min_freq, scaling_max_freq,
>> scaling_min_freq under /sys/devices/system/cpu/cpufreq/policy0/ .
>
> /sys/devices/system/cpu/cpufreq/policy0> cat cpuinfo_{min,max}_freq =
scaling_{min,max}_freq
>    800000
>    4000000
>    800000
>    4000000
>
>> However, please note that Busy% of 3 isn't particularly low.
>
> Indeed. On the laptop it is around 0.3 to 0.4 even with GNOME
> running.
>
> So, to check if everything is working, I boot into initramfs
> and check the numbers there?
>

Myself, I think there is nothing wrong here. If you want
to pursue further, then my suggestion would be to disable
HWP and use trace and the intel_pstate_tracer.py utility
to fully analyze your "idle" system load and your systems
response to it.

... Doug


