Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F9BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3555206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3555206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeIFMT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:19:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727773AbeIFMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:19:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w867i14X092513
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 03:45:19 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2maymd1bnv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 03:45:19 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
        Thu, 6 Sep 2018 08:45:17 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 08:45:08 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w867j7eO36110454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 07:45:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C63311C05C;
        Thu,  6 Sep 2018 10:44:59 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F9F611C054;
        Thu,  6 Sep 2018 10:44:58 +0100 (BST)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Sep 2018 10:44:58 +0100 (BST)
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christopher Lameter <cl@linux.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        dave@stgolabs.net, dave.dice@oracle.com,
        Dhaval Giani <dhaval.giani@oracle.com>, ktkhai@virtuozzo.com,
        Pavel.Tatashin@microsoft.com, paulmck@linux.vnet.ibm.com,
        shady.issa@oracle.com, tariqt@mellanox.com, tim.c.chen@intel.com,
        vbabka@suse.cz, longman@redhat.com, yang.shi@linux.alibaba.com,
        shy828301@gmail.com, Huang Ying <ying.huang@intel.com>,
        subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
 <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com>
 <839e2703-1588-0873-00a7-d04810f403cf@linux.vnet.ibm.com>
 <alpine.DEB.2.21.1809060059390.1416@nanos.tec.linutronix.de>
From:   Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date:   Thu, 6 Sep 2018 09:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809060059390.1416@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18090607-0028-0000-0000-000002F5149E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090607-0029-0000-0000-000023AE98B0
Message-Id: <4d6a466c-6f77-b54e-fb30-9ad8e5bb4023@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2018 01:01, Thomas Gleixner wrote:
> On Wed, 5 Sep 2018, Laurent Dufour wrote:
>> On 05/09/2018 17:10, Christopher Lameter wrote:
>>> Large page sizes also reduce contention there.
>>
>> That's true for the page fault path, but for process's actions manipulating the
>> memory process's layout (mmap,munmap,madvise,mprotect) the impact is minimal
>> unless the code has to manipulate the page tables.
> 
> And how exactly are you going to do any of those operations _without_
> manipulating the page tables?

I agree, at one time the page tables would have to be manipulated, and this is
mostly done under the protection of the page table locks - should the mmap_sem
still being held then ?

I was thinking about all the processing done on the VMAs, accounting, etc.
That part, usually not manipulating the page tables, is less dependent of the
underlying page size.

But I agree at one time of the processing, the page table are manipulated and
dealing with larger pages is better then.

Thanks,
Laurent.

