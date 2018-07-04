Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5228DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08991241F0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08991241F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbeGDUPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 16:15:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752622AbeGDUPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 16:15:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1953D7A7EB;
        Wed,  4 Jul 2018 20:15:09 +0000 (UTC)
Received: from [10.36.112.34] (ovpn-112-34.ams2.redhat.com [10.36.112.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F10B2156880;
        Wed,  4 Jul 2018 20:15:03 +0000 (UTC)
Subject: Re: [PATCH net-next 6/8] virtio: introduce packed ring defines
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wexu@redhat.com, tiwei.bie@intel.com, jfreimann@redhat.com
References: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
 <1530596284-4101-7-git-send-email-jasowang@redhat.com>
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <0f293989-a0ca-e7ad-f907-83a8d8445335@redhat.com>
Date:   Wed, 4 Jul 2018 22:15:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530596284-4101-7-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 04 Jul 2018 20:15:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 04 Jul 2018 20:15:09 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'maxime.coquelin@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2018 07:38 AM, Jason Wang wrote:
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 6d5d5fa..71c7a46 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -43,6 +43,8 @@
>   #define VRING_DESC_F_WRITE	2
>   /* This means the buffer contains a list of buffer descriptors. */
>   #define VRING_DESC_F_INDIRECT	4
> +#define VRING_DESC_F_AVAIL      7
> +#define VRING_DESC_F_USED	15

For consistency, you may want to make VRING_DESC_F_AVAIL and 
VRING_DESC_F_USED to represent the bit mask and not the bit position,
as done for VRING_DESC_F_WRITE and VRING_DESC_F_INDIRECT.

Regards,
Maxime
