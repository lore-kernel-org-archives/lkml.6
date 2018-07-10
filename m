Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D4AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4C7208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4C7208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934488AbeGJQJw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:09:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44015 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934062AbeGJQJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:09:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id u11-v6so16968575eds.10;
        Tue, 10 Jul 2018 09:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1X+dgrB2ev9jDKmiI+Gt6wRc268Q8H8t0C/Ab9v9Vcw=;
        b=GCeNeQIG2OCy+pTisXG0uX5N6B4t66TSijIP1tVLtgbiwRRuqoDhVu3B40KzECL9Hx
         oULMSTPdJTmZoF/0ZDeCuZWPTXAGwch/JNpuLixKATqmtj9148sm/1Mrz+pomXHhYMYX
         KdUznAWj8VvoAE57eZuF6aCg8fTwzdgz7Bh5+uESXzU/wZxAAy8AiAxIAftWq7r+NgCD
         Oisck+aJ5fUcFBZLVUL2RRmQazbAH9LRzS/bCQTIzwyPPxPqNavuLn2RLovnxEjWzW66
         Wmq+KnkgIe3knDjpOIw0GXJZY3ZFqQkfbpZGLeFsXSvW7WPWx7Es8YVWRavf/9N7epGx
         Ct/A==
X-Gm-Message-State: APt69E26hH0US6dpLWV3W6AK+aeTewvpUfXMHjgWDHa8uBxExiC4Lkwo
        hVXpvJNkm5XcRB8tOWIbiNJdhwGm
X-Google-Smtp-Source: AAOMgpeURH7wJ4OrxzGR9gfjqZGGvrISMKLZmolEmJA8Oz0ZMt+2rshR9TN81BqpiRPitdEwoVWiBA==
X-Received: by 2002:a50:8386:: with SMTP id 6-v6mr27246758edi.170.1531238988868;
        Tue, 10 Jul 2018 09:09:48 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id w2-v6sm957993edb.33.2018.07.10.09.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 09:09:48 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id j5-v6so8690190wrr.8;
        Tue, 10 Jul 2018 09:09:47 -0700 (PDT)
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr17805049wrh.148.1531238987130;
 Tue, 10 Jul 2018 09:09:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 09:09:26
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-17-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-17-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 00:09:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v64rjUnwnXbWxTSYJyhMyCV5QmV9YSr+Jryx3nEeMP8GJg@mail.gmail.com>
Message-ID: <CAGb2v64rjUnwnXbWxTSYJyhMyCV5QmV9YSr+Jryx3nEeMP8GJg@mail.gmail.com>
Subject: Re: [PATCH 16/17] drm/sun4i: tcon-top: Remove mux configuration at
 probe time
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
> Now that R40 TCON migrated to runtime mux configuration, old code can be
> removed.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 81 +++-----------------------
>  1 file changed, 7 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> index c09b15b64192..78795d6cb174 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -87,34 +87,6 @@ int sun8i_tcon_top_de_config(struct device *dev, int mixer, int tcon)
>  }
>  EXPORT_SYMBOL(sun8i_tcon_top_de_config);
>
> -static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
> -                                             int port_id)
> -{
> -       struct device_node *ep, *remote, *port;
> -       struct of_endpoint endpoint;
> -
> -       port = of_graph_get_port_by_id(node, port_id);
> -       if (!port)
> -               return -ENOENT;
> -
> -       for_each_available_child_of_node(port, ep) {
> -               remote = of_graph_get_remote_port_parent(ep);
> -               if (!remote)
> -                       continue;
> -
> -               if (of_device_is_available(remote)) {
> -                       of_graph_parse_endpoint(ep, &endpoint);
> -
> -                       of_node_put(remote);
> -
> -                       return endpoint.id;
> -               }
> -
> -               of_node_put(remote);
> -       }
> -
> -       return -ENOENT;
> -}
>
>  static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
>                                                    const char *parent,
> @@ -149,11 +121,9 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
>         struct platform_device *pdev = to_platform_device(dev);
>         struct clk_hw_onecell_data *clk_data;
>         struct sun8i_tcon_top *tcon_top;
> -       bool mixer0_unused = false;
>         struct resource *res;
>         void __iomem *regs;
> -       int ret, i, id;
> -       u32 val;
> +       int ret, i;
>
>         tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
>         if (!tcon_top)
> @@ -198,49 +168,12 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
>                 goto err_assert_reset;
>         }
>
> -       val = 0;
> -
> -       /* check if HDMI mux output is connected */
> -       if (sun8i_tcon_top_get_connected_ep_id(dev->of_node, 5) >= 0) {
> -               /* find HDMI input endpoint id, if it is connected at all*/
> -               id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 4);
> -               if (id >= 0)
> -                       val = FIELD_PREP(TCON_TOP_HDMI_SRC_MSK, id + 1);
> -               else
> -                       DRM_DEBUG_DRIVER("TCON TOP HDMI input is not connected\n");
> -       } else {
> -               DRM_DEBUG_DRIVER("TCON TOP HDMI output is not connected\n");
> -       }
> -
> -       writel(val, regs + TCON_TOP_GATE_SRC_REG);
> -
> -       val = 0;
> -
> -       /* process mixer0 mux output */
> -       id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 1);
> -       if (id >= 0) {
> -               val = FIELD_PREP(TCON_TOP_PORT_DE0_MSK, id);
> -       } else {
> -               DRM_DEBUG_DRIVER("TCON TOP mixer0 output is not connected\n");
> -               mixer0_unused = true;
> -       }
> -
> -       /* process mixer1 mux output */
> -       id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 3);
> -       if (id >= 0) {
> -               val |= FIELD_PREP(TCON_TOP_PORT_DE1_MSK, id);
> -
> -               /*
> -                * mixer0 mux has priority over mixer1 mux. We have to
> -                * make sure mixer0 doesn't overtake TCON from mixer1.
> -                */
> -               if (mixer0_unused && id == 0)
> -                       val |= FIELD_PREP(TCON_TOP_PORT_DE0_MSK, 1);
> -       } else {
> -               DRM_DEBUG_DRIVER("TCON TOP mixer1 output is not connected\n");
> -       }
> -
> -       writel(val, regs + TCON_TOP_PORT_SEL_REG);
> +       /*
> +        * Default register values might have some reserved bits set, which
> +        * prevents TCON TOP from working properly. Set them to 0 here.
> +        */
> +       writel(0, regs + TCON_TOP_GATE_SRC_REG);
> +       writel(0, regs + TCON_TOP_PORT_SEL_REG);

Would it make sense to just force a reset using the reset control?

ChenYu
