Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F8ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17AB2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VirXoMlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17AB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJRJOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:14:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34455 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeJRJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:14:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id o17-v6so32506788qtr.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 18:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ur+Uhp8bN2qc32VHjasdHdJWZ8B7fFu+w72XJxtIRGk=;
        b=VirXoMlNL9J8BflyY25z0KjIsQ5Xq659hDQbkA8s3ga/TxyJgOPOIowp7GeSnfuCqT
         ZvjUtktEijvlh8dHrQAeO11csDcA0d9zKV0JXTGQZXiKyfQpmChCK9FxE+VUsF0OJq9H
         E3NkeVh7MgvIGqNUP5NOf8jtHWYaZbXVbJPmAG1eJoD0ACV+TCUGD07lm/ri7BZcFS3q
         Mb8a4MRAROav2/FmKbPRjJU/RAXHxnwevAF/O7nLD2V4/Ah0NxlIICBUG5biCpVUFVsl
         RavSVcCaFS5p/bEt1QMlEcHvmrfOHmMCUGv7ViDnfBspR65HyKiNrT5bFi6K8Gn+IOyx
         uXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ur+Uhp8bN2qc32VHjasdHdJWZ8B7fFu+w72XJxtIRGk=;
        b=OvYfkJha21d9X39UJsMw64kefIURc8mpZON0quBaraCIJQumcZTepveFg/NiZiFVse
         BYS2PgT15HMIA95+HNYw4RngpDQjOlUdqWFl6VSyeT5GhSqp9vQPNRvOkDlSj/cKNPkv
         m7QgkM88/u5YKZSQCoOGGKd9Q3kZAraX0FvxLsKEH/WYIbIY8sskIJxZ0ia44nhZxIfe
         Gwxe/i8D7DQuNC1OknxqbALZcsrF6JKfUQkdmTpHLikHHSDOknyr4MVgZj54S5DH3GfV
         122khn7rny8hNtWErzJgEDGkwajDjsWQWbsIyV18kQU477C7E7Rxzj+OwhmBbetGYCav
         nmUg==
X-Gm-Message-State: ABuFfoiog6s1hVNQ/1RF1q/TZJfbPgi/L63+t3nSEQ7MdiGXkbRTyjdn
        0HqonBQ2uqNi2/zwxn1ehmFxIa/F3x4jDdzI+As=
X-Google-Smtp-Source: ACcGV60V24DqgJcOOhpnOdGUDQGKttqKZe5QiGPjmvMDT5SxRMO8D52IcU9eIWdPt3NGOjO0359njD11QcuIFMPFVQI=
X-Received: by 2002:a0c:e883:: with SMTP id b3mr3600095qvo.35.1539825337762;
 Wed, 17 Oct 2018 18:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181005120934.21959-1-kraxel@redhat.com>
In-Reply-To: <20181005120934.21959-1-kraxel@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 18 Oct 2018 11:15:25 +1000
Message-ID: <CAPM=9twEjDr5dj+9B==QSYtAB7uqy0Szn2d7cw9swSk+THMA2g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bochs: add edid support.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 at 22:10, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Recent qemu (latest master branch, upcoming 3.1 release) got support
> for EDID data.  This patch adds guest driver support.
>
> EDID support in qemu is not (yet) enabled by default, so please use
> 'qemu -device VGA,edid=on' for testing.

The EDID never changes after boot? Is there plans to let it?
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs.h     |  1 +
>  drivers/gpu/drm/bochs/bochs_hw.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/bochs/bochs_kms.c | 18 +++++++++++++++---
>  3 files changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index e7a69077e4..06b8166efa 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -66,6 +66,7 @@ struct bochs_device {
>         u16 yres_virtual;
>         u32 stride;
>         u32 bpp;
> +       struct edid *edid;
>
>         /* drm */
>         struct drm_device  *dev;
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index cacff73a64..6ce4cdac38 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -69,6 +69,41 @@ static void bochs_hw_set_little_endian(struct bochs_device *bochs)
>  #define bochs_hw_set_native_endian(_b) bochs_hw_set_little_endian(_b)
>  #endif
>
> +static int bochs_load_edid(struct bochs_device *bochs)
> +{
> +       uint8_t *blob;
> +       size_t i, len;
> +       uint8_t num_exts;
> +
> +       if (!bochs->mmio)
> +               return -1;
> +
> +       if ((readb(bochs->mmio+0) != 0x00 ||
> +            readb(bochs->mmio+1) != 0xff))
> +               return -1;
> +
> +       num_exts = readb(bochs->mmio + 126);
> +       len = EDID_LENGTH * (1 + num_exts);
> +       if (len > 0x400 /* vga register offset */)
> +               return -1;
> +
> +       kfree(bochs->edid);
> +       bochs->edid = kmalloc(len, GFP_KERNEL);

Don't you need to free it somewhere?

Dave.
