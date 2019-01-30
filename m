Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6FFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4917220882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDM2v5pM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfA3Mqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:46:47 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40426 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3Mqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:46:47 -0500
Received: by mail-io1-f68.google.com with SMTP id k2so19250917iog.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 04:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzr4ARbu1TjAJHS3g9jhoTSUIRon+Ua3EZgbCU4NmpM=;
        b=GDM2v5pMEse2iQm6bSsuV5UVIP0VjgRMA6ramkeol82YtrVdtd4Par+3h+hCvbrVzw
         1DV4uxTgUAzZZ2tuMzI/B673fLbs6mWkA5r0byaLmHwtMOgqty7/s/X5Wi/2YPH054i1
         QcbixkX+aEwWjAcSoRHbDhAdr7fON+Ld2lf3Zq0CGQRWC8WCBJVQHv2+yGuQJ7LLogZ5
         xAArSfC1hJwEf6cQ/JlbEWT519L2w7kmn0N36Stmo0Oe8c6vVnyGRTL73UMLYH5hkOVM
         fMJXkIYEWkS4ajs6VF+fmLVeW4cypQjXQHAfke1yKJOX5i5yEaho2RD3tcc6mT5truDw
         gFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzr4ARbu1TjAJHS3g9jhoTSUIRon+Ua3EZgbCU4NmpM=;
        b=qWN+Vl3Qc7ezy49H74Mtv78MMkV28irTC/XmjthUyAz6yryByNtuq+pzzTq01+r+yj
         5N97TrOOkZAgWSPxDelVrZXax2hKxfBQxnwjBMqLBPDivhbRUu2CzARB4i33O3i/lUEg
         KVup8hNUgsrIvi4yP1KfaX11RsLJS4kr2uYhuBTQoWHv4EmuCNE7K4YHiB1oFtbWA0FO
         OaSgq5B4h52y+d7Av1zKwEUde/iWJytRODijxPaGgy7qCgcn02EsSZk4CRhGuzXd4OV7
         wmFpq/XN5G+2iyBjDVU1puU4ljec60WBkIpFCWTSiTA75I7PWSMCRk/fHtnr4hr77tqd
         HGYw==
X-Gm-Message-State: AHQUAub5m9X1VA5/ugY1I6F1uHDZ+/7DwV4sP6bQq/2wKK59V7dRga1d
        WF4upRquWWKplKQ4Dz8ejgq559/RUrLIjDmsh4M=
X-Google-Smtp-Source: AHgI3Ia2MHeEdqbgKMaIi6axve2Mh8Pu5dfNmgDGM7u3sNA0XqCauHSh9mPjAGD8nYLdiGMG0WWXfiFcrcnOlM0EIdE=
X-Received: by 2002:a5e:8517:: with SMTP id i23mr15184935ioj.28.1548852406261;
 Wed, 30 Jan 2019 04:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20190130095749.8952-1-daniel.baluta@nxp.com>
In-Reply-To: <20190130095749.8952-1-daniel.baluta@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 30 Jan 2019 20:46:35 +0800
Message-ID: <CAA+hA=Tz0p8Ea9f8wuqUZFkmuDrqMHj8_4sLvT8wi6qrTnaVKQ@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: imx: Add support to start/stop a CPU
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 5:59 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> This is done via RPC call to SCU.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Changes since v1:
>         - remove unused variable ret
>         - add documentation for imx_sc_pm_cpu_start function
>
>  drivers/firmware/imx/misc.c           | 38 +++++++++++++++++++++++++++
>  include/linux/firmware/imx/svc/misc.h |  3 +++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
> index 97f5424dbac9..f511d6f624fd 100644
> --- a/drivers/firmware/imx/misc.c
> +++ b/drivers/firmware/imx/misc.c
> @@ -18,6 +18,14 @@ struct imx_sc_msg_req_misc_set_ctrl {
>         u16 resource;
>  } __packed;
>
> +struct imx_sc_msg_req_cpu_start {
> +       struct imx_sc_rpc_msg hdr;
> +       u32 address_hi;
> +       u32 address_lo;
> +       u16 resource;
> +       u8 enable;
> +} __packed;
> +
>  struct imx_sc_msg_req_misc_get_ctrl {
>         struct imx_sc_rpc_msg hdr;
>         u32 ctrl;
> @@ -97,3 +105,33 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
>         return 0;
>  }
>  EXPORT_SYMBOL(imx_sc_misc_get_control);
> +
> +/*
> + * This function starts/stops a CPU identified by @resource
> + *
> + * @param[in]     ipc         IPC handle
> + * @param[in]     resource    resource the control is associated with
> + * @param[in]     enable      true for start, false for stop
> + * @param[out]    address     initial instruction address to be executed
> + *
> + * @return Returns 0 for success and < 0 for errors.
> + */
> +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> +                       bool enable, u64 address)
> +{
> +       struct imx_sc_msg_req_cpu_start msg;
> +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +
> +       hdr->ver = IMX_SC_RPC_VERSION;
> +       hdr->svc = (uint8_t)IMX_SC_RPC_SVC_PM;
> +       hdr->func = (uint8_t)IMX_SC_PM_FUNC_CPU_START;

pls drop the unneccesary unit8_t

> +       hdr->size = 4;
> +
> +       msg.address_hi = address >> 32;
> +       msg.address_lo = address;
> +       msg.resource = resource;
> +       msg.enable = enable;
> +
> +       return imx_scu_call_rpc(ipc, &msg, false);

s/false/true

> +}
> +EXPORT_SYMBOL(imx_sc_pm_cpu_start);
> diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware/imx/svc/misc.h
> index e21c49aba92f..c03bf2a23add 100644
> --- a/include/linux/firmware/imx/svc/misc.h
> +++ b/include/linux/firmware/imx/svc/misc.h
> @@ -52,4 +52,7 @@ int imx_sc_misc_set_control(struct imx_sc_ipc *ipc, u32 resource,
>  int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
>                             u8 ctrl, u32 *val);
>
> +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> +                       bool enable, u64 address);

Nitpick: phy_addr

Otherwise, looks good to me.

Regards
Dong Aisheng

> +
>  #endif /* _SC_MISC_API_H */
> --
> 2.17.1
>
