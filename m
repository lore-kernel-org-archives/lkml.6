Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21751C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D215E206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y732KLdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D215E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeI2Ehi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbeI2Ehi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:37:38 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19F06206B6;
        Fri, 28 Sep 2018 22:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538172710;
        bh=unjdaZAIpcVtsiihZ/Zbeq5GkczDyn1hRCMCkrMgXO8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y732KLdb0onei8qZ/EQloFGLnQHT1oFH5hB6glTFTeUsYo8Fmr8IMgE5GbEKwnBBg
         F9vuBGeQQ+Da6ziqVIq2PLkFdEdOAnpHAOvXgWnLE4JmIlzP2fHXlEW9ogYLZiJcCu
         pZk6SGicwCnCRgVaUZYrfevU/reP95kKoaYCIvR8=
Received: by mail-qk1-f170.google.com with SMTP id 84-v6so4859314qkf.0;
        Fri, 28 Sep 2018 15:11:50 -0700 (PDT)
X-Gm-Message-State: ABuFfohDzxbQlVYkUm21JilQ0Uc8fwU5k8mtLZvaOfS9JxK+yBLUjuiA
        JGUd3WJHpl6vgAqo9kkDmoFbFaUcmQH0x8JG8Q==
X-Google-Smtp-Source: ACcGV607EgGr7S1r/eF7OlZCt0cUI2UsxaFuR88gWAQ90SwPOe2AjqHabr2/axAllbY85O490oA0qEnDopaV3ahR5K8=
X-Received: by 2002:a37:12d1:: with SMTP id 78-v6mr441887qks.147.1538172709313;
 Fri, 28 Sep 2018 15:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-49-robh@kernel.org>
In-Reply-To: <20180828015252.28511-49-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 17:11:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLofcnkhOPx5v=5K6DAnq7J8wCtJuakh4doJTF8d3TLhw@mail.gmail.com>
Message-ID: <CAL_JsqLofcnkhOPx5v=5K6DAnq7J8wCtJuakh4doJTF8d3TLhw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: Convert to using %pOFn instead of device_node.name
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 8:55 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/video/fbdev/cg14.c        |  4 +---
>  drivers/video/fbdev/cg3.c         |  2 +-
>  drivers/video/fbdev/core/fbmon.c  |  4 ++--
>  drivers/video/fbdev/imsttfb.c     |  2 +-
>  drivers/video/fbdev/leo.c         |  2 +-
>  drivers/video/fbdev/offb.c        | 12 ++++++++----
>  drivers/video/fbdev/p9100.c       |  2 +-
>  drivers/video/of_display_timing.c |  2 +-
>  8 files changed, 16 insertions(+), 14 deletions(-)

Ping!

>
> diff --git a/drivers/video/fbdev/cg14.c b/drivers/video/fbdev/cg14.c
> index 8de88b129b62..9af54c2368fd 100644
> --- a/drivers/video/fbdev/cg14.c
> +++ b/drivers/video/fbdev/cg14.c
> @@ -355,9 +355,7 @@ static int cg14_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
>  static void cg14_init_fix(struct fb_info *info, int linebytes,
>                           struct device_node *dp)
>  {
> -       const char *name = dp->name;
> -
> -       strlcpy(info->fix.id, name, sizeof(info->fix.id));
> +       snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
>
>         info->fix.type = FB_TYPE_PACKED_PIXELS;
>         info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
> diff --git a/drivers/video/fbdev/cg3.c b/drivers/video/fbdev/cg3.c
> index 6c334260cf53..1bd95b02f3aa 100644
> --- a/drivers/video/fbdev/cg3.c
> +++ b/drivers/video/fbdev/cg3.c
> @@ -246,7 +246,7 @@ static int cg3_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
>  static void cg3_init_fix(struct fb_info *info, int linebytes,
>                          struct device_node *dp)
>  {
> -       strlcpy(info->fix.id, dp->name, sizeof(info->fix.id));
> +       snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
>
>         info->fix.type = FB_TYPE_PACKED_PIXELS;
>         info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
> index 852d86c1c527..dd3128990776 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -1480,8 +1480,8 @@ int of_get_fb_videomode(struct device_node *np, struct fb_videomode *fb,
>         if (ret)
>                 return ret;
>
> -       pr_debug("%pOF: got %dx%d display mode from %s\n",
> -               np, vm.hactive, vm.vactive, np->name);
> +       pr_debug("%pOF: got %dx%d display mode\n",
> +               np, vm.hactive, vm.vactive);
>         dump_fb_videomode(fb);
>
>         return 0;
> diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
> index ecdcf358ad5e..901ca4ed10e9 100644
> --- a/drivers/video/fbdev/imsttfb.c
> +++ b/drivers/video/fbdev/imsttfb.c
> @@ -1473,7 +1473,7 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>
>         dp = pci_device_to_OF_node(pdev);
>         if(dp)
> -               printk(KERN_INFO "%s: OF name %s\n",__func__, dp->name);
> +               printk(KERN_INFO "%s: OF name %pOFn\n",__func__, dp);
>         else if (IS_ENABLED(CONFIG_OF))
>                 printk(KERN_ERR "imsttfb: no OF node for pci device\n");
>
> diff --git a/drivers/video/fbdev/leo.c b/drivers/video/fbdev/leo.c
> index 71862188f528..446ac3364bad 100644
> --- a/drivers/video/fbdev/leo.c
> +++ b/drivers/video/fbdev/leo.c
> @@ -434,7 +434,7 @@ static int leo_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
>  static void
>  leo_init_fix(struct fb_info *info, struct device_node *dp)
>  {
> -       strlcpy(info->fix.id, dp->name, sizeof(info->fix.id));
> +       snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
>
>         info->fix.type = FB_TYPE_PACKED_PIXELS;
>         info->fix.visual = FB_VISUAL_TRUECOLOR;
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index 77c0a2f45b3b..31f769d67195 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -419,9 +419,13 @@ static void __init offb_init_fb(const char *name,
>         var = &info->var;
>         info->par = par;
>
> -       strcpy(fix->id, "OFfb ");
> -       strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
> -       fix->id[sizeof(fix->id) - 1] = '\0';
> +       if (name) {
> +               strcpy(fix->id, "OFfb ");
> +               strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
> +               fix->id[sizeof(fix->id) - 1] = '\0';
> +       } else
> +               snprintf(fix->id, sizeof(fix->id), "OFfb %pOFn", dp);
> +
>
>         var->xres = var->xres_virtual = width;
>         var->yres = var->yres_virtual = height;
> @@ -644,7 +648,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
>                 /* kludge for valkyrie */
>                 if (strcmp(dp->name, "valkyrie") == 0)
>                         address += 0x1000;
> -               offb_init_fb(no_real_node ? "bootx" : dp->name,
> +               offb_init_fb(no_real_node ? "bootx" : NULL,
>                              width, height, depth, pitch, address,
>                              foreign_endian, no_real_node ? NULL : dp);
>         }
> diff --git a/drivers/video/fbdev/p9100.c b/drivers/video/fbdev/p9100.c
> index 64de5cda541d..c4283e9e95af 100644
> --- a/drivers/video/fbdev/p9100.c
> +++ b/drivers/video/fbdev/p9100.c
> @@ -239,7 +239,7 @@ static int p9100_ioctl(struct fb_info *info, unsigned int cmd,
>
>  static void p9100_init_fix(struct fb_info *info, int linebytes, struct device_node *dp)
>  {
> -       strlcpy(info->fix.id, dp->name, sizeof(info->fix.id));
> +       snprintf(info->fix.id, sizeof(info->fix.id), "%pOFn", dp);
>
>         info->fix.type = FB_TYPE_PACKED_PIXELS;
>         info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
> diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
> index 5244e93ceafc..c2e7aa103fa5 100644
> --- a/drivers/video/of_display_timing.c
> +++ b/drivers/video/of_display_timing.c
> @@ -170,7 +170,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
>                 goto entryfail;
>         }
>
> -       pr_debug("%pOF: using %s as default timing\n", np, entry->name);
> +       pr_debug("%pOF: using %pOFn as default timing\n", np, entry);
>
>         native_mode = entry;
>
> --
> 2.17.1
>
