Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAC3C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B1520881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B1520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbeGIMLa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:11:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754515AbeGIML2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:11:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69C4tZt101769
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 08:11:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k452s0fqb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:11:27 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 9 Jul 2018 13:11:24 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 13:11:22 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w69CBKbO40304774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 12:11:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC09442056;
        Mon,  9 Jul 2018 15:11:42 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BB8542045;
        Mon,  9 Jul 2018 15:11:42 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 15:11:42 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v6 10/21] s390: vfio-ap: sysfs interfaces to configure
 adapters
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
 <1530306683-7270-11-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 9 Jul 2018 14:11:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530306683-7270-11-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070912-4275-0000-0000-00000296A493
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070912-4276-0000-0000-0000379E3AC3
Message-Id: <3ec78f60-e1b3-79fc-5592-c53520703bc7@linux.ibm.com>
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
> Provides the sysfs interfaces for assigning AP adapters to
> and unassigning AP adapters from a mediated matrix device.
>
> The IDs of the AP adapters assigned to the mediated matrix
> device are stored in an AP mask (APM). The bits in the APM,
> from most significant to least significant bit, correspond to
> AP adapter ID (APID) 0 to 255. When an adapter is assigned, the
> bit corresponding the APID will be set in the APM.
> Likewise, when an adapter is unassigned, the bit corresponding
> to the APID will be cleared from the APM.
>
> The relevant sysfs structures are:
>
> /sys/devices/vfio_ap
> ... [matrix]
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ...............[$uuid]
> .................. assign_adapter
> .................. unassign_adapter
>
> To assign an adapter to the $uuid mediated matrix device's APM,
> write the APID to the assign_adapter file. To unassign an adapter,
> write the APID to the unassign_adapter file. The APID is specified
> using conventional semantics: If it begins with 0x the number will
> be parsed as a hexadecimal number; if it begins with a 0 the number
> will be parsed as an octal number; otherwise, it will be parsed as a
> decimal number.
>
> For example, to assign adapter 173 (0xad) to the mediated matrix
> device $uuid:
>
> 	echo 173 > assign_adapter
>
> 	or
>
> 	echo 0xad > assign_adapter
>
> 	or
>
> 	echo 0255 > assign_adapter
>
> To unassign adapter 173 (0xad):
>
> 	echo 173 > unassign_adapter
>
> 	or
>
> 	echo 0xad > unassign_adapter
>
> 	or
>
> 	echo 0255 > unassign_adapter
>
> The assignment will be rejected:
>
> * If the APID exceeds the maximum value for an AP adapter:
>    * If the AP Extended Addressing (APXA) facility is
>      installed, the max value is 255
>    * Else the max value is 64
>
> * If no AP domains have yet been assigned and there are
>    no AP queues bound to the VFIO AP driver that have an APQN
>    with an APID matching that of the AP adapter being assigned.
>
> * If any of the APQNs that can be derived from the cross product
>    of the APID being assigned and the AP queue index (APQI) of
>    each of the AP domains previously assigned can not be matched
>    with an APQN of an AP queue device reserved by the VFIO AP
>    driver.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c |  317 +++++++++++++++++++++++++++++++++++++
>   1 files changed, 317 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index bf7ed9f..a4351bd 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -16,6 +16,7 @@
>
>   #define VFOP_AP_MDEV_TYPE_HWVIRT "passthrough"
>   #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
> +#define KVM_AP_MASK_BYTES(n) DIV_ROUND_UP(n, BITS_PER_BYTE)
>
>   DEFINE_SPINLOCK(mdev_list_lock);
>   LIST_HEAD(mdev_list);
> @@ -116,9 +117,325 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
>   	NULL,
>   };
>
> +struct vfio_ap_qid_reserved {
> +	ap_qid_t qid;
> +	bool reserved;
> +};
> +
> +struct vfio_id_reserved {
> +	unsigned long id;
> +	bool reserved;
> +};
> +
> +/**
> + * vfio_ap_qid_reserved
> + *
> + * @dev: an AP queue device
> + * @data: a queue ID
> + *
> + * Flags whether any AP queue device has a particular qid
> + *
> + * Returns 0 to indicate the function succeeded
> + */
> +static int vfio_ap_queue_has_qid(struct device *dev, void *data)
> +{
> +	struct vfio_ap_qid_reserved *qid_res = data;
> +	struct ap_queue *ap_queue = to_ap_queue(dev);
> +
> +	if (qid_res->qid == ap_queue->qid)
> +		qid_res->reserved = true;
> +
> +	return 0;
> +}
> +
> +/**
> + * vfio_ap_queue_has_apid
> + *
> + * @dev: an AP queue device
> + * @data: an AP adapter ID
> + *
> + * Flags whether any AP queue device has a particular AP adapter ID
> + *
> + * Returns 0 to indicate the function succeeded
> + */
> +static int vfio_ap_queue_has_apid(struct device *dev, void *data)
> +{
> +	struct vfio_id_reserved *id_res = data;
> +	struct ap_queue *ap_queue = to_ap_queue(dev);
> +
> +	if (id_res->id == AP_QID_CARD(ap_queue->qid))
> +		id_res->reserved = true;
> +
> +	return 0;
> +}
> +
> +/**
> + * vfio_ap_verify_qid_reserved
> + *
> + * @matrix_dev: a mediated matrix device
> + * @qid: a qid (i.e., APQN)
> + *
> + * Verifies that the AP queue with @qid is reserved by the VFIO AP device
> + * driver.
> + *
> + * Returns 0 if the AP queue with @qid is reserved; otherwise, returns -ENODEV.
> + */
> +static int vfio_ap_verify_qid_reserved(struct ap_matrix_dev *matrix_dev,
> +				       ap_qid_t qid)
> +{
> +	int ret;
> +	struct vfio_ap_qid_reserved qid_res;
> +
> +	qid_res.qid = qid;
> +	qid_res.reserved = false;
> +
> +	ret = driver_for_each_device(matrix_dev->device.driver, NULL, &qid_res,
> +				     vfio_ap_queue_has_qid);
> +	if (ret)
> +		return ret;
> +
> +	if (qid_res.reserved)
> +		return 0;
> +
> +	return -EPERM;
> +}
> +
> +/**
> + * vfio_ap_verify_apid_reserved
> + *
> + * @matrix_dev: a mediated matrix device
> + * @apid: an AP adapter ID
> + *
> + * Verifies that an AP queue with @apid is reserved by the VFIO AP device
> + * driver.
> + *
> + * Returns 0 if an AP queue with @apid is reserved; otherwise, returns -ENODEV.
> + */
> +static int vfio_ap_verify_apid_reserved(struct ap_matrix_dev *matrix_dev,
> +					const char *mdev_name,
> +					unsigned long apid)
> +{
> +	int ret;
> +	struct vfio_id_reserved id_res;
> +
> +	id_res.id = apid;
> +	id_res.reserved = false;
> +
> +	ret = driver_for_each_device(matrix_dev->device.driver, NULL, &id_res,
> +				     vfio_ap_queue_has_apid);
> +	if (ret)
> +		return ret;
> +
> +	if (id_res.reserved)
> +		return 0;
> +
> +	pr_err("%s: mdev %s using adapter %02lx not reserved by %s driver",
> +					VFIO_AP_MODULE_NAME, mdev_name, apid,
> +					VFIO_AP_DRV_NAME);
> +
> +	return -EPERM;
> +}
> +
> +static int vfio_ap_verify_queues_reserved(struct ap_matrix_dev *matrix_dev,
> +					  const char *mdev_name,
> +					  struct ap_matrix *matrix)
> +{
> +	unsigned long apid, apqi;
> +	int ret;
> +	int rc = 0;
> +
> +	for_each_set_bit_inv(apid, matrix->apm, matrix->apm_max + 1) {
> +		for_each_set_bit_inv(apqi, matrix->aqm, matrix->aqm_max + 1) {
> +			ret = vfio_ap_verify_qid_reserved(matrix_dev,
> +							  AP_MKQID(apid, apqi));
> +			if (ret == 0)
> +				continue;
> +
> +			/*
> +			 * We want to log every APQN that is not reserved by
> +			 * the driver, so record the return code, log a message
> +			 * and allow the loop to continue
> +			 */
> +			rc = ret;
> +			pr_err("%s: mdev %s using queue %02lx.%04lx not reserved by %s driver",
> +				VFIO_AP_MODULE_NAME, mdev_name, apid,
> +				apqi, VFIO_AP_DRV_NAME);
> +		}
> +	}
> +
> +	return rc;
> +}
> +
> +/**
> + * vfio_ap_validate_apid
> + *
> + * @mdev: the mediated device
> + * @matrix_mdev: the mediated matrix device
> + * @apid: the APID to validate
> + *
> + * Validates the value of @apid:
> + *	* If there are no AP domains assigned, then there must be at least
> + *	  one AP queue device reserved by the VFIO AP device driver with an
> + *	  APQN containing @apid.
> + *
> + *	* Else each APQN that can be derived from the intersection of @apid and
> + *	  the IDs of the AP domains already assigned must identify an AP queue
> + *	  that has been reserved by the VFIO AP device driver.
> + *
> + * Returns 0 if the value of @apid is valid; otherwise, returns an error.
> + */
> +static int vfio_ap_validate_apid(struct mdev_device *mdev,
> +				 struct ap_matrix_mdev *matrix_mdev,
> +				 unsigned long apid)
> +{
> +	int ret;
> +	unsigned long aqmsz = matrix_mdev->matrix.aqm_max + 1;
> +	struct device *dev = mdev_parent_dev(mdev);
> +	struct ap_matrix_dev *matrix_dev = to_ap_matrix_dev(dev);
> +	struct ap_matrix matrix = matrix_mdev->matrix;
> +
> +	/* If there are any queues assigned to the mediated device */
> +	if (find_first_bit_inv(matrix.aqm, aqmsz) < aqmsz) {
> +		matrix.apm_max = matrix_mdev->matrix.apm_max;
> +		memset(matrix.apm, 0,
> +		       ARRAY_SIZE(matrix.apm) * sizeof(matrix.apm[0]));
> +		set_bit_inv(apid, matrix.apm);
> +		matrix.aqm_max = matrix_mdev->matrix.aqm_max;
> +		memcpy(matrix.aqm, matrix_mdev->matrix.aqm,
> +		       ARRAY_SIZE(matrix.aqm) * sizeof(matrix.aqm[0]));
> +		ret = vfio_ap_verify_queues_reserved(matrix_dev,
> +						     matrix_mdev->name,
> +						     &matrix);
> +	} else {
> +		ret = vfio_ap_verify_apid_reserved(matrix_dev,
> +						   matrix_mdev->name, apid);
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * assign_adapter_store
> + *
> + * @dev: the matrix device
> + * @attr: a mediated matrix device attribute
> + * @buf: a buffer containing the adapter ID (APID) to be assigned
> + * @count: the number of bytes in @buf
> + *
> + * Parses the APID from @buf and assigns it to the mediated matrix device. The
> + * APID must be a valid value:
> + *	* The APID value must not exceed the maximum allowable AP adapter ID
> + *
> + *	* If there are no AP domains assigned, then there must be at least
> + *	  one AP queue device reserved by the VFIO AP device driver with an
> + *	  APQN containing @apid.

I do not understand the reason here.
Can you develop?

I suppose that by reserved you mean bound. (then use bound)
But I still can not understand the reason why.

Beside if I understand correctly what you do it forbid the automatic
assignment of a new card plugged into the host.

> + *
> + *	* Else each APQN that can be derived from the intersection of @apid and
> + *	  the IDs of the AP domains already assigned must identify an AP queue
> + *	  that has been reserved by the VFIO AP device driver.
> + *
> + * Returns the number of bytes processed if the APID is valid; otherwise returns
> + * an error.
> + */
> +static ssize_t assign_adapter_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	int ret;
> +	unsigned long apid;
> +	struct mdev_device *mdev = mdev_from_dev(dev);
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	unsigned long max_apid = matrix_mdev->matrix.apm_max;
> +
> +	ret = kstrtoul(buf, 0, &apid);
> +	if (ret || (apid > max_apid)) {
> +		pr_err("%s: %s: adapter id '%s' not a value from 0 to %02lu(%#04lx)",
> +		       VFIO_AP_MODULE_NAME, __func__, buf, max_apid, max_apid);
> +
> +		return ret ? ret : -EINVAL;
> +	}
> +
> +	ret = vfio_ap_validate_apid(mdev, matrix_mdev, apid);
> +	if (ret)
> +		return ret;
> +
> +	/* Set the bit in the AP mask (APM) corresponding to the AP adapter
> +	 * number (APID). The bits in the mask, from most significant to least
> +	 * significant bit, correspond to APIDs 0-255.
> +	 */
> +	set_bit_inv(apid, matrix_mdev->matrix.apm);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(assign_adapter);
> +
> +/**
> + * unassign_adapter_store
> + *
> + * @dev: the matrix device
> + * @attr: a mediated matrix device attribute
> + * @buf: a buffer containing the adapter ID (APID) to be assigned
> + * @count: the number of bytes in @buf
> + *
> + * Parses the APID from @buf and unassigns it from the mediated matrix device.
> + * The APID must be a valid value
> + *
> + * Returns the number of bytes processed if the APID is valid; otherwise returns
> + * an error.
> + */
> +static ssize_t unassign_adapter_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	int ret;
> +	unsigned long apid;
> +	struct mdev_device *mdev = mdev_from_dev(dev);
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	unsigned long max_apid = matrix_mdev->matrix.apm_max;
> +
> +	ret = kstrtoul(buf, 0, &apid);
> +	if (ret || (apid > max_apid)) {
> +		pr_err("%s: %s: adapter id '%s' must be a value from 0 to %02lu(%#04lx)",
> +		       VFIO_AP_MODULE_NAME, __func__, buf, max_apid, max_apid);
> +
> +		return ret ? ret : -EINVAL;
> +	}
> +
> +	if (!test_bit_inv(apid, matrix_mdev->matrix.apm)) {
> +		pr_err("%s: %s: adapter id %02lu(%#04lx) not assigned",
> +		       VFIO_AP_MODULE_NAME, __func__, apid, apid);
> +
> +		return -ENODEV;
> +	}
> +
> +	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
> +
> +	return count;
> +}
> +DEVICE_ATTR_WO(unassign_adapter);
> +
> +static struct attribute *vfio_ap_mdev_attrs[] = {
> +	&dev_attr_assign_adapter.attr,
> +	&dev_attr_unassign_adapter.attr,
> +	NULL
> +};
> +
> +static struct attribute_group vfio_ap_mdev_attr_group = {
> +	.attrs = vfio_ap_mdev_attrs
> +};
> +
> +static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
> +	&vfio_ap_mdev_attr_group,
> +	NULL
> +};
> +
>   static const struct mdev_parent_ops vfio_ap_matrix_ops = {
>   	.owner			= THIS_MODULE,
>   	.supported_type_groups	= vfio_ap_mdev_type_groups,
> +	.mdev_attr_groups	= vfio_ap_mdev_attr_groups,
>   	.create			= vfio_ap_mdev_create,
>   	.remove			= vfio_ap_mdev_remove,
>   };


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

