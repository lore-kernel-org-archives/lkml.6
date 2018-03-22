Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeCVPmF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:42:05 -0400
Received: from cmta18.telus.net ([209.171.16.91]:49088 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbeCVPmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:42:00 -0400
X-Authority-Analysis: v=2.2 cv=ebrSR/MH c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=HLEhOUT7AAAA:8 a=FGbulvE0AAAA:8 a=6zee2FuY2o9LUhDUDAwA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=73WewclNby-GrhdgABwy:22 a=svzTaB3SJmTkU8mK-ULk:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>
Cc: "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <1635957.yuHkCe9oyz@aspire.rjw.lan> <CAJZ5v0j-CnEms-Wm0Op=386ceuG2GfAouVLXO48rbD_pUPJhMg@mail.gmail.com> <b05c00e7-b5d8-0bcb-0b38-a91324ec597a@tu-dresden.de> ym0ceyYVT1Konym0eegfln ysl4eqMKwFfdwytebe4RNZ
In-Reply-To: ysl4eqMKwFfdwytebe4RNZ
Subject: RE: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Thu, 22 Mar 2018 08:41:54 -0700
Message-ID: <000401d3c1f4$5043adb0$f0cb0910$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdPBYg/Oh/zHpvmbQaGiHmKF6GMzzgAO92wgABPNHDA=
X-CMAE-Envelope: MS4wfEQqqI6vvfONZC8wPnA1BnalzRImpZKyhKRIvXJbIGiIFa8hC6z/RSZai+t74qFDJhDDOc6E0S6OjFnK6uGwga+8S1fyD+XzANqn8aErsXiqZ6pM39ke
 I6jxrxx1av2/rZu/N+qAU2eKUUZTCQ2HRnHEiLANEZlUguXcFO7useFLrdY7O87IMU827u7Wp/+4M2F2YUb58B/EvaY3t/usUr0XX/52r4QF8cvBhll8/nhP
 zhY76g1FP82ULypxx/Sfm/AbXRg/7wXJzXydvru+kPGB8vaxRewcnhg4EvNDSveqsFNcJf15eDXjbOUtioLSlhdItnAiPhy/jfnyGMVlzLAXrL1kq49t4+wJ
 NqO57Ze3b11dRazOdaOy5ASwBcbV0+ntHu/Y/GbasPUAN5Yw7YCA7/9R/ufYG/cbzzbwsPx1rSbx0Fmb8o25wjsvc58Wf/WY+GGVM8kfeNY2ZkiP6FJ2b1ci
 Hp2uRNDVAaYamy3iCggfm998Unnmr/UN0nq1LfVPqy9L0UIz8JYN4x+SwFc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.21 23:25 Doug Smythies wrote:
> On 2018.03.21 15:15 Rafael J. Wysocki wrote:
>> On Wed, Mar 21, 2018 at 6:59 PM, Thomas Ilsche wrote:
>>> On 2018-03-21 15:36, Rafael J. Wysocki wrote:
>>>>
>>>> So please disregard this one entirely and take the v7.2 replacement
>>>> instead of it:https://patchwork.kernel.org/patch/10299429/
>>>>
>>>> The current versions (including the above) is in the git branch at
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>>>   idle-loop-v7.2
>>>
>>> With v7.2 (tested on SKL-SP from git) I see similar behavior in idle
>>> as with v5: several cores which just keep the sched tick enabled.
>>> Worse yet, some go only in C1 (not even C1E!?) despite sleeping the
>>> full sched tick.
>>> The resulting power consumption is ~105 W instead of ~ 70 W.
>>>
>>> https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_skl_sp_idle.png
>>>
>>> I have briefly ran v7 and I believe it was also affected.

I am not seeing any issues at all with V7.

>>
>> Then it looks like menu_select() stubbornly thinks that the idle
>> duration will be within the tick boundary on those cores.
>> 
>> That may be because the bumping up of the correction factor in
>> menu_reflect() is too conservative or it may be necessary to do
>> something radical to measured_us in menu_update() in case of a tick
>> wakeup combined with a large next_timer_us value.
>>
>> For starters, please see if the attached patch (on top of the
>> idle-loop-v7.2 git branch) changes this behavior in any way.
>
> O.K. I am seeing some weirdness.
> On my system with both V7.2 and V7.2 plus this patch, I observe
> A spike in Idle State 1 residency every 34+ minutes. And slightly
> higher average idle power than before.
> (I might not have done V7 idle tests long enough).

I re-did the idle test on V7, and for longer.
It is great.
See line added to the idle graph for V7.2+:

http://fast.smythies.com/rjw_v72p_v7_idle.png

>
> It can be seen in the frequency sweep I did earlier today, with V7.2:
>
> http://fast.smythies.com/rjw_freq_sweep_72_combined.png
>
> Despite the note on the graph that says it might be real, I don't think
> it is (I forgot to delete the note).
>
> With V7.2+ sometimes the event occurs at 17 minute intervals.
> Here is a idle graph (for reference: we have seen idle package power
> pretty steady at ~3.7 watts before).

Now shown on the new graph. Link above.

>
> http://fast.smythies.com/rjw_v72p_idle.png

... Doug
 
