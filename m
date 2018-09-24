Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C02C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAEF21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAEF21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbeIXWpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:45:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731922AbeIXWpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:45:51 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OGd0ae096002
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:42:50 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mq20j51gc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:42:49 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 24 Sep 2018 10:42:49 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Sep 2018 10:42:45 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8OGggYm50790504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Sep 2018 09:42:42 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71CAABE04F;
        Mon, 24 Sep 2018 10:42:42 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6249FBE051;
        Mon, 24 Sep 2018 10:42:39 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.130.123])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 Sep 2018 10:42:39 -0600 (MDT)
Subject: Re: [PATCH v10 13/26] s390: vfio-ap: zeroize the AP queues
To:     Harald Freudenberger <freude@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180924133611.01fef50e.cohuck@redhat.com>
 <b2eae775-0917-8c71-4ecf-6ef921ac9b0b@linux.ibm.com>
 <113e07ba-370e-bdcf-4e85-412834947552@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 24 Sep 2018 12:42:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <113e07ba-370e-bdcf-4e85-412834947552@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092416-0016-0000-0000-00000933DEEF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009763; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093030; UDB=6.00564899; IPR=6.00873068;
 MB=3.00023484; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-24 16:42:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092416-0017-0000-0000-00004077A8AC
Message-Id: <6f04d759-7bc8-cf96-30ba-81621572e7d3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 09:22 AM, Harald Freudenberger wrote:
> On 24.09.2018 14:16, Halil Pasic wrote:
>>
>> On 09/24/2018 01:36 PM, Cornelia Huck wrote:

(...)

>>> ...and here, we return the last error of any of the resets. Two
>>> questions:
>>>
>>> - Does it make sense to continue if we get -EIO? IOW, does "really
>>>    broken" only refer to a certain tuple and other tuples still can/need
>>>    to be reset?
>> I think it does make sense to continue, because IMHO "things are really
>> broken" is an overstatement (I mean the APQN invalid case). One could
>> argue would skipping the current card (adapter) be justified or not.
>>
>> IMHO the current code is good enough for the first shot, and we can think
>> about fine-tuning it later.
> Absolutely. The -EIO case is reached for example when the APQN
> is 'deconfigured' which means the crypto adapter is logically unplugged.
> So the -EIO case should NOT lead to some fatal actions like panic()
> or cause a KVM guest to shut down or so.
>>> - Is the return code useful in any way, as we don't know which tuple it
>>>    refers to?
>>>
>> Well, good question. It conveys that the operation can 'fail'. AFAIR -EBUSY
>> is mostly fine given what the architecture say if we are satisfied with just
>> reset. And the cases behind -EIO might actually be OK too in the same sense.
>> My guess is, that based on the return value client code can tell if we have
>> zeroize for all queues or basically just reset (like rapq). We could log that
>> to some debug facility or whatever -- I guess, but at the moment we don't care.
>>
>> In the end I think the code is good enough as is, and if we want we can
>> improve on it later.
>>
>> Regards,
>> Halil
>>

I'll note that in v7 a message was logged to indicate for which APQN the 
error occurred, but I was asked to remove the printk log messsages. I 
agree with Halil and Harald confirmed that the code is probably okay as 
it stands. I can definitely see enhancing all of AP virtualization down 
the road with some type of debug logging.

> 

