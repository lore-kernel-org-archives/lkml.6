Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A3C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D92B20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D92B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbeLNMmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:42:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730364AbeLNMmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:42:17 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBECdAW5021192
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 07:42:16 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pcahj633c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 07:42:16 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 14 Dec 2018 12:42:14 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 12:42:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBECg9dk45547688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 12:42:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AB8FAE04D;
        Fri, 14 Dec 2018 12:42:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28711AE05F;
        Fri, 14 Dec 2018 12:42:09 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.98.143])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 12:42:09 +0000 (GMT)
Date:   Fri, 14 Dec 2018 13:42:07 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, pasic@linux.vnet.ibm.com,
        farman@linux.ibm.com, alifm@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] vfio: ccw: serialize the write system calls
In-Reply-To: <20181213163953.5b534e6b.cohuck@redhat.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
        <1543408867-16465-7-git-send-email-pmorel@linux.ibm.com>
        <20181213163953.5b534e6b.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121412-0012-0000-0000-000002D9039C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121412-0013-0000-0000-0000210E8EC9
Message-Id: <20181214134207.1a6a95b9@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 16:39:53 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 28 Nov 2018 13:41:07 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > When the user program is QEMU we rely on the QEMU lock to serialize
> > the calls to the driver.
> > 
> > In the general case we need to make sure that two data transfer are
> > not started at the same time.
> > It would in the current implementation resul in a overwriting of the
> > IO region.
> > 
> > We also need to make sure a clear or a halt started after a data
> > transfer do not win the race agains the data transfer.
> > Which would result in the data transfer being started after the
> > halt/clear.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >  drivers/s390/cio/vfio_ccw_ops.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> > index eb5b49d..b316966 100644
> > --- a/drivers/s390/cio/vfio_ccw_ops.c
> > +++ b/drivers/s390/cio/vfio_ccw_ops.c
> > @@ -267,22 +267,31 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
> >  {
> >  	unsigned int index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
> >  	struct vfio_ccw_private *private;
> > +	static atomic_t serialize  = ATOMIC_INIT(0);
> > +	int ret = -EINVAL;
> > +
> > +	if (!atomic_add_unless(&serialize, 1, 1))
> > +		return -EBUSY;
> 
> I think that hammer is far too big: This serializes _all_ write
> operations across _all_ devices.
> 
> There are various cases of simultaneous writes that may happen
> (assuming any userspace; QEMU locking will prevent some of them from
> happening):
> 
> - One thread does a write for one mdev, another thread does a write for
>   another mdev. For example, if two vcpus issue an I/O instruction on
>   two different devices. This should be fine.
> - One thread does a write for one mdev, another thread does a write for
>   the same mdev. Maybe a guest has confused/no locking and is trying to
>   do ssch on the same device from different vcpus. There, we want to
>   exclude simultaneous writes; the desired outcome may be that one ssch
>   gets forwarded to the hardware, and the second one either gets
>   forwarded after processing for the first one has finished, or
>   userspace gets an error immediately (hopefully resulting in a
>   appropriate condition code for that second ssch in any case). Both
>   handing the second ssch to the hardware or signaling device busy
>   immediately are probably sane in that case.
> - If those writes for the same device involve hsch/csch, things get
>   more complicated. First, we have two different regions, and allowing
>   simultaneous writes to the I/O region and to the async region should
>   not really be a problem, so I don't think fencing should be done in
>   the generic write handler. Second, the semantics for device busy are
>   different: a hsch immediately after a ssch should not give device
>   busy, and csch cannot return device busy at all.
> 
> I don't think we'll be able to get around some kind of "let's retry
> sending this" logic for hsch/csch; maybe we should already do that for
> ssch. (Like the -EINVAL logic I described in the other thread.)
> 
> 

Nice write-up! I agree with the conclusion, and also with the most of
the analysis. IMHO, to sort this out properly, we really have to think
end-to-end (i.e. guest, userspace, vfio-ccw, backing-device). Striving
towards an comprehensively documented the user-space facing vfio-ccw
interface could help as well.

I hope we can figure out a good solution in the context of hsch/csch.

Regards,
Halil



