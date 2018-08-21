Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC05C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B3E217B4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B3E217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeHVCkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 22:40:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727053AbeHVCkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 22:40:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LN9g53137368
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 19:18:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m0r8vgtkj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 19:18:30 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 22 Aug 2018 00:18:27 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 00:18:24 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7LNINom34603242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Aug 2018 23:18:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38C7D4C044;
        Wed, 22 Aug 2018 02:18:25 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 444C34C04A;
        Wed, 22 Aug 2018 02:18:23 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.145.79.230])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 02:18:23 +0100 (BST)
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
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
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Wed, 22 Aug 2018 01:18:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <82a391ee-85b1-cdc7-0f9b-d37fd8ba8e47@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082123-4275-0000-0000-000002AD56AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082123-4276-0000-0000-000037B65946
Message-Id: <a43ef10f-aa91-cb4c-a8aa-cd3ce9cfebf2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/21/2018 07:07 PM, Tony Krowiak wrote:
> On 08/21/2018 11:25 AM, Cornelia Huck wrote:
>> On Mon, 20 Aug 2018 13:41:32 -0400
>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>
>>> On 08/20/2018 10:23 AM, Cornelia Huck wrote:
>>>> On Mon, 13 Aug 2018 17:48:09 -0400
>>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>>
>>>>> Provides the sysfs interfaces for:
>>>>>
>>>>> 1. Assigning AP control domains to the mediated matrix device
>>>>>
>>>>> 2. Unassigning AP control domains from a mediated matrix device
>>>>>
>>>>> 3. Displaying the control domains assigned to a mediated matrix
>>>>>      device
>>>>>
>>>>> The IDs of the AP control domains assigned to the mediated matrix
>>>>> device are stored in an AP domain mask (ADM). The bits in the ADM,
>>>>> from most significant to least significant bit, correspond to
>>>>> AP domain numbers 0 to 255. On some systems, the maximum allowable
>>>>> domain number may be less than 255 - depending upon the host's
>>>>> AP configuration - and assignment may be rejected if the input
>>>>> domain ID exceeds the limit.
>>>> Please remind me of the relationship between control domains and usage
>>>> domains... IIRC, usage domains allow both requests and configuration,
>>>> while control domains allow only configuration, and are by convention a
>>>> superset of usage domains.
>>> A usage domain is a domain to which an AP command-request message can be
>>> submitted for processing. A control domain is a domain that can
>>> be changed by an AP command request message submitted to a usage domain.
>>> AP command request messages to configure a domain will contain the domain
>>> number of the domain to be modified. The AP firmware will check the
>>> control domain mask (ADM) and will allow the request to proceed only if
>>> the corresponding bit in the ADM is set.
>> Thanks to you and Halil for the explanation.
>>
>>>> Is there a hard requirement somewhere in there, or can the admin
>>>> cheerfully use different masks for usage domains and control domains
>>>> without the SIE choking on it?
>>> There is no hard requirement that control domains must be a superset of
>>> the usage domains, it is merely an architectural convention. AFAIK,
>>> SIE doesn't enforce this and will not break if the convention is not
>>> enforced externally. Having said that, you should note that the AQM
>>> and ADM masks configured for the mediated matrix device will be logically
>>> OR'd together to create the ADM stored in the CRYCB referenced from the
>>> guest's SIE state description. In other words, we are enforcing the
>>> convention in our software.
>> Hm, that's interesting, as Halil argued that we should not enforce it
>> in the kernel. Might be somewhat surprising as well. If that is really
>> the way to do it, this needs to be documented clearly.
> 
> This convention has been enforced by the kernel since v1. This is also
> enforced by both the LPAR as well as in z/VM. The following is from the
> PR/SM Planning Guide:
> 
> Control Domain
> A logical partition's control domains are those cryptographic domains for which remote secure
> administration functions can be established and administered from this logical partition. This
> logical partition’s control domains must include its usage domains. For each index selected in the
> usage domain index list, you must select the same index in the control domain index list
> 

IMHO this quote is quite a half-full half-empty cup one:
* it mandates the set of usage domains is a subset of the set
of the control domains, but
* it speaks of independent controls, namely about the 'usage domain index'
and the 'control domain index list' and makes the enforcement of the rule
a job of the administrator (instead of codifying it in the controls).

> 
> Consequently, I'm going to opt for ensuring this is clearly documented. Based on the fact you've
> requested clarification of many points described in this section of the doc, I
> think I'll try putting my meager skills as a wordsmith to work to hopefully clarify things.
> I'll run it by you when I complete that task to see if I've succeeded:)

I don't think just a doc update will do. Let me explain why.

What describe as "... note that the AQM and ADM masks configured for the
mediated matrix device will be logically OR'd together to create the ADM
stored in the CRYCB referenced from the guest's SIE state description."
is a gotcha at best. The member of struct ap_matrix and the member of the
respective apcb in the crycb are both called 'adm', but ap_matrix.adm is
not an ADM as we know it from the architecture, but rather ~ AQM & ADM.

I feel pretty strongly about this one. If we want to keep the enforcement
in the kernel, I guess, the assign_domain should set the bit corresponding
bit not only in ap_matrix.aqm but also in ap_matrix.adm. When the
ap_matrix is committed into the crycb no further manipulating the masks
should take place.

I don't feel strongly about whether to enforce this convention about AQM
and ADM in the kernel or not. Frankly, I don't know what is behind the
rule. Since I can't tell if any problems are to be expected if this
convention is violated, I would feel more comfortable if the rule was
accommodated higher in the management stack.

Regards,
Halil

> 
>>
> 

