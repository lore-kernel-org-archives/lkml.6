Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B36C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992292089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546931454;
	bh=SFgbGnJC8V5YJETBnMuBdMuhTOBoBFxvOuu/HPY8+oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SwiO0e8xjsGaI4uWJIQdtZe4qnyvk+nvBDwuwjr/zm0Q9o4gYvSO2EXn5TsoSeSEP
	 nh+8r9pF9Jbjf1FRB6/FT7asPlc37y2rVoKPQjcUXj4iaJxhkkyxNWXD2x3KmCspp2
	 tBr6rEY3Z+qETqCLi7PWBF3q5eD9PQxKFybfF7I8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfAHHKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:10:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbfAHHKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:10:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A948C2087F;
        Tue,  8 Jan 2019 07:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546931452;
        bh=SFgbGnJC8V5YJETBnMuBdMuhTOBoBFxvOuu/HPY8+oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjEpVcLDp8q0A1y9GmPUk4qdxN2nxLwADNNRNTUssuGtR1xHzjMVyCxKIMAy2mrd1
         CCnCoyrNvGXSbsNjTHAS2w2gjJWT3iV/woiVVhwQ/ri3jGV9gatYw3lIAhyaTAcl7A
         kqOsRHCuAOfRBHNFxa3z/e8cxN/rSRVYWhM+DGOo=
Date:   Tue, 8 Jan 2019 08:10:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com,
        borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v4 3/3] virtio_balloon: remove the unnecessary
 0-initialization
Message-ID: <20190108071049.GC32048@kroah.com>
References: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com>
 <1546923005-40517-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546923005-40517-4-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:50:05PM +0800, Wei Wang wrote:
> We've changed to kzalloc the vb struct, so no need to 0-initialize
> this field one more time.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index d48c12c..048959a 100644
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
> -- 
> 2.7.4
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
