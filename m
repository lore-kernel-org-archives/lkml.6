Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6064EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF8121903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfBSJ74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:59:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726969AbfBSJ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:59:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1J9sHe5082526
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 04:59:54 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qrfg0rm8h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 04:59:54 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 19 Feb 2019 09:59:52 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Feb 2019 09:59:49 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1J9xl8C58523690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 09:59:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75DC342045;
        Tue, 19 Feb 2019 09:59:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06C4B4203F;
        Tue, 19 Feb 2019 09:59:47 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.97.246])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Feb 2019 09:59:46 +0000 (GMT)
Date:   Tue, 19 Feb 2019 10:59:46 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v3 6/9] vfio: ap: register IOMMU VFIO notifier
In-Reply-To: <3ce0a3a0-22fb-c418-321d-7e6e3af5b66c@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-7-git-send-email-pmorel@linux.ibm.com>
        <3ce0a3a0-22fb-c418-321d-7e6e3af5b66c@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021909-0012-0000-0000-000002F774A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021909-0013-0000-0000-0000212F00D2
Message-Id: <20190219105946.29e510a6@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 17:55:35 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 2/14/19 8:51 AM, Pierre Morel wrote:
> > To be able to use the VFIO interface to facilitate the
> > mediated device memory pining/unpining we need to register
> > a notifier for IOMMU.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >   drivers/s390/crypto/vfio_ap_ops.c     | 64 +++++++++++++++++++++++++++++++----
> >   drivers/s390/crypto/vfio_ap_private.h |  2 ++
> >   2 files changed, 60 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> > index 1851b24..6eddc2c 100644
> > --- a/drivers/s390/crypto/vfio_ap_ops.c
> > +++ b/drivers/s390/crypto/vfio_ap_ops.c

[..]
  	struct vfio_ap_queue *q;
> > @@ -967,12 +996,32 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
> >   
> >   	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> >   				     &events, &matrix_mdev->group_notifier);
> > -	if (ret) {
> > -		module_put(THIS_MODULE);
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		goto err_group;
> > +
> > +	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
> > +	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
> > +
> > +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> > +				     &events, &matrix_mdev->iommu_notifier);
> > +	if (ret)
> > +		goto err_iommu;
> > +
> > +	ret = vfio_ap_associate_queues(matrix_mdev);
> > +	if (ret)
> > +		goto err_associate;
> 
> I think the matrix_mdev should be associated with queues when an 
> assignment of an adapter or domain is made to the mdev device via its
> sysfs interfaces. I say this because assigning an adapter or domain to
> an mdev device effectively grants ownership of any additional AP queues 
> added to the mdev device's AP matrix as a result of the assignment. It
> only makes sense to assign ownership to the vfio_ap_queue objects
> representing the queues at that time. If an adapter or domain is
> dynamically assigned while a guest is using the affected queues, then
> the associations will have to be made at that time and this code will
> likely go bye bye.
>


Actually, we need the stuff in vfio_ap_queues only if the guest is
offered to  decides to use AP adaper interrupts. I would prefer to have
it around only when needed: as long as we have the nib pinned for any
given queue. Is there a reason why not to do so? 

Regards,
Halil
 
[..]

