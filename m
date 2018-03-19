Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030557AbeCSTiK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:38:10 -0400
Received: from cmta19.telus.net ([209.171.16.92]:47366 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031192AbeCSSWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:22:03 -0400
X-Authority-Analysis: v=2.2 cv=TI+qcxta c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=QyXUC8HyAAAA:8
 a=gu6fZOg2AAAA:8 a=DZUM9XUHyLTfwFUYx18A:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
 a=2RSlZUUhi9gRBrsHwhhZ:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <2148754.TY7qXgFyZy@aspire.rjw.lan> xuDHe5JrTQdbpxuDMeg0da
In-Reply-To: xuDHe5JrTQdbpxuDMeg0da
Subject: RE: [RFT][PATCH v5 7/7] cpuidle: menu: Avoid selecting shallow states with stopped tick
Date: Mon, 19 Mar 2018 11:21:58 -0700
Message-ID: <003301d3bfaf$2d5e4090$881ac1b0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdO/gJrvyo9eKq4lRGmNVPItTw3wKgAFzGIQ
X-CMAE-Envelope: MS4wfE+XYkzwpE8phWkAe5WjCFWSsLFv+jm7xVDaNdLzekJb4WZk96umZAPsfnABsOmFaEgNE3Jc87RE/0UPWarPgEd290AyIvN7qeYbOuohCmgjbAz4uO7w
 w/6sdsZSjjq8gTOjow1pvohUWasOdFpGoAnSch3QVjtEOg8TPgtbnnzQOYyYeJDPCIM0ua33jriFL5HqZ1HiYwNl3NfVG/JrIFjSDYoU9iiE55XJTE/Nf4Oi
 gK3oB2WIOanfldm84cj/Ps+bxkIZGhnYTdc2VFqeg8jRFU7PgG+7CLOvmaf16Mx6slRaLu8LjtV5wZ73Ouu+nqLe1zI0W2BIvGEVKjzSPuyVXUq1zc3vNimr
 AMsufpETUerIPclYUaHyTp4lVSZEuLi5fz/3chwguJHYRz6OzHsQSEOVQa523+Dy7baji3zpJFg36D5WfbTf3r1uiKwUhPNfyKF59FH1ut+xPT9UmEn0iu4V
 ASagfM6mwsBGMYhu3xgh/E4ULRW6+NvmHRodIv5MDVseQ3iuyST2ooBsiK0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.19 05:47 Thomas Ilsche wrote:
> On 2018-03-15 23:19, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> 
>> If the scheduler tick has been stopped already and the governor
>> selects a shallow idle state, the CPU can spend a long time in that
>> state if the selection is based on an inaccurate prediction of idle
>> time.  That effect turns out to be noticeable, so it needs to be
>> mitigated.
>
> What are some common causes for that situation?
> How could I trigger this for testing?

It appeared quite readily with my simple 100% load
on one CPU test. Back then (V3) there only 6 patches in the set,
and before the re-spin there ended up being a patch 7 of 6, which
made a significant difference in both package power and the
histograms of times in each idle state.

Reference:
https://marc.info/?l=linux-pm&m=152075419526696&w=2

... Doug
 
