Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE950C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABC2206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbfAIO1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:27:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34411 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbfAIO1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:27:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E27E7F6A7;
        Wed,  9 Jan 2019 14:27:03 +0000 (UTC)
Received: from redhat.com (ovpn-123-72.rdu2.redhat.com [10.10.123.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id BBDF2608DA;
        Wed,  9 Jan 2019 14:27:02 +0000 (UTC)
Date:   Wed, 9 Jan 2019 09:27:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 1/3] virtio: introduce in order feature bit
Message-ID: <20190109092633-mutt-send-email-mst@kernel.org>
References: <20190109080530.18572-1-jasowang@redhat.com>
 <20190109080530.18572-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109080530.18572-2-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 09 Jan 2019 14:27:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 04:05:28PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/uapi/linux/virtio_config.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 1196e1c1d4f6..2698e069ed9e 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -78,6 +78,12 @@
>  /* This feature indicates support for the packed virtqueue layout. */
>  #define VIRTIO_F_RING_PACKED		34
>  
> +/*
> + * Device uses buffers in the same order in which they have been
> + * available.

been *made* available

> + */
> +#define VIRTIO_F_IN_ORDER		35
> +
>  /*
>   * Does the device support Single Root I/O Virtualization?
>   */
> -- 
> 2.17.1
