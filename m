Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD6CECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AAF21470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJXYbu6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AAF21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeJRJPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:15:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38204 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeJRJPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:15:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9-v6so32435647qtf.5;
        Wed, 17 Oct 2018 18:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLREJIs3pZSSAN2IjBzRgsm8xvZAm4XvsbPOyvNiQ5M=;
        b=TJXYbu6dOLBy2WZYK1Z8iQy3S/yf/yXjU6EPoEpI2tN1gup2CXSyUYrDzh7tJQOZa5
         A497T9/o1ixgaXQ5H8P+aD246+k6F86afPjl7oDT/IgdJbJyxU8Rqu9xU6d1RwFfyt6e
         qMtyT/h+RLPXIE8WmJLp3GDG1WskHi4pAOD0wXT2CADgTzI/6r5NzbN1FZV5raRY6Ppn
         BJo1hRB5CDUmdDXH7u7R5bVXOzOm114303ubu3eKF/zhO/H+xXM2RNuURzWlmaIeGS8v
         gKEsFg2yVStJpv++EWIT+B/qpVI/4O5MgFhdTIZdk8w7brnoO/o7qpzuDV2nysQhiZxW
         bP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLREJIs3pZSSAN2IjBzRgsm8xvZAm4XvsbPOyvNiQ5M=;
        b=Ab/lL/j1LMlTetYX8XK0BizP4qqTLcIi8xX0Hl56p1L7gKyq5zq1GB3puL8tPMlukR
         VcJO2GszFIhXLg8A+tA3CUIyVJ7EAMaBdgKxHXwqiqOwCLYIpGjKNlfQ16xgy4phTWFi
         bgWJaYr8sUxgEZ2PSDtzpb8FrF2JSQA5U/fy+tNuqabm57iM84RUCk5PSeJmrLseAvmr
         jFe9NGyjmpJhxqfwWII2uJhDVujPYrnaCk28rItfVY63p8RXHqEBNRzHh5knGF2J6r1C
         1cxQ9v0zcP9E0obqqXqZkJ3u5M3M5dGHa5w3CHesiHumOSfOSfZptMucwisVwKQSKQ6S
         y8mQ==
X-Gm-Message-State: ABuFfojmZT3aPyL62N+YV4IrKCbk+fo9PFZ9BJ66auwMJzNyb4gWFpPQ
        F7u/04F8l4TIGP94u60Qx4LPVbDjNwbAf2hcaL0=
X-Google-Smtp-Source: ACcGV60y31Vj3s0OLTQ70WEZW4CeorFh8rv0i8qMA2A8K0G48Lzgsd2X1qHZyOfKjzhIMoQNuqKlTuio9dq9Sx0tMG0=
X-Received: by 2002:a0c:8a08:: with SMTP id 8mr19507199qvt.203.1539825447566;
 Wed, 17 Oct 2018 18:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181005125154.19824-1-kraxel@redhat.com>
In-Reply-To: <20181005125154.19824-1-kraxel@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 18 Oct 2018 11:17:14 +1000
Message-ID: <CAPM=9twky-=a44GABrqi7prQjorzQRpLHQw8TOTc3Th83bjB1g@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: add VIRTIO_GPU_F_EDID feature
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     virtio-dev@redhat.com, KVM list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Dave Airlie <airlied@linux.ie>,
        Jason Wang <jasowang@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Dave Airlie <airlied@redhat.com>
On Fri, 5 Oct 2018 at 22:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The feature allows the guest request an EDID blob (describing monitor
> capabilities) for a given scanout (aka virtual monitor connector).
>
> It brings a new command message, which has just a scanout field (beside
> the standard virtio-gpu header) and a response message which carries the
> EDID data.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/uapi/linux/virtio_gpu.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index f43c3c6171..1cef1ff339 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -41,6 +41,7 @@
>  #include <linux/types.h>
>
>  #define VIRTIO_GPU_F_VIRGL 0
> +#define VIRTIO_GPU_F_EDID  1
>
>  enum virtio_gpu_ctrl_type {
>         VIRTIO_GPU_UNDEFINED = 0,
> @@ -56,6 +57,7 @@ enum virtio_gpu_ctrl_type {
>         VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
>         VIRTIO_GPU_CMD_GET_CAPSET_INFO,
>         VIRTIO_GPU_CMD_GET_CAPSET,
> +       VIRTIO_GPU_CMD_GET_EDID,
>
>         /* 3d commands */
>         VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
> @@ -76,6 +78,7 @@ enum virtio_gpu_ctrl_type {
>         VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
>         VIRTIO_GPU_RESP_OK_CAPSET_INFO,
>         VIRTIO_GPU_RESP_OK_CAPSET,
> +       VIRTIO_GPU_RESP_OK_EDID,
>
>         /* error responses */
>         VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
> @@ -291,6 +294,20 @@ struct virtio_gpu_resp_capset {
>         __u8 capset_data[];
>  };
>
> +/* VIRTIO_GPU_CMD_GET_EDID */
> +struct virtio_gpu_get_edid {
> +       struct virtio_gpu_ctrl_hdr hdr;
> +       __le32 scanout;
> +};
> +
> +/* VIRTIO_GPU_RESP_OK_EDID */
> +struct virtio_gpu_resp_edid {
> +       struct virtio_gpu_ctrl_hdr hdr;
> +       __le32 scanout;
> +       __le32 size;
> +       __u8 edid[1024];
> +};
> +
>  #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
>
>  struct virtio_gpu_config {
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
