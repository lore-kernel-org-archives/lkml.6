Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AA2ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F33620821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHlq3Wu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F33620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeJaShM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:37:12 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:32830 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJaShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:37:12 -0400
Received: by mail-vk1-f196.google.com with SMTP id l186so3749407vke.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkM4fZTJWWCAtvbfzHbA7JEsdH/DSkvV6DP0rjdlLxU=;
        b=XHlq3Wu/D2NC4fCDlcsCfz/PKITtT1yfuCdwsufUVYos2a/mJZG1+zRtimaHmLIC5d
         Ek6fUUmKge393kgPKFP5lgVgE0fDSiTyQPl0gqiBvIsiLoc4cfXqtGjrHPUQveD4KjwE
         bq0Ol5fgsD5DuoP0C0LcTFtfPMGKdh/W0fM6vafkK77bQ3leGrOik9Hx+FsOeNv9UfwF
         8q+98rehaymu7gNrLG6xDFBNsm9YX96xQP12WjLAbRshLOH0++EYXPgJhCnz7sEObxb2
         dqnFaNMyKMIs+1656UM7ccMV2rBPDjBqP2UOLeE035+Q8iuAsp9G9V+fQAeSf5TGsD+m
         cehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkM4fZTJWWCAtvbfzHbA7JEsdH/DSkvV6DP0rjdlLxU=;
        b=tkmv5ftX13TLpd1gk5HxLceUGKVV9aF0lFhPRw+O1SSW1BC02rEx39yxn1+nvz55LB
         w5RSNUXs6OlqAFmxswkq2B+ZySK5h7WK7oWbP2B37KvKat7VQTnHtfWYw8nMQJJ4A/F+
         IOlo2zziHS3vJLl2/C4HTWPpXD4/1ene2bE2Fsz5QPw8gi+Uix9Dl8Wkhk6AeMMExovj
         hcAc5m6RTFTomoxKDIMsx4iLUSRI6sKxOOsRuJFUcKf8O/UwSCLzNs91GfAf5jEJmnbj
         g5lmbx1OsG4M1m7cB0sbB5SpWRCtt9WaS7qb5zeUMGm/jSh2BxajrWSJO4a5FUaeXhz8
         eOLw==
X-Gm-Message-State: AGRZ1gJxddz25wQJR7i7lIedK7qwvB8ee9Nrwof7PRjWu0Vna9zgTfDM
        w96FukXcZHbaBX6VPbE4VyPI0LLNUh8/pCv4bXs=
X-Google-Smtp-Source: AJdET5d1P7jM2QUIhs2MqbqW3evqeoTdXSoj2URDlC6YDxiXqxHNNec9fS8+Hh7R7HC5HuV2JoWa46eIgG0e4TbewVQ=
X-Received: by 2002:a1f:e9c7:: with SMTP id g190mr925186vkh.69.1540978789557;
 Wed, 31 Oct 2018 02:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181025183739.9375-1-robert.foss@collabora.com> <20181025183739.9375-2-robert.foss@collabora.com>
In-Reply-To: <20181025183739.9375-2-robert.foss@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 31 Oct 2018 09:38:31 +0000
Message-ID: <CACvgo516JGdfBZ8zM73bQ-TCeNEbOp9ioBy9jh0AAtpUsu5tOg@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/virtio: add virtio_gpu_alloc_fence()
To:     Robert Foss <robert.foss@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:
>
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
>
> Refactor fence creation to remove the potential allocation failure from
> the cmd_submit and atomic_commit paths. Now the fence should be allocated
> first and just after we should proceed with the rest of the execution.
>

Commit does a bit more that what the above says:
 - dummy, factor out fence creation/destruction
 - use per virtio_gpu_framebuffer fence

Personally I'd keep the two separate patches and elaborate on the latter.
Obviously in that case, one will need to add 3 lines worth of
virtio_gpu_fence_alloc() in virtio_gpu_cursor_plane_update which will be nuked
with the next patch.

Not a big deal, but it's up-to the maintainer to make the final call if it's
worth splitting or not.

Couple of minor nitpicks below.

>         struct virtio_gpu_device *vgdev = dev->dev_private;
>         struct virtio_gpu_output *output = NULL;
>         struct virtio_gpu_framebuffer *vgfb;
> -       struct virtio_gpu_fence *fence = NULL;
>         struct virtio_gpu_object *bo = NULL;
>         uint32_t handle;
>         int ret = 0;

Add the virtio_gpu_fence_alloc()? And yes it will be nuked with patch 2/...



> +struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
> +{
> +       struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
> +       struct virtio_gpu_fence *fence = kzalloc(sizeof(struct virtio_gpu_fence), GFP_ATOMIC);
> +       if (!fence)
> +               return fence;
> +
> +       fence->drv = drv;
> +       dma_fence_init(&fence->f, &virtio_fence_ops, &drv->lock, drv->context, 0);
Oh no, lines over 80 col... while the original code is pretty and neat.

> +
> +       return fence;
> +}
> +
> +void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence)
> +{
> +       if (!fence)
> +               return;
> +
> +       if (fence->drv)
> +               dma_fence_put(&fence->f);
> +       else
> +               kfree(fence);
I'm not sure if/how we reach the else case here?

> +}
> +
>  int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>                           struct virtio_gpu_ctrl_hdr *cmd_hdr,
> -                         struct virtio_gpu_fence **fence)
> +                         struct virtio_gpu_fence *fence)
>  {

With a follow-up commit, we can drop the no longer needed return type.
Which it turns out was never checked ...



> @@ -319,6 +332,8 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>                 dma_fence_put(&fence->f);
>         }
>         return 0;
> +fail_fence:

The error labels seems to be called after what they do, not what
fails. fail_backoff seems better IMHO.

> +ttm_eu_backoff_reservation(&ticket, &validate_list);
Indentation seems off (or my client ate it)?


HTH
Emil
