Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B465C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D69A206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfAIOao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:30:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28815 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbfAIOan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:30:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7514180F90;
        Wed,  9 Jan 2019 14:30:43 +0000 (UTC)
Received: from redhat.com (ovpn-123-72.rdu2.redhat.com [10.10.123.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id 36C68546E0;
        Wed,  9 Jan 2019 14:30:38 +0000 (UTC)
Date:   Wed, 9 Jan 2019 09:30:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     jasowang@redhat.com, davem@davemloft.net,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        "huang.zijiang" <huang.zijiang@zte.com.cn>
Subject: Re: [PATCH] virtio:linux:kernel:NULL check after kmalloc is  needed
Message-ID: <20190109093026-mutt-send-email-mst@kernel.org>
References: <1546926033-31684-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546926033-31684-1-git-send-email-wang.yi59@zte.com.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 09 Jan 2019 14:30:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:40:33PM +0800, Yi Wang wrote:
> From: "huang.zijiang" <huang.zijiang@zte.com.cn>
> 
> NULL check is needed because kmalloc maybe return NULL.
> 
> Signed-off-by: huang.zijiang <huang.zijiang@zte.com.cn>

Can't hurt I will queue it.

> ---
>  tools/virtio/linux/kernel.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 7ef45a4..2afcad8 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -65,6 +65,8 @@ static inline void *kzalloc(size_t s, gfp_t gfp)
>  {
>  	void *p = kmalloc(s, gfp);
>  
> +	if (!p)
> +		return -ENOMEM;
>  	memset(p, 0, s);
>  	return p;
>  }
> -- 
> 1.8.3.1
