Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-990390-1524208971-2-3959135115985187969
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enfrca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524208971; b=M3vS4X2WVldt6trn4YoYdanh49D2ez+7clE3GYPpi7VhyAvRW3
    PX3bYQC5lJB0VhW74QVg2/Xqo8tUKH4SsGrCEUx0nlAHt68ftCxgK0ozj3fFDfDh
    Lz3tfzaYInPW9z7weBUzw8/H3xzNbdWc4+e/PQjuWuy7ut80x/yoiAPdoUgfPlGH
    i3L8zhlub78GHalfS04U+MPnWIdR4ZpzTe3jnTxLin8cqOoQZVi6mkVSg4a4xem5
    83+Hz9rWJmypGinM3IAEOTvjQ8BhoHd6lOXy1xD2UPUHtfp4CElYuoy3TIzG1u8Z
    VINJ5/gDKhPJY58A3ldzVVHXqjsBRGSUiWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524208971; bh=raMGkARTM+k2aIC+0JaLXRs5XDVITB
    EjePh1mQyN7iQ=; b=JBGsfUWsr/Ajih/7EraIgI0DP8+pCtkHi2+7N05xXVH3M8
    A9RRYpoq7lARWgkas4ttBBIAg+mp/k13dyQWGYC5NbSRP9zl3vA/mfYh/0ncsXp5
    JJCjwIhgkYI5wln0Zncr79BxMlJDAsBPHnJ26Er+//fVToLRxCQ/8LPVCbqhm3b0
    7OIOb4rszwq/TESXoiAyzXfAC0mRh1GJN/Wxz86NGgT3FlL1DxqTxT2zpZfCjoxw
    VPpjtNdf/pOE+Lhb0xDmP0HTJ9r0hI7cGrS2hdcraajRXjzsTujwUBoyPVYImhIa
    E+Se7oL9VfcYY9AdKqLCXAtRn8uAWkfqmnOly4sw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfI/eb1Ri+9TR73pITtcGnG9qBMwhlRXN8VPYBCAMr+0FDV8SCBjNuCEwXuGJQ3Y4YX0V/AAg+9iLJYTSLZPtJpYfy1ePdQoWiNlLmNcswHpcFnyQII7c
    cMJ8lN8LiyI3uNbmNbQ6wiLuh9A9ugXLzyCLRpM0XIpbVDDMwSCdHq+6ZFbDEVqt6Y3oE0cRqdFo3nu1R835Km5+FejTZDRRPdJ+kXnJyS1kK02raaLdQjyy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ePdMqToNAAAA:8 a=20KFwNOVAAAA:8 a=CV6j7DpJueoG8-WQY4QA:9
    a=ju9NCZLEcBWG5oWj:21 a=wnufclw2-acI5ou6:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=fq9aknvlO0Q50tsIl6NS:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbeDTHWi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 03:22:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753744AbeDTHWg (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 03:22:36 -0400
Date: Fri, 20 Apr 2018 09:22:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: amagloire@blackberry.com, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER"
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: fix vq wait_event condition
Message-ID: <20180420072228.uorb3h7snx4io6xs@sirius.home.kraxel.org>
References: <20180403095904.11152-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403095904.11152-1-kraxel@redhat.com>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 11:59:04AM +0200, Gerd Hoffmann wrote:
> Wait until we have enough space in the virt queue to actually queue up
> our request.  Avoids the guest spinning in case we have a non-zero
> amount of free entries but not enough for the request.

Ping airlied, can you please either pick it up or review so I can commit
myself?

thanks,
  Gerd

> Cc: stable@vger.kernel.org
> Reported-by: Alain Magloire <amagloire@blackberry.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 48e4f1df6e..020070d483 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -293,7 +293,7 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
>  	if (ret == -ENOSPC) {
>  		spin_unlock(&vgdev->ctrlq.qlock);
> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free);
> +		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= outcnt + incnt);
>  		spin_lock(&vgdev->ctrlq.qlock);
>  		goto retry;
>  	} else {
> @@ -368,7 +368,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>  	if (ret == -ENOSPC) {
>  		spin_unlock(&vgdev->cursorq.qlock);
> -		wait_event(vgdev->cursorq.ack_queue, vq->num_free);
> +		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
>  		spin_lock(&vgdev->cursorq.qlock);
>  		goto retry;
>  	} else {
> -- 
> 2.9.3
> 
