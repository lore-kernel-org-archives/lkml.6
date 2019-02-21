Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18301C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A232083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfBUPV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:21:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbfBUPV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:21:58 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LFLm4K093021
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:21:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qsvvj5x9g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:21:54 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 21 Feb 2019 15:21:17 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 15:21:15 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LFLEkR29294746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:21:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42A3A4C052;
        Thu, 21 Feb 2019 15:21:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9FAC4C04E;
        Thu, 21 Feb 2019 15:21:13 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.46])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 15:21:13 +0000 (GMT)
Date:   Thu, 21 Feb 2019 16:21:12 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com
Subject: Re: [PATCH v3 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
In-Reply-To: <20190221160910.5bf34f04.cohuck@redhat.com>
References: <1550758494-28227-1-git-send-email-pmorel@linux.ibm.com>
        <1550758494-28227-2-git-send-email-pmorel@linux.ibm.com>
        <20190221160910.5bf34f04.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022115-0028-0000-0000-0000034B59FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022115-0029-0000-0000-000024099F49
Message-Id: <20190221162112.19d54f71@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 16:09:10 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 21 Feb 2019 15:14:54 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > Libudev relies on having a subsystem link for non-root devices. To
> > avoid libudev (and potentially other userspace tools) choking on the
> > matrix device let us introduce a matrix bus and with it the matrix
> > bus subsytem. Also make the matrix device reside within the matrix
> > bus.
> > 
> > Doing this we remove the forced link from the matrix device to the
> > vfio_ap driver and the device_type we do not need anymore.
> > 
> > Since the associated matrix driver is not the vfio_ap driver any more,
> > we have to change the search for the devices on the vfio_ap driver in
> > the function vfio_ap_verify_queue_reserved.
> > 
> > Fixes: 1fde573413b5 ("s390: vfio-ap: base implementation of VFIO AP device driver")
> > 
> > Cc: stable@vger.kernel.org
> > 
> 
> I'd kill the two empty lines.

The summary/title line is a bit weird. It says link to the vfio_ap bus
subsystem, which sounds like establishing a relationship between two
pre-existing entities.  But this change actually introduces the vfio_bus.
I would prefer something like "introduce vfio_ap bus".

I don't feel strongly about it.

Regards,
Halil

> 
> > Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Acked-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >  drivers/s390/crypto/vfio_ap_drv.c     | 44 ++++++++++++++++++++++++++++-------
> >  drivers/s390/crypto/vfio_ap_ops.c     |  4 ++--
> >  drivers/s390/crypto/vfio_ap_private.h |  1 +
> >  3 files changed, 38 insertions(+), 11 deletions(-)
> 
> Otherwise, still looks good.
> 

