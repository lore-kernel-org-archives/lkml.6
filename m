Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D373DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815A02082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8NHHmGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815A02082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeJ3UZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:25:29 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41244 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeJ3UZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:25:28 -0400
Received: by mail-vs1-f66.google.com with SMTP id t17so4250389vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 04:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E04pV4Qobv3gDE4RrtGIrhsAe23uBikvEc8jciqeZHo=;
        b=K8NHHmGITW7DwzLZjd2gTOQ/ga2HQmQZYnLqMqYBDW/afRxEbw+Mj3J4m0RzFtrlKI
         qx5RQErR6yBPsW+aCjEWL3Y8lg12DzvKkFKLMCeey/N7vLK2EoUvZ8Lxt78r3c9h9rRO
         0KEqbTU0UAi/uh5OZjpcIxY5ktemC/fqmpdWK8W7ibklZDMwMXfbiKKWlm3xnDn1li5V
         f2zj5k6nYL0T8kcHHFi3v/p8QB+ySkMiq02uZlR/BtkrwGnbWKl8SpEokDcZv4s2TAH0
         /lQ71M5IxZY5bwjCg7MUyKRAN+9cy3YthCtPr+FP+8n8NT7SsotlHLhqStJvc88MjWf0
         f8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E04pV4Qobv3gDE4RrtGIrhsAe23uBikvEc8jciqeZHo=;
        b=q94gFATFIDQyGPOnKb+n4LQpfxSW1wHeohuNB4UFSQH3znVux+nc+aSgVXCkE56xy+
         EOnssLbvMoJmcgPN62rT4Cez1kshTJpZ5bkHsNO8ACuOIpvAZX9IkQIAqF5fsk2KqBDF
         QOLsnKCj5YsO0mOs9EyumIBegpq1aSYxdPZanDZYjslo2vxJVKOdp2KTxqHMlxGUDxQt
         zzAxJZy0nnIcXLfR5exq7AFYAM3byx7XjHcgKJiK9xaq/mzRaBb9pe4gB4EtGK4NEyiK
         +PY+uecfeO341N/RfMInofgQ/DytHXDJHO/fglTrXFSZpoFG1seU3u4uTZflfGP/MUKG
         krCA==
X-Gm-Message-State: AGRZ1gKVah7ja4sOxqmBsbkYyuMc4GfjqnLkhAmhb6Kua6rOvDgVq+Du
        p6Af/Lr8k8Ck8pS+vKgKaDxQvU/Jg+EPxnRPfgs=
X-Google-Smtp-Source: AJdET5fF9CzVAfC5s5Woeo2G2E8DQIKYENW3ipKREyLpc4nnwiLTV1vengLm7cPfaHDO2UU8W7WNBth7Bi8suPcrK8w=
X-Received: by 2002:a67:60c7:: with SMTP id u190mr4556581vsb.85.1540899141292;
 Tue, 30 Oct 2018 04:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181025183739.9375-1-robert.foss@collabora.com>
 <20181025183739.9375-3-robert.foss@collabora.com> <20181030061127.hp4n2scw5f3j2rqq@sirius.home.kraxel.org>
In-Reply-To: <20181030061127.hp4n2scw5f3j2rqq@sirius.home.kraxel.org>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 30 Oct 2018 11:31:04 +0000
Message-ID: <CACvgo50MK1jU0jKMCfZJQSaSmpQ8mmYj1=4GP2NQvM_DHOaW-Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/virtio: add uapi for in and out explicit fences
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Robert Foss <robert.foss@collabora.com>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Gerd,

On Tue, 30 Oct 2018 at 06:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > The execbuffer IOCTL is now read-write to allow the userspace to read the
> > out-fence.
>
> >  #define DRM_IOCTL_VIRTGPU_EXECBUFFER \
> > -     DRM_IOW(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
> > +     DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
> >               struct drm_virtgpu_execbuffer)
>
> That changes the ioctl number and breaks the userspace api.
>
Have you looked at the drm_ioctl() implementation? AFAICT it
explicitly caters for this kind of changes.

-Emil
