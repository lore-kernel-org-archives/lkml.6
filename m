Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0EE3DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80F7208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80F7208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935493AbeFMMCJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:02:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754096AbeFMMCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:02:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DC03ED011585
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:02:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jk0f0eah9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:02:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 13 Jun 2018 13:02:00 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 13:01:56 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5DC1tir18219170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jun 2018 12:01:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33027AE05A;
        Wed, 13 Jun 2018 12:50:45 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 671D7AE064;
        Wed, 13 Jun 2018 12:50:44 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 12:50:44 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 04/13] s390: vfio-ap: base implementation of VFIO AP
 device driver
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
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <889b8d41-e08c-0eb5-2de0-a1d6669a03b3@linux.ibm.com>
 <20180613094812.1fd1846d.cohuck@redhat.com>
 <41e7ccbd-f6f5-ba20-f236-7824c682994d@linux.ibm.com>
 <20180613131402.0305d092.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 13 Jun 2018 14:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613131402.0305d092.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18061312-0020-0000-0000-0000029A6903
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061312-0021-0000-0000-000020E69162
Message-Id: <7237751c-66b5-d14c-5b71-cc1cfc79db87@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806130134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2018 13:14, Cornelia Huck wrote:
> On Wed, 13 Jun 2018 12:54:40 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 13/06/2018 09:48, Cornelia Huck wrote:
>>> On Wed, 13 Jun 2018 09:41:16 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>   
>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>> Introduces a new AP device driver. This device driver
>>>>> is built on the VFIO mediated device framework. The framework
>>>>> provides sysfs interfaces that facilitate passthrough
>>>>> access by guests to devices installed on the linux host.
>>>> ...snip...
>>>>   
>>>>> +static int vfio_ap_matrix_dev_create(void)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	vfio_ap_root_device = root_device_register(VFIO_AP_ROOT_NAME);
>>>>> +
>>>>> +	if (IS_ERR(vfio_ap_root_device)) {
>>>>> +		ret = PTR_ERR(vfio_ap_root_device);
>>>>> +		goto done;
>>>>> +	}
>>>>> +
>>>>> +	ap_matrix = kzalloc(sizeof(*ap_matrix), GFP_KERNEL);
>>>>> +	if (!ap_matrix) {
>>>>> +		ret = -ENOMEM;
>>>>> +		goto matrix_alloc_err;
>>>>> +	}
>>>>> +
>>>>> +	ap_matrix->device.type = &vfio_ap_dev_type;
>>>>> +	dev_set_name(&ap_matrix->device, "%s", VFIO_AP_DEV_NAME);
>>>>> +	ap_matrix->device.parent = vfio_ap_root_device;
>>>>> +	ap_matrix->device.release = vfio_ap_matrix_dev_release;
>>>>> +	ap_matrix->device.driver = &vfio_ap_drv.driver;
>>>>> +
>>>>> +	ret = device_register(&ap_matrix->device);
>>>>> +	if (ret)
>>>>> +		goto matrix_reg_err;
>>>>> +
>>>>> +	goto done;
>>>>> +
>>>>> +matrix_reg_err:
>>>>> +	put_device(&ap_matrix->device);
>>>> Did not see this before but here you certainly want to
>>>> do a kfree and not a put_device.
>>> No, this must not be a kfree. Once you've tried to register something
>>> embedding a struct device with the driver core, you need to use
>>> put_device, as another path may have acquired a reference, even if
>>> registering ultimately failed. See the comment for device_register().
>>> IOW, the code is correct.
>> learned something again :) ,
>> but still, a kfree is needed for the kzalloc.
>> Does'nt it?
> No, the put callback for the embedding structure needs to take care of
> freeing things. Otherwise it is buggy.

Seems buggy to me.
How does the put_device knows if it is embedded and then in what it is 
embedded ?

>
>>>   
>>>>   
>>>>> +
>>>>> +matrix_alloc_err:
>>>>> +	root_device_unregister(vfio_ap_root_device);
>>>>> +
>>>>> +done:
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static void vfio_ap_matrix_dev_destroy(struct ap_matrix *ap_matrix)
>>>>> +{
>>>>> +	device_unregister(&ap_matrix->device);
>>>>> +	root_device_unregister(vfio_ap_root_device);
>>>> Also here you need a kfree(ap_matrix) too .
>>> Same here.
>>>   


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

