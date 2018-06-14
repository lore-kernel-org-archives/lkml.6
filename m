Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 39A91C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C6F208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C6F208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755277AbeFNNHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:07:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754927AbeFNNHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:07:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5ED6rSt034815
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 09:07:08 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jkpakq7he-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 09:07:06 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 14 Jun 2018 09:04:19 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Jun 2018 09:04:16 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5ED4Eat6947122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Jun 2018 13:04:14 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A235AE05F;
        Thu, 14 Jun 2018 09:04:21 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DD66AE063;
        Thu, 14 Jun 2018 09:04:20 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.85.185.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jun 2018 09:04:20 -0400 (EDT)
Subject: Re: [PATCH v5 04/13] s390: vfio-ap: base implementation of VFIO AP
 device driver
To:     pmorel@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>
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
 <7237751c-66b5-d14c-5b71-cc1cfc79db87@linux.ibm.com>
 <20180613141221.5b924348.cohuck@redhat.com>
 <65ec9340-6a25-20ac-3078-f67992d5cc15@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 14 Jun 2018 09:04:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <65ec9340-6a25-20ac-3078-f67992d5cc15@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18061413-2213-0000-0000-000002BA1482
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009189; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046843; UDB=6.00536171; IPR=6.00825816;
 MB=3.00021643; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-14 13:04:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061413-2214-0000-0000-00005A7B688A
Message-Id: <6ff0eac2-7c0f-4ab1-6301-c7f6997be591@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806140147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 08:16 AM, Pierre Morel wrote:
> On 13/06/2018 14:12, Cornelia Huck wrote:
>> On Wed, 13 Jun 2018 14:01:54 +0200
>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>
>>> On 13/06/2018 13:14, Cornelia Huck wrote:
>>>> On Wed, 13 Jun 2018 12:54:40 +0200
>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>> On 13/06/2018 09:48, Cornelia Huck wrote:
>>>>>> On Wed, 13 Jun 2018 09:41:16 +0200
>>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>>>>> Introduces a new AP device driver. This device driver
>>>>>>>> is built on the VFIO mediated device framework. The framework
>>>>>>>> provides sysfs interfaces that facilitate passthrough
>>>>>>>> access by guests to devices installed on the linux host.
>>>>>>> ...snip...
>>>>>>>> +static int vfio_ap_matrix_dev_create(void)
>>>>>>>> +{
>>>>>>>> +    int ret;
>>>>>>>> +
>>>>>>>> +    vfio_ap_root_device = 
>>>>>>>> root_device_register(VFIO_AP_ROOT_NAME);
>>>>>>>> +
>>>>>>>> +    if (IS_ERR(vfio_ap_root_device)) {
>>>>>>>> +        ret = PTR_ERR(vfio_ap_root_device);
>>>>>>>> +        goto done;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ap_matrix = kzalloc(sizeof(*ap_matrix), GFP_KERNEL);
>>>>>>>> +    if (!ap_matrix) {
>>>>>>>> +        ret = -ENOMEM;
>>>>>>>> +        goto matrix_alloc_err;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ap_matrix->device.type = &vfio_ap_dev_type;
>>>>>>>> +    dev_set_name(&ap_matrix->device, "%s", VFIO_AP_DEV_NAME);
>>>>>>>> +    ap_matrix->device.parent = vfio_ap_root_device;
>>>>>>>> +    ap_matrix->device.release = vfio_ap_matrix_dev_release;
>>>>>>>> +    ap_matrix->device.driver = &vfio_ap_drv.driver;
>>>>>>>> +
>>>>>>>> +    ret = device_register(&ap_matrix->device);
>>>>>>>> +    if (ret)
>>>>>>>> +        goto matrix_reg_err;
>>>>>>>> +
>>>>>>>> +    goto done;
>>>>>>>> +
>>>>>>>> +matrix_reg_err:
>>>>>>>> +    put_device(&ap_matrix->device);
>>>>>>> Did not see this before but here you certainly want to
>>>>>>> do a kfree and not a put_device.
>>>>>> No, this must not be a kfree. Once you've tried to register 
>>>>>> something
>>>>>> embedding a struct device with the driver core, you need to use
>>>>>> put_device, as another path may have acquired a reference, even if
>>>>>> registering ultimately failed. See the comment for 
>>>>>> device_register().
>>>>>> IOW, the code is correct.
>>>>> learned something again :) ,
>>>>> but still, a kfree is needed for the kzalloc.
>>>>> Does'nt it?
>>>> No, the put callback for the embedding structure needs to take care of
>>>> freeing things. Otherwise it is buggy.
>>> Seems buggy to me.
>>> How does the put_device knows if it is embedded and then in what it is
>>> embedded ?
>> It does not need to know; the code registering the structure needs to
>> set up device->release correctly.
>
> yes right, thanks.

See the vfio_ap_matrix_dev_release() callback.

>
>
>>
>>>>>>>> +
>>>>>>>> +matrix_alloc_err:
>>>>>>>> +    root_device_unregister(vfio_ap_root_device);
>>>>>>>> +
>>>>>>>> +done:
>>>>>>>> +    return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void vfio_ap_matrix_dev_destroy(struct ap_matrix 
>>>>>>>> *ap_matrix)
>>>>>>>> +{
>>>>>>>> +    device_unregister(&ap_matrix->device);
>>>>>>>> +    root_device_unregister(vfio_ap_root_device);
>>>>>>> Also here you need a kfree(ap_matrix) too .
>>>>>> Same here.
>>>
>

