Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596C2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C07A2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMMRqSk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfBZNha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:37:30 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39227 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZNha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:37:30 -0500
Received: by mail-oi1-f195.google.com with SMTP id b4so10313061oif.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 05:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSjDv4hcZl88gGGx2mHdRSPb6viE4KjMCMgatmCI9xE=;
        b=fMMRqSk/AjRdW1IzGTCaSeXiaEvT/z+oxDIeEb3SWbtdlVQvXoFHQYqLGPyRD2VI5B
         eqxgTkngbFipQJkrmsIfvink6ss6TS1jCWVd/V9abbs13mqFd4aL/uwfwEoQLu9vf/RI
         W/dMCI6Ud1A3wygCFvy6vwW+bld0nPjZxHv+68lyMCTszsdw5pTZ+7lSkDFTN18DBMOK
         DpTtRLbVPg46FBpKyYWOAXWZZXUmE4zR/ECoB7lcOwSwap/9qe/Ps/BpU1Rf4oHdIXQu
         XDzbKzlzYvqW5dEwwRpo7pxZhiEo54cU+imxUSfLg8OX/Pe0nNcgr8yQEZ2i84O//rlX
         yDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSjDv4hcZl88gGGx2mHdRSPb6viE4KjMCMgatmCI9xE=;
        b=BoJjLViUGGy1X/IrtTwaWSGmZ4MbXlcgy6LhGDz9EQiwUmkSgJLkexyxrNuZNepmjt
         WCOgBrfMCcFPOk/D5N3mXDCoC8GrrQXf9dLe8tVL7Yuh14blNCpudMcHayAleGlKEekt
         Rsxx5FGeO50VQldI3Vq6T8nSIUQ1aSPxTvAOhGa7ygI89OS/AoxWfyfgKZSZmh5ic2UI
         c+qC0KMWCcXWCV7qwotylPIzQ9ql2V+SNEgV5u4pQ/tHVFt8GS5y2xgPz9fwsF5Kk9cL
         RZyu17vlFEJcCn0BMVc72gkwtHHJhKpvEQGzsrqS7/VmPyouu9S3EiOc6/DHlncp7Gha
         gg/Q==
X-Gm-Message-State: AHQUAubGrPGXmiFG7OyxYrAbijInlRKNvPVtNcAxEk254NibwywNKcVs
        2ISgpZ7A/NtGDf5C7/Kg1InYTZ5WFYXyjX14z+I=
X-Google-Smtp-Source: AHgI3IYZtWhaAPcNNlBKLwWqNkgeh9ehmNzwojlKcMhTQUqGGLRV+capIRPFlglTeXPXaG8JDpsQ+7gP49Ng0axhOps=
X-Received: by 2002:aca:b5c1:: with SMTP id e184mr2359488oif.75.1551188249238;
 Tue, 26 Feb 2019 05:37:29 -0800 (PST)
MIME-Version: 1.0
References: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Feb 2019 10:37:18 -0300
Message-ID: <CAOMZO5AmRAhxSw2KB-LBY68a+DvVSKPQ1ecAf_YPhQhBAdJ1UQ@mail.gmail.com>
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

On Tue, Feb 26, 2019 at 7:53 AM Abel Vesa <abel.vesa@nxp.com> wrote:

> +       magic = readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
> +       if (magic == IMX8MQ_SW_MAGIC_B1)
> +               rev = REV_B1;

Don't you mean rev == REV_B1; ?
