Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x227g+YSdTkX8Smqzr4PIenY5V7GZBRfuKWRZmzcjI575dy29Em7kFSQiyMyziaFvpKOe1PO2
ARC-Seal: i=1; a=rsa-sha256; t=1518701764; cv=none;
        d=google.com; s=arc-20160816;
        b=fK1aEtqGl4AMRopOPbGCjmUmu8xmvSSVl3ftQfx7bLFXpuNGZKIhRuZtjjag4EDHv2
         hoxB6upFD/jnVPKQGshR43HdenPJCmH9IDJaN71EhnYRvUcAnF/Dm/YmhyI/Fd3ONoRo
         1VNTb4Ysrcs6FYEmAPBRPy9GbmKPsNfaIZcXqc3j58YVYXgSFXqydvqbiXPcgniqk0ay
         N9x+UimbODx+lVGMcOE0dNE52mM0saPaG6Od4ZyzkiMCTmlKssQNbgnxuL7mLRxIMXmm
         /RQTQcgW7ttP2EYc/QqCz5T4lAFLr+zd6/K60TsuIkNlRe0zcLLkBKTUWgRsO1M6y+Si
         yJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=w/zrKqgS3Dkxuf6l/XpbzqQtc2UG2MQo7AIjD8aBsN8=;
        b=k/3VojINjlnrBNMDvnBuDvdnFNYOSvDoYBnqObWyYANC9jp90mUXu2ATPklhCEusKC
         XlzAIZY88GLKYb4sxVQe4rstk5XfmGV9f2d/CgM89y2QWlbEeVSqKXJL7teucY6T8iw3
         A4tUFDCB6qBCBneFW8hgDWukSbenyFkWcXvufFikgBU/jsB4mvNLANUtYcMLQtKlY/xk
         NC/BUVXFYycG6MDvij/dxEsqFddihYuCloycJ/9MUV9jD7ONPYbd/2lPeMnFtlF/ucoF
         4aA3kRwghXJjqj1KK49pWkRZ26vKHXs+RQz8Nezu/JiRg9m5LUuAvyhGsFUrPBteVNjz
         L57w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=mbXUsnfF;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=mbXUsnfF;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
In-Reply-To: <20180215113407.GB7275@dhcp22.suse.cz>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
 <20180213193159.14606-2-pasha.tatashin@oracle.com> <20180215113407.GB7275@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 15 Feb 2018 08:36:00 -0500
X-Gmail-Original-Message-ID: <CAOAebxvF6mxDb4Ub02F0B9TEMRJUG0UGrKJ6ypaMGcje80cy6w@mail.gmail.com>
Message-ID: <CAOAebxvF6mxDb4Ub02F0B9TEMRJUG0UGrKJ6ypaMGcje80cy6w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm/memory_hotplug: enforce block size aligned
 range check
To: Michal Hocko <mhocko@kernel.org>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, bhe@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8805 signatures=668671
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=991
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150169
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315509448855886?=
X-GMAIL-MSGID: =?utf-8?q?1592474221404339725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Michal,

Thank you very much for your reviews and for Acking this patch.

>
> The whole memblock != section_size sucks! It leads to corner cases like
> you see. There is no real reason why we shouldn't be able to to online
> 2G unaligned memory range. Failing for that purpose is just wrong. The
> whole thing is just not well thought through and works only for well
> configured cases.

Hotplug operates over memory blocks, and it seems that conceptually
memory blocks are OK: their sizes are defined by arch, and may
represent a pluggable dimm (on virtual machines it is a different
story though). If we forced memory blocks to be equal to section size,
that would force us to handle millions of memory devices in sysfs,
which would not scale well.

>
> Your patch doesn't address the underlying problem.

What is the underlying problem? The hotplug operation was allowed, but
we ended up with half populated memory block, which is broken. The
patch solves this problem by making sure that this is never the case
for any arch, no matter what block size is defined as unit of
hotplugging.

> On the other hand, it
> is incorrect to check memory section here conceptually because this is
> not a hotplug unit as you say so I am OK with the patch regardless. It
> deserves a big fat TODO to fix this properly at least. I am not sure why
> we insist on the alignment in the first place. All we should care about
> is the proper memory section based range. The code is crap and it
> assumes pageblock start aligned at some places but there shouldn't be
> anything fundamental to change that.

So, if I understand correctly, ideally you would like to redefine unit
of memory hotplug to be equal to section size?

>
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you,
Pavel
