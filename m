Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2887782-1519390069-2-8861129109663889197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519390069; b=HoDmy/z/pulLtgOsR3C0L6pDkxn75UZXQ+68EGrXPIZ4YRV
    JVe9scqPhgaWwSDAqOC4C7rFYMlt66mzaAfkljvxpBHTujyHg+/K+mDyepT7+crk
    PiTh5vrhBdrnzK2BsqpmHXS39uzMmG0kgdVfB9drp9J9WRRDz7FgZlp1/CekDJOe
    XnclaLnhzeKsYL8Aj3IO0XOG41ceV/cB4IT77qQwFepB1nM7lcFqc4KO8MroWSKt
    ArL5iiL5HNPzAa4s9M7lItxAt0t+iVEJa/yu88t5rM2/Ai2KAH3SRAW6MU9ShsCx
    mWV+TKJgC8eJ+NdV9VcrhhvuNtId2Rew46mDNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519390069; bh=h/wA687ZOF0MsuyDZFtSK0kVGGDpyWBRIiVqmuzUN3o=; b=h
    KHiAyoPaxNPdLLvS3Tyj3vQlnkbpayuuq4354Kb/72Il0twMrcWqdCZwRiXt6BAb
    DVNWJkg/DXTQetvD3BbKmYVUu4dgsxI9QpyTWDu/5D//zTqzh3hJTQ7U2P/j4bZV
    JVDGj3hQyMJJs/VOTWIZ6/tXNuU5LGuppaI/kGlONsQ3SMUSKj9XygLrn+cJiY6N
    qLlsAnywf8FZzkPB5Ot6SItwSk24T88RG05bMpd2F0mvIhoKOqutVUl8mEyY4Cpq
    Lbn9j0ut8JcBd8lyQw1+YVMEINhQEFHOCkiC+ni4tYW6sU3cvkSX50RAx5Pp0IHP
    s1zib/H4b6aMajCVOL86A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeBWMrd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 07:47:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750805AbeBWMrc (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 07:47:32 -0500
Date: Fri, 23 Feb 2018 13:47:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] virtio_ring: fix num_free handling in error case
Message-ID: <20180223134726.3db96065.cohuck@redhat.com>
In-Reply-To: <20180223114130.16332-1-tiwei.bie@intel.com>
References: <20180223114130.16332-1-tiwei.bie@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 19:41:30 +0800
Tiwei Bie <tiwei.bie@intel.com> wrote:

> The vq->vq.num_free hasn't been changed when error happens,
> so it shouldn't be changed when handling the error.
> 
> Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index eb30f3e09a47..71458f493cf8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -428,8 +428,6 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  		i = virtio16_to_cpu(_vq->vdev, vq->vring.desc[i].next);
>  	}
>  
> -	vq->vq.num_free += total_sg;
> -
>  	if (indirect)
>  		kfree(desc);
>  

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
