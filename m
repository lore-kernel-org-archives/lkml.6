Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F9C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BE22089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BE22089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeGIMOC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:14:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932567AbeGIMOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:14:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69C4jI7113607
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 08:14:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k44wchhk5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:14:00 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 9 Jul 2018 13:13:58 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 13:13:55 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w69CDr9721561356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 12:13:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C33CA42045;
        Mon,  9 Jul 2018 15:14:16 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F3B94204D;
        Mon,  9 Jul 2018 15:14:16 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 15:14:16 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v6 11/21] s390: vfio-ap: sysfs interfaces to configure
 domains
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-12-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 9 Jul 2018 14:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530306683-7270-12-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070912-0008-0000-0000-00000251248A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070912-0009-0000-0000-000021B74DAE
Message-Id: <0b29176d-7222-6111-6fea-d8bde66fa670@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2018 23:11, Tony Krowiak wrote:
> Provides the sysfs interfaces for assigning AP domains to
> and unassigning AP domains from a mediated matrix device.
>
> An AP domain ID corresponds to an AP queue index (APQI). For
> each domain assigned to the mediated matrix device, its
> corresponging APQI is stored in an AP queue mask (AQM).
> The bits in the AQM, from most significant to least
> significant bit, correspond to AP domain numbers 0 to 255.
> When a domain is assigned, the bit corresponding to its
> APQI will be set in the AQM. Likewise, when a domain is
> unassigned, the bit corresponding to its APQI will be
> cleared from the AQM.
>
> The relevant sysfs structures are:
>
> /sys/devices/vfio_ap
> ... [matrix]
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. assign_domain
> .................. unassign_domain
>
> To assign a domain to the $uuid mediated matrix device,
> write the domain's ID to the assign_domain file. To
> unassign a domain, write the domain's ID to the
> unassign_domain file. The ID is specified using
> conventional semantics: If it begins with 0x, the number
> will be parsed as a hexadecimal (case insensitive) number;
> if it begins with 0, it will be parsed as an octal number;
> otherwise, it will be parsed as a decimal number.
>
> For example, to assign domain 173 (0xad) to the mediated matrix
> device $uuid:
>
> 	echo 173 > assign_domain
>
> 	or
>
> 	echo 0255 > assign_domain
>
> 	or
>
> 	echo 0xad > assign_domain
>
> To unassign domain 173 (0xad):
>
> 	echo 173 > unassign_domain
>
> 	or
>
> 	echo 0255 > unassign_domain
>
> 	or
>
> 	echo 0xad > unassign_domain
>
> The assignment will be rejected:
>
> * If the domain ID exceeds the maximum value for an AP domain:
>
>    * If the AP Extended Addressing (APXA) facility is installed,
>      the max value is 255
>
>    * Else the max value is 15
>
> * If no AP adapters have yet been assigned and there are
>    no AP queues reserved by the VFIO AP driver that have an APQN
>    with an APQI matching that of the AP domain number being
>    assigned.
>
> * If any of the APQNs that can be derived from the intersection
>    of the APQI being assigned and the AP adapter ID (APID) of
>    each of the AP adapters previously assigned can not be matched
>    with an APQN of an AP queue device reserved by the VFIO AP
>    driver.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c |  173 ++++++++++++++++++++++++++++++++++++-
>   1 files changed, 172 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index a4351bd..a5b06e7 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -170,6 +170,27 @@ static int vfio_ap_queue_has_apid(struct device *dev, void *data)
>   }
>
>   /**
> + * vfio_ap_queue_has_apqi
> + *
> + * @dev: an AP queue device
> + * @data: an AP queue index
> + *
> + * Flags whether any AP queue device has a particular AP queue index
> + *
> + * Returns 0 to indicate the function succeeded
> + */
> +static int vfio_ap_queue_has_apqi(struct device *dev, void *data)
> +{
> +	struct vfio_id_reserved *id_res = data;
> +	struct ap_queue *ap_queue = to_ap_queue(dev);
> +
> +	if (id_res->id == AP_QID_QUEUE(ap_queue->qid))
> +		id_res->reserved = true;
> +
> +	return 0;
> +}
> +
> +/**
>    * vfio_ap_verify_qid_reserved
>    *
>    * @matrix_dev: a mediated matrix device
> @@ -236,6 +257,42 @@ static int vfio_ap_verify_apid_reserved(struct ap_matrix_dev *matrix_dev,
>   	return -EPERM;
>   }
>
> +/**
> + * vfio_ap_verify_apqi_reserved
> + *
> + * @matrix_dev: a mediated matrix device
> + * @apqi: an AP queue index
> + *
> + * Verifies that an AP queue with @apqi is reserved by the VFIO AP device
> + * driver.
> + *
> + * Returns 0 if an AP queue with @apqi is reserved; otherwise, returns -ENODEV.
> + */
> +static int vfio_ap_verify_apqi_reserved(struct ap_matrix_dev *matrix_dev,
> +					const char *mdev_name,
> +					unsigned long apqi)
> +{
> +	int ret;
> +	struct vfio_id_reserved id_res;
> +
> +	id_res.id = apqi;
> +	id_res.reserved = false;
> +
> +	ret = driver_for_each_device(matrix_dev->device.driver, NULL, &id_res,
> +				     vfio_ap_queue_has_apqi);
> +	if (ret)
> +		return ret;
> +
> +	if (id_res.reserved)
> +		return 0;
> +
> +	pr_err("%s: mdev %s using queue %04lx not reserved by %s driver",
> +					VFIO_AP_MODULE_NAME, mdev_name, apqi,
> +					VFIO_AP_DRV_NAME);
> +
> +	return -EPERM;
> +}
> +
>   static int vfio_ap_verify_queues_reserved(struct ap_matrix_dev *matrix_dev,
>   					  const char *mdev_name,
>   					  struct ap_matrix *matrix)
> @@ -417,10 +474,124 @@ static ssize_t unassign_adapter_store(struct device *dev,
>   }
>   DEVICE_ATTR_WO(unassign_adapter);
>
> +/**
> + * vfio_ap_validate_apqi
> + *
> + * @matrix_mdev: the mediated matrix device
> + * @apqi: the APQI (domain ID) to validate
> + *
> + * Validates the value of @apqi:
> + *	* If there are no AP adapters assigned, then there must be at least
> + *	  one AP queue device reserved by the VFIO AP device driver with an
> + *	  APQN containing @apqi.

Same as in preceding patch, I do not understand why you need this.

Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

