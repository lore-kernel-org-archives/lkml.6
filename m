Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A187BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1D32190B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrbanMnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389213AbeLUKAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:00:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44351 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389173AbeLUJ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:59:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so4168343lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EZY0VwWEPq9uTwm+I+YKStnf5E+WhmoJ6xAAPWM1I/w=;
        b=qrbanMnj85ZJP9DYVhhqsFw+/rgj714z/fFezJnbkAOS7RKW6kApRjly++TtwFBE3a
         aAT/p1MK1xVAL2/SZaB4jYjZyK/gjl9Pw8fOqK3rZzuYFw1A63Vu3M14QTVgqh84j6kl
         VeFn4GWGA18A1Q23V/5XZ3Sp6JtBTRf4QBbnuxIRPRoweS5ChiJdZTtyrQTICTptMNG6
         8JBwjNuTEd+WvtLLYX7DS33Ijx108c25pWq/F/uLvQ0ewcS8zb3OOpNb6mkJJKqSny3d
         GNxUbSaXKHkLdkUH6x0J/KEEHmExSY2+pz9vJvWW4vTpp1oVuJ517IuRbwpHTUqES0Oi
         9R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EZY0VwWEPq9uTwm+I+YKStnf5E+WhmoJ6xAAPWM1I/w=;
        b=m+kSkGQciKmm5O9/T38W9GiFlkd43ssyZxwkpAGcZW7h8yS3ESKg5tAfSMNKu8CmCW
         AZfbJZKbpUDLrSQG8mCRF23t10hlgRv4bnxw16UNGCsBXLZNkl0FsfKrBaCL+UuIV9HO
         upUL9Y16mStbHtnSO/CzKn9i+odG8SaTk+8Yq4+1kUHi7Qt9opQNISDulEiob+1lfwhx
         uYUt1ky3BRLvL9tUF7kFL4Hu5UdmGG9MikFlLH5PA1bRdkOvMTNlvoflI+b20W7ut0Lu
         w6gAJrBBI/mr3x6eQf2Fo0JIM3uwtXMsWFfBPjd6nxR2g10TrbYtx/9U2S/nPn5XJEBj
         3JSA==
X-Gm-Message-State: AJcUukeYzkEfpP2BMXgIXhJ86eRIMHjTh4q9lQipmny6N2/7gApcB8hX
        qbEewfrg7C1ELIZGFlIWj74=
X-Google-Smtp-Source: ALg8bN6GcRjj5luxD+TnqROhGbb2yOXiv0ryQ/e5uQAyCC4LUp21NQ/vwNGWpXwfKGnJKE6e/GxiRA==
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr1156210ljc.84.1545386395371;
        Fri, 21 Dec 2018 01:59:55 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id f16-v6sm4647652lji.88.2018.12.21.01.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 01:59:54 -0800 (PST)
Subject: Re: [PATCH 01/10] drm/virtio: log error responses
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20181219122708.4586-1-kraxel@redhat.com>
 <20181219122708.4586-2-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <7af5ce00-d751-5c21-51f9-fdea793fd57b@gmail.com>
Date:   Fri, 21 Dec 2018 11:59:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219122708.4586-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 2:26 PM, Gerd Hoffmann wrote:
> If we got an error response code from the host, print it to the log.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_vq.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index e27c4aedb8..6bc2008b0d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -192,8 +192,16 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
>   
>   	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
>   		resp = (struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
> -		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA))
> -			DRM_DEBUG("response 0x%x\n", le32_to_cpu(resp->type));
> +		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA)) {
> +			if (resp->type >= cpu_to_le32(VIRTIO_GPU_RESP_ERR_UNSPEC)) {
> +				struct virtio_gpu_ctrl_hdr *cmd;
> +				cmd = (struct virtio_gpu_ctrl_hdr *)entry->buf;
> +				DRM_ERROR("response 0x%x (command 0x%x)\n",
> +					  le32_to_cpu(resp->type),
> +					  le32_to_cpu(cmd->type));
> +			} else
> +				DRM_DEBUG("response 0x%x\n", le32_to_cpu(resp->type));
> +		}
>   		if (resp->flags & cpu_to_le32(VIRTIO_GPU_FLAG_FENCE)) {
>   			u64 f = le64_to_cpu(resp->fence_id);
>   

