Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC740C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC3E20873
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC3E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeGLHee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:34:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbeGLHed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:34:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6C7NVOV071250
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:26:16 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k61fxbb0t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:26:15 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 12 Jul 2018 08:26:13 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 08:26:10 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6C7Q9R942270744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 07:26:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA35F52065;
        Thu, 12 Jul 2018 10:26:30 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.135])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 66F6E52051;
        Thu, 12 Jul 2018 10:26:30 +0100 (BST)
Date:   Thu, 12 Jul 2018 10:26:07 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] docs/mm: add description of boot time memory
 management
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530370506-21751-12-git-send-email-rppt@linux.vnet.ibm.com>
 <20180703122324.GA23824@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703122324.GA23824@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18071207-0020-0000-0000-000002A5A73C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071207-0021-0000-0000-000020F1F203
Message-Id: <20180712072606.GB4422@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 03, 2018 at 02:23:24PM +0200, Michal Hocko wrote:
> On Sat 30-06-18 17:55:06, Mike Rapoport wrote:
> > Both bootmem and memblock are have pretty good internal documentation
> > coverage. With addition of some overview we get a nice description of the
> > early memory management.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> Yes this looks reasonable. I would just mention the available debugging
> options and CONFIG_ARCH_DISCARD_MEMBLOCK.

I'd really prefer to add it as a separate patch rather then resending the
whole series.

> Other than that looks goot to get a rough idea. Improvements can be done
> on top of course.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for the review. I think Jon was mostly concerned about the patch
"mm/memblock: add a name for memblock flags enumeration" [1]. Could you
please review it as well?

[1] https://lore.kernel.org/lkml/1530370506-21751-7-git-send-email-rppt@linux.vnet.ibm.com/

> > ---
> >  Documentation/core-api/boot-time-mm.rst | 92 +++++++++++++++++++++++++++++++++
> >  Documentation/core-api/index.rst        |  1 +
> >  2 files changed, 93 insertions(+)
> >  create mode 100644 Documentation/core-api/boot-time-mm.rst
> > 
> > diff --git a/Documentation/core-api/boot-time-mm.rst b/Documentation/core-api/boot-time-mm.rst
> > new file mode 100644
> > index 0000000..03cb164
> > --- /dev/null
> > +++ b/Documentation/core-api/boot-time-mm.rst
> > @@ -0,0 +1,92 @@
> > +===========================
> > +Boot time memory management
> > +===========================
> > +
> > +Early system initialization cannot use "normal" memory management
> > +simply because it is not set up yet. But there is still need to
> > +allocate memory for various data structures, for instance for the
> > +physical page allocator. To address this, a specialized allocator
> > +called the :ref:`Boot Memory Allocator <bootmem>`, or bootmem, was
> > +introduced. Several years later PowerPC developers added a "Logical
> > +Memory Blocks" allocator, which was later adopted by other
> > +architectures and renamed to :ref:`memblock <memblock>`. There is also
> > +a compatibility layer called `nobootmem` that translates bootmem
> > +allocation interfaces to memblock calls.
> > +
> > +The selection of the early allocator is done using
> > +``CONFIG_NO_BOOTMEM`` and ``CONFIG_HAVE_MEMBLOCK`` kernel
> > +configuration options. These options are enabled or disabled
> > +statically by the architectures' Kconfig files.
> > +
> > +* Architectures that rely only on bootmem select
> > +  ``CONFIG_NO_BOOTMEM=n && CONFIG_HAVE_MEMBLOCK=n``.
> > +* The users of memblock with the nobootmem compatibility layer set
> > +  ``CONFIG_NO_BOOTMEM=y && CONFIG_HAVE_MEMBLOCK=y``.
> > +* And for those that use both memblock and bootmem the configuration
> > +  includes ``CONFIG_NO_BOOTMEM=n && CONFIG_HAVE_MEMBLOCK=y``.
> > +
> > +Whichever allocator is used, it is the responsibility of the
> > +architecture specific initialization to set it up in
> > +:c:func:`setup_arch` and tear it down in :c:func:`mem_init` functions.
> > +
> > +Once the early memory management is available it offers a variety of
> > +functions and macros for memory allocations. The allocation request
> > +may be directed to the first (and probably the only) node or to a
> > +particular node in a NUMA system. There are API variants that panic
> > +when an allocation fails and those that don't. And more recent and
> > +advanced memblock even allows controlling its own behaviour.
> > +
> > +.. _bootmem:
> > +
> > +Bootmem
> > +=======
> > +
> > +(mostly stolen from Mel Gorman's "Understanding the Linux Virtual
> > +Memory Manager" `book`_)
> > +
> > +.. _book: https://www.kernel.org/doc/gorman/
> > +
> > +.. kernel-doc:: mm/bootmem.c
> > +   :doc: bootmem overview
> > +
> > +.. _memblock:
> > +
> > +Memblock
> > +========
> > +
> > +.. kernel-doc:: mm/memblock.c
> > +   :doc: memblock overview
> > +
> > +
> > +Functions and structures
> > +========================
> > +
> > +Common API
> > +----------
> > +
> > +The functions that are described in this section are available
> > +regardless of what early memory manager is enabled.
> > +
> > +.. kernel-doc:: mm/nobootmem.c
> > +
> > +Bootmem specific API
> > +--------------------
> > +
> > +These interfaces available only with bootmem, i.e when ``CONFIG_NO_BOOTMEM=n``
> > +
> > +.. kernel-doc:: include/linux/bootmem.h
> > +.. kernel-doc:: mm/bootmem.c
> > +   :nodocs:
> > +
> > +Memblock specific API
> > +---------------------
> > +
> > +Here is the description of memblock data structures, functions and
> > +macros. Some of them are actually internal, but since they are
> > +documented it would be silly to omit them. Besides, reading the
> > +descriptions for the internal functions can help to understand what
> > +really happens under the hood.
> > +
> > +.. kernel-doc:: include/linux/memblock.h
> > +.. kernel-doc:: mm/memblock.c
> > +   :nodocs:
> > diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> > index f5a66b7..93d5a46 100644
> > --- a/Documentation/core-api/index.rst
> > +++ b/Documentation/core-api/index.rst
> > @@ -28,6 +28,7 @@ Core utilities
> >     printk-formats
> >     circular-buffers
> >     gfp_mask-from-fs-io
> > +   boot-time-mm
> >  
> >  Interfaces for kernel debugging
> >  ===============================
> > -- 
> > 2.7.4
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

