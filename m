Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E352C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F2A216FF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 03:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F2A216FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeHOGNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 02:13:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728623AbeHOGNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 02:13:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CF6140200CD;
        Wed, 15 Aug 2018 03:22:58 +0000 (UTC)
Received: from [10.72.12.27] (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41B992156712;
        Wed, 15 Aug 2018 03:22:53 +0000 (UTC)
Subject: Re: [PATCH 1/1] vhost: change the signature of
 __vhost_get_user_slow()
To:     Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com,
        virtualization@lists.linux-foundation.org
References: <1534297600-2577-1-git-send-email-dongli.zhang@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <12b14053-b3ef-0616-6057-0406e7fd01bf@redhat.com>
Date:   Wed, 15 Aug 2018 11:22:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534297600-2577-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 15 Aug 2018 03:22:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 15 Aug 2018 03:22:58 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月15日 09:46, Dongli Zhang wrote:
> Remove 'type' from the signature of __vhost_get_user_slow() as it is not
> used.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   drivers/vhost/vhost.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index ed31145..f78d3bc 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -807,8 +807,7 @@ static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
>   }
>   
>   static void __user *__vhost_get_user_slow(struct vhost_virtqueue *vq,
> -					  void __user *addr, unsigned int size,
> -					  int type)
> +					  void __user *addr, unsigned int size)
>   {
>   	int ret;
>   
> @@ -846,7 +845,7 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
>   	if (uaddr)
>   		return uaddr;
>   
> -	return __vhost_get_user_slow(vq, addr, size, type);
> +	return __vhost_get_user_slow(vq, addr, size);
>   }
>   
>   #define vhost_put_user(vq, x, ptr)		\

Please keep this as is.

It will be used by incoming packed virtqueue.

Thanks

