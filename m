Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A19C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7319E2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfAGOHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:07:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfAGOHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:07:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F332C81F0B;
        Mon,  7 Jan 2019 14:07:44 +0000 (UTC)
Received: from gondolin (ovpn-117-50.ams2.redhat.com [10.36.117.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F4FC5D739;
        Mon,  7 Jan 2019 14:07:40 +0000 (UTC)
Date:   Mon, 7 Jan 2019 15:07:38 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
        dgilbert@redhat.com, pasic@linux.ibm.com
Subject: Re: [PATCH v3 3/3] virtio_balloon: remove the unnecessary
 0-initialization
Message-ID: <20190107150738.03bdcf27.cohuck@redhat.com>
In-Reply-To: <1546844466-38079-4-git-send-email-wei.w.wang@intel.com>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
        <1546844466-38079-4-git-send-email-wei.w.wang@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 07 Jan 2019 14:07:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Jan 2019 15:01:06 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> We've changed to kzalloc the vb struct, so no need to 0-initialize
> this field one more time.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_balloon.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index e33dc8e..f19061b 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -925,7 +925,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  						  VIRTIO_BALLOON_CMD_ID_STOP);
>  		vb->cmd_id_stop = cpu_to_virtio32(vb->vdev,
>  						  VIRTIO_BALLOON_CMD_ID_STOP);
> -		vb->num_free_page_blocks = 0;
>  		spin_lock_init(&vb->free_page_list_lock);
>  		INIT_LIST_HEAD(&vb->free_page_list);
>  		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
