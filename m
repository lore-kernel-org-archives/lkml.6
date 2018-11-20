Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88C8C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C33B2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C33B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeKUAZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:25:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbeKUAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:25:21 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAKDteFg130335
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:56:04 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nvj59v7ky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:55:50 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 20 Nov 2018 13:53:42 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Nov 2018 13:53:40 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAKDrdAW7405868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 13:53:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2963952050;
        Tue, 20 Nov 2018 13:53:39 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.151])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 080CD5204E;
        Tue, 20 Nov 2018 13:53:36 +0000 (GMT)
Date:   Tue, 20 Nov 2018 14:53:34 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 5/7] doc/vm: New documentation for memory cache
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-6-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114224921.12123-6-keith.busch@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18112013-0016-0000-0000-00000229DFCB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112013-0017-0000-0000-0000328219C5
Message-Id: <20181120135333.GB24627@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811200126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:49:18PM -0700, Keith Busch wrote:
> Platforms may provide system memory that contains side caches to help
> spped up access. These memory caches are part of a memory node and
> the cache attributes are exported by the kernel.
> 
> Add new documentation providing a brief overview of system memory side
> caches and the kernel provided attributes for application optimization.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  Documentation/vm/numacache.rst | 76 ++++++++++++++++++++++++++++++++++++++++++

I think it's better to have both numaperf and numacache in a single
document, as they are quite related.

>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/vm/numacache.rst
> 
> diff --git a/Documentation/vm/numacache.rst b/Documentation/vm/numacache.rst
> new file mode 100644
> index 000000000000..e79c801b7e3b
> --- /dev/null
> +++ b/Documentation/vm/numacache.rst
> @@ -0,0 +1,76 @@
> +.. _numacache:
> +
> +==========
> +NUMA Cache
> +==========
> +
> +System memory may be constructed in a hierarchy of various performing
> +characteristics in order to provide large address space of slower
> +performing memory cached by a smaller size of higher performing
> +memory. The system physical addresses that software is aware of see
> +is provided by the last memory level in the hierarchy, while higher
> +performing memory transparently provides caching to slower levels.
> +
> +The term "far memory" is used to denote the last level memory in the
> +hierarchy. Each increasing cache level provides higher performing CPU
> +access, and the term "near memory" represents the highest level cache
> +provided by the system. This number is different than CPU caches where
> +the cache level (ex: L1, L2, L3) uses a CPU centric view with each level
> +being lower performing and closer to system memory. The memory cache
> +level is centric to the last level memory, so the higher numbered cache
> +level denotes memory nearer to the CPU, and further from far memory.
> +
> +The memory side caches are not directly addressable by software. When
> +software accesses a system address, the system will return it from the
> +near memory cache if it is present. If it is not present, the system
> +accesses the next level of memory until there is either a hit in that
> +cache level, or it reaches far memory.
> +
> +In order to maximize the performance out of such a setup, software may
> +wish to query the memory cache attributes. If the system provides a way
> +to query this information, for example with ACPI HMAT (Heterogeneous
> +Memory Attribute Table)[1], the kernel will append these attributes to
> +the NUMA node that provides the memory.
> +
> +When the kernel first registers a memory cache with a node, the kernel
> +will create the following directory::
> +
> +	/sys/devices/system/node/nodeX/cache/
> +
> +If that directory is not present, then either the memory does not have
> +a side cache, or that information is not provided to the kernel.
> +
> +The attributes for each level of cache is provided under its cache
> +level index::
> +
> +	/sys/devices/system/node/nodeX/cache/indexA/
> +	/sys/devices/system/node/nodeX/cache/indexB/
> +	/sys/devices/system/node/nodeX/cache/indexC/
> +
> +Each cache level's directory provides its attributes. For example,
> +the following is a single cache level and the attributes available for
> +software to query::
> +
> +	# tree sys/devices/system/node/node0/cache/
> +	/sys/devices/system/node/node0/cache/
> +	|-- index1
> +	|   |-- associativity
> +	|   |-- level
> +	|   |-- line_size
> +	|   |-- size
> +	|   `-- write_policy
> +
> +The cache "associativity" will be 0 if it is a direct-mapped cache, and
> +non-zero for any other indexed based, multi-way associativity.
> +
> +The "level" is the distance from the far memory, and matches the number
> +appended to its "index" directory.
> +
> +The "line_size" is the number of bytes accessed on a cache miss.
> +
> +The "size" is the number of bytes provided by this cache level.
> +
> +The "write_policy" will be 0 for write-back, and non-zero for
> +write-through caching.
> +
> +[1] https://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> -- 
> 2.14.4
> 

-- 
Sincerely yours,
Mike.

