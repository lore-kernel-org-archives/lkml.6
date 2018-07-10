Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4365C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7270320871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7270320871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeGJItY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:49:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751212AbeGJItV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:49:21 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6A8iMf2075341
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 04:49:21 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k4qt20wgp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 04:49:20 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 10 Jul 2018 09:49:19 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 09:49:16 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6A8nE9T41615550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 08:49:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3780011C05B;
        Tue, 10 Jul 2018 11:49:32 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6612D11C04A;
        Tue, 10 Jul 2018 11:49:31 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 11:49:31 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
To:     Halil Pasic <pasic@linux.ibm.com>,
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
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <753c5e17-c241-580d-6e3a-a3c3159d44a8@linux.ibm.com>
 <0580735b-8813-f860-a2ac-654d82203b35@linux.ibm.com>
 <2e30976a-a2d0-c407-c491-acde565b63f1@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 10 Jul 2018 10:49:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2e30976a-a2d0-c407-c491-acde565b63f1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18071008-0016-0000-0000-000001E5269A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071008-0017-0000-0000-00003239AAE0
Message-Id: <fa82b7e9-b6c5-440e-422d-cf3ad8c08757@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 17:50, Halil Pasic wrote:
>
>
> On 07/09/2018 05:21 AM, Pierre Morel wrote:
>> On 03/07/2018 01:10, Halil Pasic wrote:
>>>
>>>
>>> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>>>> This patch provides documentation describing the AP architecture and
>>>> design concepts behind the virtualization of AP devices. It also
>>>> includes an example of how to configure AP devices for exclusive
>>>> use of KVM guests.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>
>>> I don't like the design of external interfaces except for:
>>> * cpu model features, and
>>> * reset handling.
>>>
>>> In particular:
>>>
>>>
>> ...snip...
>>
>>> 4) If I were to act out the role of the administrator, I would 
>>> prefer to think of
>>> specifying or changing the access controls of a guest in respect to 
>>> AP (that is
>>> setting the AP matrix) as a single atomic operation -- which either 
>>> succeeds or fails.
>>>
>>> The operation should succeed for any valid configuration, and fail 
>>> for any invalid
>>> on.
>>>
>>> The current piecemeal approach seems even less fitting if we 
>>> consider changing the
>>> access controls of a running guest. AFAIK changing access controls 
>>> for a running
>>> guest is possible, and I don't see a reason why should we 
>>> artificially prohibit this.
>>>
>>> I think the current sysfs interface for manipulating the matrix is 
>>> good for
>>> manual playing around, but I would prefer having an interface that 
>>> is better
>>> suited for programs (e.g. ioctl).
>>
>> I disagree with using ioctl.
>
> Why? What speaks against ioctl?

Using a sysfs interface is easy and can be done using any interpreted 
language.
It has become the standard way to configure drivers.
Even the existing interface must be consolidated, it exist and is 
functional.


For what I understood, the problem is to have an atomic update of the 
matrix to avoid possible dead-lock
when two admin tasks try to configure a matrix for a guest.

The problematic is a userland problem it is not a kernel problem.

We have several possibilities to avoid this problem but  still keep a 
sysfs interface:
- the admin tasks may use a lock
- the admin task may use a policy like freeing owned resources if they 
can not get all resources.

Using a step by step configuration allows to easily know the missing 
resource in case of failure.

Regards,

Pierre


>
>> I agree that the current implementation is not right.
>> The configuration of APM and AQM should always be guarantied as coherent
>> within the host but it can be done doing the right checks when using 
>> the sysfs.
>>
>
> I'm glad we agree on this one at least.
>
> Regards,
> Halil


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

