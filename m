Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4242BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA102086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSajK00m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA102086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeH1S4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:56:44 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45513 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1S4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:56:44 -0400
Received: by mail-io0-f195.google.com with SMTP id e12-v6so1701772iok.12;
        Tue, 28 Aug 2018 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2GXxLl1vXfv7C9aDEdlTUpyffLTu/UbcVNyYi6Tpfyw=;
        b=XSajK00mk/8d94XtdO+SQSv+jWVHZLgK6+kpJr3yYzV36MBtf0hBP61eD2hq9nosNZ
         nCp0XkznFhL/dnppQxxG87KwG3gdltN20r8m/38P8Ch1eMx6yuZPPYXv4zdF7NeL+Qx9
         PDLwzbnsNiN4an973eZHu0VuX526h0XSiryb4HhVjuDdOI2zz/iJ1AOdHtSWfPxW633k
         /l6ift2si/Dn7P6r1Di0z6mhzseX91on23bbKEIdt92/imnlwtJYy5xhYI6VPQ3n3p6a
         e8vFjjKhyCnC5+CMMoXwX8GNJdbNaXIPAnzoyA1qdfYjkva3KhynXqiDWGrv+fZYIWOY
         BJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GXxLl1vXfv7C9aDEdlTUpyffLTu/UbcVNyYi6Tpfyw=;
        b=oJe4MFb4fgeAQXpQurQbtRbAqkSG1xhBjbEw3NYuIe1wTADb3IV+qtXMLOD3i23jUe
         PpH7tTQrRHDb08EHaVNBdkkeHqt3KQY7zJSFHYVXHGzXJwQKjFXzprGTxIzQSv8ohCoO
         iVOo07FHVpIRyTSMMrFkOSDe6Lu4jdW9LDGTj2dh8EjoS0n9lRyu0ff2LtNAxd/Y39KD
         ZKggQSdS01DOuTsGXOrIj4aXC8CTFQ7bc3F2+xHE09ncEMJaw534+e0jnG6xG3f+ezjK
         WX1ZZQFD7QEMP4C4RXNBujblOXDodIZr/NFB2mrQmxTv0ynOJc30eo3QpK5HMVj0vIaR
         7TuQ==
X-Gm-Message-State: APzg51A0NLLyGsfCo+3ry7YvWr+u5FDLrlzcVuEf9Yiymke+0zN+cpCM
        SLFEnWHXR/lalHEVjjINbN2RpesEonMCk8GAu7s=
X-Google-Smtp-Source: ANB0VdZ3Mnr9eAV+yDn0StxEVYp+OlIEBBBlKem9PbhO7+7RqC5AInakpVYe5CwkNMifzfh0dlpG5j4f8Npa2Mcai4k=
X-Received: by 2002:a6b:ac45:: with SMTP id v66-v6mr1819444ioe.66.1535468677747;
 Tue, 28 Aug 2018 08:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-19-robh@kernel.org>
In-Reply-To: <20180828015252.28511-19-robh@kernel.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 28 Aug 2018 11:04:22 -0400
Message-ID: <CAF6AEGveHXEfDb4U8-N1SRYcHytSkpCfx4pEYg4=EMwiPW7Gsg@mail.gmail.com>
Subject: Re: [PATCH] drm: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:53 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>

for msm part,

Acked-by: Rob Clark <robdclark@gmail.com>

(for drm_modes part, I guess there is no harm removing the redundant name)

BR,
-R

> ---
>  drivers/gpu/drm/drm_modes.c     | 4 ++--
>  drivers/gpu/drm/msm/hdmi/hdmi.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 02db9ac82d7a..24a750436559 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -716,8 +716,8 @@ int of_get_drm_display_mode(struct device_node *np,
>         if (bus_flags)
>                 drm_bus_flags_from_videomode(&vm, bus_flags);
>
> -       pr_debug("%pOF: got %dx%d display mode from %s\n",
> -               np, vm.hactive, vm.vactive, np->name);
> +       pr_debug("%pOF: got %dx%d display mode\n",
> +               np, vm.hactive, vm.vactive);
>         drm_mode_debug_printmodeline(dmode);
>
>         return 0;
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> index c79659ca5706..23670907a29d 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -579,7 +579,7 @@ static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
>         hdmi_cfg = (struct hdmi_platform_config *)
>                         of_device_get_match_data(dev);
>         if (!hdmi_cfg) {
> -               dev_err(dev, "unknown hdmi_cfg: %s\n", of_node->name);
> +               dev_err(dev, "unknown hdmi_cfg: %pOFn\n", of_node);
>                 return -ENXIO;
>         }
>
> --
> 2.17.1
>
