Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CAAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A55F2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A55F2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbeHOTwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:52:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729388AbeHOTwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:52:45 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FGxXOi057337
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:59:47 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kvn0s0qxj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 12:59:47 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 15 Aug 2018 10:59:46 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 Aug 2018 10:59:42 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7FGxdNJ13042018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Aug 2018 09:59:39 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A31F136059;
        Wed, 15 Aug 2018 10:59:39 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D197D136051;
        Wed, 15 Aug 2018 10:59:35 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.175.5])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 15 Aug 2018 10:59:35 -0600 (MDT)
Subject: Re: [PATCH v9 10/22] s390: vfio-ap: sysfs interfaces to configure
 adapters
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
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180815115242.35a2a1ce.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 15 Aug 2018 12:59:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180815115242.35a2a1ce.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081516-0012-0000-0000-0000169EF8CB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009550; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073947; UDB=6.00553401; IPR=6.00853906;
 MB=3.00022736; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-15 16:59:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081516-0013-0000-0000-0000540D2915
Message-Id: <4bf27c7a-34c6-9160-cdc6-19022b86202b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808150179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 05:52 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:07 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> +/**
>> + * assign_adapter_store
>> + *
>> + * @dev: the matrix device
>> + * @attr: a mediated matrix device attribute
>> + * @buf: a buffer containing the adapter ID (APID) to be assigned
>> + * @count: the number of bytes in @buf
>> + *
>> + * Parses the APID from @buf and assigns it to the mediated matrix device.
>> + *
>> + * Returns the number of bytes processed if the APID is valid; otherwise returns
>> + * an error.
>> + */
>> +static ssize_t assign_adapter_store(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    const char *buf, size_t count)
>> +{
>> +	int ret = 0;
> You don't need to initialize this to 0, as kstrtoul will set it in any
> case.

Right you are! Will change it.

>
>> +	unsigned long apid;
>> +	struct mdev_device *mdev = mdev_from_dev(dev);
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +	unsigned long max_apid = matrix_mdev->matrix.apm_max;
>> +
>> +	ret = kstrtoul(buf, 0, &apid);
>> +	if (ret)
>> +		return ret;
>> +	if (apid > max_apid)
>> +		return -EINVAL;
>> +
>> +	/* Set the bit in the AP mask (APM) corresponding to the AP adapter
>> +	 * number (APID). The bits in the mask, from most significant to least
>> +	 * significant bit, correspond to APIDs 0-255.
>> +	 */
>> +	mutex_lock(&matrix_dev.lock);
>> +
>> +	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);
> That function name really is a mouthful :) I don't have any better
> suggestions, though.

It is, but I think it describes exactly what the function does.

>
>> +	if (ret)
>> +		goto done;
>> +
>> +	set_bit_inv(apid, matrix_mdev->matrix.apm);
>> +
>> +	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
>> +	if (ret)
>> +		goto share_err;
>> +
>> +	ret = count;
>> +	goto done;
>> +
>> +share_err:
>> +	clear_bit_inv(apid, matrix_mdev->matrix.apm);
>> +done:
>> +	mutex_unlock(&matrix_dev.lock);
>> +
>> +	return ret;
>> +}
>> +static DEVICE_ATTR_WO(assign_adapter);
>> +
>> +/**
>> + * unassign_adapter_store
>> + *
>> + * @dev: the matrix device
>> + * @attr: a mediated matrix device attribute
>> + * @buf: a buffer containing the adapter ID (APID) to be assigned
>> + * @count: the number of bytes in @buf
>> + *
>> + * Parses the APID from @buf and unassigns it from the mediated matrix device.
>> + * The APID must be a valid value
> A valid value, but not necessarily assigned, right?

You are correct, if the APID is not assigned, then the corresponding bit 
will be
cleared regardless. In a previous version, the functions failed if the 
APID is
not assigned, but a colleague removed that check. I guess it makes sense 
given
it really does not hurt anything to ask to unassign an APID that isn't 
assigned
to begin with. Would you prefer I update the comment, or do you feel the 
user
should be made aware of an attempt to unassign an APID that is not assigned?

>
>> + *
>> + * Returns the number of bytes processed if the APID is valid; otherwise returns
>> + * an error.
>> + */
>> +static ssize_t unassign_adapter_store(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      const char *buf, size_t count)
>> +{
>> +	int ret;
>> +	unsigned long apid;
>> +	struct mdev_device *mdev = mdev_from_dev(dev);
>> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +
>> +	ret = kstrtoul(buf, 0, &apid);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (apid > matrix_mdev->matrix.apm_max)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&matrix_dev.lock);
>> +	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
>> +	mutex_unlock(&matrix_dev.lock);
>> +
>> +	return count;
>> +}
>> +DEVICE_ATTR_WO(unassign_adapter);
> In general, looks good to me.

That is good news indeed.

>

