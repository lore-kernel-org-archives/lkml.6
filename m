Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbeDXUBD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 16:01:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55064 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeDXUBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 16:01:01 -0400
X-Google-Smtp-Source: AB8JxZq0JTr3VelURmilMqkmShBGlTuAg9niaHlzUW/jKAc9T5C9QrLHt5HDDUJyUmws5Rwif3IGZgeU3yppTi0bW60=
MIME-Version: 1.0
In-Reply-To: <20180420152922.21f43e52@gandalf.local.home>
References: <20180420191042.23452-1-pasha.tatashin@oracle.com> <20180420152922.21f43e52@gandalf.local.home>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 24 Apr 2018 16:00:11 -0400
X-Gmail-Original-Message-ID: <CAGM2reaqf4y4kb1jC+_vgG8mGRwaV_o75eMXTxWjZB3tWOM+KA@mail.gmail.com>
Message-ID: <CAGM2reaqf4y4kb1jC+_vgG8mGRwaV_o75eMXTxWjZB3tWOM+KA@mail.gmail.com>
Subject: Re: [v1] mm: access to uninitialized struct page
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8873 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thank you for your review:

>> https://lkml.org/lkml/2018/4/18/797
>
> #2, Do not use "lkml.org" it is a very unreliable source.
>

OK

> I'm fine with this change, but what happens if mm_init() traps?
>
> But that is probably not a case we really care about, as it is in the
> very early boot stage.


Yes, the assumption is that we do not trap in mm_init(), which I think
is the case because of early boot, and also I did not see this happen
during testing.

>
>>
>>       ftrace_init();
>>
>
> One thing I could add is to move ftrace_init() before trap_init(). But
> that may require some work, because it may still depend on trap_init()
> as well. But making ftrace_init() not depend on trap_init() is easier
> than making it not depend on ftrace_init(). Although it may require
> more arch updates.
>
> I'm not saying that you should move it, it's something that can be
> added later after this change is implemented.

This makes, sense, but should be done outside of this bug fix.

>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>

Thank you. I will send out an updated patch.

Pavel
