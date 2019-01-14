Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E165BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EED20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfANOKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:10:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfANOKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:10:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42D619D501;
        Mon, 14 Jan 2019 14:10:07 +0000 (UTC)
Received: from gondolin (ovpn-117-118.ams2.redhat.com [10.36.117.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A1DD18536;
        Mon, 14 Jan 2019 14:10:01 +0000 (UTC)
Date:   Mon, 14 Jan 2019 15:09:58 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        Wei Wang <wei.w.wang@intel.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/2] virtio: fix virtio_config_ops description
Message-ID: <20190114150958.39a4a56a.cohuck@redhat.com>
In-Reply-To: <20190103160804.21438-2-cohuck@redhat.com>
References: <20190103160804.21438-1-cohuck@redhat.com>
        <20190103160804.21438-2-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 14 Jan 2019 14:10:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Jan 2019 17:08:03 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> - get_features has returned 64 bits since commit d025477368792
>   ("virtio: add support for 64 bit features.")
> - properly mark all optional callbacks
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/linux/virtio_config.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 32baf8e26735..7087ef946ba7 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -22,7 +22,7 @@ struct irq_affinity;
>   *	offset: the offset of the configuration field
>   *	buf: the buffer to read the field value from.
>   *	len: the length of the buffer
> - * @generation: config generation counter
> + * @generation: config generation counter (optional)
>   *	vdev: the virtio_device
>   *	Returns the config generation counter
>   * @get_status: read the status byte
> @@ -48,17 +48,17 @@ struct irq_affinity;
>   * @del_vqs: free virtqueues found by find_vqs().
>   * @get_features: get the array of feature bits for this device.
>   *	vdev: the virtio_device
> - *	Returns the first 32 feature bits (all we currently need).
> + *	Returns the first 64 feature bits (all we currently need).
>   * @finalize_features: confirm what device features we'll be using.
>   *	vdev: the virtio_device
>   *	This gives the final feature bits for the device: it can change
>   *	the dev->feature bits if it wants.
>   *	Returns 0 on success or error status
> - * @bus_name: return the bus name associated with the device
> + * @bus_name: return the bus name associated with the device (optional)
>   *	vdev: the virtio_device
>   *      This returns a pointer to the bus name a la pci_name from which
>   *      the caller can then copy.
> - * @set_vq_affinity: set the affinity for a virtqueue.
> + * @set_vq_affinity: set the affinity for a virtqueue (optional).
>   * @get_vq_affinity: get the affinity for a virtqueue (optional).
>   */
>  typedef void vq_callback_t(struct virtqueue *);

Ping. Any feedback on that patch?
