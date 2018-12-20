Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFBCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D7121720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbeLTHtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:49:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727990AbeLTHtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:49:41 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBK7i6FQ021483
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 02:49:39 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pg5cs4ccv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 02:49:39 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 20 Dec 2018 07:49:37 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Dec 2018 07:49:34 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBK7nXm142664090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 07:49:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6C425205A;
        Thu, 20 Dec 2018 07:49:32 +0000 (GMT)
Received: from [9.152.224.123] (unknown [9.152.224.123])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 939CD52051;
        Thu, 20 Dec 2018 07:49:32 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v5 01/15] KVM: s390: unregister debug feature on failing
 arch init
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
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-2-mimu@linux.ibm.com>
 <20181219210934.2f370eb7.cohuck@redhat.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Thu, 20 Dec 2018 08:49:32 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181219210934.2f370eb7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18122007-0012-0000-0000-000002DB9F95
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122007-0013-0000-0000-000021114001
Message-Id: <4ce0210a-e054-16e6-3089-278ecb3ef5ea@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-20_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.12.18 21:10, Cornelia Huck wrote:
> On Wed, 19 Dec 2018 20:17:42 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> Make sure the debug feature and its allocated resources get
>> released upon unsuccessful architecture initialization.
>>
>> A related indication of the issue will be reported as kernel
>> message.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Message-Id: <20181130143215.69496-2-mimu@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   Documentation/kmsg/s390/kvm | 12 ++++++++++++
>>   arch/s390/kvm/kvm-s390.c    | 17 ++++++++++++++---
>>   2 files changed, 26 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/kmsg/s390/kvm
>>
>> diff --git a/Documentation/kmsg/s390/kvm b/Documentation/kmsg/s390/kvm
>> new file mode 100644
>> index 000000000000..76ffe2012254
>> --- /dev/null
>> +++ b/Documentation/kmsg/s390/kvm
>> @@ -0,0 +1,12 @@
>> +/*?
>> + * Text: "Failed to register FLIC rc=%d\n"
>> + * Severity: Error
>> + * Parameter:
>> + *   @1: return code of the FLIC registration call
>> + * Description:
>> + * The registration of the FLIC (Floating Interrupt Controller Interface)
>> + * was not successful.
>> + * User action:
>> + * If this problem persists after a reload of the kvm kernel module, gather
>> + * Linux debug data and contact your support organization.
>> + */
> 
> Hm, it seems that the kmsg stuff crept in there again...
> 

picked from wrong branch, sorry...

