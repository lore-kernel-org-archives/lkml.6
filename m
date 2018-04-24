Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2218510-1524537651-2-18317853679953210846
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524537650; b=R8GTDeaWN48ym6hpZia9JhdQGBaAPq1PpPWvS9ePomRMFl0M77
    sZxK3BgZ9wT2Gdnah3+VpgEgbOMEl59VzYeLZLyqCnl/aq19Rwcp1Fwwl6gUZ6J5
    rVAlJxXiTTuFtIapoaKXaO5EPfH7PAVz1nbe1bEIoiT7WDhigJDMj457u654mmBe
    rVFKqC1JrssK93Mdyw3LuCuTY2j/iYhIpsUdcS58fbSod0+l/yzlLvt3QB74c7q4
    B/hEU/WWq6Q1LDzLksMm9GKR52FL2Iw23niumIF7ZzdjeIuD8FUdT/rrNFGdvC+n
    Ix7TmyzQQePEFav7hhAkhCKullHgIGqd0ZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524537650;
    bh=BVMYpnY5x4jmdaqRjwVdzZZuBi+4zqcvKpzMHDuU/kI=; b=iM9PS9XQXJMh
    puZaxaC2piu4HBDOW8P1uTddfBXMWdjDwIi6iF1uQBybCPU0aJwkQcU1GtgSyeVM
    WRYC5ezyslyXhPRjKD/rTi9iXanozmkKchav1duYklcGK12hfZKupQDNgqysDMU7
    Fex9z+sNrqnLkdZLDUf90W/BFdzjZ5TVuCu/Uhpsh9dXR1xRgf1YIeG67E4cig2w
    zcCdA3RwiQeGiLeszRj1lKqcOmdGwf5JbsWvei9p30eEAQz7ne7Cy2LvRROik3So
    cBMv5/pUMUIYiEImD05oEV41BuBiS1XWPRFGV1DHO8u0LRQweYJO5TG94ct0MB3r
    lcMhQvkREA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCciwvmIzxQLzZPPpS268VqvvN2bkU6Xg+XLgUwxe+v/ciK8u9/yMqoOIcl8+bTrNwMzEqUeODbzEHcRUtUaQySpFUQ5Zxc0W7j6eCT8VYU7Vgw3vcCk
    dsj1koufc3YYSGf/y8UAFGurGx956hAhfxXkNiH0yvEQx6jPt5PpGJKT1E03nZYaF5tnA58eVENzu/rJiQeXOebLG+Cxt4NxizEiUtgDzY1GaqYgI5Rd83m7
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=0bvriv2XhD2TnvsIUAYA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932750AbeDXCkr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 22:40:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932688AbeDXCko (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 23 Apr 2018 22:40:44 -0400
Subject: Re: [PATCH 3/6] virtio_console: free buffers after reset
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>, stable@kernel.org
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
 <1524248223-393618-4-git-send-email-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <27e87df7-2835-7f3e-c3da-76b844dbd780@redhat.com>
Date: Tue, 24 Apr 2018 10:40:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524248223-393618-4-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018年04月21日 02:18, Michael S. Tsirkin wrote:
> Console driver is out of spec. The spec says:
> 	A driver MUST NOT decrement the available idx on a live
> 	virtqueue (ie. there is no way to “unexpose” buffers).
> and it does exactly that by trying to detach unused buffers
> without doing a device reset first.
>
> Defer detaching the buffers until device unplug.
>
> Of course this means we might get an interrupt for
> a vq without an attached port now. Handle that by
> discarding the consumed buffer.
>
> Reported-by: Tiwei Bie <tiwei.bie@intel.com>
> Fixes: b3258ff1d6 ("virtio: Decrement avail idx on buffer detach")
> CC: stable@kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I wonder whether or not we can have some BUG_ON() in 
virtqueue_detach_unused_buf() to detect such bugs (e.g by checking status?).

Thanks

> ---
>   drivers/char/virtio_console.c | 49 +++++++++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 3e56f32..26a66ff 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1402,7 +1402,6 @@ static int add_port(struct ports_device *portdev, u32 id)
>   {
>   	char debugfs_name[16];
>   	struct port *port;
> -	struct port_buffer *buf;
>   	dev_t devt;
>   	unsigned int nr_added_bufs;
>   	int err;
> @@ -1513,8 +1512,6 @@ static int add_port(struct ports_device *portdev, u32 id)
>   	return 0;
>   
>   free_inbufs:
> -	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
> -		free_buf(buf, true);
>   free_device:
>   	device_destroy(pdrvdata.class, port->dev->devt);
>   free_cdev:
> @@ -1539,34 +1536,14 @@ static void remove_port(struct kref *kref)
>   
>   static void remove_port_data(struct port *port)
>   {
> -	struct port_buffer *buf;
> -
>   	spin_lock_irq(&port->inbuf_lock);
>   	/* Remove unused data this port might have received. */
>   	discard_port_data(port);
>   	spin_unlock_irq(&port->inbuf_lock);
>   
> -	/* Remove buffers we queued up for the Host to send us data in. */
> -	do {
> -		spin_lock_irq(&port->inbuf_lock);
> -		buf = virtqueue_detach_unused_buf(port->in_vq);
> -		spin_unlock_irq(&port->inbuf_lock);
> -		if (buf)
> -			free_buf(buf, true);
> -	} while (buf);
> -
>   	spin_lock_irq(&port->outvq_lock);
>   	reclaim_consumed_buffers(port);
>   	spin_unlock_irq(&port->outvq_lock);
> -
> -	/* Free pending buffers from the out-queue. */
> -	do {
> -		spin_lock_irq(&port->outvq_lock);
> -		buf = virtqueue_detach_unused_buf(port->out_vq);
> -		spin_unlock_irq(&port->outvq_lock);
> -		if (buf)
> -			free_buf(buf, true);
> -	} while (buf);
>   }
>   
>   /*
> @@ -1791,13 +1768,24 @@ static void control_work_handler(struct work_struct *work)
>   	spin_unlock(&portdev->c_ivq_lock);
>   }
>   
> +static void flush_bufs(struct virtqueue *vq, bool can_sleep)
> +{
> +	struct port_buffer *buf;
> +	unsigned int len;
> +
> +	while ((buf = virtqueue_get_buf(vq, &len)))
> +		free_buf(buf, can_sleep);
> +}
> +
>   static void out_intr(struct virtqueue *vq)
>   {
>   	struct port *port;
>   
>   	port = find_port_by_vq(vq->vdev->priv, vq);
> -	if (!port)
> +	if (!port) {
> +		flush_bufs(vq, false);
>   		return;
> +	}
>   
>   	wake_up_interruptible(&port->waitqueue);
>   }
> @@ -1808,8 +1796,10 @@ static void in_intr(struct virtqueue *vq)
>   	unsigned long flags;
>   
>   	port = find_port_by_vq(vq->vdev->priv, vq);
> -	if (!port)
> +	if (!port) {
> +		flush_bufs(vq, false);
>   		return;
> +	}
>   
>   	spin_lock_irqsave(&port->inbuf_lock, flags);
>   	port->inbuf = get_inbuf(port);
> @@ -1984,6 +1974,15 @@ static const struct file_operations portdev_fops = {
>   
>   static void remove_vqs(struct ports_device *portdev)
>   {
> +	struct virtqueue *vq;
> +
> +	virtio_device_for_each_vq(portdev->vdev, vq) {
> +		struct port_buffer *buf;
> +
> +		flush_bufs(vq, true);
> +		while ((buf = virtqueue_detach_unused_buf(vq)))
> +			free_buf(buf, true);
> +	}
>   	portdev->vdev->config->del_vqs(portdev->vdev);
>   	kfree(portdev->in_vqs);
>   	kfree(portdev->out_vqs);
