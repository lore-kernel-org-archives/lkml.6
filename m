Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFB8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54D3206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54D3206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbeJEVhT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:37:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34044 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbeJEVhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:37:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so11890080edr.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9bOZnsmtI+qRo/nGXvCHQTb73ss/mKqxcOZr5ubuhsQ=;
        b=KuXIJ0NgZuR1woVSx1mwhHS6EKd2FEKo7nmMTdc9V7JEtu2DTWlAziFtAraVA/aJZP
         qxwZuYTFkpsO4yjRg58ogtfYrpHgty94dwEIerySJFSKvxorGwvcZK9PK59uzZ2IEnlU
         VRRz/gZc2k15Adph5NIdsmMbP/byVnmLFGRabFR6+xFjYTxDaNteWfDpJT3rxn5zDuKK
         CTEPK9IeXS8tQBMtP9pwvggq/L7u1io39UGdOG0Q9eVx+4z3FNLbZs/nSw7fkCe3CTjM
         ZYCsSHwnSj+3w/MpeZtl7dB35Ib2qTnlrL8L4J1SvcVLrMKyDGjbAloBt+IY/Vt3q84D
         XZKw==
X-Gm-Message-State: ABuFfojTsy59X+GyjATWFVYkNp3rkS4bTCxzrzoNjEVSfVBep8ZhRd7B
        TWL9Ldnf9K6wqcGExdUSAIg4Lg==
X-Google-Smtp-Source: ACcGV60Shcn9m4DJ+o2FTYPBPQjGcbeMYxUGS1h2bBYWV5cW6AyPNbAkLnNTbz/F0k8TvOWTyDil4g==
X-Received: by 2002:a05:6402:1602:: with SMTP id f2mr14669119edv.35.1538750296640;
        Fri, 05 Oct 2018 07:38:16 -0700 (PDT)
Received: from [192.168.77.22] (val06-1-88-182-161-34.fbx.proxad.net. [88.182.161.34])
        by smtp.gmail.com with ESMTPSA id d38-v6sm2390877edb.16.2018.10.05.07.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 07:38:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] virtio-gpu: add VIRTIO_GPU_F_EDID feature
From:   Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20181005125154.19824-1-kraxel@redhat.com>
Date:   Fri, 5 Oct 2018 16:38:11 +0200
Cc:     virtio-dev@redhat.com, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <1BA83F18-87E5-4B01-A2D9-01777078B637@redhat.com>
References: <20181005125154.19824-1-kraxel@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 5 Oct 2018, at 14:51, Gerd Hoffmann <kraxel@redhat.com> wrote:
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
> include/uapi/linux/virtio_gpu.h | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index f43c3c6171..1cef1ff339 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -41,6 +41,7 @@
> #include <linux/types.h>
> 
> #define VIRTIO_GPU_F_VIRGL 0
> +#define VIRTIO_GPU_F_EDID  1
> 
> enum virtio_gpu_ctrl_type {
> 	VIRTIO_GPU_UNDEFINED = 0,
> @@ -56,6 +57,7 @@ enum virtio_gpu_ctrl_type {
> 	VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
> 	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
> 	VIRTIO_GPU_CMD_GET_CAPSET,
> +	VIRTIO_GPU_CMD_GET_EDID,
> 
> 	/* 3d commands */
> 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
> @@ -76,6 +78,7 @@ enum virtio_gpu_ctrl_type {
> 	VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
> 	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
> 	VIRTIO_GPU_RESP_OK_CAPSET,
> +	VIRTIO_GPU_RESP_OK_EDID,
> 
> 	/* error responses */
> 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
> @@ -291,6 +294,20 @@ struct virtio_gpu_resp_capset {
> 	__u8 capset_data[];
> };
> 
> +/* VIRTIO_GPU_CMD_GET_EDID */
> +struct virtio_gpu_get_edid {
> +	struct virtio_gpu_ctrl_hdr hdr;
> +	__le32 scanout;
> +};
> +
> +/* VIRTIO_GPU_RESP_OK_EDID */
> +struct virtio_gpu_resp_edid {
> +	struct virtio_gpu_ctrl_hdr hdr;
> +	__le32 scanout;
> +	__le32 size;
> +	__u8 edid[1024];

Wouldn’t it be enough to stick to EDID 2.0 (256 bytes)?

If not, maybe add comment to explain why you chose 1024.

> +};
> +
> #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
> 
> struct virtio_gpu_config {
> -- 
> 2.9.3
> 

