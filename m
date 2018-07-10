Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96802C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B72E208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiglrBJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B72E208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbeGJTmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:42:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34082 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732595AbeGJTme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:42:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id s13-v6so13433419wmc.1;
        Tue, 10 Jul 2018 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r74C6DrzYAjJzl7k8cVl3O0+7LMpzzK/Ev1VdHWQPVU=;
        b=EiglrBJDjEbA0mOGf8/WsX2MSvxcuho+xo5uXAdRgwzGiWYsPAHPyHFL+fFDnGVJbz
         kndip55JRJzBJpwRxbnvC/vT1bj1D+VVf/kUcmLdjjWfitWttmvqM+TvdV1P/gPrBDPu
         eMJcERQ6OFV2xmzgY6qWTUTC4KrOJc6oPG+83jY7N9CCPoBMwfNK34ijAcagljYFiEWh
         nOkvsaFqIqzsk58drecQK1d2xZRbURjJui/N23WqXJtNPX4wDFmv1xsUEv0UfDwxbaek
         BtKoSXbUtUrXCX10COn3IXOUeKzXG681A/795bbUUx10ZNZQHXZL0FZ8saPTzUAQd5Jn
         HzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r74C6DrzYAjJzl7k8cVl3O0+7LMpzzK/Ev1VdHWQPVU=;
        b=N1v3V6UbEadQPzZ1nhQmxesBtRE/OUYgKzd4g8PkKu4rmzD1v+qkcmm39EGRP/ocuK
         BYBqiye0OG3IsERHyJPv90C1/9K4KeqdtLsPBGHVEFVvhi07j3oZbzqZy+aJfPoG9drv
         vJL97v9HWsrZ79uIoLE6ekmRlQ0D0Us90MPQrH+YA+cdH3A3SGlpUpptH1A+PT1eBEVv
         TcYBWEx4s93QsssXscZ2tWDMkQOKUvrbTGDRF9WRXS88fi3RtGkqK+aeu6I0ODDnnhDM
         /fGZjBM5Wq/VpDNPYTgcOiNHEhtw9QQk+tC67Tf9kK6bm8My/b+04Fkqbg/F3IJ63g4R
         hUeQ==
X-Gm-Message-State: APt69E1IF7mARAF5LK2GnxwwtM7sSCV29xor9zTsh706c6QmzrVz2iu1
        bZ999Gtkp6CndTdI8xDJGO4=
X-Google-Smtp-Source: AAOMgpdjf7TWb7fiyCTZ7G9zMsRLbfI7HyhOd0A8Sls75K/z6cZ3g5C+Mvp5ymCeAhsMXgKJlcmJTQ==
X-Received: by 2002:a1c:8a04:: with SMTP id m4-v6mr15115291wmd.137.1531251721461;
        Tue, 10 Jul 2018 12:42:01 -0700 (PDT)
Received: from jernej-laptop.localnet ([194.152.15.144])
        by smtp.gmail.com with ESMTPSA id 185-v6sm260114wmw.23.2018.07.10.12.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 12:42:00 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-sunxi] Re: [PATCH 16/17] drm/sun4i: tcon-top: Remove mux configuration at probe time
Date:   Tue, 10 Jul 2018 21:41:58 +0200
Message-ID: <1819290.nadSthU6Yv@jernej-laptop>
In-Reply-To: <1843348.gnui32CGBV@jernej-laptop>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <CAGb2v64rjUnwnXbWxTSYJyhMyCV5QmV9YSr+Jryx3nEeMP8GJg@mail.gmail.com> <1843348.gnui32CGBV@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 10. julij 2018 ob 18:18:43 CEST je Jernej =C5=A0krabec napisal(a=
):
> Dne torek, 10. julij 2018 ob 18:09:26 CEST je Chen-Yu Tsai napisal(a):
> > On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net>
>=20
> wrote:
> > > Now that R40 TCON migrated to runtime mux configuration, old code can=
 be
> > > removed.
> > >=20
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >=20
> > >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 81 +++---------------------=
=2D-
> > >  1 file changed, 7 insertions(+), 74 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c index
> > > c09b15b64192..78795d6cb174
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > @@ -87,34 +87,6 @@ int sun8i_tcon_top_de_config(struct device *dev, i=
nt
> > > mixer, int tcon)>
> > >=20
> > >  }
> > >  EXPORT_SYMBOL(sun8i_tcon_top_de_config);
> > >=20
> > > -static int sun8i_tcon_top_get_connected_ep_id(struct device_node *no=
de,
> > > -                                             int port_id)
> > > -{
> > > -       struct device_node *ep, *remote, *port;
> > > -       struct of_endpoint endpoint;
> > > -
> > > -       port =3D of_graph_get_port_by_id(node, port_id);
> > > -       if (!port)
> > > -               return -ENOENT;
> > > -
> > > -       for_each_available_child_of_node(port, ep) {
> > > -               remote =3D of_graph_get_remote_port_parent(ep);
> > > -               if (!remote)
> > > -                       continue;
> > > -
> > > -               if (of_device_is_available(remote)) {
> > > -                       of_graph_parse_endpoint(ep, &endpoint);
> > > -
> > > -                       of_node_put(remote);
> > > -
> > > -                       return endpoint.id;
> > > -               }
> > > -
> > > -               of_node_put(remote);
> > > -       }
> > > -
> > > -       return -ENOENT;
> > > -}
> > >=20
> > >  static struct clk_hw *sun8i_tcon_top_register_gate(struct device *de=
v,
> > > =20
> > >                                                    const char *parent,
> > >=20
> > > @@ -149,11 +121,9 @@ static int sun8i_tcon_top_bind(struct device *de=
v,
> > > struct device *master,>
> > >=20
> > >         struct platform_device *pdev =3D to_platform_device(dev);
> > >         struct clk_hw_onecell_data *clk_data;
> > >         struct sun8i_tcon_top *tcon_top;
> > >=20
> > > -       bool mixer0_unused =3D false;
> > >=20
> > >         struct resource *res;
> > >         void __iomem *regs;
> > >=20
> > > -       int ret, i, id;
> > > -       u32 val;
> > > +       int ret, i;
> > >=20
> > >         tcon_top =3D devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
> > >         if (!tcon_top)
> > >=20
> > > @@ -198,49 +168,12 @@ static int sun8i_tcon_top_bind(struct device *d=
ev,
> > > struct device *master,>
> > >=20
> > >                 goto err_assert_reset;
> > >        =20
> > >         }
> > >=20
> > > -       val =3D 0;
> > > -
> > > -       /* check if HDMI mux output is connected */
> > > -       if (sun8i_tcon_top_get_connected_ep_id(dev->of_node, 5) >=3D =
0) {
> > > -               /* find HDMI input endpoint id, if it is connected at
> > > all*/
> > > -               id =3D sun8i_tcon_top_get_connected_ep_id(dev->of_nod=
e,
> > > 4);
> > > -               if (id >=3D 0)
> > > -                       val =3D FIELD_PREP(TCON_TOP_HDMI_SRC_MSK, id =
+ 1);
> > > -               else
> > > -                       DRM_DEBUG_DRIVER("TCON TOP HDMI input is not
> > > connected\n"); -       } else {
> > > -               DRM_DEBUG_DRIVER("TCON TOP HDMI output is not
> > > connected\n"); -       }
> > > -
> > > -       writel(val, regs + TCON_TOP_GATE_SRC_REG);
> > > -
> > > -       val =3D 0;
> > > -
> > > -       /* process mixer0 mux output */
> > > -       id =3D sun8i_tcon_top_get_connected_ep_id(dev->of_node, 1);
> > > -       if (id >=3D 0) {
> > > -               val =3D FIELD_PREP(TCON_TOP_PORT_DE0_MSK, id);
> > > -       } else {
> > > -               DRM_DEBUG_DRIVER("TCON TOP mixer0 output is not
> > > connected\n"); -               mixer0_unused =3D true;
> > > -       }
> > > -
> > > -       /* process mixer1 mux output */
> > > -       id =3D sun8i_tcon_top_get_connected_ep_id(dev->of_node, 3);
> > > -       if (id >=3D 0) {
> > > -               val |=3D FIELD_PREP(TCON_TOP_PORT_DE1_MSK, id);
> > > -
> > > -               /*
> > > -                * mixer0 mux has priority over mixer1 mux. We have to
> > > -                * make sure mixer0 doesn't overtake TCON from mixer1.
> > > -                */
> > > -               if (mixer0_unused && id =3D=3D 0)
> > > -                       val |=3D FIELD_PREP(TCON_TOP_PORT_DE0_MSK, 1);
> > > -       } else {
> > > -               DRM_DEBUG_DRIVER("TCON TOP mixer1 output is not
> > > connected\n"); -       }
> > > -
> > > -       writel(val, regs + TCON_TOP_PORT_SEL_REG);
> > > +       /*
> > > +        * Default register values might have some reserved bits set,
> > > which
> > > +        * prevents TCON TOP from working properly. Set them to 0 her=
e.
> > > +        */
> > > +       writel(0, regs + TCON_TOP_GATE_SRC_REG);
> > > +       writel(0, regs + TCON_TOP_PORT_SEL_REG);
> >=20
> > Would it make sense to just force a reset using the reset control?
>=20
> I wrote TCON TOP driver for H6 at first. For some reason, some registers =
had
> reserved bits set after reset line was released. TCON TOP was not used in
> U- Boot, so I guess this counts as full reset.
>=20
> I never tried to find out how it behaves on R40 because setting those
> registers to 0 seems like simple, good enough solution, which works
> everywhere.

It seems those bits are not needed for R40. I'll leave them out for now. TC=
ON=20
TOP will need some adjustments for H6 anyway and I'll take a look at that=20
then.
=20
Best regards,
Jernej




