Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeCRPah (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:30:37 -0400
Received: from cmta20.telus.net ([209.171.16.93]:34902 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbeCRPae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:30:34 -0400
X-Authority-Analysis: v=2.2 cv=Pr98V0E3 c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=FGbulvE0AAAA:8
 a=1_jNL22JWkIHjat0TdkA:9 a=CjuIK1q_8ugA:10 a=svzTaB3SJmTkU8mK-ULk:22
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>
Cc: "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <001a01d3be0a$ad3a0ed0$07ae2c70$@net> xW2zeQ0g8FfdwxW30ehIAY
In-Reply-To: xW2zeQ0g8FfdwxW30ehIAY
Subject: RE: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
Date: Sun, 18 Mar 2018 08:30:29 -0700
Message-ID: <000801d3bece$0e4b9090$2ae2b1b0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdO+qE2gIO3LKbRcSpOEk14a0E1IAAAHb8pw
Content-Language: en-ca
X-CMAE-Envelope: MS4wfIzWMQUmL1rcBBeI/rgZxvtMBqk7jpBi1ngqbHwF0cwMLPfJ5jEzLY3R5MJF30S1MAtgf9rkS1MsQ5cjdj0s5mkdAf0XkcUfthjOF94RIf9cTnWHHEuh
 lqXbYza6Ejb8r/v9ms8J8bFTktJ+iHpk7jm/5OwyOztMGNJhWI0uaxgEELAamu4IjPxd+VZnKeeV+Jn4Gu7nLh8GLVWxjCVq2Bg/jAb48fbXU30iaMUbQvWl
 oHol9nvABHCZ17mf3DzfqJVPCPSj/wiFde0uEy8AJhTUetoQyU+fX64V3JI9c1sWOG1JgOTSY7qFrzcnfL6b/hDFu9NqFGxcuYxLvR7AGu36eivzj1p/xmNg
 gwVXCWCQtsKHAq+hH9QNtmNC3j3TZbf8EA+x6w5vaKZqDtpbo/5KFnT2BweAqCFfmP6IK9MCdbpyIrfM7k2UuYi5OGilvYfDlKooRmWKXiOwiSVpq3pq4xR7
 WY0WJslm64VRBKVzFMZ10z0eWSTTkaWlxKD0/JHQAJgZzWNLk2kQDcA+M6c=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.03.18 04:01 Rafael J. Wysocki wrote:

> Below is a drop-in v6 replacement for patch [4/7].
>
> With this new patch applied instead of the [4/7] the behavior should be much
> more in line with the v4 behavior, so please try it if you can and let me know
> if that really is the case on your systems.

Yes, the idle power is back down to V4 levels. (I did not do a new graph).

Some other data from this week (7 patch set + poll fix verses kernel 4.16-rc5):

pipe-test: The not cross core test is the most dramatic. Using CPU's 3 and 7,
or core 3, uses 6% less power and 18% performance improvement.

Graphs:
http://fast.smythies.com/pipe-test-one-core-power.png
http://fast.smythies.com/pipe-test-one-core-times.png

A couple of Phoronix tests (I didn't get very far yet):
himeno: 11% performance improvement; 14% less power.
compress-lzma: small performance improvement; small power improvement.
mafft: performance similar; small power improvement.

... Doug
