Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE262C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7632080A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe/Fv5+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfBDTSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:18:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40815 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:18:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so883771edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 11:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pz91TlzcgTM6YlfZuR56aYR0lcb+9noOvl7XcVJxug8=;
        b=Oe/Fv5+cS9A+/oX6dpP1dkpas5de1KCgVGT3H3dN47CxWulxsnZKOt6FTc4e445W4Z
         1PiYe0o30sir0N9AJMcZWAC/J/8SK1XX+6xcXaSbYQ8mrfC4mKH5VqsXX08P3pHq57nK
         nfw242gY09p8eeYHiMrKE6nZtW5pgvCJwBU1i+smsHwQ5DmribkoZSEmPmuOymTX5Tna
         CNzkrpLba85rQtB3vd8MN+yji9RLjOselCqLDxUUec+xYl6UA0edDy6OpANGAsAoIoXI
         htN8aFragFL1uSommREjg25t1bl2E5PfGpt92AvZfoOFrD1jJu3UTVO9Nvq5j97FZPyT
         w4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pz91TlzcgTM6YlfZuR56aYR0lcb+9noOvl7XcVJxug8=;
        b=dPEJcpO7JnL99ZGz2+Zc7eeDZbxiqHRZwFdxLUucc+gpYloHtpOFST5ztJtTazUUQN
         8j7nKsKUy0zjRmEHqdrDQByOVlwNbEua0B3cYdy4IqJB1lkRlEt4O8EqYPRg9TtEbwKX
         QDBkcGCi5qTzecDpX+M6ya8d9F6q9fVGl4l0oxnh7ZLx0xmOm4iTwDuNxWhbZoG+Zg2K
         H3U4o283KuyiVrNLjn9kwfWY0+2JlvrlWftKlakzBBt7HhgjEN0R2qScAXbXw/8EXUVe
         cjBKSc3MfcYWiuuK6mI2mOZfcQmd/BTh9+o6hNlvzpZSJm80hC5XWKWh5r1MNS1JCuXB
         LnYQ==
X-Gm-Message-State: AHQUAuaMqP4Gd5CbKre3Dl+vIFEwQztaWbmJHVsqMCkGj7gwZFhAT/80
        ezivqiNzIzH+xn1W/qCOI+3PjIRPFHrgtGEOSJI=
X-Google-Smtp-Source: AHgI3IYsN7jLkmy+DEfRgWIsyOU945j/GyCjycGsRqtml3B++HTCoyWqxlI5Ej1TEmWMAoC/4X2yG2oC+7UfGIzJKOs=
X-Received: by 2002:a50:b356:: with SMTP id r22mr772379edd.164.1549307926462;
 Mon, 04 Feb 2019 11:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20190130133005.5732-1-daniel.baluta@nxp.com> <AM0PR04MB4211CBB9D46FC6EDB9DA9F1680910@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211CBB9D46FC6EDB9DA9F1680910@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 4 Feb 2019 21:18:35 +0200
Message-ID: <CAEnQRZDjN7z1nC8RSqaQXayz3rfBw6PGC69Knc4izGw62FnDGw@mail.gmail.com>
Subject: Re: [PATCH v3] firmware: imx: Add support to start/stop a CPU
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Care to have a look?

Daniel.

On Thu, Jan 31, 2019 at 10:16 AM Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Daniel Baluta
> > Sent: Wednesday, January 30, 2019 9:30 PM
> > To: shawnguo@kernel.org
> > Cc: s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > dl-linux-imx <linux-imx@nxp.com>; daniel.baluta@gmail.com; Aisheng Dong
> > <aisheng.dong@nxp.com>; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; S.j. Wang <shengjiu.wang@nxp.com>; Daniel
> > Baluta <daniel.baluta@nxp.com>
> > Subject: [PATCH v3] firmware: imx: Add support to start/stop a CPU
> >
> > This is done via RPC call to SCU.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
>
> Regards
> Dong Aisheng
>
> > ---
> > Changes since v2: (as per Aisheng's review)
> >       - rename address with phys_address
> >       - remove unnecessary uint8_t cast
> >       - use 'true' as last parameter of imx_scu_call_rpc to actually
> >       wait for a response from SCU.
> >
> >  drivers/firmware/imx/misc.c           | 38
> > +++++++++++++++++++++++++++
> >  include/linux/firmware/imx/svc/misc.h |  3 +++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c index
> > 97f5424dbac9..4b56a587dacd 100644
> > --- a/drivers/firmware/imx/misc.c
> > +++ b/drivers/firmware/imx/misc.c
> > @@ -18,6 +18,14 @@ struct imx_sc_msg_req_misc_set_ctrl {
> >       u16 resource;
> >  } __packed;
> >
> > +struct imx_sc_msg_req_cpu_start {
> > +     struct imx_sc_rpc_msg hdr;
> > +     u32 address_hi;
> > +     u32 address_lo;
> > +     u16 resource;
> > +     u8 enable;
> > +} __packed;
> > +
> >  struct imx_sc_msg_req_misc_get_ctrl {
> >       struct imx_sc_rpc_msg hdr;
> >       u32 ctrl;
> > @@ -97,3 +105,33 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc,
> > u32 resource,
> >       return 0;
> >  }
> >  EXPORT_SYMBOL(imx_sc_misc_get_control);
> > +
> > +/*
> > + * This function starts/stops a CPU identified by @resource
> > + *
> > + * @param[in]     ipc         IPC handle
> > + * @param[in]     resource    resource the control is associated with
> > + * @param[in]     enable      true for start, false for stop
> > + * @param[in]     phys_addr   initial instruction address to be executed
> > + *
> > + * @return Returns 0 for success and < 0 for errors.
> > + */
> > +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > +                     bool enable, u64 phys_addr)
> > +{
> > +     struct imx_sc_msg_req_cpu_start msg;
> > +     struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > +
> > +     hdr->ver = IMX_SC_RPC_VERSION;
> > +     hdr->svc = IMX_SC_RPC_SVC_PM;
> > +     hdr->func = IMX_SC_PM_FUNC_CPU_START;
> > +     hdr->size = 4;
> > +
> > +     msg.address_hi = phys_addr >> 32;
> > +     msg.address_lo = phys_addr;
> > +     msg.resource = resource;
> > +     msg.enable = enable;
> > +
> > +     return imx_scu_call_rpc(ipc, &msg, true); }
> > +EXPORT_SYMBOL(imx_sc_pm_cpu_start);
> > diff --git a/include/linux/firmware/imx/svc/misc.h
> > b/include/linux/firmware/imx/svc/misc.h
> > index e21c49aba92f..031dd4d3c766 100644
> > --- a/include/linux/firmware/imx/svc/misc.h
> > +++ b/include/linux/firmware/imx/svc/misc.h
> > @@ -52,4 +52,7 @@ int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32
> > resource,  int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
> >                           u8 ctrl, u32 *val);
> >
> > +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > +                     bool enable, u64 phys_addr);
> > +
> >  #endif /* _SC_MISC_API_H */
> > --
> > 2.17.1
>
