Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5C3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11462089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11462089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeIZCEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:04:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727333AbeIZCD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:03:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PJrrcf030463
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 15:54:49 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mqujyr1eg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 15:54:48 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 25 Sep 2018 15:54:47 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Sep 2018 15:54:43 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8PJsfHO26607712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Sep 2018 19:54:41 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C60812405A;
        Tue, 25 Sep 2018 16:54:46 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FCF4124055;
        Tue, 25 Sep 2018 16:54:45 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Sep 2018 16:54:45 -0400 (EDT)
Subject: Re: [PATCH v10 11/26] s390: vfio-ap: implement mediated device open
 callback
To:     David Hildenbrand <david@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <e1ff9918-a1ab-31b1-0b32-a3980770d2ac@linux.ibm.com>
 <09a6b9e5-e335-14cf-debd-de0f92dafd5e@redhat.com>
 <ebe81ebf-9b61-dbf6-743e-6145162cdcfb@linux.ibm.com>
 <69b5e3d3-5d44-37c0-ca10-720345852134@redhat.com>
 <df269178-b486-b091-4da4-731fc3f77e85@linux.ibm.com>
 <a59965e3-0624-65e7-f1dd-8656219dcbe2@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 25 Sep 2018 15:54:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <a59965e3-0624-65e7-f1dd-8656219dcbe2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092519-2213-0000-0000-000002F6082D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009770; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093575; UDB=6.00565225; IPR=6.00873611;
 MB=3.00023500; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-25 19:54:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092519-2214-0000-0000-00005BAD8FEE
Message-Id: <1a457c48-35f3-cb73-4db8-d3b50a82f211@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809250195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 03:55 PM, David Hildenbrand wrote:
> On 24/09/2018 21:46, Tony Krowiak wrote:
>> On 09/24/2018 02:40 PM, David Hildenbrand wrote:
>>> On 24/09/2018 18:07, Tony Krowiak wrote:
>>>> On 09/24/2018 04:40 AM, David Hildenbrand wrote:
>>>>>
>>>>>>      /**
>>>>>> - * Verify that the AP instructions are available on the guest. This is
>>>>>> indicated
>>>>>> - * via the  KVM_S390_VM_CPU_FEAT_AP CPU model feature.
>>>>>> + * Verify that the AP instructions are being interpreted by firmware
>>>>>> for the
>>>>>> + * guest. This is indicated by the kvm->arch.crypto.apie flag.
>>>>>>       */
>>>>>>      static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
>>>>>>      {
>>>>>> -	if (test_bit_inv(KVM_S390_VM_CPU_FEAT_AP, kvm->arch.cpu_feat))
>>>>>> +	if (kvm->arch.crypto.apie)
>>>>>>      		return 0;
>>>>>
>>>>> I wonder if this check makes sense, because apie can be toggled during
>>>>> runtime. I guess it would be sufficient to check if the ap control block
>>>>> is available and apie is supported by the HW.
>>>>
>>>> I am not clear about what you are getting at here, but I'll attempt
>>>> to respond. There is no need to check if the AP control block (CRYCB)
>>>> is available as the address is set in the CRYCBD three instructions
>>>> above, even if AP instructions are not available. Regarding whether apie
>>>> is supported by the hardware, the value of vcpu->kvm->arch.crypto.apie
>>>> can not be set unless it is supported by the HW. In the patch (24/26)
>>>> that provides the VM attributes to toggle this value, it can only be
>>>> turned on if the AP instructions are available. I might also note that
>>>> the kvm_ap_validate_crypto_setup() function is called whenever one of
>>>> the VM crypto attributes is changed, so it makes sense that decisions
>>>> made in this function are based on a change to a VM crypto attribute. In
>>>> my first pass at changing this function, I checked
>>>> ap_instructions_available() here, but after considering all of the
>>>> above, it made sense to me to check the apie flag.
>>>>
>>>
>>> I prefer ap_instructions_available(). As I said, kvm->arch.crypto.apie
>>> is a moving target.
>>
>> Looking at this again, I think I responded before my brain shifted from
>> digesting comments about patch 24/26 (enable/disable APIE) to the
>> context for your comment here; namely, the device open callback. My
>> comment above makes no sense in this context. From the perspective of
>> the vfio_ap device driver, there is one requirement that must be met in
>> order to provide pass-through functionality: The AP instructions must be
>> must be interpreted by the HW (i.e., ECA.28 == 1). Checking whether AP
>> instructions are available does not tell us whether they are being
>> interpreted by HW. Checking whether the AP control block (i.e., CRYCB)
>> is available, even when combined with the instruction availability
>> check, does not provide any more insight into the value of ECA.28
>> becuase the CRYCB will be provided if the MSAX3 facility is installed
>> (STFLE.76) for the guest regardless of whether AP instructions are
>> available or not. There is no doubt that if the AP instructions are
>> not available, then the mdev open callback should fail, but it doesn't
>> tell the whole story.
>>
>> I realize that our CPU model protects against configuring a vfio-ap
>> device for the guest if ap=off, but this function knows nothing about
>> userspace. I can make a similar argument that kvm->arch.crypto.apie
>> will be switched on only if ap=on but again, that is userspace
>> configuration.
>>
>> Having said all of the above, maybe it doesn't really matter whether
>> AP instructions are being interpreted or not. If ECA.28 == 0, then
>> the AP masks may very well be ignored since all AP instructions will
>> be intercepted; so, maybe checking AP instruction availability is all
>> that is needed. I will verify this and if I'm correct, I'll make the
>> change you suggested.
> 
> Yes, that was exactly what I had in mind - we just have to make sure
> that the ap control block exists, so we can set the right mask bits. If
> QEMU asks for an intercept, it shall get an intercept.
> 
> But please proceed with whatever you think is best!

After discussing this with Halil, here's what I decided:
* There will be no check for kvm->arch.crypto.apie here
* A check for ap_instructions_available() will not be executed
   here, but inserted into the vfio_ap module init function.
   The module init function will fail (ENODEV) if the AP
   instructions are not installed. In my (our) opinion that
   makes more sense given the purpose of the vfio_ap driver is
   to pass through the AP instructions to the guest.
* A check will be added here to verify the CRYCB is available (i.e.,
   matrix_mdev->kvm->arch.crypto.crycbd != 0).


> 
> 

