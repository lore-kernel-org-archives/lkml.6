Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDEFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5C6208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5C6208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeGKDO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:14:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43011 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbeGKDO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:14:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id u11-v6so18006450eds.10;
        Tue, 10 Jul 2018 20:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QxU/Dw9Xlxrpz5zPQauLoiJ5usN1XoQhbiyPL7ohbrQ=;
        b=QyqjXDz38IMDydj3dNKW6czb5LaO0m19ARArgJpwdZ9Iwl739b3aAMmsIjR7/Z6gbW
         euC8VEVWnoQyP1r9WZw4dF6Whj+7kY9ZHSc+cmSHkXcEOFBR88JrIUiV8lLd8qASNn95
         0CJDfZVUh5TYo8zmFtJkscfuPHxjzRcMvIQI0NXoFES8biBpqBBbNwDovI+LVXTKcFgr
         Alm+VVV3+uD5w5KGNcgzWS33C81XJjF8BpSTJQbt+k91VYpSh04C/SV/I+7FJQIfve4P
         GqddT5pXDhT53qHN99FApfE84dhs5LfpuWaj2pfHvDwOYyRNEZECfTlYYOqKnl63Qalm
         unUw==
X-Gm-Message-State: APt69E3Ja9Wvumk18iO9MNTkhWDOIWHEbJrfbf5zTiEPcsrC26S/ljN1
        mNpAFAKqRcWyvDLOh7FzsIFGg0LX
X-Google-Smtp-Source: AAOMgpfYtnWgugpFnekxKbXWCipP7ogOoBOdgwE9+Woe4kY8sQsfoOtAkf0dhj3F3YXEh3vGJ8vs+A==
X-Received: by 2002:a50:8327:: with SMTP id 36-v6mr8932776edh.305.1531278739611;
        Tue, 10 Jul 2018 20:12:19 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id 33-v6sm2222730edy.82.2018.07.10.20.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 20:12:18 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id q10-v6so16547463wrd.4;
        Tue, 10 Jul 2018 20:12:17 -0700 (PDT)
X-Received: by 2002:adf:f9c9:: with SMTP id w9-v6mr18918844wrr.105.1531278737643;
 Tue, 10 Jul 2018 20:12:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 20:11:56
 -0700 (PDT)
In-Reply-To: <20180710203511.18454-11-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net> <20180710203511.18454-11-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 11:11:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v66vU4gBewGjLL-Ohx6mvKOVu4dDdwKNsXrkr3nZsSq3Cg@mail.gmail.com>
Message-ID: <CAGb2v66vU4gBewGjLL-Ohx6mvKOVu4dDdwKNsXrkr3nZsSq3Cg@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] drm/sun4i: mixer: Read id from DT
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:35 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Currently, TCON supports 2 ways to match TCON with engine (mixer in this
> case). Old way is to just traverse of graph backwards and compare node
> pointer. New way is to match TCON and engine by their respective ids.
> All SoCs with DE2 enabled till now used the old way, which means mixer
> id was never used and thus never implemented.
>
> However, for R40, only the new way will be used. To prepare for that,
> implement mixer id fetching from DT.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 40 +++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index aa81b9838ae8..4bd4d8ccb34f 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -22,6 +22,7 @@
>  #include <linux/component.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of_device.h>
> +#include <linux/of_graph.h>
>  #include <linux/reset.h>
>
>  #include "sun4i_drv.h"
> @@ -322,6 +323,42 @@ static struct regmap_config sun8i_mixer_regmap_config = {
>         .max_register   = 0xbfffc, /* guessed */
>  };
>
> +static int sun8i_mixer_of_get_id(struct device_node *node)
> +{
> +       struct device_node *port, *ep;
> +       int ret = -EINVAL;
> +
> +       /* output is port 1 */
> +       port = of_graph_get_port_by_id(node, 1);
> +       if (!port)
> +               return -EINVAL;
> +
> +       /* try to find downstream endpoint */
> +       for_each_available_child_of_node(port, ep) {
> +               struct device_node *remote;
> +               u32 reg;
> +
> +               remote = of_graph_get_remote_endpoint(ep);
> +               if (!remote)
> +                       continue;
> +
> +               ret = of_property_read_u32(remote, "reg", &reg);
> +               if (!ret) {
> +                       of_node_put(remote);
> +                       of_node_put(ep);
> +                       of_node_put(port);
> +
> +                       return reg;
> +               }
> +
> +               of_node_put(remote);
> +       }
> +
> +       of_node_put(port);
> +
> +       return ret;
> +}
> +

The above looks good.

>  static int sun8i_mixer_bind(struct device *dev, struct device *master,
>                               void *data)
>  {
> @@ -353,8 +390,7 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
>         dev_set_drvdata(dev, mixer);
>         mixer->engine.ops = &sun8i_engine_ops;
>         mixer->engine.node = dev->of_node;
> -       /* The ID of the mixer currently doesn't matter */
> -       mixer->engine.id = -1;
> +       mixer->engine.id = sun8i_mixer_of_get_id(dev->of_node);

Should you be handling error codes?

ChenYu
