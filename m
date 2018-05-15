Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeEOQAG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:00:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47246 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeEOQAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:00:05 -0400
X-Google-Smtp-Source: AB8JxZpfqL14g1LI0GPO6KcIoDPGIlo78IU4Xegh5BlfvBcEflX3SAP9P7AOEKvY6OI0QsLK7s/lgD+FcjscBLndY3c=
MIME-Version: 1.0
References: <20180510115356.31164-1-pasha.tatashin@oracle.com>
 <20180510123039.GF5325@dhcp22.suse.cz> <CAGM2reZbYR96_uv-SB=5eL6tt0OSq9yXhtA-B2TGHbRQtfGU6g@mail.gmail.com>
 <20180515091036.GC12670@dhcp22.suse.cz> <CAGM2reaQusBA-nmQ5xqH4u-EVxgJCnaHAZs=1AXFOpNWTh7VbQ@mail.gmail.com>
 <20180515125541.GH12670@dhcp22.suse.cz>
In-Reply-To: <20180515125541.GH12670@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 15 May 2018 11:59:25 -0400
X-Gmail-Original-Message-ID: <CAGM2reYGFjG38FW0nEf1gwRMfDyVQ7QCGZ83VewxXgedeT=Zsg@mail.gmail.com>
Message-ID: <CAGM2reYGFjG38FW0nEf1gwRMfDyVQ7QCGZ83VewxXgedeT=Zsg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: allow deferred page init for vmemmap only
To: mhocko@kernel.org
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        Linux Memory Management List <linux-mm@kvack.org>,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=528
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This will always be a maze as the early boot tends to be. Sad but true.
> That is why I am not really convinced we should use a large hammer and
> disallow deferred page initialization just because UP implementation of
> pcp does something too early. We should instead rule that one odd case.
> Your patch simply doesn't rule a large class of potential issues. It
> just rules out a potentially useful feature for an odd case. See my
> point?

Hi Michal,

OK, I will send an updated patch with disabling deferred pages only whe
NEED_PER_CPU_KM. Hopefully, we won't see similar issues in other places.

Thank you,
Pavel
