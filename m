Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C23DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319A7218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfAXPYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:24:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727955AbfAXPYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:24:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OFJ8j6029482
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:24:42 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q7f3akhbs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:24:42 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 24 Jan 2019 15:24:39 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 24 Jan 2019 15:24:30 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0OFOSL649741888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 15:24:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB9A211C054;
        Thu, 24 Jan 2019 15:24:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7376F11C05B;
        Thu, 24 Jan 2019 15:24:28 +0000 (GMT)
Received: from [9.152.224.122] (unknown [9.152.224.122])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Jan 2019 15:24:28 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v6 07/13] KVM: s390: introduce struct
 kvm_s390_gisa_interrupt
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
 <20190124125939.130763-8-mimu@linux.ibm.com>
 <20190124160637.0f8b47a7.cohuck@redhat.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Thu, 24 Jan 2019 16:24:28 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124160637.0f8b47a7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012415-4275-0000-0000-00000303A034
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012415-4276-0000-0000-00003811D8AF
Message-Id: <a9f57ea6-4f87-3af0-46c9-695708f98649@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=552 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.01.19 16:06, Cornelia Huck wrote:
> On Thu, 24 Jan 2019 13:59:33 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> Use this struct analog to the kvm interruption structs
>> for kvm emulated floating and local interruptions.
> 
> I guess that makes sense.
> 
>> Further fields will be added with this series as
>> required.
> 
> A reference to "this series" will look a bit strange if you look at the
> committed patch later. What about:
> 
> "GIB handling will add further fields to this structure as required."

Yes, that reads pretty well. I will replace the sentence.

> 
> ?
> 
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |  6 ++++-
>>   arch/s390/kvm/interrupt.c        | 52 +++++++++++++++++++++++-----------------
>>   arch/s390/kvm/kvm-s390.c         |  2 +-
>>   3 files changed, 36 insertions(+), 24 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

