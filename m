Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeCUSXa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:23:30 -0400
Received: from cmta16.telus.net ([209.171.16.89]:39563 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752431AbeCUSX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:23:27 -0400
X-Authority-Analysis: v=2.2 cv=EJrp6xRC c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=HLEhOUT7AAAA:8 a=MJ2xowUNjgiAORS1SgoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=73WewclNby-GrhdgABwy:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <1635957.yuHkCe9oyz@aspire.rjw.lan> <CAJZ5v0j-CnEms-Wm0Op=386ceuG2GfAouVLXO48rbD_pUPJhMg@mail.gmail.com> yi2qeYpqCpApsyi2ve5qq1
In-Reply-To: yi2qeYpqCpApsyi2ve5qq1
Subject: RE: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Wed, 21 Mar 2018 11:23:22 -0700
Message-ID: <002201d3c141$b3f9bd80$1bed3880$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdPBPplr9X1Z2E22Szmp7z6qfTxehwAARzCA
X-CMAE-Envelope: MS4wfLt/N0jltyLRKLDV/AEEe0F8IMt82t6FuBzZwzPG+lJmkA1xEchwFggrQ/RyVJpgI4nnBJwakIjnYqacAfOvjAInv9DYYsu8UxALPej3FEBAjKaiPR5F
 zJR00CHLzk41CQoDqaz/eIea1VuQjynKZRmqZ4emUzIbjKY9wczDXtlrRXcEp81fUM5a+pmKq38YM1emiiYglkzf3EaSs1hPAJGCN4Ct9uu4OKX/kzZqKRqi
 LPEsj7C/3rlDvS93hf6EdNCswpdnQPYCR1lVZLJzsV4sMsaoGw1teCgFSgzd47F4kq7e8RrESvgjM84a73U/vaYYHfoqhCq0L662IAbW29GlOU/rOU19j9SC
 ZVyEgvxe5FE8LbQnXC+JiVu/M0L4EcJld7Z8KK7TNiusDRVkIxyAufl7CtDqpaIbih1BTuW3W9P9hEuwL/WxC55uOG1F24nKY+fS075pHhMp2zO5LdM1tMrB
 LLP2PEA0r+v8DSCX+MfOVRK7FRceeF+0W8N9ih4saFtQX83YTu3K6iPJSuQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.21 11:00 Thomas Ilsche wrote:
> On 2018-03-21 15:36, Rafael J. Wysocki wrote:
>> 
>> So please disregard this one entirely and take the v7.2 replacement
>> instead of it:https://patchwork.kernel.org/patch/10299429/
>> 
>> The current versions (including the above) is in the git branch at
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>   idle-loop-v7.2
>
> With v7.2 (tested on SKL-SP from git) I see similar behavior in idle
> as with v5: several cores which just keep the sched tick enabled.
> Worse yet, some go only in C1 (not even C1E!?) despite sleeping the
> full sched tick.
> The resulting power consumption is ~105 W instead of ~ 70 W.
>
> https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v7_2_skl_sp_idle.png
>
> I have briefly ran v7 and I believe it was also affected.

I am not able to repeat your issues anymore.
Idle powers were fine with V7, on my test computer.
I have not done thorough idle tests with V7.2, but they looked O.K.

As for the high frequency loop stuff, I no longer see any issues there
either. I tried several loops frequencies, and did one for a couple of hours.

I'll try again later today, as there is a test running now (frequency sweep)
that takes about 4 hours.

... Doug
