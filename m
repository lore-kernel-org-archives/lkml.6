Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9AAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA00206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA00206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeLDPnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:43:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725910AbeLDPnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:43:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB4FZPxL111128
        for <linux-kernel@vger.kernel.org>; Tue, 4 Dec 2018 10:43:46 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p5tw4wyy7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:43:45 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 4 Dec 2018 15:43:43 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Dec 2018 15:43:39 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB4FhckL58589268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 15:43:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A8B25204E;
        Tue,  4 Dec 2018 15:43:38 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.51.227])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 20DCD52052;
        Tue,  4 Dec 2018 15:43:35 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Keith Busch <keith.busch@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
In-Reply-To: <20181116183254.GD14630@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com> <20181115135710.GD19286@bombadil.infradead.org> <20181115145920.GG11416@localhost.localdomain> <20181115203654.GA28246@bombadil.infradead.org> <20181116183254.GD14630@localhost.localdomain>
Date:   Tue, 04 Dec 2018 21:13:33 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18120415-0016-0000-0000-00000231EC31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120415-0017-0000-0000-00003289F82A
Message-Id: <87sgzd5mca.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812040133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Busch <keith.busch@intel.com> writes:

> On Thu, Nov 15, 2018 at 12:36:54PM -0800, Matthew Wilcox wrote:
>> On Thu, Nov 15, 2018 at 07:59:20AM -0700, Keith Busch wrote:
>> > On Thu, Nov 15, 2018 at 05:57:10AM -0800, Matthew Wilcox wrote:
>> > > On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
>> > > > Memory-only nodes will often have affinity to a compute node, and
>> > > > platforms have ways to express that locality relationship.
>> > > > 
>> > > > A node containing CPUs or other DMA devices that can initiate memory
>> > > > access are referred to as "memory iniators". A "memory target" is a
>> > > > node that provides at least one phyiscal address range accessible to a
>> > > > memory initiator.
>> > > 
>> > > I think I may be confused here.  If there is _no_ link from node X to
>> > > node Y, does that mean that node X's CPUs cannot access the memory on
>> > > node Y?  In my mind, all nodes can access all memory in the system,
>> > > just not with uniform bandwidth/latency.
>> > 
>> > The link is just about which nodes are "local". It's like how nodes have
>> > a cpulist. Other CPUs not in the node's list can acces that node's memory,
>> > but the ones in the mask are local, and provide useful optimization hints.
>> 
>> So ... let's imagine a hypothetical system (I've never seen one built like
>> this, but it doesn't seem too implausible).  Connect four CPU sockets in
>> a square, each of which has some regular DIMMs attached to it.  CPU A is
>> 0 hops to Memory A, one hop to Memory B and Memory C, and two hops from
>> Memory D (each CPU only has two "QPI" links).  Then maybe there's some
>> special memory extender device attached on the PCIe bus.  Now there's
>> Memory B1 and B2 that's attached to CPU B and it's local to CPU B, but
>> not as local as Memory B is ... and we'd probably _prefer_ to allocate
>> memory for CPU A from Memory B1 than from Memory D.  But ... *mumble*,
>> this seems hard.
>
> Indeed, that particular example is out of scope for this series. The
> first objective is to aid a process running in node B's CPUs to allocate
> memory in B1. Anything that crosses QPI are their own.

But if you can extrapolate how such a system can possibly be expressed
using what is propsed here, it would help in reviewing this. Also how
do we intent to express the locality of memory w.r.t to other computing
units like GPU/FPGA?

I understand that this is looked at as ACPI HMAT in sysfs format.
But as mentioned by others in this thread, if we don't do this platform
and device independent way, we can have application portability issues
going forward?

-aneesh

