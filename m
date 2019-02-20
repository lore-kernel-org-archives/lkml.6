Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B2CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AA42086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfBTLyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:54:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbfBTLyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:54:31 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KBn5S3147294
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 06:54:30 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qs5gmb12a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 06:54:29 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 20 Feb 2019 11:54:26 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Feb 2019 11:54:24 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1KBsMgB20906086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 11:54:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69526A4053;
        Wed, 20 Feb 2019 11:54:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED946A4040;
        Wed, 20 Feb 2019 11:54:21 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.98.235])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Feb 2019 11:54:21 +0000 (GMT)
Date:   Wed, 20 Feb 2019 12:54:20 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v3 7/9] s390: ap: implement PAPQ AQIC interception in
 kernel
In-Reply-To: <1550152269-6317-8-git-send-email-pmorel@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-8-git-send-email-pmorel@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022011-4275-0000-0000-00000311BCE6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022011-4276-0000-0000-0000381FEC8D
Message-Id: <20190220125420.04984405@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=744 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 14:51:07 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We register the AP PQAP instruction hook during the open
> of the mediated device. And unregister it on release.
> 
> In the AP PQAP instruction hook, if we receive a demand to
> enable IRQs,
> - we retrieve the vfio_ap_queue based on the APQN we receive
>   in REG1,
> - we retrieve the page of the guest address, (NIB), from
>   register REG2
> - we the mediated device to use the VFIO pinning infratrsucture
>   to pin the page of the guest address,
> - we retrieve the pointer to KVM to register the guest ISC
>   and retrieve the host ISC
> - finaly we activate GISA
> 
> If we receive a demand to disable IRQs,
> - we deactivate GISA
> - unregister from the GIB
> - unping the NIB
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---

[..]

> +static int handle_pqap(struct kvm_vcpu *vcpu)
> +{
> +	uint64_t status;
> +	uint16_t apqn;
> +	struct vfio_ap_queue *q;
> +	struct ap_queue_status qstatus = {};
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	/* If we do not use the AIV facility just go to userland */
> +	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
> +		return -EOPNOTSUPP;
> +
> +	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
> +	q = vfio_ap_get_queue(apqn);
> +	if (!q) {
> +		qstatus.response_code = AP_RESPONSE_Q_NOT_AVAIL;
> +		goto out;
> +	}
> +
> +	/* Check if the queue is associated with a guest matrix */
> +	matrix_mdev = q->matrix;
> +	if (!matrix_mdev || !matrix_mdev->kvm) {
> +		qstatus.response_code = AP_RESPONSE_DECONFIGURED;
> +		goto out;
> +	}
> +
> +	status = vcpu->run->s.regs.gprs[1];
> +
> +	/* If IR bit(16) is set we enable the interrupt */
> +	if ((status >> (63 - 16)) & 0x01) {
> +		q->isc = status & 0x07;
> +		q->nib = vcpu->run->s.regs.gprs[2];

Careful! You may already have q->nib set (may or may not be a 0x07
scenario). You should unpin the old nib if set interruption controls
works out, if we get 0x07 response then you unpin the new one.


> +		qstatus = vfio_ap_setirq(q);
> +		if (qstatus.response_code) {
> +			q->nib = 0;
> +			q->isc = 0;
> +		}
> +	} else
> +		qstatus = vfio_ap_clrirq(q);
> +
> +out:
> +	memcpy(&vcpu->run->s.regs.gprs[1], &qstatus, sizeof(qstatus));
> +	vfio_ap_put_queue(q);
> +	return 0;
> +}

[..]

>  
> @@ -877,11 +1052,15 @@ static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>  				    unsigned int retry)
>  {
>  	struct ap_queue_status status;
> +	struct vfio_ap_queue *q;
> +
> +	q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
>  
>  	do {
>  		status = ap_zapq(AP_MKQID(apid, apqi));
>  		switch (status.response_code) {
>  		case AP_RESPONSE_NORMAL:

You could do the get queue here

> +			vfio_ap_free_irq(q);

And the put here.


Regards,
Halil

>  			return 0;
>  		case AP_RESPONSE_RESET_IN_PROGRESS:
>  		case AP_RESPONSE_BUSY:
> @@ -999,6 +1178,11 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>  	if (ret)
>  		goto err_group;
>  
> +	if (!matrix_mdev->kvm) {
> +		ret = -ENODEV;
> +		goto err_iommu;
> +	}
> +
>  	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>  	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>  

[..]

