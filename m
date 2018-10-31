Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E06ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B5320685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzxp6BRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B5320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeJaShg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:37:36 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46249 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJaShg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:37:36 -0400
Received: by mail-ua1-f68.google.com with SMTP id z8so5635978uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7M0UgePHpuUxoExjLDO7Ng++06lZMkdKHfd3ukiizY=;
        b=Tzxp6BRSkUosaiQK5pmbni4jsj0r1RiGF5vKU5jNPOThdEuh0arhROKKb0uRV/j5MK
         X5kRxAVsoFPNS5GbwrpqX0wsIwSX21fTVyG1sT4BDN3Ksq41fOXJwC2Gc8qxsLkztQuq
         tIQmJSFiRk3Cf8XNILJjEM6m5T+F5G+AFXH7t75SYnQaegEdUSYJfN7+yWt7WUM58t4a
         tGvvq45a90uFn10cXRkJ8DBVsKK10VRFu1n3uljJfBwX8iVslBfHihEMVj2KQIYts/rd
         zmpfvneMfAc0tbYpdKXw+NRHreYLj02BxGDFPnx6Hg4bjMZ7RUqNBmsrTh1aeg6wEW+v
         5cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7M0UgePHpuUxoExjLDO7Ng++06lZMkdKHfd3ukiizY=;
        b=pys+HfC2vSE10NEPhy2Od1esdSHaAKvUDCz37tfkjA631CWkYb01xLdC0U96WjB/3C
         cO/10O/UFIqc5cUYfESgWqzJnRUyXj/3v4u8ofz5im9iElC/EBzPTDWvLwH2aEqSOYps
         crFLcB6WGW/YjzVyBZOkR4hqacDVYBZNYh+Vnp06lXVlr6pEjVLnKWHX4S65m2U8X9tN
         eRXnzL0vUsYeYDqHt7M1M3RxcO0eZ+1zQ955OcwUz7UjwwxwiNaH1UjDNAoSWctlIKvE
         ruspGLjO/EVw5KD3coiNIJ1Ry1LpI2/jVrGW2v05X2RddDtqOupI/QmbH1JVAj78hfN/
         EGRw==
X-Gm-Message-State: AGRZ1gLtuyc82T+dKvmFhCEUIfGdZG6BfrI+yX7rH4lhjy90KyAwrZRe
        yvCabyGqqQORnKGb73AO+up01pSoe9yww32XN20=
X-Google-Smtp-Source: AJdET5fITL9I8sRApL/w1smQv1Ks7YRHZDyo/twwfMk7Wp46xgp+owNrlhcu8CFjVkL2ekmqKYdTrdh6DpQAle1z/HM=
X-Received: by 2002:ab0:15a1:: with SMTP id i30mr1027142uae.11.1540978813892;
 Wed, 31 Oct 2018 02:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181025183739.9375-1-robert.foss@collabora.com> <20181025183739.9375-4-robert.foss@collabora.com>
In-Reply-To: <20181025183739.9375-4-robert.foss@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 31 Oct 2018 09:38:56 +0000
Message-ID: <CACvgo51EXugYmNamgUKzyaYbk_kEyODNbG10AJtkvhbQgYwxWw@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/virtio: add in-fences support for explicit synchronization
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

> @@ -124,6 +127,22 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
>                 return -EINVAL;
>
> +       if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
> +               in_fence = sync_file_get_fence(in_fence_fd);
> +               if (!in_fence)
> +                       return -EINVAL;
> +
> +               /*
> +                * Wait if the fence is from a foreign context, or if the fence
> +                * array contains any fence from a foreign context.
> +                */
> +               if (!dma_fence_match_context(in_fence, vgdev->fence_drv.context)) {
> +                       ret = dma_fence_wait(in_fence, true);
> +                       if (ret)
> +                               return ret;
Aren't we missing dma_fence_put() before the return here?

With that
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
