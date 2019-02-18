Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A599C2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389604AbfBRQf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:35:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389434AbfBRQf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:35:56 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IGYeYO110536
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:35:54 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qqxynct2u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:35:54 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 18 Feb 2019 16:35:54 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Feb 2019 16:35:50 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1IGZkD016449758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 16:35:46 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BB0FAC059;
        Mon, 18 Feb 2019 16:35:46 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA084AC05B;
        Mon, 18 Feb 2019 16:35:45 +0000 (GMT)
Received: from [9.85.134.111] (unknown [9.85.134.111])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 18 Feb 2019 16:35:45 +0000 (GMT)
Subject: Re: [PATCH v3 1/9] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     pmorel@linux.ibm.com, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-2-git-send-email-pmorel@linux.ibm.com>
 <20190214155441.087d2a68.cohuck@redhat.com>
 <9403117a-04a6-8f69-2a61-f96d35a59555@linux.ibm.com>
 <20190214175730.4ab609ae.cohuck@redhat.com>
 <9200b1f8-874f-ffa7-bef0-19ca570d7ac1@linux.ibm.com>
 <eac03540-a499-fa0f-1a4a-b5cc99030775@linux.ibm.com>
 <20190215101118.5417d725.cohuck@redhat.com>
 <f38c99e6-bb25-9179-e4cd-20ba8482111f@linux.ibm.com>
 <20190218130147.5ed3edbe.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 18 Feb 2019 11:35:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190218130147.5ed3edbe.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021816-0052-0000-0000-0000038C4EA3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010620; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01162903; UDB=6.00607153; IPR=6.00943480;
 MB=3.00025639; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-18 16:35:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021816-0053-0000-0000-00005FE3CD84
Message-Id: <602fd1f8-0ac1-42dc-30fd-ea16bb7bbc99@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=718 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 7:01 AM, Cornelia Huck wrote:
> On Fri, 15 Feb 2019 16:59:33 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 2/15/19 4:11 AM, Cornelia Huck wrote:
>>> On Thu, 14 Feb 2019 13:30:59 -0500
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>>    
>>>> On 2/14/19 12:36 PM, Pierre Morel wrote:
>>>>> On 14/02/2019 17:57, Cornelia Huck wrote:
> 
>>>>>> (And reading further in the current code, it seems we clear that
>>>>>> structure _after_ the matrix device had been setup, so how can that
>>>>>> even work? Where am I confused?)
>>>>>
>>>>> On device_register there were no bus, so the core just do not look for a
>>>>> driver and this field was nor tested nor overwritten.
>>>
>>> Hm... so has the callback in driver_for_each_device() in
>>> vfio_ap_verify_queue_reserved() ever been invoked at all? It seems this
>>> patch fixes more than just libudev issues...
>>
>> It is this patch that rendered the driver_for_each_device() in
>> vfio_ap_verify_queue_reserved() erroneous. That function gets called
>> every time an adapter or domain is assigned to the mdev. This patch
>> introduced the problem with driver_for_each_device().
> 
> So, does this function need to be removed or called from another place,
> then? (It looks like it was dead code before.)

I don't see why you think it's dead code:

assign_adapter_store
==> vfio_ap_mdev_verify_queues_reserved_for_apid
     ==> vfio_ap_verify_queue_reserved
         ==> driver_for_each_device

The only way that the vfio_ap_verify_queue_reserved - the function that
calls driver_for_each_device - does not get called is if no bits have
yet been set in matrix_mdev->matrix.aqm.

> 

