Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeCVUq4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:46:56 -0400
Received: from cmta18.telus.net ([209.171.16.91]:57337 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbeCVUqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:46:54 -0400
X-Authority-Analysis: v=2.2 cv=ebrSR/MH c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8
 a=UQ8mlwBPq_CX1FJq91kA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <1635957.yuHkCe9oyz@aspire.rjw.lan> z4Bte42s61Konz4ByelYCQ
In-Reply-To: z4Bte42s61Konz4ByelYCQ
Subject: RE: [RFT][PATCH v7.3 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Thu, 22 Mar 2018 13:46:49 -0700
Message-ID: <004001d3c21e$e867a3b0$b936eb10$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdPCBM5CitelSSkKQxC1UE+Xq/NUEwAGGCYQ
X-CMAE-Envelope: MS4wfPM0ouOquZiLd6heONyjnrvqUYc2+XtVhgeq3Ri/S+9+N28SJJPjtJZgJ6we9vpKdOjA1Vl8pU1vYHIbvt7AasK73cDRg4PJ7Vxnu7FOBGjQWV8AxeNt
 ZcODmbAwcEEHg4gh7bJleInOh8Onh7PcDV3nXRtRy6ajiVrOhN0z8IZmly9dGzLj5ZWK5yjPo9ojyQqvvvuLEfUgOsH0yPBJGQP+HM4UmPxSwAeRjLhrlDjV
 QtDWUWkuRWLXaTsP1a45e4PppzONdpgbgEv+nbiDiYvVFXLX6LkX2N49hbWsFU8Tbk+k3/8UU/K1pri5EcolneIswrBWkRWRgoKxOs5dOY9so96hyfc0Stie
 Wap1b93Y04AKYyz2o17h2D0C3YjGk7WurA+PQhNzXUyqJO4UIaWUXCycffYVfOefWWm/3EBumOfdlwObV8locpDAIMdvZg3ywiZIuq5zCt0K39+Ro+zZ5BTB
 VTWXiEmjSDSFuso5xXqwzaDwdKEm0rFprV2vXg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.22 10:40 Rafael J. Wysocki wrote:

...[snip]...

>The difference between this and the original v7 (of patch [5/8]) is
> what happens in menu_update().  This time next_timer_us is checked
> properly and if that is above the tick boundary and a tick wakeup occurs,
> the function simply sets mesured_us to a large constant and uses that to
> update both the correction factor and data->intervals[] (the particular
> value used in this patch was found through a bit of experimentation).
>
> Let's see how this works for Thomas and Doug.

System idle test done for 74 minutes.
After boot and after the system settles down for a couple of minutes,
Processor package power is constant at 3.7 Watts. (great)
Not worth a new graph to show a flat line.

V7.3 average package power = 3.68 Watts.
V7 average package power = 3.68 Watts
V7.2+ average package power = 4.06 Watts (+10%)

> For easier testing there is a git branch containing this patch (and the
> rest of the series) at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  idle-loop-v7.3

Thanks. I used this git branch this time and for the first time.
Much easier.

... Doug
