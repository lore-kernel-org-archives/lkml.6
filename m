Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9C7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEED2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfAGRiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:38:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726942AbfAGRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:38:11 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x07HULek146078
        for <linux-kernel@vger.kernel.org>; Mon, 7 Jan 2019 12:38:10 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pvb4c8r5p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 12:38:09 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mimu@linux.ibm.com>;
        Mon, 7 Jan 2019 17:38:07 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Jan 2019 17:38:05 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x07Hc3u749938528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 17:38:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 864CEAE04D;
        Mon,  7 Jan 2019 17:38:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 223CEAE05A;
        Mon,  7 Jan 2019 17:38:03 +0000 (GMT)
Received: from [9.152.96.120] (unknown [9.152.96.120])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Jan 2019 17:38:03 +0000 (GMT)
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v5 10/15] KVM: s390: add functions to (un)register GISC
 with GISA
To:     Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-11-mimu@linux.ibm.com>
 <bd1a6082-cb73-5ef7-f2b6-8cbd7d8c7136@linux.ibm.com>
 <20190104141836.0ca98a77.cohuck@redhat.com>
From:   Michael Mueller <mimu@linux.ibm.com>
Organization: IBM
Date:   Mon, 7 Jan 2019 18:38:02 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190104141836.0ca98a77.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19010717-0016-0000-0000-000002417F51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010717-0017-0000-0000-0000329B8EE7
Message-Id: <b001fc9b-c174-644f-a9fa-e60ff5b4aa58@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.01.19 14:19, Cornelia Huck wrote:
> On Wed, 2 Jan 2019 18:29:00 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 19/12/2018 20:17, Michael Mueller wrote:
>>> Add the IAM (Interruption Alert Mask) to the architecture specific
>>> kvm struct. This mask in the GISA is used to define for which ISC
>>> a GIB alert can be issued.
>>>
>>> The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
>>> are used to (un)register a GISC (guest ISC) with a virtual machine and
>>> its GISA.
>>>
>>> Upon successful completion, kvm_s390_gisc_register() returns the
>>> ISC to be used for GIB alert interruptions. A negative return code
>>> indicates an error during registration.
>>>
>>> Theses functions will be used by other adapter types like AP and PCI to
>>> request pass-through interruption support.
>>>
>>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>>> ---
>>>    arch/s390/include/asm/kvm_host.h |  9 ++++++
>>>    arch/s390/kvm/interrupt.c        | 66 ++++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 75 insertions(+)
>>>
> 
>>> +int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
>>> +{
>>> +	if (!kvm->arch.gib_in_use)
>>> +		return -ENODEV;
>>> +	if (gisc > MAX_ISC)
>>> +		return -ERANGE;
>>> +
>>> +	spin_lock(&kvm->arch.iam_ref_lock);
>>> +	if (kvm->arch.iam_ref_count[gisc] == 0)
>>> +		kvm->arch.iam |= 0x80 >> gisc;
>>> +	kvm->arch.iam_ref_count[gisc]++;
>>> +	if (kvm->arch.iam_ref_count[gisc] == 1)
>>> +		set_iam(kvm->arch.gisa, kvm->arch.iam);
>>
>> testing the set_iam return value?
>> Even it should be fine if the caller works correctly, this is done
>> before GISA is ever used.

There is a rc but a check here is not required.

There are three cases:

a) This is the first ISC that gets registered, then the GISA is
    not in use and IAM is set in the GISA.

b) A second ISC gets registered and the GISA is *not* in the
    alert list. Then the IAM is set here as well.

c) A second ISC gets registered and the GISA is in the
    alert list. Then the IAM is intentionally not set here
    by set_iam(). It will be restored by get_ipm() with
    the new IAM value by the gib alert processing code.


> 
> My feeling is that checking the return code is a good idea, even if it
> Should Never Fail(tm).
> 
>>
>>> +	spin_unlock(&kvm->arch.iam_ref_lock);
>>> +
>>> +	return gib->nisc;
>>> +}
>>> +EXPORT_SYMBOL_GPL(kvm_s390_gisc_register);
>>> +
>>> +int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc)
>>> +{
>>> +	int rc = 0;
>>> +
>>> +	if (!kvm->arch.gib_in_use)
>>> +		return -ENODEV;
>>> +	if (gisc > MAX_ISC)
>>> +		return -ERANGE;
>>> +
>>> +	spin_lock(&kvm->arch.iam_ref_lock);
>>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
>>> +		rc = -EINVAL;
>>> +		goto out;
>>> +	}
>>> +	kvm->arch.iam_ref_count[gisc]--;
>>> +	if (kvm->arch.iam_ref_count[gisc] == 0) {
>>> +		kvm->arch.iam &= ~(0x80 >> gisc);
>>> +		set_iam(kvm->arch.gisa, kvm->arch.iam);
> 
> Any chance of this function failing here? If yes, would there be any
> implications?

It is the same here.

> 
>>> +	}
>>> +out:
>>> +	spin_unlock(&kvm->arch.iam_ref_lock);
>>> +
>>> +	return rc;
>>> +}
>>> +EXPORT_SYMBOL_GPL(kvm_s390_gisc_unregister);
>>> +
>>>    void kvm_s390_gib_destroy(void)
>>>    {
>>>    	if (!gib)
>>>    
>>
>>
> 

