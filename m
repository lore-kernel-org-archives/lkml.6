Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeBIA6e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 19:58:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35484 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeBIA6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 19:58:32 -0500
X-Google-Smtp-Source: AH8x225CTO4PGm5CupZVWuzU0VL1HmAG2A8u3CZU5477o1A/yiwpBTuZn+l1LO1WEIqarEpYU1mvL1nZzwjlU4RZubs=
MIME-Version: 1.0
In-Reply-To: <92cb25ed-cd60-f3fa-dde5-72aa8b839808@oracle.com>
References: <20180208184555.5855-1-pasha.tatashin@oracle.com>
 <20180208184555.5855-2-pasha.tatashin@oracle.com> <20180208120334.0779ed0726bb527a9cad0336@linux-foundation.org>
 <92cb25ed-cd60-f3fa-dde5-72aa8b839808@oracle.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 8 Feb 2018 19:58:28 -0500
X-Gmail-Original-Message-ID: <CAOAebxssDZvLyHMCiYieaFMvC6S+CSpN76C_VP6zdM_UvC8wKQ@mail.gmail.com>
Message-ID: <CAOAebxssDZvLyHMCiYieaFMvC6S+CSpN76C_VP6zdM_UvC8wKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: initialize pages on demand during boot
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, m.mizuma@jp.fujitsu.com,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        baiyaowei@cmss.chinamobile.com, Wei Yang <richard.weiyang@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=605
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090010
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> It would be nice to have a little comment explaining why READ_ONCE was
>> needed.
>>
>> Would it still be needed if this code was moved into the locked region?
>
>
> No, we would need to use READ_ONCE() if we grabbed deferred_zone_grow_lock
> before this code. In fact I do not even think we strictly need READ_ONCE()
> here, as it is a single load anyway. But, because we are outside of the
> lock, and we want to quickly fetch the data with a single load, I think it
> makes sense to emphasize it using READ_ONCE() without expected compiler to
> simply do the write thing for us.
>
>

Correction:

No, we would NOT need ...
