Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B8C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD0720892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD0720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeG3JBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:01:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbeG3JBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:01:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 757C47C6A9;
        Mon, 30 Jul 2018 07:28:06 +0000 (UTC)
Received: from [10.72.12.118] (ovpn-12-118.pek2.redhat.com [10.72.12.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CBD92156701;
        Mon, 30 Jul 2018 07:28:04 +0000 (UTC)
Subject: Re: [PATCH 1/2] tools/virtio: add dma barrier stubs
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     khandual@linux.vnet.ibm.com,
        virtualization@lists.linux-foundation.org
References: <20180725134057.113423-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <066294db-82d6-9b7c-14ac-d64428b3a15a@redhat.com>
Date:   Mon, 30 Jul 2018 15:28:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725134057.113423-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 30 Jul 2018 07:28:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 30 Jul 2018 07:28:06 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月25日 21:45, Michael S. Tsirkin wrote:
> Fixes: 55e49dc43a8 ("virtio_ring: switch to dma_XX barriers for rpmsg")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   tools/virtio/asm/barrier.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
> index 0ac3caf90877..d0351f83aebe 100644
> --- a/tools/virtio/asm/barrier.h
> +++ b/tools/virtio/asm/barrier.h
> @@ -13,8 +13,8 @@
>   } while (0);
>   /* Weak barriers should be used. If not - it's a bug */
>   # define mb() abort()
> -# define rmb() abort()
> -# define wmb() abort()
> +# define dma_rmb() abort()
> +# define dma_wmb() abort()
>   #else
>   #error Please fill in barrier macros
>   #endif

Reviewed-by: Jason Wang <jasowang@redhat.com>
