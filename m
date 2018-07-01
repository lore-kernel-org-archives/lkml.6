Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0717FC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB3C2579D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmVUesdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB3C2579D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeGATLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 15:11:23 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40092 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbeGATLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 15:11:21 -0400
Received: by mail-wr0-f195.google.com with SMTP id t6-v6so1076224wrn.7;
        Sun, 01 Jul 2018 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t8b2gN/S/piqeSwhdtvvdWE4Dtg0cxf/Fziw9C4cNwc=;
        b=dmVUesdHt2OMJsncglY5LyFugiJxS2mNNzzoAvvfonnAsm27qYZKbJHMxkRlF3gbSI
         pYiGo6iZyuBMr6cCAO/5bSBUiA2Dbvjx5EqD3vSrYX5JyzOxLI950lL9LkWjdrt6CwPn
         WHi9mI9uCgiGyxAbAazQQYHgY6JHYXFusJOpsqyt1t8DQdi7Q8GHLGcpOrRw9AEj0VK+
         4qKPUVtddwldWRPLOWui4GO/6+JUCLv7SJ8XKMwkKYDY0QDb1IP6KCcCREHblvEx7MqT
         gNfQrQptOob+2T2PNO7CbGlLSPNQhWKAEteCXqHY8T2SKDKZaXaJLV5kmSrWkIKmOoFM
         S7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8b2gN/S/piqeSwhdtvvdWE4Dtg0cxf/Fziw9C4cNwc=;
        b=SQ0nLjuBaQ+zgTbH0VyZqi8uVr48MI0+OlPbihAj1Zi0iKdHfzNvrofYiazixl+AU7
         98+TyTYTVj3kIl/Gl36xKOdXcC2KR8DG21LYupSjNaMZ4vEN29Qn5N+g3KWy13nknfsy
         bxd83JAVTIB8I7W04CKN/R37VtAjfKnJi7wmEHGFeTIJ75Mdllnlh5/ikv/2ycdCPAjW
         kUvXl+j1LbvcqrRB2sZcTySz1Pg6EGAWjtOE3I4Xl+PLs3r+a8JrHeYN8o3X6nCRcMiq
         L78BxEo7pbShTP+4HKRKmu4Uw6O/4e9zr5XvHF8tZfNxuFvoNvjTeuHE7A8oNs/jcJxN
         b2Ow==
X-Gm-Message-State: APt69E0ofORUZnlqIO/zMEfrT0PsXLdMQO4cgazmVAgMxYZMSu+bJUKC
        LqvmZfZDpqLdOsZj9nQ+8QwBZ/Xm
X-Google-Smtp-Source: AAOMgpdKOQxMxpr5ewWT9Xb3zbPwNeQYRG2cU0ptEKD7vmABvvuMex0N6opOmZYUZpc4DJSBCw4DCg==
X-Received: by 2002:a5d:4985:: with SMTP id r5-v6mr1159525wrq.116.1530472279552;
        Sun, 01 Jul 2018 12:11:19 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id w3-v6sm17291510wrr.88.2018.07.01.12.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 12:11:18 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [linux-sunxi] Re: [PATCH v3 10/24] drm/sun4i: tcon: Generalize engine search algorithm
Date:   Sun, 01 Jul 2018 21:09:47 +0200
Message-ID: <7152481.kAipQ5gD38@jernej-laptop>
In-Reply-To: <3257762.ZQzN8rrT6c@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180628182543.yyja6hiry7rx7fu2@flea> <3257762.ZQzN8rrT6c@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 29. junij 2018 ob 21:06:09 CEST je Jernej =C5=A0krabec napisal(a=
):
> Dne =C4=8Detrtek, 28. junij 2018 ob 20:25:43 CEST je Maxime Ripard napisa=
l(a):
> > On Thu, Jun 28, 2018 at 06:48:50AM +0200, Jernej =C5=A0krabec wrote:
> > > Dne =C4=8Detrtek, 28. junij 2018 ob 04:06:52 CEST je Chen-Yu Tsai nap=
isal(a):
> > > > On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec
> > > > <jernej.skrabec@siol.net>
> > >=20
> > > wrote:
> > > > > Current "old" method to find engine worked pretty well for DE2.
> > > > > However,
> > > > > it doesn't work when TCON TOP is between  mixer (engine) and TCON.
> > > > > TCON
> > > > > TOP has multiple input ports, but current engine search algorithm
> > > > > expects only one.
> > > > >=20
> > > > > This can be fixed by first looking for output port id and selecti=
ng
> > > > > matching input by subtracting 1 for the next round. This work even
> > > > > if
> > > > > there is only one input and output.
> > > > >=20
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > ---
> > > > >=20
> > > > >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 22 ++++++++++++++++++----
> > > > >  1 file changed, 18 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index
> > > > > 08747fc3ee71..264bcc43da11
> > > > > 100644
> > > > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > > @@ -791,12 +791,14 @@ static int sun4i_tcon_init_regmap(struct
> > > > > device
> > > > > *dev,
> > > > >=20
> > > > >   */
> > > > > =20
> > > > >  static struct sunxi_engine *
> > > > >  sun4i_tcon_find_engine_traverse(struct sun4i_drv *drv,
> > > > >=20
> > > > > -                               struct device_node *node)
> > > > > +                               struct device_node *node,
> > > > > +                               u32 port_id)
> > > > >=20
> > > > >  {
> > > > > =20
> > > > >         struct device_node *port, *ep, *remote;
> > > > >         struct sunxi_engine *engine =3D ERR_PTR(-EINVAL);
> > > > >=20
> > > > > +       u32 reg =3D 0;
> > > > >=20
> > > > > -       port =3D of_graph_get_port_by_id(node, 0);
> > > > > +       port =3D of_graph_get_port_by_id(node, port_id);
> > > > >=20
> > > > >         if (!port)
> > > > >        =20
> > > > >                 return ERR_PTR(-EINVAL);
> > > > >=20
> > > > > @@ -826,8 +828,20 @@ sun4i_tcon_find_engine_traverse(struct
> > > > > sun4i_drv
> > > > > *drv,
> > > > >=20
> > > > >                 if (remote =3D=3D engine->node)
> > > > >                =20
> > > > >                         goto out_put_remote;
> > > > >=20
> > > > > +       /*
> > > > > +        * According to device tree binding input ports have even=
 id
> > > > > +        * number and output ports have odd id. Since component w=
ith
> > > > > +        * more than one input and one output (TCON TOP) exits,
> > > > > correct
> > > > > +        * remote input id has to be calculated by subtracting 1
> > > > > from
> > > > > +        * remote output id. If this for some reason can't be don=
e,
> > > > > 0
> > > > > +        * is used as input port id.
> > > > > +        */
> > > >=20
> > > > You need to call
> > > >=20
> > > >     of_node_put(port);
> > > >=20
> > > > to drop the reference to the original port.
> > >=20
> > > Thanks for noticing it. I guess I should send fix patch, since patches
> > > from
> > > drm-misc-next can't be dropped.
> >=20
> > Yeah, please send additional patches for all the issues pointed out by
> > Chen-Yu.
>=20
> Of course. I hope this can be resolved till the end of the next week. Aft=
er
> that, I will be away from PC for 2 weeks. Feel free to drop DT patches if
> you think that it will come too close to merge window.

Actually, can you drop it anyway? It needs a lot of changes and keeping HDM=
I=20
working would need some effort.

Best regards,
Jernej




