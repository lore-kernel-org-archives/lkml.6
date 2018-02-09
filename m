Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeBIQC4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:02:56 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:52094 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBIQCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:02:55 -0500
X-Google-Smtp-Source: AH8x227oJ39QMmFGPAhlRUMZgyu+tUJ4UoIwUfamMitm+meoOqPjC9LESUg6swzHqgzTKzDqXH39Wg==
Subject: Re: [PATCH RFC tools/lkmm] Miscellaneous fixes
To: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, Akira Yokosawa <akiyks@gmail.com>
References: <20180209141832.GA17505@linux.vnet.ibm.com>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <df87e89b-7fbe-37a7-42cb-62df74591df4@gmail.com>
Date: Sat, 10 Feb 2018 01:02:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209141832.GA17505@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/02/09 23:18, Paul E. McKenney wrote:
> Hello!
> 
> This RFC series adds some miscellaneous updates to the Linux kernel
> memory model:
> 
> 1.	Clarify the origin and scope of the tool name to avoid confusion
> 	between "memory model" and "memory management", courtesy of
> 	Andrea Parri.
> 
> 2.	Move the maintainer list for LKMM to the main MAINTAINERS file,
> 	courtesy of Andrea Parri.
> 
> 3.	Add memory-barriers.txt to the LKMM MAINTAINERS entry, courtesy
> 	of Andrea Parri.
> 
> 4.	Add comments explaining the purpose of the various litmus tests.
> 
> 5.	Fix puntuation errors in litmus-tests/README.
> 
> 6.	Add LKMM acronym to MAINTAINERS entry.  If there are no objections,
> 	this will be squashed with #3 above.
> 
> 7.	Add Akira Yokosawa as an LKMM reviewer.
> 
> 8-10.	Replace underscores with hyphens for smp_mb__*() workings.  Note that
> 	this patch leaves rb_dep alone because the underscore is set by herd7.
> 	If there are no objections, these will be squashed together.

Paul, Patches 8-10 made the problem even worse with herd7 7.47.
I'll submit an alternative patch in reply to this message.

      Thanks, Akira

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  /tools/memory-model/MAINTAINERS                                                            |   15 -------
>  b/MAINTAINERS                                                                              |   20 +++++++++-
>  b/tools/memory-model/MAINTAINERS                                                           |    2 -
>  b/tools/memory-model/README                                                                |   14 +++----
>  b/tools/memory-model/linux-kernel.bell                                                     |    8 ++--
>  b/tools/memory-model/linux-kernel.cat                                                      |    8 ++--
>  b/tools/memory-model/linux-kernel.def                                                      |    6 +--
>  b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus                              |    7 +++
>  b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus                              |    7 +++
>  b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus                              |    7 +++
>  b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus                                   |    7 +++
>  b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus                         |   10 +++++
>  b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus                         |   10 +++++
>  b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus                                  |    9 ++++
>  b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus |   11 +++++
>  b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus                        |   11 +++++
>  b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus                    |    8 ++++
>  b/tools/memory-model/litmus-tests/LB+poonceonces.litmus                                    |    7 +++
>  b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus                           |   11 +++++
>  b/tools/memory-model/litmus-tests/MP+polocks.litmus                                        |   11 +++++
>  b/tools/memory-model/litmus-tests/MP+poonceonces.litmus                                    |    7 +++
>  b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus                    |    8 ++++
>  b/tools/memory-model/litmus-tests/MP+porevlocks.litmus                                     |   11 +++++
>  b/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus                        |    8 ++++
>  b/tools/memory-model/litmus-tests/R+mbonceonces.litmus                                     |    9 ++++
>  b/tools/memory-model/litmus-tests/R+poonceonces.litmus                                     |    8 ++++
>  b/tools/memory-model/litmus-tests/README                                                   |    4 +-
>  b/tools/memory-model/litmus-tests/S+poonceonces.litmus                                     |    9 ++++
>  b/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus                       |    7 +++
>  b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus                                    |    9 ++++
>  b/tools/memory-model/litmus-tests/SB+poonceonces.litmus                                    |    8 ++++
>  b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus                              |    8 ++++
>  b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus                |    8 ++++
>  b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus               |    9 ++++
>  b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus               |    8 ++++
>  b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus    |   14 +++++++
>  36 files changed, 286 insertions(+), 38 deletions(-)
> 
