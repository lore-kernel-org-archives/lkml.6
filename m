Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF908C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFF32077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFF32077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeIEUtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:49:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726046AbeIEUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:49:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85GFhws071509
        for <linux-kernel@vger.kernel.org>; Wed, 5 Sep 2018 12:18:13 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2maj3wshrs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:18:13 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
        Wed, 5 Sep 2018 17:18:10 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Sep 2018 17:18:02 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w85GI1CT42991710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Sep 2018 16:18:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 436414203F;
        Wed,  5 Sep 2018 19:17:56 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F3ED42045;
        Wed,  5 Sep 2018 19:17:54 +0100 (BST)
Received: from [9.145.21.228] (unknown [9.145.21.228])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Sep 2018 19:17:54 +0100 (BST)
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
To:     Christopher Lameter <cl@linux.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        dave@stgolabs.net, dave.dice@oracle.com,
        Dhaval Giani <dhaval.giani@oracle.com>, ktkhai@virtuozzo.com,
        Pavel.Tatashin@microsoft.com, paulmck@linux.vnet.ibm.com,
        shady.issa@oracle.com, tariqt@mellanox.com, tglx@linutronix.de,
        tim.c.chen@intel.com, vbabka@suse.cz, longman@redhat.com,
        yang.shi@linux.alibaba.com, shy828301@gmail.com,
        Huang Ying <ying.huang@intel.com>, subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
 <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com>
From:   Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date:   Wed, 5 Sep 2018 18:17:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18090516-0012-0000-0000-000002A43CA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090516-0013-0000-0000-000020D85FC8
Message-Id: <839e2703-1588-0873-00a7-d04810f403cf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=934 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/2018 17:10, Christopher Lameter wrote:
> On Tue, 4 Sep 2018, Daniel Jordan wrote:
> 
>>  - Promoting huge page usage:  With memory sizes becoming ever larger, huge
>> pages are becoming more and more important to reduce TLB misses and the
>> overhead of memory management itself--that is, to make the system scalable
>> with the memory size.  But there are still some remaining gaps that prevent
>> huge pages from being deployed in some situations, such as huge page
>> allocation latency and memory fragmentation.
> 
> You forgot the major issue that huge pages in the page cache are not
> supported and thus we have performance issues with fast NVME drives that
> are now able to do 3Gbytes per sec that are only possible to reach with
> directio and huge pages.
> 
> IMHO the huge page issue is just the reflection of a certain hardware
> manufacturer inflicting pain for over a decade on its poor users by not
> supporting larger base page sizes than 4k. No such workarounds needed on
> platforms that support large sizes. Things just zoom along without
> contortions necessary to deal with huge pages etc.
> 
> Can we come up with a 2M base page VM or something? We have possible
> memory sizes of a couple TB now. That should give us a million or so 2M
> pages to work with.
> 
>>  - Reducing the number of users of mmap_sem:  This semaphore is frequently
>> used throughout the kernel.  In order to facilitate scaling this longstanding
>> bottleneck, these uses should be documented and unnecessary users should be
>> fixed.
> 
> 
> Large page sizes also reduce contention there.

That's true for the page fault path, but for process's actions manipulating the
memory process's layout (mmap,munmap,madvise,mprotect) the impact is minimal
unless the code has to manipulate the page tables.

>> If you haven't already done so, please let us know if you are interested in
>> attending, or have suggestions for other attendees.
> 
> Certainly interested in attending but this overlaps supercomputing 2018 in
> Dallas Texas...
> 

