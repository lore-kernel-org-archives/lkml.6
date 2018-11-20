Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E1C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4DF208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4DF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeKUAVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:21:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbeKUAVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:21:17 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAKDnFJk140625
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:52:01 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nvj5c41rs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:52:00 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 20 Nov 2018 13:51:58 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Nov 2018 13:51:56 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAKDpta864094380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 13:51:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DF54A405D;
        Tue, 20 Nov 2018 13:51:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBEE5A4051;
        Tue, 20 Nov 2018 13:51:52 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.151])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Nov 2018 13:51:52 +0000 (GMT)
Date:   Tue, 20 Nov 2018 14:51:50 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/7] doc/vm: New documentation for memory performance
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-4-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114224921.12123-4-keith.busch@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18112013-0016-0000-0000-00000229DF96
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112013-0017-0000-0000-00003282198E
Message-Id: <20181120135149.GA24627@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811200125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry if I'm jumping too late.

On Wed, Nov 14, 2018 at 03:49:16PM -0700, Keith Busch wrote:
> Platforms may provide system memory where some physical address ranges
> perform differently than others. These heterogeneous memory attributes are
> common to the node that provides the memory and exported by the kernel.
> 
> Add new documentation providing a brief overview of such systems and
> the attributes the kernel makes available to aid applications wishing
> to query this information.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  Documentation/vm/numaperf.rst | 71 +++++++++++++++++++++++++++++++++++++++++++

As this document describes user-space interfaces it belongs to
Documentation/admin-guide/mm.

>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/vm/numaperf.rst
> 
> diff --git a/Documentation/vm/numaperf.rst b/Documentation/vm/numaperf.rst
> new file mode 100644
> index 000000000000..5a3ecaff5474
> --- /dev/null
> +++ b/Documentation/vm/numaperf.rst
> @@ -0,0 +1,71 @@
> +.. _numaperf:
> +
> +================
> +NUMA Performance
> +================
> +
> +Some platforms may have multiple types of memory attached to a single
> +CPU. These disparate memory ranges share some characteristics, such as
> +CPU cache coherence, but may have different performance. For example,
> +different media types and buses affect bandwidth and latency.
> +
> +A system supporting such heterogeneous memory groups each memory type
> +under different "nodes" based on similar CPU locality and performance
> +characteristics.  Some memory may share the same node as a CPU, and
> +others are provided as memory-only nodes. While memory only nodes do not
> +provide CPUs, they may still be local to one or more compute nodes. The
> +following diagram shows one such example of two compute noes with local
> +memory and a memory only node for each of compute node:
> +
> + +------------------+     +------------------+
> + | Compute Node 0   +-----+ Compute Node 1   |
> + | Local Node0 Mem  |     | Local Node1 Mem  |
> + +--------+---------+     +--------+---------+
> +          |                        |
> + +--------+---------+     +--------+---------+
> + | Slower Node2 Mem |     | Slower Node3 Mem |
> + +------------------+     +--------+---------+
> +
> +A "memory initiator" is a node containing one or more devices such as
> +CPUs or separate memory I/O devices that can initiate memory requests. A
> +"memory target" is a node containing one or more CPU-accessible physical
> +address ranges.
> +
> +When multiple memory initiators exist, accessing the same memory
> +target may not perform the same as each other. The highest performing
> +initiator to a given target is considered to be one of that target's
> +local initiators.
> +
> +To aid applications matching memory targets with their initiators,
> +the kernel provide symlinks to each other like the following example::
> +
> +	# ls -l /sys/devices/system/node/nodeX/initiator*
> +	/sys/devices/system/node/nodeX/targetY -> ../nodeY
> +
> +	# ls -l /sys/devices/system/node/nodeY/target*
> +	/sys/devices/system/node/nodeY/initiatorX -> ../nodeX
> +
> +Applications may wish to consider which node they want their memory to
> +be allocated from based on the nodes performance characteristics. If
> +the system provides these attributes, the kernel exports them under the
> +node sysfs hierarchy by appending the initiator_access directory under
> +the node as follows::
> +
> +	/sys/devices/system/node/nodeY/initiator_access/
> +
> +The kernel does not provide performance attributes for non-local memory
> +initiators. The performance characteristics the kernel provides for
> +the local initiators are exported are as follows::
> +
> +	# tree /sys/devices/system/node/nodeY/initiator_access
> +	/sys/devices/system/node/nodeY/initiator_access
> +	|-- read_bandwidth
> +	|-- read_latency
> +	|-- write_bandwidth
> +	`-- write_latency
> +
> +The bandwidth attributes are provided in MiB/second.
> +
> +The latency attributes are provided in nanoseconds.
> +
> +See also: https://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> -- 
> 2.14.4
> 

-- 
Sincerely yours,
Mike.

