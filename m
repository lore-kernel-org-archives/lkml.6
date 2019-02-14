Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A09C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F5E222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="LXiBP3YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406121AbfBNHz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:55:28 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36285 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731244AbfBNHz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:55:27 -0500
Received: by mail-yw1-f67.google.com with SMTP id 189so1989922ywi.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 23:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yBwSSlNv9tCyPDX/sqUOFEoAcNsBJ8hUgkR8QwekNPc=;
        b=LXiBP3YVwUoJYM9R7Y6HmgAPbLmALMeOLVMlAuQI2AASyM9TF8cs+09o2Wn5YmGlcG
         fJVY5IdFShBJpvqKjfXJoCSbv13xnYbBJTUbolx3B3NayUWIMXv3W5zZgzZfge9ScRlh
         xeuEa8chAb0m7k/MxjX5Q/oRWUXHH6Bni9G7260kl0HplK12sLXPJMd4iKkn0a1qR69g
         JwTpQJNElgM/hTpMx9i2vuG2tUwFGGXJVDhQj0cHg0PCB7vdENPQfPp7BIonWfyTVsSh
         q8EtJU/wF8B3ynqJTIuLcPhrJx0BUQ7gfpQdTMnk6URLQBWMIN/QOE1KC9ygQYxu6mBH
         5W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yBwSSlNv9tCyPDX/sqUOFEoAcNsBJ8hUgkR8QwekNPc=;
        b=Aob8StKa9ymE48eoiv2pT5A15+J+uxtR3SjdSk7TuM0ukNYwfJhsOt8R1BjLWcwcs1
         no/Qvv0Hr2sp0eZAn+smCodtlJLbzZ62xzTwybgaP1ecXbWpENQouKYwWac1lgc+kMRM
         pQb5aOyzp8ey4VdxPF3s/zlg5wEx8ij73dzUXHeND1IWYRskxXK7ctITWRE+JWfctVZq
         1dr7SgBXEuCYdBfqjOnGwJc9e4cfiNQ/u9LMJh1Kx003UIGHvxD777aghzzXeAMH1ir8
         DFgKTeEPNBLqtKh7RGIe0hrS1h8B62hUFFUY+T0E69fmN0tcXLx5GoPrsX+mbNH5dCfF
         DkPA==
X-Gm-Message-State: AHQUAuaqcAqs5nEYqaPwe2+bp3m1WCnJGW+/TtiKnY7HkXbdNAfdUmtg
        RbLzCpWRE4+HEC6IvpRpzq0JqIo7BDGtRiQGxGb/pA==
X-Google-Smtp-Source: AHgI3IZuQqRFXQU0lDya6EixA9gy4bQPrBjRhcUu1uoPiRAE1QsbusX2LXOq2LYzaHpMOBCcaEfYst6UhSc+DPQrF6k=
X-Received: by 2002:a81:2fcc:: with SMTP id v195mr1794829ywv.419.1550130926284;
 Wed, 13 Feb 2019 23:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20190201085035.18481-1-yuri.benditovich@daynix.com>
In-Reply-To: <20190201085035.18481-1-yuri.benditovich@daynix.com>
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Date:   Thu, 14 Feb 2019 09:55:17 +0200
Message-ID: <CAOEp5OfvoB3YV4Ga9K7xRrHvKmtX57ExOB-wYbYaUZHmDn=ydw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_net: Introduce extended RSC feature
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you please let me know whether this patch accepted?
Is yes, I'll post similar change to qemu to prevent future compilation
error when linux header will be updated.

Thanks,
Yuri

On Fri, Feb 1, 2019 at 10:50 AM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> is able to provide extended RSC information. When the feature
> is active and 'gso_type' field in received packet is not GSO_NONE,
> the device reports number of coalesced packets in 'csum_start'
> field and number of duplicated acks in 'csum_offset' field
> and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/uapi/linux/virtio_net.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index a3715a3224c1..23e73d666fc2 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,7 +56,7 @@
>  #define VIRTIO_NET_F_MQ        22      /* Device supports Receive Flow
>                                          * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23  /* Set MAC address */
> -
> +#define VIRTIO_NET_F_RSC_EXT     61    /* Provides extended RSC info */
>  #define VIRTIO_NET_F_STANDBY     62    /* Act as standby for another device
>                                          * with the same MAC.
>                                          */
> @@ -104,6 +104,7 @@ struct virtio_net_config {
>  struct virtio_net_hdr_v1 {
>  #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1       /* Use csum_start, csum_offset */
>  #define VIRTIO_NET_HDR_F_DATA_VALID    2       /* Csum is valid */
> +#define VIRTIO_NET_HDR_F_RSC_INFO      4   /* rsc_ext data in csum_ fields */
>         __u8 flags;
>  #define VIRTIO_NET_HDR_GSO_NONE                0       /* Not a GSO frame */
>  #define VIRTIO_NET_HDR_GSO_TCPV4       1       /* GSO frame, IPv4 TCP (TSO) */
> @@ -118,6 +119,15 @@ struct virtio_net_hdr_v1 {
>         __virtio16 num_buffers; /* Number of merged rx buffers */
>  };
>
> +/* if VIRTIO_NET_HDR_F_RSC_INFO is set, the csum_start
> + * field contains number of coalesced segments
> + */
> +#define virtio_net_rsc_ext_num_packets csum_start
> +/* if VIRTIO_NET_HDR_F_RSC_INFO is set, the csum_offset
> + * field contains number of duplicated acks
> + */
> +#define virtio_net_rsc_ext_num_dupacks csum_offset
> +
>  #ifndef VIRTIO_NET_NO_LEGACY
>  /* This header comes first in the scatter-gather list.
>   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
> --
> 2.17.1
>
