Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED7C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086DB20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086DB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeG3JCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:02:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbeG3JCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:02:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B84840241C0;
        Mon, 30 Jul 2018 07:28:31 +0000 (UTC)
Received: from [10.72.12.118] (ovpn-12-118.pek2.redhat.com [10.72.12.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9A1A2026D68;
        Mon, 30 Jul 2018 07:28:28 +0000 (UTC)
Subject: Re: [PATCH 2/2] tools/virtio: add kmalloc_array stub
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     khandual@linux.vnet.ibm.com,
        virtualization@lists.linux-foundation.org
References: <20180725134057.113423-1-mst@redhat.com>
 <20180725134057.113423-2-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4542b5ea-6c09-3dbf-e62e-c96f15e847c7@redhat.com>
Date:   Mon, 30 Jul 2018 15:28:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725134057.113423-2-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 30 Jul 2018 07:28:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 30 Jul 2018 07:28:31 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月25日 21:45, Michael S. Tsirkin wrote:
> Fixes: 6da2ec56059 ("treewide: kmalloc() -> kmalloc_array()")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   tools/virtio/linux/kernel.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index fca8381bbe04..fb22bccfbc8a 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -52,6 +52,11 @@ static inline void *kmalloc(size_t s, gfp_t gfp)
>   		return __kmalloc_fake;
>   	return malloc(s);
>   }
> +static inline void *kmalloc_array(unsigned n, size_t s, gfp_t gfp)
> +{
> +	return kmalloc(n * s, gfp);
> +}
> +
>   static inline void *kzalloc(size_t s, gfp_t gfp)
>   {
>   	void *p = kmalloc(s, gfp);

Reviewed-by: Jason Wang <jasowang@redhat.com>
