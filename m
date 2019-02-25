Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070C8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25C62087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciOIEzIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfBYH5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 02:57:35 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42918 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBYH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 02:57:35 -0500
Received: by mail-oi1-f196.google.com with SMTP id s16so6516973oih.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 23:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5AmyUQFwlZ5Bk+oW79CIwNgeC61rRf9hzgzMUkdTYLc=;
        b=ciOIEzIwYybzPrxqjbs3V0zfX9pNpNKVr6rsZiiZ0iW27iUEspgwSHHvPr1ZBORNrS
         /7kHxBL2SbX2XSjsjqlskyDXYTPLWCdWLQOwyvT3Y4U1wdz2ryGx/IuOZo2tJO78H1jD
         5hUoFJn/l+kcFjAq259eqaTAhQfrwLp0Ns/fpz3mpb36xFEAF3RQFswbi6UF3wacU/pD
         1vMDG4IvJNgw5wbhOF3QTgL2+QA6wyznQhE1zPfGbo31uRQB5WlPzMTVQSwD13vt0ny0
         iepM4ACuL9Ny7KtBb6jcH/h7nMtNxscBMMGmDKBd/cs4ZrAxT0IEGXebecPsEh8/PpWF
         /2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AmyUQFwlZ5Bk+oW79CIwNgeC61rRf9hzgzMUkdTYLc=;
        b=n1l5liqdaMT7xKzJsx9MsGQMZhwlC8bQH2jLKgQB6G+WKdit8oQUd4C/hH42AXFzlS
         Tk8qedlRNVypNm0UXvj91M5fMruUdabZ98tu2+UmHaKdS7ARZsZy9zAcxnwSVsguIC9C
         neIc8EAs4otT+RIK9xaOeGU++/kAaqtSSFx+TDwXDEAzCXY34R+PMFz8jf6OSmX20KYH
         iLJqTwejiiOdEhWAgkmDPdv7VU09g2S6XQGRSvkgaIkIEnUB3WcnWT5Zx3Sbl2x+wnWV
         2GyFtDGx1Rb+vUCHzX32c6wyrfAScj8oGROmlX2KQuBvlqeBGR6eFGwwpjvc7gGouYBV
         t/aA==
X-Gm-Message-State: AHQUAuZ8PwXL22W0wmXpn3mFou5ZsaSid0UOc4mgKkGjACAUBBDT3SE/
        XVHMmPNMOy0iN7TjhTOojn5+9gF1LE0QLPZtMJ3KiBL7yKE=
X-Google-Smtp-Source: AHgI3IYsSko6M20Yv5aIh7Uf1qpnrO9qFkrlQBnQRslILT68cRtZiwxkkuY1nZCfftv7BSiOg1kcVLgwN2n+zM70JBU=
X-Received: by 2002:aca:be83:: with SMTP id o125mr10680272oif.72.1551081454670;
 Sun, 24 Feb 2019 23:57:34 -0800 (PST)
MIME-Version: 1.0
References: <1549194583-7684-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1549194583-7684-1-git-send-email-abel.vesa@nxp.com>
From:   Chris Spencer <spencercw@gmail.com>
Date:   Mon, 25 Feb 2019 07:57:22 +0000
Message-ID: <CAGUNXRTY0yKnLH1hnxiv5ydnWG2VKNzpY_4rZ2yRhj8_Jq9rYQ@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: Add generic i.MX8 SoC driver
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
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

On Sun, 3 Feb 2019 at 11:50, Abel Vesa <abel.vesa@nxp.com> wrote:
> Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Tested-by: Chris Spencer <christopher.spencer@sea.co.uk>

My patch series which adds support for the i.MX8MQ to the CAAM driver
[1] needs the SoC driver, so it would be good to get this one in.

Thanks,
Chris

[1] https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg36947.html
