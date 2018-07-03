Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BB1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD769247B3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD769247B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932208AbeGCN6s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:58:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753381AbeGCN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:58:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63DshNi063819
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 09:58:46 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0a9jgjhf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 09:58:45 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 3 Jul 2018 14:58:43 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 14:58:40 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63DwdFv18350102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 13:58:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C7C1A4055;
        Tue,  3 Jul 2018 16:59:04 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20E64A4057;
        Tue,  3 Jul 2018 16:59:03 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.224.39])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 16:59:03 +0100 (BST)
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
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
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <49b11ac2-2230-ad74-1583-c6a57f8b31e3@linux.ibm.com>
 <6a330cae-2fe2-54df-edce-c3360117cf3c@linux.ibm.com>
 <13998e79-9bae-5c55-b83d-85e6db8d3b99@linux.ibm.com>
 <20180703135205.2ebb107f.cohuck@redhat.com>
 <18532145-abeb-1251-926e-edbc6fa0bcb0@linux.ibm.com>
 <20180703152557.08d10223.cohuck@redhat.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Tue, 3 Jul 2018 15:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703152557.08d10223.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070313-0016-0000-0000-000001E2EE08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070313-0017-0000-0000-000032374CA0
Message-Id: <99aabca1-76ba-1a9e-256d-0e234a3ac28f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2018 03:25 PM, Cornelia Huck wrote:
> On Tue, 3 Jul 2018 14:20:11 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 07/03/2018 01:52 PM, Cornelia Huck wrote:
>>> On Tue, 3 Jul 2018 11:22:10 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    
>> [..]
>>>>
>>>> Let me try to invoke the DASD analogy. If one for some reason wants to detach
>>>> a DASD the procedure to follow seems to be (see
>>>> https://www.ibm.com/support/knowledgecenter/en/linuxonibm/com.ibm.linux.z.lgdd/lgdd_t_dasd_online.html)
>>>> the following:
>>>> 1) Unmount.
>>>> 2) Offline possibly using safe_offline.
>>>> 3) Detach.
>>>>
>>>> Detaching a disk that is currently doing I/O asks for trouble, so the admin is encouraged
>>>> to make sure there is no pending I/O.
>>>
>>> I don't think we can use dasd (block devices) as a good analogy for
>>> every kind of device (for starters, consider network devices).
>>>    
>>
>> I did not use it for every kind of device. I used it for AP. I'm
>> under the impression you find the analogy inappropriate. If, could
>> you please explain why?
> 
> I don't think block devices (which are designed to be more or less
> permanently accessed, e.g. by mounting a file system) have the same
> semantics as ap devices (which exist as a backend for crypto requests).
> Not everything that makes sense for a block device makes sense for
> other devices as well, and I don't think it makes sense here.
> 

I'm still confused. If it's about frequency of access (as hinted
by block devices accessed more or less permanently) I'm not sure
there is a substantial difference. I guess there are scenarios where
the AP domain is used very seldom (e.g. protected keys --> most of
the crypto ops done by CPACF but AP unwraps at the beginning), but
there are such scenarios for block too.

If it's about (persistent) state, I guess it again depends on the
scenario and on the type of the card. But I may be wrong.

>>
>>>> In case of AP you can interpret my 'in use' as the queue is not empty. In my understanding
>>>> unbind is supposed to be hard (I used the word radical). That's why I compared it to pulling
>>>> a cable. So that's why I ask is there stuff the admin is supposed to do before doing the
>>>> unbind.
>>>
>>> Are you asking for a kind of 'quiescing' operation? I would hope that
>>> the crypto drivers already can deal with that via flushing the queue,
>>> not allowing new requests, or whatever. This is not the block device
>>> case.
>>>    
>>
>> The current implementation of vfio-ap which is a crypto driver too certainly
>> can not deal 'with that'. Whether the rest of the drivers can, I don't
>> know. Maybe Tony can tell.
> 
> If the current implementation of vfio-ap cannot deal with it (by
> cleaning up, blocking, etc.), it needs at the very least be documented
> so that it can be implemented later. I do not know what the SIE will or
> won't do to assist here (e.g., if you're removing it from some masks,
> the device will already be inaccessible to the guest). But the part you
> were referring to was talking about the existing host driver anyway,
> wasn't it?
> 

I was thinking about both directions. Re-classifying a device form
pass-through to normal should also be possible. But the document only
talks about one direction.

I'm not familiar with the existing host drivers. If we can say 'Hey,
unbind is perfectly safe at any time: no per-cautions need to be considered!'
I'm very happy with that. Although I would find it a bit surprising.

I just wanted to make sure this is not something we forget.

>>
>> I'm aware of the fact that AP adapters are not block devices. But
>> as stated above I don't understand what is the big difference regarding
>> the unbind operation.
>>
>>> Anyway, this is an administrative issue. If you don't have a clear
>>> concept which devices are for host usage and which for guest usage, you
>>> already have problems.
>>
>> I'm trying to understand the whole solution. I agree, this is an administrative
>> issue. But the document is trying to address such administrative issues.
> 
> I'd assume "know which devices are for the host and which devices are
> for the guests" to be a given, no?
> 

My other email scratches this topic. AFAIK we don't have a solution for
that yet. Nor we have a good understanding of how and to what extent
is statically given what is given. E.g. if one wants to re-partition my AP
resources (and at some point one will have to at least do the initial
re-partitioning) do I need a reboot for the changes to take effect? Or
is this 'known' variable during the uptime of an OS.

@Tony: Please feel free to fill the gaps in my understanding.

Regards,
Halil

