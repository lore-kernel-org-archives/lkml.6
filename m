Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89EAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72D3208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfANO5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:57:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726653AbfANO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:57:32 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0EEGniR077972
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:57:31 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q0v1wsu0m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:57:30 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 14 Jan 2019 14:57:28 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 14:57:24 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0EEvNSQ65011890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 14:57:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8560EA405B;
        Mon, 14 Jan 2019 14:57:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40600A4054;
        Mon, 14 Jan 2019 14:57:23 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.110])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jan 2019 14:57:23 +0000 (GMT)
Date:   Mon, 14 Jan 2019 15:57:22 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        Wei Wang <wei.w.wang@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH 1/2] virtio: fix virtio_config_ops
 description
In-Reply-To: <20190114150958.39a4a56a.cohuck@redhat.com>
References: <20190103160804.21438-1-cohuck@redhat.com>
        <20190103160804.21438-2-cohuck@redhat.com>
        <20190114150958.39a4a56a.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011414-0028-0000-0000-000003390965
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011414-0029-0000-0000-000023F628D9
Message-Id: <20190114155722.488b59cb@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 15:09:58 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu,  3 Jan 2019 17:08:03 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > - get_features has returned 64 bits since commit d025477368792
> >   ("virtio: add support for 64 bit features.")
> > - properly mark all optional callbacks
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

> > ---
> >  include/linux/virtio_config.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 32baf8e26735..7087ef946ba7 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -22,7 +22,7 @@ struct irq_affinity;
> >   *	offset: the offset of the configuration field
> >   *	buf: the buffer to read the field value from.
> >   *	len: the length of the buffer
> > - * @generation: config generation counter
> > + * @generation: config generation counter (optional)
> >   *	vdev: the virtio_device
> >   *	Returns the config generation counter
> >   * @get_status: read the status byte
> > @@ -48,17 +48,17 @@ struct irq_affinity;
> >   * @del_vqs: free virtqueues found by find_vqs().
> >   * @get_features: get the array of feature bits for this device.
> >   *	vdev: the virtio_device
> > - *	Returns the first 32 feature bits (all we currently need).
> > + *	Returns the first 64 feature bits (all we currently need).
> >   * @finalize_features: confirm what device features we'll be using.
> >   *	vdev: the virtio_device
> >   *	This gives the final feature bits for the device: it can change
> >   *	the dev->feature bits if it wants.
> >   *	Returns 0 on success or error status
> > - * @bus_name: return the bus name associated with the device
> > + * @bus_name: return the bus name associated with the device (optional)
> >   *	vdev: the virtio_device
> >   *      This returns a pointer to the bus name a la pci_name from which
> >   *      the caller can then copy.
> > - * @set_vq_affinity: set the affinity for a virtqueue.
> > + * @set_vq_affinity: set the affinity for a virtqueue (optional).
> >   * @get_vq_affinity: get the affinity for a virtqueue (optional).
> >   */
> >  typedef void vq_callback_t(struct virtqueue *);
> 
> Ping. Any feedback on that patch?
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

