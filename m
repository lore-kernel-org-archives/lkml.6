Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121DAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75A92184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLtu5x/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbfA3NPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:15:01 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36112 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfA3NPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:15:00 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so10401741itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgzAwcx6EQsoHlyeUDoxuVDHqlcmqfsXDDq/w/zZLcY=;
        b=ZLtu5x/S8WrKKVcmvOZoyW5QDvWRhk8cKMcPn1DgZ1CVJgv3iharZny+Y0iXjogF4R
         XMibHYjaYAqBYrwfR72H53U8MxRS5oksiC0tt0A+L1M+1yZm8GxZbuIF4tj8ppgX2OVL
         xEq/mdnkNxGy9T0pVc9E+kQKD8zqj3AisG5WhNbkJ6WXdddlD7F4T+pLB1MztGSsz1Cd
         M0jMQGTl1/0AAYAp83WUJo8wsPqmg/FHrBenUOn6J12Y22e1ZGAcjMvf0/t2BVxCuj8t
         v3hV7q4xoRP+daYVi8OYbbAH0YYHAuWal31YqjcW3SgJhFpbAiQ3raz/m4MMx/SYr1jZ
         SRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgzAwcx6EQsoHlyeUDoxuVDHqlcmqfsXDDq/w/zZLcY=;
        b=oee9fU57xRlntgCBgwiwYhdi3ShvRoeSey4t8MOpI+yR6bYdZzVET62jPSFPop1ZBZ
         vB0GWuOmFTefLWbcFQygGptF4KNUu7eboUF0QrhmTeM6GhwIejK08rbwxjdAmZMwSMK9
         tCL89HJzLQnqGJ7HmiTFwNnCtSVPcA7o7JlJn/pr8H35gPJq8jg41VRb6nSSniVSPC+u
         yT66DCaODhbpbi8phOyy1pgud4I9nuLBOCYYD1cBmBHrnRNaG8HyzjQrANKlSEZVwYX0
         sTRSn0WVtVzgdOpKXkIu1V6ct+wPoBmt0PmM2MD/MfBeA5hQCGLJTqo2ud6Qzu6/iFtH
         VUVg==
X-Gm-Message-State: AJcUukfxze5w6cQEyZXCA61EeAbQVm16JDDBGE9+1bMO4cGwA+pSAQLH
        px/2ryGIQyaX2Tq+Aa/BiM7DPymXUaBEfZzk/wzRJA==
X-Google-Smtp-Source: ALg8bN76qLfDM0655iUIMslnzVmQhQaUEi+YVujV9iv6ygUA8/4Ky+4ZmKXQpds0CaNv3jk42dXfV3AWLVSJWSl0s7Y=
X-Received: by 2002:a24:65c8:: with SMTP id u191mr16186348itb.7.1548854099929;
 Wed, 30 Jan 2019 05:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20190130095749.8952-1-daniel.baluta@nxp.com> <CAA+hA=Tz0p8Ea9f8wuqUZFkmuDrqMHj8_4sLvT8wi6qrTnaVKQ@mail.gmail.com>
 <fc0ef2f1709cb678f29cd37d618e28a7ed606791.camel@nxp.com>
In-Reply-To: <fc0ef2f1709cb678f29cd37d618e28a7ed606791.camel@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 30 Jan 2019 21:14:48 +0800
Message-ID: <CAA+hA=Ra8aV3FQrxrM68hx99X-fqw5+GH1Qv-AtaSzCX-hng7w@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: imx: Add support to start/stop a CPU
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 9:12 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> Thanks Aisheng for the comments!
>
> <snip>
>
> +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > > +                       bool enable, u64 address)
> > > +{
> > > +       struct imx_sc_msg_req_cpu_start msg;
> > > +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> > > +
> > > +       hdr->ver = IMX_SC_RPC_VERSION;
> > > +       hdr->svc = (uint8_t)IMX_SC_RPC_SVC_PM;
> > > +       hdr->func = (uint8_t)IMX_SC_PM_FUNC_CPU_START;
> >
> > pls drop the unneccesary unit8_t
>
> Ok, I can do that. I had borrowed it from the already existing
> functions imx_sc_misc_get_control / imx_sc_misc_set_control
>

Yes, i know, we need remove them later to avoid confusing.

Regards
Dong Aisheng

> >
> > > +       hdr->size = 4;
> > > +
> > > +       msg.address_hi = address >> 32;
> > > +       msg.address_lo = address;
> > > +       msg.resource = resource;
> > > +       msg.enable = enable;
> > > +
> > > +       return imx_scu_call_rpc(ipc, &msg, false);
> >
> > s/false/true
>
> Nice catch!
>
> Inded, the old API had a different semantic for this parameter.
> >
> > > +}
> > > +EXPORT_SYMBOL(imx_sc_pm_cpu_start);
> > > diff --git a/include/linux/firmware/imx/svc/misc.h
> > > b/include/linux/firmware/imx/svc/misc.h
> > > index e21c49aba92f..c03bf2a23add 100644
> > > --- a/include/linux/firmware/imx/svc/misc.h
> > > +++ b/include/linux/firmware/imx/svc/misc.h
> > > @@ -52,4 +52,7 @@ int imx_sc_misc_set_control(struct imx_sc_ipc
> > > *ipc, u32 resource,
> > >  int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
> > >                             u8 ctrl, u32 *val);
> > >
> > > +int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > > +                       bool enable, u64 address);
> >
> > Nitpick: phy_addr
>
> Ok, will fix.
>
>
