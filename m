Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA390C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B548222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389846AbfBOWat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:30:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727270AbfBOWat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:30:49 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FMOZD9034326
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:30:47 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qp5m2s91r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 17:30:47 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 15 Feb 2019 22:30:46 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Feb 2019 22:30:44 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1FMUe2q22741244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 22:30:40 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C717AE05F;
        Fri, 15 Feb 2019 22:30:40 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 859EFAE05C;
        Fri, 15 Feb 2019 22:30:39 +0000 (GMT)
Received: from [9.80.239.175] (unknown [9.80.239.175])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 15 Feb 2019 22:30:39 +0000 (GMT)
Subject: Re: [PATCH v3 5/9] s390: ap: tools to associate a queue to a matrix
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-6-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 15 Feb 2019 17:30:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550152269-6317-6-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021522-0052-0000-0000-0000038B4721
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010604; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000280; SDB=6.01161598; UDB=6.00606360; IPR=6.00942158;
 MB=3.00025605; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-15 22:30:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021522-0053-0000-0000-00005FDC5B3B
Message-Id: <061c4900-03fa-8320-c3a0-c832ccd152aa@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 8:51 AM, Pierre Morel wrote:
> We need tools to associate a queue and a matrix to be able
> later to find the matrix associated with the queue for which
> we got the APQN in the register 1 during a PQAP/AQIC instruction
> interception.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 66 +++++++++++++++++++++++++++++++++--
>   drivers/s390/crypto/vfio_ap_private.h |  1 +
>   2 files changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 2a52c9b..1851b24 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -50,8 +50,7 @@ static int vfio_ap_check_apqn(struct device *dev, void *data)
>    *
>    * Returns the pointer to the associated vfio_ap_queue
>    */
> -static  __attribute__((unused))
> -	struct vfio_ap_queue *vfio_ap_get_queue(int apqn)

I don't like this, it indicates to me that this and the previous
patch should have been squashed together. I realize your intent
was to make the patches smaller, but I don't think this makes it
any easier to review them. In fact, it makes it harder IMHO, because
you have to flip back and forth between patches to fully comprehend
the usage.

> +static struct vfio_ap_queue *vfio_ap_get_queue(int apqn)
>   {
>   	struct device *dev;
>   	struct vfio_ap_queue *q;
> @@ -72,7 +71,7 @@ static  __attribute__((unused))
>    * put the associated device
>    *
>    */
> -static  __attribute__((unused)) void vfio_ap_put_queue(struct vfio_ap_queue *q)

Ditto for this.

> +static void vfio_ap_put_queue(struct vfio_ap_queue *q)
>   {
>   	put_device(q->dev);
>   	q->dev = NULL;
> @@ -867,6 +866,67 @@ static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>   	return -EBUSY;
>   }
>   
> +/**
> + * vfio_ap_dissociate_queues: Dissociate a matrix mediated device to a queue
> + *
> + * Go through all bits in the AQM and APM and dissociate the queue
> + * from the matrix device.
> + *
> + * No return value we are throwing the mediated device anyway.
> + */
> +static void vfio_ap_dissociate_queues(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	unsigned long apid, apqi;

The changes I recommend here are based on the comments in my
response to patch 4.

> +	struct vfio_ap_queue *q;

Add this:

	struct device *qdev;

> +
> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
> +			     matrix_mdev->matrix.apm_max + 1) {
> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
> +				     matrix_mdev->matrix.aqm_max + 1) {
> +			q = vfio_ap_get_queue(AP_MKQID(apid, apqi));

Replace with:
	qdev = vfio_ap_get_queue_dev(AP_MKQID(apid, apqi);

> +			if (q) {

Replace with:
	if (qdev) {

Add this:
	q = dev_get_drvdata(qdev);

> +				vfio_ap_mdev_reset_queue(apid, apqi, 1);
> +				q->matrix = NULL;
> +				vfio_ap_put_queue(q);

Replace with:
	put_device(qdev)

> +			} else
> +				pr_err("%s: no queue for %02lx.%04lx\n",
> +				       __func__, apid, apqi);
> +		}
> +	}
> +}
> +
> +/**
> + * vfio_ap_associate_queues: Associate a matrix mediated device to a queue
> + *
> + * Go through all bits in the AQM and APM and calculate the APQN, and find
> + * the matching queue to associate with the matrix device.
> + *
> + * In the case a queue could not be found return -ENODEV.
> + * Otherwise return 0.
> + */
> +static __attribute__((unused))

This indicates this patch should be squashed with the patch that
introduces this function. Why have a patch that introduces a function
that is not used and put and artificially specify an attribute just to
keep the compiler from issuing a warning?

> +	int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)
> +{

The same as above, the changes I recommend here are based on the
comments in my response to patch 4.

> +	unsigned long apid, apqi;
> +	struct vfio_ap_queue *q;

Add:
	struct device *qdev;

> +
> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
> +			     matrix_mdev->matrix.apm_max + 1) {
> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
> +				     matrix_mdev->matrix.aqm_max + 1) {
> +			q = vfio_ap_get_queue(AP_MKQID(apid, apqi));

Replace with:
	qdev = vfio_ap_get_queue_dev(AP_MKQID(apid, apqi));
> +			if (!q)

Replace with:
	if (!qdev)

> +				goto error;

Add:
	q = dev_get_drvdata(qdev);

> +			q->matrix = matrix_mdev;
> +			vfio_ap_put_queue(q);


Replace with:
	put_device(qdev);



> +		}
> +	}
> +	return 0;
> +error:
> +	pr_err("%s: no queue for %02lx.%04lx\n", __func__, apid, apqi);
> +	vfio_ap_dissociate_queues(matrix_mdev);
> +	return -ENODEV;
> +}
>   static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>   {
>   	int ret;
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 081f0d7..10bc8b5 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -89,5 +89,6 @@ extern void vfio_ap_mdev_unregister(void);
>   struct vfio_ap_queue {
>   	struct device *dev;
>   	int	apqn;
> +	struct ap_matrix_mdev *matrix;

Can you rename this variable matrix_mdev?
* That is how struct ap_matrix_mdev vars are named everywhere else
* It prevents confusing it with naming of vars for struct ap_matrix.

>   };
>   #endif /* _VFIO_AP_PRIVATE_H_ */
> 

