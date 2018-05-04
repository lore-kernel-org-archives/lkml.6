Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeEDQzL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:55:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51702 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeEDQzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:55:10 -0400
Subject: Re: [PATCH v8 0/6] optimize memblock_next_valid_pfn and
 early_pfn_valid on arm and arm64
To: Daniel Vacek <neelx@redhat.com>, Jia He <hejianet@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>, Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, Steve Capper <steve.capper@arm.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <1523431317-30612-1-git-send-email-hejianet@gmail.com>
 <05b0fcf2-7670-101e-d4ab-1f656ff6b02f@gmail.com>
 <CACjP9X8bHmrxmd7ZPcfQq6Eq0Mzwmt0saOR3Ph53gp2n-dcKBQ@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <23b14717-0f4a-10f2-5118-7cb8445fbdab@oracle.com>
Date: Fri, 4 May 2018 12:53:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACjP9X8bHmrxmd7ZPcfQq6Eq0Mzwmt0saOR3Ph53gp2n-dcKBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8883 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805040154
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm wondering, ain't simple enabling of config
> DEFERRED_STRUCT_PAGE_INIT provide even better speed-up? If that is the
> case then it seems like this series is not needed at all, right?
> I am not sure why is this config optional. It looks like it could be
> enabled by default or even unconditionally considering that with
> commit c9e97a1997fb ("mm: initialize pages on demand during boot") the
> deferred code is statically disabled after all the pages are
> initialized.

Hi Daniel,

Currently, deferred struct pages are initialized in parallel only on NUMA machines. I would like to make a change to use all the available CPUs even on a single socket systems, but that is not there yet. So, I believe Jia's performance improvements are still relevant.

Thank you,
Pavel
