Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14F4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8764208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8764208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933016AbeGCPRh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:17:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933768AbeGCPRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:17:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63FEx65041192
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 11:17:32 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0a3hn08c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 11:17:32 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 3 Jul 2018 11:17:31 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 11:17:27 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63FHPiI51773534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:17:25 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97E1228064;
        Tue,  3 Jul 2018 11:16:58 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F27CE2805C;
        Tue,  3 Jul 2018 11:16:57 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.218])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 11:16:57 -0400 (EDT)
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
To:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
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
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <49b11ac2-2230-ad74-1583-c6a57f8b31e3@linux.ibm.com>
 <6a330cae-2fe2-54df-edce-c3360117cf3c@linux.ibm.com>
 <13998e79-9bae-5c55-b83d-85e6db8d3b99@linux.ibm.com>
 <20180703135205.2ebb107f.cohuck@redhat.com>
 <18532145-abeb-1251-926e-edbc6fa0bcb0@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 3 Jul 2018 11:17:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <18532145-abeb-1251-926e-edbc6fa0bcb0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070315-0068-0000-0000-0000031276B9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009301; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055991; UDB=6.00541662; IPR=6.00833914;
 MB=3.00021977; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 15:17:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070315-0069-0000-0000-000044E64A4E
Message-Id: <a48a3086-07ff-5519-9820-8067c4e29f44@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 08:20 AM, Halil Pasic wrote:
>
>
> On 07/03/2018 01:52 PM, Cornelia Huck wrote:
>> On Tue, 3 Jul 2018 11:22:10 +0200
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
> [..]
>>>
>>> Let me try to invoke the DASD analogy. If one for some reason wants 
>>> to detach
>>> a DASD the procedure to follow seems to be (see
>>> https://www.ibm.com/support/knowledgecenter/en/linuxonibm/com.ibm.linux.z.lgdd/lgdd_t_dasd_online.html) 
>>>
>>> the following:
>>> 1) Unmount.
>>> 2) Offline possibly using safe_offline.
>>> 3) Detach.
>>>
>>> Detaching a disk that is currently doing I/O asks for trouble, so 
>>> the admin is encouraged
>>> to make sure there is no pending I/O.
>>
>> I don't think we can use dasd (block devices) as a good analogy for
>> every kind of device (for starters, consider network devices).
>>
>
> I did not use it for every kind of device. I used it for AP. I'm
> under the impression you find the analogy inappropriate. If, could
> you please explain why?
>
>>> In case of AP you can interpret my 'in use' as the queue is not 
>>> empty. In my understanding
>>> unbind is supposed to be hard (I used the word radical). That's why 
>>> I compared it to pulling
>>> a cable. So that's why I ask is there stuff the admin is supposed to 
>>> do before doing the
>>> unbind.
>>
>> Are you asking for a kind of 'quiescing' operation? I would hope that
>> the crypto drivers already can deal with that via flushing the queue,
>> not allowing new requests, or whatever. This is not the block device
>> case.
>>
>
> The current implementation of vfio-ap which is a crypto driver too 
> certainly
> can not deal 'with that'. Whether the rest of the drivers can, I don't
> know. Maybe Tony can tell.

As stated in the cover letter, unbinding a queue from the vfio-ap device
driver is akin to a hot unplug. Hot plug/unplug is one of the goals of
the next patch series.

>
>
> I'm aware of the fact that AP adapters are not block devices. But
> as stated above I don't understand what is the big difference regarding
> the unbind operation.
>
>> Anyway, this is an administrative issue. If you don't have a clear
>> concept which devices are for host usage and which for guest usage, you
>> already have problems.
>
> I'm trying to understand the whole solution. I agree, this is an 
> administrative
> issue. But the document is trying to address such administrative issues.

This section of the document is intended to describe how to provision AP 
queues
for dedicated guest usage and to show the relationship between the 
various objects
involved. While it does administrative actions, it is not intended to be an
administrator's guide.


>
>>
>> Speaking of administrative issues, is there libvirt support for vfio-ap
>> under development? It would be helpful to validate the approach.
>
> I full-heartedly agree. I guess Tony will have to answer this one too.
>
> Regards,
> Halil


