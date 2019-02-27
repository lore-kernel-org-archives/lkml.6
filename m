Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BEA2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfB0Ko2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:44:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729129AbfB0Ko1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:44:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RAhnkF062470
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 05:44:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qwqkackqd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 05:44:25 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 27 Feb 2019 10:44:23 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 10:44:20 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1RAiI1q51904618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Feb 2019 10:44:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C34C0A405D;
        Wed, 27 Feb 2019 10:44:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21F0DA404D;
        Wed, 27 Feb 2019 10:44:18 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Feb 2019 10:44:18 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v4 3/7] s390: ap: associate a ap_vfio_queue and a matrix
 mdev
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-4-git-send-email-pmorel@linux.ibm.com>
 <20190227103211.5e4d63b2.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 27 Feb 2019 11:44:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190227103211.5e4d63b2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022710-0020-0000-0000-0000031BD95C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022710-0021-0000-0000-0000216D44B2
Message-Id: <d72343b0-4431-a686-07f3-4b3f916729d8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2019 10:32, Cornelia Huck wrote:
> On Fri, 22 Feb 2019 16:29:56 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We need to associate the ap_vfio_queue, which will hold the
>> per queue information for interrupt with a matrix mediated device
>> which hold the configuration and the way to the CRYCB.
>>
>> Let's do this when assigning a APID or a APQI to the mediated device
>> and clear the relation when unassigning.
>>
>> Queuing the devices on a list of free devices and testing the
>> matrix_mdev pointer to the associated matrix allow us to know
>> if the queue is associated to the matrix device and associated
>> or not to a mediated device.
>>
>> When resetting an AP queue we must wait until there are no more
>> messages in the message queue before considering the queue is really
>> in a clean state.
>>
>> Let's do it and wait until the status response code indicate the
>> queue is empty after issuing a PAPQ/ZAPQ instruction.
> 
> I'm a bit confused about the context where that list moving etc. is
> supposed to take place.

You are confused because... it is confuse.

> 
> When are we assigning/deassigning? Is there even supposed to be any
> activity that we need to zap on the queues?

No I mixed two functionalities here. It is not right.

I think I must:

- separate the simplification for the reset may be move the chunks to 
the previous patch as it is a simplification coming with the use of the 
lists or move them to a separate patch.

- make the commit message less confuse :)


Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

