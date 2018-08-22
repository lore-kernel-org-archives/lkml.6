Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC66C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1BA20C07
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1BA20C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeHVOHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:07:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728385AbeHVOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:07:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7MAdg4G040132
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 06:43:14 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m13spnbwg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 06:43:14 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 22 Aug 2018 11:43:12 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 11:43:08 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7MAh64I43450494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 10:43:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A743A404D;
        Wed, 22 Aug 2018 13:43:06 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F624A405F;
        Wed, 22 Aug 2018 13:43:04 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.145.189.122])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 13:43:04 +0100 (BST)
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820162317.08bd7d23.cohuck@redhat.com>
 <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
 <20180821172548.57a6c758.cohuck@redhat.com>
 <82a391ee-85b1-cdc7-0f9b-d37fd8ba8e47@linux.ibm.com>
 <a43ef10f-aa91-cb4c-a8aa-cd3ce9cfebf2@linux.ibm.com>
 <20180822114250.59a250aa.cohuck@redhat.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Wed, 22 Aug 2018 12:43:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180822114250.59a250aa.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082210-0016-0000-0000-000001FA2009
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082210-0017-0000-0000-000032507458
Message-Id: <c9fddc44-4f9f-051f-d73c-6a68336dae8f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/22/2018 11:42 AM, Cornelia Huck wrote:
> On Wed, 22 Aug 2018 01:18:20 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 08/21/2018 07:07 PM, Tony Krowiak wrote:
>>> This convention has been enforced by the kernel since v1. This is also
>>> enforced by both the LPAR as well as in z/VM. The following is from the
>>> PR/SM Planning Guide:
>>>
>>> Control Domain
>>> A logical partition's control domains are those cryptographic domains for which remote secure
>>> administration functions can be established and administered from this logical partition. This
>>> logical partition’s control domains must include its usage domains. For each index selected in the
>>> usage domain index list, you must select the same index in the control domain index list
>>>    
> 
> That's interesting.
> 
>>
>> IMHO this quote is quite a half-full half-empty cup one:
>> * it mandates the set of usage domains is a subset of the set
>> of the control domains, but
>> * it speaks of independent controls, namely about the 'usage domain index'
>> and the 'control domain index list' and makes the enforcement of the rule
>> a job of the administrator (instead of codifying it in the controls).
> 
> I'm wondering if a configuration with a usage domain that is not also a
> control domain is rejected outright? Anybody tried that? :)
> 

I did not. This is my first exposure to the PR/SM Planning Guide. As I
stated previously the HMC interface enforces the convention by UI design:
in the activation profile you can either configure a domain as 'control' or
'control and usage' domain -- think radio button. I have no idea how
is this information feed into PR/SM and same goes for alternatives to
specify it. So I'm also very curious about this.

Another interesting question: On what level does z/VM and PR/SM
enforce the convention (i.e. on privilege level does the code
doing the enforcement run)?

>>
>>>
>>> Consequently, I'm going to opt for ensuring this is clearly documented. Based on the fact you've
>>> requested clarification of many points described in this section of the doc, I
>>> think I'll try putting my meager skills as a wordsmith to work to hopefully clarify things.
>>> I'll run it by you when I complete that task to see if I've succeeded:)
>>
>> I don't think just a doc update will do. Let me explain why.
>>
>> What describe as "... note that the AQM and ADM masks configured for the
>> mediated matrix device will be logically OR'd together to create the ADM
>> stored in the CRYCB referenced from the guest's SIE state description."
>> is a gotcha at best. The member of struct ap_matrix and the member of the
>> respective apcb in the crycb are both called 'adm', but ap_matrix.adm is
>> not an ADM as we know it from the architecture, but rather ~ AQM & ADM.
>>
>> I feel pretty strongly about this one. If we want to keep the enforcement
>> in the kernel, I guess, the assign_domain should set the bit corresponding
>> bit not only in ap_matrix.aqm but also in ap_matrix.adm. When the
>> ap_matrix is committed into the crycb no further manipulating the masks
>> should take place.
> 
> Would you be fine if the control domain interface stated that it is
> used to configure _additional_ control domains and the usage domain
> interface stated that it is used to define usage and implicitly also
> control domains? (And make the usage domain interface also set the
> equivalent bit in the control domain mask.)
> 

I'm fine with the interface, otherwise I would not have r-b-ed the patch.
What I strongly dislike is the implementation is IMHO very confusing (along
the lines "surprise, surprise it is called adm but it ain't adm"). This
implementation detail however can be changed any time, so I did not want
to start a big discussion as we wanted to get this out ASAP. But since
it was brought up, I decided to put in my two cents.

>>
>> I don't feel strongly about whether to enforce this convention about AQM
>> and ADM in the kernel or not. Frankly, I don't know what is behind the
>> rule. Since I can't tell if any problems are to be expected if this
>> convention is violated, I would feel more comfortable if the rule was
>> accommodated higher in the management stack.
> 
> I guess it depends:
> 
> - If this is a case of: "Don't configure control domains that are not
>    also usage domains. You are likely to go through
>    {code,firmware,hardware} paths that are generally not used.",
>    configure it in the kernel.
> - If this rather is "Everybody is doing that, it's a general
>    convention.", configure it higher up in the stack (libvirt?)
> 

My guess is that it's the second, but I really don't know. Maybe
somebody else will help us answer this question, and also tell
what is the rationale behind the rule.

Regards,
Halil

