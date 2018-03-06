Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754187AbeCFVtL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:49:11 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34354 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753823AbeCFVtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:49:09 -0500
Subject: Re: [PATCH] mm: might_sleep warning
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20180306192022.28289-1-pasha.tatashin@oracle.com>
 <20180306123655.957e5b6b20b200505544ea7a@linux-foundation.org>
 <CAGM2rea1raxsXDkqZgmmdBiuywp1M3y1p++=J893VJDgGDWLnQ@mail.gmail.com>
 <20180306125604.c394a25a50cae0e36c546855@linux-foundation.org>
 <CAGM2rebb9FdceEBO2GfJ7BKf=fEf8p86Yc1vCq4eZyyB0Me+DA@mail.gmail.com>
 <20180306132129.45b395d9732b6360fa0b600d@linux-foundation.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <a90aa8fc-0612-3107-93c6-9e4b706785db@oracle.com>
Date: Tue, 6 Mar 2018 16:48:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306132129.45b395d9732b6360fa0b600d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=848
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060234
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> That's why page_alloc_init_late() needs spin_lock_irq().  If a CPU is
> holding deferred_zone_grow_lock with enabled interrupts and an
> interrupt comes in on that CPU and the CPU runs deferred_grow_zone() in
> its interrupt handler, we deadlock.
> 
> lockdep knows about this bug and should have reported it.
> 

I see what you are saying. Yes you are correct, we need spin_lock_irq() 
in page_alloc_init_late(). I will update the patch. I am not sure why 
lockdep has not reported it. May be it is initialized after this code is 
executed?

Thank you,
Pavel
