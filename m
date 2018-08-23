Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD6BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DDA20841
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DDA20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbeHWPOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:14:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728588AbeHWPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:14:10 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NBiGQq087677
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:44:48 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m1uf128jq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:44:48 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 23 Aug 2018 12:44:46 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 12:44:43 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NBifUJ42926184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 11:44:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F17AE4C044;
        Thu, 23 Aug 2018 14:44:42 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B5D14C040;
        Thu, 23 Aug 2018 14:44:42 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 14:44:42 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
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
 <25a44526-a2d6-c632-6a6d-8ca385925731@linux.ibm.com>
 <20180823133134.32e1d2f8.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 23 Aug 2018 13:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823133134.32e1d2f8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082311-0016-0000-0000-000001FAAE06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082311-0017-0000-0000-0000325108E6
Message-Id: <d2356f8e-3ed8-02d7-c6f8-2d0efffe4669@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2018 13:31, Cornelia Huck wrote:
> On Thu, 23 Aug 2018 12:43:42 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 23/08/2018 12:25, Cornelia Huck wrote:
>>> On Wed, 22 Aug 2018 15:16:19 -0400
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>    
>>>> One of the things I suggested in a private conversation with Christian
>>>> earlier
>>>> today was to provide an additional rw sysfs attribute - a boolean - that
>>>> indicates
>>>> whether all usage domains should also be control domains. The default
>>>> could be
>>>> true. This would allow one to configure guests with usage-only domains
>>>> as well
>>>> as satisfy the convention.
>>>
>>> Would this additional attribute then control "add usage domains to the
>>> list of control domains automatically", or "don't allow to add a usage
>>> domain if it has not already been added as a control domain"?
>>>
>>> One thing I'm still unsure about is how libvirt comes into the picture
>>> here. Will it consume the setting, or actively manipulate it?
>>>
>>> [In general, I'm not very clear about how libvirt will interact with the
>>> whole infrastructure...]
>>>    
>>
>> When I read you it convince me that it is not wise to change anything
>> that has been already discuss and could impact the Libvirt.
> 
> My main point basically was that we should get feedback from a libvirt
> POV :) The new attribute may make sense, or not; but I'm really feeling
> a bit in the dark with regard to libvirt.
> 

Me too, this explains my conservative approach ;)



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

