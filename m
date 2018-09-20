Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182BCECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2746220858
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2746220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbeIUCUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:20:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387845AbeIUCUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:20:32 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KKTtD4028133
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 16:35:15 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mmf9mgu53-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 16:35:15 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 20 Sep 2018 16:35:14 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Sep 2018 16:35:12 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8KKZ9OG22544498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Sep 2018 20:35:09 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F31E12405C;
        Thu, 20 Sep 2018 17:35:21 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70926124069;
        Thu, 20 Sep 2018 17:35:19 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.85.177.229])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Sep 2018 17:35:19 -0400 (EDT)
Subject: Re: [PATCH v10 05/26] s390: vfio-ap: register matrix device with VFIO
 mdev framework
To:     Cornelia Huck <cohuck@redhat.com>,
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
 <1536781396-13601-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180920175041.57ad867e.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 20 Sep 2018 16:35:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180920175041.57ad867e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092020-2213-0000-0000-000002F24AB6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009741; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091206; UDB=6.00563797; IPR=6.00871230;
 MB=3.00023419; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-20 20:35:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092020-2214-0000-0000-00005B9F60A3
Message-Id: <1d433a50-9ff9-aef5-fcef-8ccaffc859a8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 11:50 AM, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 15:42:55 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Registers the matrix device created by the VFIO AP device
>> driver with the VFIO mediated device framework.
>> Registering the matrix device will create the sysfs
>> structures needed to create mediated matrix devices
>> each of which will be used to configure the AP matrix
>> for a guest and connect it to the VFIO AP device driver.
>>
>> Registering the matrix device with the VFIO mediated device
>> framework will create the following sysfs structures:
>>
>> /sys/devices/vfio_ap/matrix/
>> ...... [mdev_supported_types]
>> ......... [vfio_ap-passthrough]
>> ............ create
>>
>> To create a mediated device for the AP matrix device, write a UUID
>> to the create file:
>>
>> 	uuidgen > create
>>
>> A symbolic link to the mediated device's directory will be created in the
>> devices subdirectory named after the generated $uuid:
>>
>> /sys/devices/vfio_ap/matrix/
>> ...... [mdev_supported_types]
>> ......... [vfio_ap-passthrough]
>> ............ [devices]
>> ............... [$uuid]
>>
>> A symbolic link to the mediated device will also be created
>> in the vfio_ap matrix's directory:
>>
>> /sys/devices/vfio_ap/matrix/[$uuid]
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   MAINTAINERS                           |    1 +
>>   drivers/s390/crypto/Makefile          |    2 +-
>>   drivers/s390/crypto/vfio_ap_drv.c     |   19 +++++
>>   drivers/s390/crypto/vfio_ap_ops.c     |  126 +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   49 +++++++++++++
>>   include/uapi/linux/vfio.h             |    1 +
>>   6 files changed, 197 insertions(+), 1 deletions(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
> (...)
>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 3e635f0..75f8bdc 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -76,6 +76,16 @@ static int vfio_ap_matrix_dev_create(void)
>>   		goto matrix_alloc_err;
>>   	}
>>   
>> +	/* Test if PQAP(QCI) instruction is available */
> /* Fill in config info via PQAP(QCI), if available */

Okay

>
> ?
>
>> +	if (test_facility(12)) {
>> +		ret = ap_qci(&matrix_dev->info);
>> +		if (ret)
>> +			goto matrix_alloc_err;
>> +	}
>> +
>> +	mutex_init(&matrix_dev->lock);
>> +	INIT_LIST_HEAD(&matrix_dev->mdev_list);
>> +
>>   	matrix_dev->device.type = &vfio_ap_dev_type;
>>   	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
>>   	matrix_dev->device.parent = root_device;
> (...)
>
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index 6141420..a2eab78 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -3,6 +3,7 @@
>>    * Private data and functions for adjunct processor VFIO matrix driver.
>>    *
>>    * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>> + *	      Halil Pasic <pasic@linux.ibm.com>
>>    *
>>    * Copyright IBM Corp. 2018
>>    */
>> @@ -24,11 +25,59 @@
>>   /**
>>    * ap_matrix_dev - the AP matrix device structure
>>    * @device:	generic device structure associated with the AP matrix device
>> + * @available_instances: number of mediated matrix devices that can be created
>> + * @info:	the struct containing the output from the PQAP(TAPQ) instruction
> Hm, isn't that rather PQAP(QCI)?

Yes it is!

>
>> + * mdev_list:	the list of mediated matrix devices created
>> + * lock:	mutex for locking the AP matrix device. This lock will be
>> + *		taken every time we fiddle with state managed by the vfio_ap
>> + *		driver, be it using @mdev_list or writing the state of a
>> + *		single ap_matrix_mdev device. It's quite coarse but we don't
>> + *		expect much contention.
>>    */
>>   struct ap_matrix_dev {
>>   	struct device device;
>> +	atomic_t available_instances;
>> +	struct ap_config_info info;
>> +	struct list_head mdev_list;
>> +	struct mutex lock;
>>   };
> Otherwise:
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>

