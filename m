Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F0A2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZMfDXVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfBZNij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:38:39 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43575 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfBZNij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:38:39 -0500
Received: by mail-oi1-f193.google.com with SMTP id i8so10308389oib.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 05:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utLRdCBRFM4gyIdZWj/RwZKM2SuYji0tmszj9nFdaK0=;
        b=nZMfDXVM7ZPj1TnJgzQHhTTdw477ESkFFuIApQ1DuXEoRopaGzbiA50AiTUElxQ4yE
         erAV9m4iJeoP282obpeIbNeowhP9yNkzKp02/OzYFfAU/l1HGZtuGEs50zOOaKaGXWXy
         QgUz6lYeSGdj7NhTKGLs/i+vqxzZoqC+lBowlyepJV38C5FyyaSlaE9LxwQfXMKitLro
         9c345lYaEO1ysVhdE1CWV+IibX95Ybl6IBNQ3dxjJdkF243ShulStMCF7sKQJ53tWTLZ
         AARCshOAC1t1kcFXsZCvoUHXuWK4e4NiDqHRb2+Q6iIhbsu8NIsSSL89z7u7I7y+1dDl
         TDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utLRdCBRFM4gyIdZWj/RwZKM2SuYji0tmszj9nFdaK0=;
        b=fXCwigFsW2yJQa6l1VRQ9da+rxISMddBqaVBbIQ1rGvYXE4LFtCvUdpkRwP8RwvYVV
         /K0BvPQCjFPwO+cwyOAlr15jMsgPBMHdBfk0xH5uVdmol/2BA6l3uuMWKeb3meaOmAUK
         kIUIptHlE06sLR2DYnF/fum80RG16PPr+224NVmfG/qF49nJIHg1Pb9VGcnwLizH5pMx
         qz86Sg21QWemjiuxkpPFTGTqKbM7a+B7P/B6QsZTaYld5oiuXpwC67XmQ2swJ7matGvG
         ghtZeOhYr8ekYdetnle5jccTF1KdNTP+KOzRByNWLTeffR+lpf9MJezbHfA11+PNN+L4
         IUGg==
X-Gm-Message-State: AHQUAuYfm7y0QJpmyU4Ynr9E05ZuN8LFEV740ZPzhXQIIzsamc+WGcwJ
        ZRticK0SeBuXl4YZA7ZkxpcDFMpYzV2bVlLr6sw=
X-Google-Smtp-Source: AHgI3IYqjATxXn47G5zBKU1PtC+fMUzXmPUE5eweUwBJTuGMzill9BQEMGdTYYcleWPlAn8vSVKh9QtH2yA4e/+NCOo=
X-Received: by 2002:aca:aac7:: with SMTP id t190mr2222649oie.43.1551188318562;
 Tue, 26 Feb 2019 05:38:38 -0800 (PST)
MIME-Version: 1.0
References: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com> <CAOMZO5AmRAhxSw2KB-LBY68a+DvVSKPQ1ecAf_YPhQhBAdJ1UQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AmRAhxSw2KB-LBY68a+DvVSKPQ1ecAf_YPhQhBAdJ1UQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Feb 2019 10:38:28 -0300
Message-ID: <CAOMZO5AC+Zna4oYTk7Er-2SpbQayhmeyrbhpZM-wFfO6axcFVQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Spencer <spencercw@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:37 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 7:53 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> > +       magic = readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
> > +       if (magic == IMX8MQ_SW_MAGIC_B1)
> > +               rev = REV_B1;
>
> Don't you mean rev == REV_B1; ?

Ops, was looking at the wrong line, sorry :-)
