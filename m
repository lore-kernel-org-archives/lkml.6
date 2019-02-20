Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0B6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA4F20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfBTMvT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:51:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727879AbfBTMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:51:19 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KCjHY0119166
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:51:18 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qs6etaaqx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:51:17 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 20 Feb 2019 12:51:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Feb 2019 12:51:12 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1KCpA8r48562428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 12:51:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 817C542041;
        Wed, 20 Feb 2019 12:51:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2503142045;
        Wed, 20 Feb 2019 12:51:10 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.98.235])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Feb 2019 12:51:10 +0000 (GMT)
Date:   Wed, 20 Feb 2019 13:51:08 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
In-Reply-To: <20190220102731.4fca4f91.cohuck@redhat.com>
References: <1550513328-12646-1-git-send-email-pmorel@linux.ibm.com>
        <1550513328-12646-2-git-send-email-pmorel@linux.ibm.com>
        <8e6853ba-12ed-a4f3-1263-0e15f715b644@linux.ibm.com>
        <6cc5b478-4678-9a82-b902-cc9aed22becf@linux.ibm.com>
        <20190220102731.4fca4f91.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19022012-4275-0000-0000-00000311C378
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022012-4276-0000-0000-0000381FF356
Message-Id: <20190220135108.49f8f891@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 10:27:31 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 19 Feb 2019 22:31:17 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > On 19/02/2019 19:52, Tony Krowiak wrote:
> > > On 2/18/19 1:08 PM, Pierre Morel wrote:  
> > >> Libudev relies on having a subsystem link for non-root devices. To
> > >> avoid libudev (and potentially other userspace tools) choking on the
> > >> matrix device let us introduce a vfio_ap bus and with that the vfio_ap
> > >> bus subsytem, and make the matrix device reside within it.
> > >>
> > >> Doing this we need to suppress the forced link from the matrix device to
> > >> the vfio_ap driver and we suppress the device_type we do not need
> > >> anymore.
> > >>
> > >> Since the associated matrix driver is not the vfio_ap driver any more,
> > >> we have to change the search for the devices on the vfio_ap driver in
> > >> the function vfio_ap_verify_queue_reserved.
> > >>
> > >> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > >> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > >> ---
> > >>   drivers/s390/crypto/vfio_ap_drv.c     | 48 
> > >> +++++++++++++++++++++++++++++------
> > >>   drivers/s390/crypto/vfio_ap_ops.c     |  4 +--
> > >>   drivers/s390/crypto/vfio_ap_private.h |  1 +
> > >>   3 files changed, 43 insertions(+), 10 deletions(-)
> > >>
> > >> diff --git a/drivers/s390/crypto/vfio_ap_drv.c 
> > >> b/drivers/s390/crypto/vfio_ap_drv.c
> > >> index 31c6c84..8e45559 100644
> > >> --- a/drivers/s390/crypto/vfio_ap_drv.c
> > >> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> > >> @@ -24,10 +24,6 @@ MODULE_LICENSE("GPL v2");
> > >>   static struct ap_driver vfio_ap_drv;
> > >> -static struct device_type vfio_ap_dev_type = {
> > >> -    .name = VFIO_AP_DEV_TYPE_NAME,
> > >> -};
> > >> -
> > >>   struct ap_matrix_dev *matrix_dev;
> > >>   /* Only type 10 adapters (CEX4 and later) are supported
> > >> @@ -62,6 +58,27 @@ static void vfio_ap_matrix_dev_release(struct 
> > >> device *dev)
> > >>       kfree(matrix_dev);
> > >>   }
> > >> +static int matrix_bus_match(struct device *dev, struct device_driver 
> > >> *drv)
> > >> +{
> > >> +    return 1;  
> > > 
> > > I think we should verify the following:
> > > 
> > > * dev == matrix_dev->device
> > > * drv == &matrix_driver
> > > 
> > > The model employed is for the matrix device to be a singleton, so I
> > > think we should verify that the matrix device and driver defined herein
> > > ought to be the only possible choices for a match. Of course, doing so
> > > will require some restructuring of this patch.  
> > 
> > I think Conny already answered this question.
> 
> Not quite :), but I don't think we need any magic in there, as there's
> only one device and only one driver on that bus. No need to make this
> more complicated.
> 


I agree, no need to complicate this any further.

> > 
> > >   
> > >> +}
> > >> +
> > >> +static struct bus_type matrix_bus = {
> > >> +    .name = "vfio_ap",
> > >> +    .match = &matrix_bus_match,
> > >> +};
> > >> +
> > >> +static int matrix_probe(struct device *dev)
> > >> +{
> > >> +    return 0;
> > >> +}
> > >> +
> > >> +static struct device_driver matrix_driver = {
> > >> +    .name = "vfio_ap",  
> > > 
> > > This is the same name used for the original device driver. I think
> > > this driver ought to have a different name to avoid confusion.
> > > How about vfio_ap_matrix or some other name to differentiate the
> > > two.  
> > 
> > I would like too, but changing this will change the path to the mediated 
> > device supported type.
> 
> Yes, we don't want to change that.
> 

Nod.

> > 
> > 
> > >   
> > >> +    .bus = &matrix_bus,
> > >> +    .probe = matrix_probe,  
> > > 
> > > I would add:
> > >      .suppress_bind_attrs = true;
> > > 
> > > This will remove the sysfs bind/unbind interfaces. Since there is only
> > > one matrix device and it's lifecycle is controlled herein, there is no
> > > sense in allowing a root user to bind/unbind it.
> > >   
> > 
> > OTOH bind/unbind has no impact.
> > If no one else ask for this I will not change what has already been 
> > reviewed by Conny and Christian.
> 
> As we only have one driver, it does not really make sense anyway.
> 

I see this as a reason to suppress_bind_attrs. It is much easier than to
think about what should happen when one unbinds the matrix device from
the vfio_ap driver on the vfio_ap bus. With the code as is it seems to
just keep working as if nothing happened.
And /sys/devices/vfio_ap/matrix/mdev_supported_types/ referencing the
name of the driver that is already gone sounds a bit weird.

Regards,
Halil

