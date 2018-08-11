Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CABC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DB2219F2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DB2219F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeHKMTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 08:19:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35759 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeHKMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 08:19:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so4181764wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 02:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fd4+RL+f/owZqN/PPDk/kBm1nrcNE+O5u5pEurAl4zU=;
        b=DbrXgr41p4WEdbD6tui2EZFaDfkaIikxcVaabBOahz+wGCwt6JVoKiDEzQdGRMHOJR
         aLs+Z8Gw2kziXJbx5oSqWXDN/1FtX+htM6m7kemjxt4AB5myzCkvWMrMd+9OF1EpR6qt
         pAWfst88kLZT5GnrHePx5AYSfBgtqKlWK38lZaI0Sk34n/bV9PzSDhXFQ1ZoWq61AXqu
         xQJHKnu+m/XuZwiato25BXUWe9yumZOpi9QaABsIKc//+PDnE4uiIvsSxb6ylDaU7tH3
         qr9UdNl1GSVKmpuCQf2rF2SWiw/HVoO9QeCMbLLG1Pm/Pj4vlCq67oU1I0DPQZPv2itR
         WAGw==
X-Gm-Message-State: AOUpUlE/UdxrH3Z6sxOEvMjwzaIfIhAatKD2/YiVWtfBgbsVOawG9HC1
        5LyFOkyiX3F2hIyowZmqxO/B4ac8KVoP09zlUNwfQbWv
X-Google-Smtp-Source: AA+uWPz1a2kuJmUMWnum18KH+6nVmuCap8SvEnnjiPjPd0k3DeNtG5OyNMANQk14oR2upAK0najFZtsz1W2AVklyzyw=
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr3316388wmf.1.1533980759623;
 Sat, 11 Aug 2018 02:45:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 02:45:58
 -0700 (PDT)
In-Reply-To: <20180807203914.2192-6-lyude@redhat.com>
References: <20180807203914.2192-1-lyude@redhat.com> <20180807203914.2192-6-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 11 Aug 2018 11:45:58 +0200
Message-ID: <CACO55ts8cWRpXyEa-t2E_jtj_iDhsruWLfmk4LnJJ9vVBZvoeA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v5 05/13] drm/nouveau: Remove useless
 poll_enable() call in drm_load()
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1-5 are Acked-by: Karol Herbst <kherbst@redhat.com>

On Tue, Aug 7, 2018 at 10:39 PM, Lyude Paul <lyude@redhat.com> wrote:
> Again, this doesn't do anything. drm_kms_helper_poll_enable() will have
> already been called in nouveau_display_init()
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Karol Herbst <karolherbst@gmail.com>
> [omitting stable Cc, this probably doesn't fix any real bugs]
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 5fdc1fbe2ee5..04f704b77a3c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -592,10 +592,8 @@ nouveau_drm_load(struct drm_device *dev, unsigned long flags)
>                 pm_runtime_allow(dev->dev);
>                 pm_runtime_mark_last_busy(dev->dev);
>                 pm_runtime_put(dev->dev);
> -       } else {
> -               /* enable polling for external displays */
> -               drm_kms_helper_poll_enable(dev);
>         }
> +
>         return 0;
>
>  fail_dispinit:
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
