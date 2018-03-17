Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbeCQQMD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 12:12:03 -0400
Received: from cmta20.telus.net ([209.171.16.93]:58479 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753283AbeCQQL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 12:11:59 -0400
X-Authority-Analysis: v=2.2 cv=Pr98V0E3 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=FGbulvE0AAAA:8
 a=6UC-6IbxLh7Es9vKJjsA:9 a=QEXdDO2ut3YA:10 a=svzTaB3SJmTkU8mK-ULk:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>
Cc: "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> xBBLeKgi1FfdwxBBQedJaO
In-Reply-To: xBBLeKgi1FfdwxBBQedJaO
Subject: RE: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
Date: Sat, 17 Mar 2018 09:11:53 -0700
Message-ID: <001a01d3be0a$ad3a0ed0$07ae2c70$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdO97ZNLL3WiQehXTqSv51Idn8yeAgAHCweQ
X-CMAE-Envelope: MS4wfB9en3JXJZw9DoL63hUc3G00GyamgKYl3Scc8rAj1buJ++Htblexg9oCJUj1rjuQUctW/XrE1fCFc8CGRiWdw8/0dr8qnEaoteKXaxUnLlG6B/e0+Qhf
 KG7dr9XhYYdbV1i1fq3ahhH+G6i6F6fzhXvPi8YvXHvo5YxhhBIscAzNILHymwzT63w8S6HP3DttMCrLZ9ilEvSfakB6u1Nje4yn6B09tTf9jTaIyz+egs+w
 zyexWIA3hrZ57o/Sfz7iWK86DuT02lue2gAUS34W/G8hPTI5WhyMvLf6LJxx5/txA7rYm48PKNhEsVDs50bhKTWiuoEQ6t/V0tkxOKgqXZ/HU+breWimBjM4
 Ypj+LcPf1hux1tZQESg8plzKX8TUtwDGEx5ATvkfacJIp7FWXLtHQvSQ64MMc+dYbpncDZVXLPlsWUHMTtJ8EyZ7Q2ipukoM1nx7ssgjpGJA7mVNJZi2Ln/2
 LzATipg5Y00adQvIVJMG39z/93KHUj0fc/YW9Icf2Ve/0hSXPk/b8JNVrew=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.17 Thomas Ilsche wrote:

> Over the last week I tested v4+pollv2 and now v5+pollv3. With v5, I
> observe a particular idle behavior, that I have not seen before with
> v4. On a dual-socket Skylake system the idle power increases from
> 74.1 W (system total) to 85.5 W with a 300 HZ build and even to
> 138.3 W with a 1000 HZ build. A similar Haswell-EP system is also
> affected.

I confirm your idle findings. There is a regression between V4 and V5.
The differences on my test computer are much less than on yours,
probably because I have only 8 CPUs.

http://fast.smythies.com/rjw_idle.png

1000 Hz kernel only.

... Doug
