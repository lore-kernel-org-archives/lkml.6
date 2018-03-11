Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932203AbeCKPwM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:52:12 -0400
Received: from cmta17.telus.net ([209.171.16.90]:39824 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932163AbeCKPwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:52:10 -0400
X-Authority-Analysis: v=2.2 cv=StJ/0LG0 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=VwQbUJbxAAAA:8 a=jgyTgBD9P3kwVBe0OM4A:9 a=CjuIK1q_8ugA:10
 a=svzTaB3SJmTkU8mK-ULk:22 a=AjGcO6oz07-iQ99wixmX:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Rik van Riel'" <riel@surriel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <2450532.XN8DODrtDf@aspire.rjw.lan> <000701d3b889$eadd5340$c097f9c0$@net> <001801d3b90c$99232600$cb697200$@net> uy66ebKjsFfdwuy6Be0qnb
In-Reply-To: uy66ebKjsFfdwuy6Be0qnb
Subject: RE: [RFC/RFT][PATCH v3 0/6] sched/cpuidle: Idle loop rework
Date: Sun, 11 Mar 2018 08:52:02 -0700
Message-ID: <000701d3b950$e88e2bb0$b9aa8310$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdO5Iqo8D92TMYoqSVyabI5dAwHWqAAKkqFg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfAVnT8XEJCTJsnn5/qNBixR0DlhYhfrXvsUT9y2QcTsoxhonvf2CCPAGDTwIuY0rWn+0kNWNCrkD8Kis1AoYlNT1457mSheiLygXSUGWbAzE+PL98aDp
 8lXaFAvvxNAmMr0PKdWS1tVykTf75nInE6NLusLCVnDhep/aKzqWE6IXncQK3VPrSw/b/DcQa225p1sdW06LjCSwlpRprVuOOlh+o+z1NrRKWWsLtSVykrSY
 2rZfDf1AdfHi070UFQnJTO3QfVvEGaiSiZdpko9g3tNK7Z39c78I2Rae8LASwOJNomzYO9+nEml9NX8NN/mQ0x6quH9aEhZDko84K4xQ7wVwIsPDk2pLuZ0L
 pDVlnGvE/qTjMo+iOkDnVLyku0yFIJm39OZcEctQhrNvcZD6W5ouB/1wq2ZaOa1DhmedeSHd1u6VDx73KG3cY1XJeE0m6dZsDvvjdJ5Zv9OYoWGxg0Ea3OdS
 YkEfVuUqTj8W2ApxUSOmBaEElcCj/v2qK6i8LUDIXSUSfCJrAPlGgVZLFUM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.11 03:22 Rafael J. Wysocki wrote:
> On Sunday, March 11, 2018 8:43:02 AM CET Doug Smythies wrote:
>> On 2018.03.10 15:55 Rafael J. Wysocki wrote: 
>>>On Saturday, March 10, 2018 5:07:36 PM CET Doug Smythies wrote:
>>>> On 2018.03.10 01:00 Rafael J. Wysocki wrote:
>>>
>> ... [snip] ...
>> 
>>> The information that they often spend more time than a tick
>>>> period in state 0 in one go *is* relevant, though.
>>>
>>>
>>> That issue can be dealt with in a couple of ways and the patch below is a
>>> rather straightforward attempt to do that.  The idea, basically, is to discard
>>> the result of governor prediction if the tick has been stopped alread and
>>> the predicted idle duration is within the tick range.
>>>
>>> Please try it on top of the v3 and tell me if you see an improvement.
>> 
>> It seems pretty good so far.
>> See a new line added to the previous graph, "rjwv3plus".
>> 
>> http://fast.smythies.com/rjwv3plus_100.png
>
> OK, cool!
>
> Below is a respin of the last patch which also prevents shallow states from
> being chosen due to interactivity_req when the tick is stopped.
>
> You may also add a poll_idle() fix I've just posted:
>
> https://patchwork.kernel.org/patch/10274595/
>
> on top of this.  It makes quite a bit of a difference for me. :-)

I will add and test, but I already know from testing previous versions
of this patch, from Rik van Riel and myself, that the results will be
awesome.

>
>> I'll do another 100% load on one CPU test overnight, this time with
>> a trace.

The only thing I'll add from the 7 hour overnight test with trace is that
there were 0 occurrences of excessive times spent in idle states above 0.
The histograms show almost entirely those idle states being limited to
one tick time (I am using a 1000 Hz kernel). Exceptions:

Idle State: 3  CPU: 0: 1 occurrence of 1790 uSec (which is O.K. anyhow)
Idle State: 3  CPU: 6: 1 occurrence of 2372 uSec (which is O.K. anyhow)

... Doug
