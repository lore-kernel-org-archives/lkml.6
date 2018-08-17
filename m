Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526DCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D42D2187A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D42D2187A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeHQWGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:06:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728161AbeHQWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:06:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7HIsmOu021600
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 15:02:15 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kx2h4kjtr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 15:02:14 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 17 Aug 2018 13:02:13 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Aug 2018 13:02:10 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7HJ27SX10879474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Aug 2018 12:02:07 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 450BC136053;
        Fri, 17 Aug 2018 13:02:07 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA45E13604F;
        Fri, 17 Aug 2018 13:02:03 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.206.50])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 17 Aug 2018 13:02:03 -0600 (MDT)
Subject: Re: [PATCH v9 09/22] s390: vfio-ap: register matrix device with VFIO
 mdev framework
To:     Cornelia Huck <cohuck@redhat.com>
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
 <1534196899-16987-10-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180814131929.37d4b530.cohuck@redhat.com>
 <5b77a5e9-6d91-c7a3-5ada-d888735f0488@linux.ibm.com>
 <20180817104331.378fa130.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 17 Aug 2018 15:02:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180817104331.378fa130.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081719-0004-0000-0000-00001478651D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009562; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01074945; UDB=6.00554000; IPR=6.00854903;
 MB=3.00022777; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-17 19:02:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081719-0005-0000-0000-0000887E66E2
Message-Id: <1966e474-abc9-33a2-8846-17daf4fb3a8d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808170201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 04:43 AM, Cornelia Huck wrote:
> On Thu, 16 Aug 2018 12:24:16 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 08/14/2018 07:19 AM, Cornelia Huck wrote:
>>> On Mon, 13 Aug 2018 17:48:06 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>> +static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>>>> +{
>>>> +	struct ap_matrix_mdev *matrix_mdev;
>>>> +
>>>> +	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
>>>> +	if (!matrix_mdev)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	matrix_mdev->name = dev_name(mdev_dev(mdev));
>>>> +	vfio_ap_matrix_init(&matrix_dev.info, &matrix_mdev->matrix);
>>>> +	mdev_set_drvdata(mdev, matrix_mdev);
>>>> +
>>>> +	if (atomic_dec_if_positive(&matrix_dev.available_instances) < 0) {
>>>> +		kfree(matrix_mdev);
>>>> +		return -EPERM;
>>>> +	}
>>> Maybe move this check to the top of the function?
>> Please ignore my previous response to your comment. I can't move the call to
>> atomic_dec_if_positive() to the top of the function because it
>> decrements the
>> available_instances and if the kzalloc() of matrix_mdev fails, then the
>> value
>> would have to then be incremented to remain valid. What I can do is this:
>>
>> 1. Check the value of available_instances using atomic_read() at the top of
>>      the function and if it is zero, return an error.
>>
>> 2. Replace the call to atomic_dec_if_positive() with a call to atomic_dec()
>>      to decrement the available_instances.
>>
>> I agree that it makes sense to return before attempting to allocate the
>> matrix_mdev if available_instances is zero.
> Wouldn't that be racy, though?
>
> I don't think re-incrementing the counter is too bad, and it's
> certainly better than going through allocation/freeing of structures.

I'll make it happen.

>
>>>   
>>>> +
>>>> +	mutex_lock(&matrix_dev.lock);
>>>> +	list_add(&matrix_mdev->list, &matrix_dev.mdev_list);
>>>> +	mutex_unlock(&matrix_dev.lock);
>>>> +
>>>> +	return 0;
>>>> +}
>>

