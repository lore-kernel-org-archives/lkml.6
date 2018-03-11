Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932125AbeCKHnN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 03:43:13 -0400
Received: from cmta16.telus.net ([209.171.16.89]:40182 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932089AbeCKHnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 03:43:11 -0400
X-Authority-Analysis: v=2.2 cv=EJrp6xRC c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=PMEPZqO0xx8o1kO-riYA:9 a=CjuIK1q_8ugA:10 a=svzTaB3SJmTkU8mK-ULk:22
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
References: <2450532.XN8DODrtDf@aspire.rjw.lan> <007c01d3b843$3d825e70$b8871b50$@net> <000701d3b889$eadd5340$c097f9c0$@net> uoK1eZIXBFfdwuoK6ezbfC
In-Reply-To: uoK1eZIXBFfdwuoK6ezbfC
Subject: RE: [RFC/RFT][PATCH v3 0/6] sched/cpuidle: Idle loop rework
Date: Sat, 10 Mar 2018 23:43:02 -0800
Message-ID: <001801d3b90c$99232600$cb697200$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdO4yy0y2fB6ZXq4RjyjaHGvqSJkWgAQBCQg
Content-Language: en-ca
X-CMAE-Envelope: MS4wfOQh26KB1kj/UBGYPd4PVKG4/pOkl3p7WcN2ol7VS4Oa4cBfGo6AcT3LbgIW14Ei90oPN8xhhP7H5QsH1ykDm4LJaCtJtX5000bgiVBw+9LMMuh2z85f
 BcHL9RwZqVqlxAOtx5j0f6qngymqENxfRf8MGqoRD9TrUYOak1TL/2PzuC7BrNC7EAq0UutUzJWw6mjSl8+ep3pikCMsvVEbdJKq6PBBG90TUcBmyth1VTw/
 WPPcuLz0XB2xUZ6WnOY/YsXhAAFBVxhU16Lpge4lQvgHPysJ1ZOeobwGmnQc2kU0XvTl8d2UxEdHPN5G5cg75kYS2RhNmMWrG/kBCGfmabRNBNbOk1S4WO3y
 IJaIMRMCaZX+89Ju2V0ZG2VV4TwhIV4cvvUvlis1tKxS8Xqy3uMf3DIJdttTcAiHml0AdAwTAPgshv/Hf3HvE4OBF5mVIb4UB/E6EH81S/k1eW+uue8Dg5r/
 rtheAJf3tD1/GRDwz9Zm1Se5ILzmcIPaEMyT0agJODx4citE7wV8Hq8C2nY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.10 15:55 Rafael J. Wysocki wrote: 
>On Saturday, March 10, 2018 5:07:36 PM CET Doug Smythies wrote:
>> On 2018.03.10 01:00 Rafael J. Wysocki wrote:
>
... [snip] ...

> The information that they often spend more time than a tick
> period in state 0 in one go *is* relevant, though.
>
>
> That issue can be dealt with in a couple of ways and the patch below is a
> rather straightforward attempt to do that.  The idea, basically, is to discard
> the result of governor prediction if the tick has been stopped alread and
> the predicted idle duration is within the tick range.
>
> Please try it on top of the v3 and tell me if you see an improvement.

It seems pretty good so far.
See a new line added to the previous graph, "rjwv3plus".

http://fast.smythies.com/rjwv3plus_100.png

I'll do another 100% load on one CPU test overnight, this time with
a trace.

... Doug
