Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC3AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602FD2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfA2Nca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:32:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbfA2Nca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:32:30 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TDRPDI036358
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:32:28 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qaqp08h5k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:32:28 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Tue, 29 Jan 2019 13:32:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 13:32:23 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TDWMNS3801374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 13:32:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1267A4051;
        Tue, 29 Jan 2019 13:32:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B7EBA4057;
        Tue, 29 Jan 2019 13:32:21 +0000 (GMT)
Received: from [9.152.224.122] (unknown [9.152.224.122])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jan 2019 13:32:21 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v6 11/13] KVM: s390: add functions to (un)register GISC
 with GISA
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
 <20190124125939.130763-12-mimu@linux.ibm.com>
 <20190129140905.288d750a.cohuck@redhat.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Tue, 29 Jan 2019 14:32:21 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129140905.288d750a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012913-0008-0000-0000-000002B7771D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012913-0009-0000-0000-00002223B9DC
Message-Id: <b323fd49-0a72-fe78-0cdb-42a23f264811@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=930 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.01.19 14:09, Cornelia Huck wrote:
> On Thu, 24 Jan 2019 13:59:37 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> Add the Interruption Alert Mask (IAM) to the architecture specific
>> kvm struct. This mask in the GISA is used to define for which ISC
>> a GIB alert will be issued.
>>
>> The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
>> are used to (un)register a GISC (guest ISC) with a virtual machine and
>> its GISA.
>>
>> Upon successful completion, kvm_s390_gisc_register() returns the
>> ISC to be used for GIB alert interruptions. A negative return code
>> indicates an error during registration.
>>
>> Theses functions will be used by other adapter types like AP and PCI to
>> request pass-through interruption support.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |  13 +++++
>>   arch/s390/kvm/interrupt.c        | 117 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 130 insertions(+)
>>
> 
>> +int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
>> +{
>> +	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
>> +	u8 alert_mask;
>> +
>> +	if (!gi->origin)
>> +		return -ENODEV;
>> +	if (gisc > MAX_ISC)
>> +		return -ERANGE;
>> +
>> +	spin_lock(&gi->alert.ref_lock);
>> +	if (gi->alert.ref_count[gisc] == 0) {
> 
> If the ref_count is 0 here...
> 
>> +		alert_mask = gi->alert.mask | 0x80 >> gisc;
>> +		WRITE_ONCE(gi->alert.mask, alert_mask);
>> +	}
>> +	gi->alert.ref_count[gisc]++;
>> +	if (gi->alert.ref_count[gisc] == 1)
> 
> ...it will certainly be 1 here, won't it?

Sure, the increment is unconditional and can be done right away.
Thus it is logically the same and now symmetric to the unregister
function:

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index ba314da746b7..f37dfb01c63c 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2976,11 +2976,11 @@ int kvm_s390_gisc_register(struct kvm *kvm, u32 
gisc)
                 return -ERANGE;

         spin_lock(&gi->alert.ref_lock);
-       if (gi->alert.ref_count[gisc] == 0)
-               gi->alert.mask |= 0x80 >> gisc;
         gi->alert.ref_count[gisc]++;
-       if (gi->alert.ref_count[gisc] == 1)
+       if (gi->alert.ref_count[gisc] == 1) {
+               gi->alert.mask |= 0x80 >> gisc;
                 gisa_set_iam(gi->origin, gi->alert.mask);
+       }
         spin_unlock(&gi->alert.ref_lock);

         return gib->nisc;


> 
> Can you do all of the manipulations in a single if branch?
> 
>> +		gisa_set_iam(gi->origin, alert_mask);
>> +	spin_unlock(&gi->alert.ref_lock);
>> +
>> +	return gib->nisc;
>> +}
> 

Thanks,
Michael

