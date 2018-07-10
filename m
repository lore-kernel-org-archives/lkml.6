Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388D1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF929208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF929208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934304AbeGJPkj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:40:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46873 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeGJPkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:40:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id r17-v6so16908936edo.13;
        Tue, 10 Jul 2018 08:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NNlLbN+t5Ut1spl98NnZf1IWY5L3lt1/avORSczNK+8=;
        b=pDfpUnJdM8bJeauKQca6E8ckOWjjTH+yqkoPu2elxaN/DT65jQVF9ZrRa1QhQtBFbx
         0Ncy4eEi8FgtNnwv5/M6G5r7NzGLgh8tEivBZtLEgLwhs8hXobUVkZYJS1E5CDuOIMTA
         kPjT4ERPgKjX5bIaq1ReQTHk08P2pAMOVvz+SRfhnnEENfMLKIsi0dndKyc5gjbX7Hv9
         FpSyxoFSkrgNZI4OhD7FYQwe8H/0r4QTAbRSyvBJRnqWyr9VrNVbZZ7kH3BM/ASJbep+
         QpnfZjgapZniK/rD5LQeubWNxQuoSYh/nKyxgQ6F2vpWV4bxlz8tlcQkwkLDwhLrG1V+
         kwMA==
X-Gm-Message-State: APt69E1mbeQJ+kXLm+XbcEQ4ot4tSWo/uqnOTTT8MwgU6x5j2qbx4oCl
        6WV15+IyoMHusGLqls+8MrzNIPf/
X-Google-Smtp-Source: AAOMgpe3h1TOyyyk25iLPsG4hWguaOgPKVLQEurj0FkkBXRJGNc81r4/jNmYiPNWu9QG/Bmu8MCnxw==
X-Received: by 2002:a50:de03:: with SMTP id z3-v6mr27553685edk.245.1531237236044;
        Tue, 10 Jul 2018 08:40:36 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id j34-v6sm9101174edd.2.2018.07.10.08.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:40:35 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id v128-v6so7527522wme.5;
        Tue, 10 Jul 2018 08:40:35 -0700 (PDT)
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr15709525wmc.58.1531237235201;
 Tue, 10 Jul 2018 08:40:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:40:14
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-10-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-10-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:40:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v64zBrzpqV9pvJPeaxbpLai8Ky0gTcwbSPv0m-vS-2JXKg@mail.gmail.com>
Message-ID: <CAGb2v64zBrzpqV9pvJPeaxbpLai8Ky0gTcwbSPv0m-vS-2JXKg@mail.gmail.com>
Subject: Re: [PATCH 09/17] drm/sun4i: mixer: Read id from DT
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

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Currently, TCON supports 2 ways to match TCON with engine (mixer in this
> case). Old way is to just traverse of graph backwards and compare node
> pointer. New way is to match TCON and engine by their respective ids.
> All SoCs with DE2 enabled till now used the old way, which means mixer
> id was never used and thus never implemented.
>
> However, for R40, only the new way will be used. To prepare for that,
> implemend fetching mixer id from DT.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 35 +++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index ee8febb25903..11221f96746d 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -23,6 +23,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/reset.h>
>  #include <linux/of_device.h>
> +#include <linux/of_graph.h>

These should be alphabetically ordered.

>
>  #include "sun4i_drv.h"
>  #include "sun8i_mixer.h"
> @@ -322,6 +323,37 @@ static struct regmap_config sun8i_mixer_regmap_config = {
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
> +       /* try finding an upstream endpoint */

You mean downstream.

> +       for_each_available_child_of_node(port, ep) {
> +               struct device_node *remote;
> +               u32 reg;
> +
> +               remote = of_graph_get_remote_endpoint(ep);
> +               if (!remote)
> +                       continue;
> +
> +               ret = of_property_read_u32(remote, "reg", &reg);
> +               if (ret)
> +                       continue;

This is somewhat redundant, given the current code structure will loop
over all available child nodes. What you want is probably an early
termination condition instead, i.e. if (!ret).

Also, remember to call of_node_put on the remote node.

ChenYu

> +
> +               ret = reg;
> +       }
> +
> +       of_node_put(port);
> +
> +       return ret;
> +}
> +
>  static int sun8i_mixer_bind(struct device *dev, struct device *master,
>                               void *data)
>  {
> @@ -353,8 +385,7 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
>         dev_set_drvdata(dev, mixer);
>         mixer->engine.ops = &sun8i_engine_ops;
>         mixer->engine.node = dev->of_node;
> -       /* The ID of the mixer currently doesn't matter */
> -       mixer->engine.id = -1;
> +       mixer->engine.id = sun8i_mixer_of_get_id(dev->of_node);
>
>         mixer->cfg = of_device_get_match_data(dev);
>         if (!mixer->cfg)
> --
> 2.18.0
>
