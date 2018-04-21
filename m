Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3583185-1524295814-2-3668990278249904110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524295814; b=jNBKIEwmrigo6Nt0XI/VdLyyf/VFYx0xnRJ9DUpz7nYGSYDeF0
    ig6sAQobMtNz4+/GMQ7h86SGkEXWQDElfSoMMGdz/KncWmYOOXPL+znkNsDfm98p
    Zv6EUAoVqFbDe5TnHmzmux1sMUOkNnqAfPEqDd8EnhWOiFrQfthtzByN825LBtUE
    rS8tO3pHzzYl0kdKK54xQAxcrPArZIxBMUPApgoxM7mm3s5T9uIBZGdNiT0RAzk9
    L+8b8tDhVs5xngwKwvrv4xU5UQ5mw4cQpdLstBTrdrHOjhsD1DS9QLBxyfWPKHHT
    D2z/oNlOdKl5fw+Pj6hRJl01E4eCOGyXy/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524295814; bh=sCxNG4Wv9NSX0XkBjOn6psffQZsb6N
    zTi2oaJ3zisms=; b=DfCT4Hll6JeaDwoZ8urTy8UiG/uez0eTvlsbC0ncKjdStM
    EmTI/0mvH8z3W+ryoUFd+bdQEZCBREYRhhJ6rHgbFIouRzX7l+HAS+YffF+kZKSp
    OA298syc2Y8Fz4D5/lPQoAftfIaJlyd7/sOhuXdKla1vxMRsiUSxvLInbDUsYLyU
    Fdc4MGRLbspWfRTe3i5zhd4iguzA7iCGTXqZsq57gMp6xaxPCNali2OxZERPa7Fk
    eVavZSvcQdvJqpT60sgrb+6z9d+GieoRacXHGv+7DoPWDwdxgh4T+pvfcJN6SkMe
    D/WGPTfjOvWhO4iH1QE7fGKsLGq8lHINObTtIF/g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM6kgeppR0sSsatPCEsgbBFnabcMnk7H76QzDSsVtDbWvbTns/UGzGBD8bwl1nPvORxoNNVBgEGmVSvIFMO2AI1wNslptCU3IYPHfkDAPz+DrRWerBdd
    HMpyeIefO7C+CZZlr/WnKZq7K/h2gMHNWb8b5+fPFfAEU38MJvbZ4B6FeHUa8+NafPqKQluJGGjCkVffayk2+8Mp0DZ4uZ6wLLfYRDFnL473RIbxl/lTJuyt
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=k3sSklilLPbVzaq_DmgA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeDUHaM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 21 Apr 2018 03:30:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeDUHaM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Apr 2018 03:30:12 -0400
Date: Sat, 21 Apr 2018 09:30:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/6] virtio_console: don't tie bufs to a vq
Message-ID: <20180421073005.GA3744@kroah.com>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
 <1524248223-393618-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524248223-393618-2-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 09:18:01PM +0300, Michael S. Tsirkin wrote:
> an allocated buffer doesn't need to be tied to a vq -
> only vq->vdev is ever used. Pass the function the
> just what it needs - the vdev.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/char/virtio_console.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 468f061..3e56f32 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -422,7 +422,7 @@ static void reclaim_dma_bufs(void)
>  	}
>  }
>  
> -static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
> +static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size,
>  				     int pages)
>  {
>  	struct port_buffer *buf;
> @@ -445,16 +445,16 @@ static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
>  		return buf;
>  	}
>  
> -	if (is_rproc_serial(vq->vdev)) {
> +	if (is_rproc_serial(vdev)) {
>  		/*
>  		 * Allocate DMA memory from ancestor. When a virtio
>  		 * device is created by remoteproc, the DMA memory is
>  		 * associated with the grandparent device:
>  		 * vdev => rproc => platform-dev.
>  		 */
> -		if (!vq->vdev->dev.parent || !vq->vdev->dev.parent->parent)
> +		if (!vdev->dev.parent || !vdev->dev.parent->parent)
>  			goto free_buf;
> -		buf->dev = vq->vdev->dev.parent->parent;
> +		buf->dev = vdev->dev.parent->parent;
>  
>  		/* Increase device refcnt to avoid freeing it */
>  		get_device(buf->dev);
> @@ -838,7 +838,7 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
>  
>  	count = min((size_t)(32 * 1024), count);
>  
> -	buf = alloc_buf(port->out_vq, count, 0);
> +	buf = alloc_buf(port->portdev->vdev, count, 0);
>  	if (!buf)
>  		return -ENOMEM;
>  
> @@ -957,7 +957,7 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
>  	if (ret < 0)
>  		goto error_out;
>  
> -	buf = alloc_buf(port->out_vq, 0, pipe->nrbufs);
> +	buf = alloc_buf(port->portdev->vdev, 0, pipe->nrbufs);
>  	if (!buf) {
>  		ret = -ENOMEM;
>  		goto error_out;
> @@ -1374,7 +1374,7 @@ static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
>  
>  	nr_added_bufs = 0;
>  	do {
> -		buf = alloc_buf(vq, PAGE_SIZE, 0);
> +		buf = alloc_buf(vq->vdev, PAGE_SIZE, 0);
>  		if (!buf)
>  			break;
>  
> -- 
> MST

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
