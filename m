Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036B8ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC7320684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC7320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeKIDiK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:38:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726672AbeKIDiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:38:10 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8HxHJ6016094
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 13:01:30 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nmrc5cv10-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 13:01:29 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 8 Nov 2018 18:01:27 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 18:01:25 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8I1Oe73473792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 18:01:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D5DEA4055;
        Thu,  8 Nov 2018 18:01:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3918A405D;
        Thu,  8 Nov 2018 18:01:23 +0000 (GMT)
Received: from [9.148.204.197] (unknown [9.148.204.197])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 18:01:23 +0000 (GMT)
Date:   Thu, 08 Nov 2018 20:01:21 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20181108175217.f55065d6115edbafd6aa3487@suse.de>
References: <20181108144428.28149-1-tbogendoerfer@suse.de> <20181108161823.GB15707@rapoport-lnx> <20181108175217.f55065d6115edbafd6aa3487@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [[PATCH]] mips: Fix switch to NO_BOOTMEM for SGI-IP27/loongons3 NUMA
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, rppt@linux.vnet.ibm.com
From:   Mike Rapoport <rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18110818-4275-0000-0000-000002DD66E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110818-4276-0000-0000-000037EA8DB9
Message-Id: <43783525-DEC2-46A5-A61E-4C3BF3DDE4A0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 8, 2018 6:52:17 PM GMT+02:00, Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:
>On Thu, 8 Nov 2018 18:18:23 +0200
>Mike Rapoport <rppt@linux.ibm.com> wrote:
>
>> On Thu, Nov 08, 2018 at 03:44:28PM +0100, Thomas Bogendoerfer wrote:
>> > Commit bcec54bf3118 ("mips: switch to NO_BOOTMEM") broke SGI-IP27
>> > and NUMA enabled loongson3 by doing memblock_set_current_limit()
>> > before max_low_pfn has been evaluated. Both platforms need to do
>the
>> > memblock_set_current_limit() in platform specific code. For
>> > consistency the call to memblock_set_current_limit() is moved
>> > to the common bootmem_init(), where max_low_pfn is calculated
>> > for non NUMA enabled platforms.
>> [..]
>> 
>> As for SGI-IP27, the initialization of max_low_pfn as late as in
>> paging_init() seems to be broken because it's value is used in
>> arch_mem_init() and in finalize_initrd() anyway.
>
>well, the patch is tested on real hardware and the first caller of
>a memblock_alloc* function is in a function called by
>free_area_init_nodes().
 
Then, apparently, I've missed something else.
The Onyx2 I worked on is dead for a couple of years now ;-)

>> AFAIU, both platforms set max_low_pfn to last available pfn, so it
>seems we
>> can simply do
>> 
>> 	max_low_pfn = PFN_PHYS(memblock_end_of_DRAM())
>>

Should have been PHYS_PFN, sorry.

>> in the prom_meminit() function for both platforms and drop the loop
>> evaluating max_low_pfn in paging_init().
>
>sounds like a better plan. I'll prepare a new patch.
>
>Thomas.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

