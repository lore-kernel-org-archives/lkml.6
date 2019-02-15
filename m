Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCC121924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405481AbfBOJ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:58:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbfBOJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:58:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1F9opJP032542
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 04:58:24 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qns5t6e6k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 04:58:24 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 15 Feb 2019 09:58:22 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Feb 2019 09:58:19 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1F9wIlE55836790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 09:58:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39769A405B;
        Fri, 15 Feb 2019 09:58:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ECCCA405C;
        Fri, 15 Feb 2019 09:58:17 +0000 (GMT)
Received: from [9.145.44.11] (unknown [9.145.44.11])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Feb 2019 09:58:17 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 3/9] s390: ap: new vfio_ap_queue structure
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-4-git-send-email-pmorel@linux.ibm.com>
 <20190215103716.00cd40db.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 15 Feb 2019 10:58:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215103716.00cd40db.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021509-0016-0000-0000-00000256CB61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021509-0017-0000-0000-000032B0FFE7
Message-Id: <019ca60e-996a-bd02-c859-3f9891083d0c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2019 10:37, Cornelia Huck wrote:
> On Thu, 14 Feb 2019 14:51:03 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> The AP interruptions are assigned on a queue basis
>> and we need some information neloging to the queue
> 
> s/neloging/belonging/
> 
>> to handle interuptions.
> 
> s/interuptions/interruptions/
> 
>>
>> We add a new structure vfio_ap_queue, to hold per
>> queue information useful to handle interruptions.
>>
>> - apqn: AP queue number (defined here)
>> - isc : Interrupt subclass (defined later)
>> - nib : notification information byte (defined later)
> 
> So, you basically simply want quick access to these? Makes sense.
> 
>>
>> The vfio_ap_queue structure is allocated when the vfio_ap_driver
>> is probed and added as driver data to the ap_queue device.
>> It is free on remove.
> 
> s/free/freed/
> 
>>
>> The structure is linked to the matrix_dev host device.
> 
> Hm, I don't quite follow?

Sorry, do not try to, this has been left from a previous internal version.
I will suppress this

> 
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_drv.c     | 23 ++++++++++++++++++++++-
>>   drivers/s390/crypto/vfio_ap_private.h |  3 +++
>>   2 files changed, 25 insertions(+), 1 deletion(-)
> 
> Patch looks reasonable; might make sense to squash it with later
> patches (still need to read).
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

