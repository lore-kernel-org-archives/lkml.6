Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C47AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D370208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D370208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeH0T0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:26:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727056AbeH0T0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:26:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7RFYNCK075645
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:39:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m4kft9ujk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:39:23 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 27 Aug 2018 16:39:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Aug 2018 16:39:18 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7RFdHJR39518230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Aug 2018 15:39:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EC274C040;
        Mon, 27 Aug 2018 18:39:16 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E9B14C050;
        Mon, 27 Aug 2018 18:39:13 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.145.32.43])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Aug 2018 18:39:13 +0100 (BST)
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
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
 <8bc5f207-f913-825c-f9fc-0a2c7fd280aa@linux.ibm.com>
 <e36abc22-9daf-e0f4-c6b3-7adbb28db4c3@de.ibm.com>
 <f84dbcc0-f627-be02-9933-3baa953adc09@linux.ibm.com>
 <219b352b-d5a2-189c-e205-82e7f9ae3d64@de.ibm.com>
 <dbb74c9c-93ab-ed05-fad4-ea2aa5f2b71e@linux.ibm.com>
 <9ef5fcb9-02e0-88e3-007c-eedb14e6db80@linux.ibm.com>
 <20180823122525.02fc4af3.cohuck@redhat.com>
 <decfe307-4449-2c85-0b7e-6f2fcdb1164f@linux.ibm.com>
 <20180827103316.4e7fbc10.cohuck@redhat.com>
 <65cb82b5-85ce-1831-5b2a-719d2cf27be8@linux.ibm.com>
 <20180827155126.440f2170.cohuck@redhat.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Mon, 27 Aug 2018 17:39:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827155126.440f2170.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18082715-4275-0000-0000-000002B0A4E7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082715-4276-0000-0000-000037B9A8C0
Message-Id: <5269782e-d0a9-9df0-b43f-eccfde00a223@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808270166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/27/2018 03:51 PM, Cornelia Huck wrote:
> On Mon, 27 Aug 2018 09:47:58 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 08/27/2018 04:33 AM, Cornelia Huck wrote:
>>> On Thu, 23 Aug 2018 10:16:59 -0400
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>   
>>>> On 08/23/2018 06:25 AM, Cornelia Huck wrote:
>>>>> On Wed, 22 Aug 2018 15:16:19 -0400
>>>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>>>      
>>>>>> One of the things I suggested in a private conversation with Christian
>>>>>> earlier
>>>>>> today was to provide an additional rw sysfs attribute - a boolean - that
>>>>>> indicates
>>>>>> whether all usage domains should also be control domains. The default
>>>>>> could be
>>>>>> true. This would allow one to configure guests with usage-only domains
>>>>>> as well
>>>>>> as satisfy the convention.
>>>>> Would this additional attribute then control "add usage domains to the
>>>>> list of control domains automatically", or "don't allow to add a usage
>>>>> domain if it has not already been added as a control domain"?
>>>> It was just a proposal that wasn't really discussed at all, but this
>>>> attribute would add usage domains to the list of control domains
>>>> automatically if set to one. That would be the default behavior which
>>>> would be turned off by manually setting it to zero.
>>> If we want to do something like that, having it add the usage domains
>>> automatically sounds like the more workable alternative. What I like
>>> about this is that we make it explicit that we change the masks beyond
>>> what the admin explicitly configured, and provide a knob to turn off
>>> that behaviour.
>>
>> So, are you saying I should go ahead and implement this?
> 
> I'm just saying that it does not sound like a bad idea :)
> 
> If you agree that it's a good idea and if others also like it... I'd
> certainly not mind you going ahead :)
> 

I can live with it. What I don't like about it is that it adds
more context dependent semantics. The same sequence of actions
results in a different result (depending on the mode of operation).

Regards,
Halil

