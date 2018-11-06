Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064BFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B842083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B842083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbeKGFsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:48:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727248AbeKGFsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:48:21 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA6KIi1X008965
        for <linux-kernel@vger.kernel.org>; Tue, 6 Nov 2018 15:21:23 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nkh07jfdu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 15:21:22 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 6 Nov 2018 20:21:21 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 6 Nov 2018 20:21:19 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA6KLFlw29294708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 20:21:15 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 516D52805C;
        Tue,  6 Nov 2018 20:21:15 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBDB728064;
        Tue,  6 Nov 2018 20:21:14 +0000 (GMT)
Received: from [9.60.85.3] (unknown [9.60.85.3])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Nov 2018 20:21:14 +0000 (GMT)
Subject: Re: [PATCH v1 6/7] vfio: ap: register guest ISC with GISA and GIB
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
 <1541009577-29656-7-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 6 Nov 2018 15:21:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541009577-29656-7-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18110620-0060-0000-0000-000002CE588A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009998; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113636; UDB=6.00577302; IPR=6.00893736;
 MB=3.00024049; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 20:21:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110620-0061-0000-0000-0000471C3931
Message-Id: <382fe325-e12d-8be8-7f30-c3c64bd37505@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 2:12 PM, Pierre Morel wrote:
> Register to the GIB Alert list and retrieve the GAL_ISC
> to pass to the GISA registration.
> 
> Unregister on error and when clearing the interrupt.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index f68102163bf4..232168797fb8 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -903,16 +903,20 @@ static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
>   	struct ap_status ap_status = reg2status(0);
>   	unsigned long p;
>   	int ret = -1;
> -	int apqn;
> +	int apqn, gal_isc;
>   	uint32_t gd;
>   
> +	gal_isc = kvm_s390_gisc_register(matrix_mdev->kvm, matrix_mdev->gisc);
> +	if (gal_isc < 0)
> +		return -EIO;
> +
>   	apqn = (int)(parm->cmd & 0xffff);
>   
>   	gd = matrix_mdev->kvm->vcpus[0]->arch.sie_block->gd;
>   	if (gd & 0x01)
>   		aqic_gisa.f = 1;
>   	aqic_gisa.gisc = matrix_mdev->gisc;
> -	aqic_gisa.isc = GAL_ISC;
> +	aqic_gisa.isc = gal_isc;
>   	aqic_gisa.ir = 1;
>   	aqic_gisa.gisao = gisa->next_alert >> 4;
>   
> @@ -923,7 +927,11 @@ static int ap_ioctl_setirq(struct ap_matrix_mdev *matrix_mdev,
>   	parm->status = ret;
>   
>   	ap_status = reg2status(ret);
> -	return (ap_status.rc) ? -EIO : 0;
> +	if (ap_status.rc) {
> +		kvm_s390_gisc_unregister(matrix_mdev->kvm, matrix_mdev->gisc);
> +		return -EIO;
> +	}
> +	return 0;
>   }
>   
>   static int ap_ioctl_clrirq(struct ap_matrix_mdev *matrix_mdev,
> @@ -946,6 +954,8 @@ static int ap_ioctl_clrirq(struct ap_matrix_mdev *matrix_mdev,
>   	parm->status = retval;
>   
>   	ap_status = reg2status(retval);
> +	/* unregister the IAM from the GIB anyway! */
> +	kvm_s390_gisc_unregister(matrix_mdev->kvm, matrix_mdev->gisc);

The case statement in patch 4 does not set mdev->gisc, so the
presumption here is that VFIO_AP_SET_IRQ has been previously called and
has set the value for matrix_mdev->gisc. Is it possible for
VFIO_AP_CLEAR_IRQ to get invoked without a prior call to
VFIO_AP_SET_IRQ? In any case, shouldn't the GISC value be taken from
bits 61-63 of 'parm'?

>   	return (ap_status.rc) ? -EIO : 0;
>   }
>   
> 

