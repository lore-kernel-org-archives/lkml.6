Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D8538C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E11A20660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mce+LpMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E11A20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754350AbeFLSco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:32:44 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37033 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753455AbeFLScn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:32:43 -0400
Received: by mail-ot0-f194.google.com with SMTP id 101-v6so29246461oth.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q8SH/QULBlEc4bPFxR4Odt4vlZslWhj+cWAQ0hbXaSI=;
        b=mce+LpMk8LjgDPNiyBb+Fuf6cNhSEyUFOYGfumZZLy7dNdqj6IfLpliazvq2wIk2lz
         OiqDbgY2dKnoTAM6kKlVRsekSwu2YqP/b0+7PvHgIy8StzX0izrZrme889eCvegb5y+N
         Ow8KeFwVj1yZ1Gp85tGqAU3v7l6pwecePiaRBYC377LPDrtlmnX0+AVSgK3tfVXN82vL
         8yVpzAjwY7aZ+ZDkh5lPPdGIBXmuDjvpMBRJ5nDT2uf0CXKHSyFTsieVJ/7OGgd7R1Q1
         WcDzYMNS4oY1V7n7vG5GWiBItO/6pcv5zxA6QNQvGk68+tQDGlb/1GPCDpxH3dVjuTux
         xNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q8SH/QULBlEc4bPFxR4Odt4vlZslWhj+cWAQ0hbXaSI=;
        b=WzcpBSmUSxJ7vu/gscJ3yt799R7MMMoUyYgKig44Nweu/ZcFohgcTWUYJVeiE/EN/t
         Djuc36wBZ36O32LJoyQM8GmyZ0b5HkpUxeAzEM8X3uQ2+tBq4KQ2Gdbe7anEPZ18FIxI
         6/c1wYnWgxXU6BSOv1SS1T/F61QyIjRcvXk73AuhRkNa0/2RTWdJOQwmsP9PbEfl0Pvk
         tk2BOQn36/vZL80SbORhjTkLAWNsjd21WNgEfuWkPfwpeyn/JtXj3b//B375biGE66Z6
         qjhzStvFXX/s1eqYcm2HRuyA8WTi9/wdUiY4sYi1vGgH0TF5HRuuks/0rzpQcPY3U3Vp
         XAfw==
X-Gm-Message-State: APt69E2gZ8C6a+j3xEHhfJweFEt8V6yTqvambR+rc8wjDpVM0KPeOS0N
        lGbRd8N+uydfUrx5ETb6F/ylGzBfVnFCxeBC1CY=
X-Google-Smtp-Source: ADUXVKKLiumlynO3UEbDdsXVCP+jqRW66vBtY8jGFzD8s8AfpAchZbab0px6EeTOdBUS4Z+EtTn7vYGZTCHqiXinX+Y=
X-Received: by 2002:a9d:62d3:: with SMTP id z19-v6mr975422otk.159.1528828362469;
 Tue, 12 Jun 2018 11:32:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 11:32:42
 -0700 (PDT)
In-Reply-To: <1528828122-9276-1-git-send-email-leoyang.li@nxp.com>
References: <1528828122-9276-1-git-send-email-leoyang.li@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Jun 2018 15:32:42 -0300
Message-ID: <CAOMZO5C0pk-27ztxeJSENBN_-i9o+2sCoS9Cc75Q_Y=-_z_dQg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: freescale: Update to use SPDX identifiers
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

On Tue, Jun 12, 2018 at 3:28 PM, Li Yang <leoyang.li@nxp.com> wrote:

> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> index 7286b1e..f90c040 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> @@ -1,45 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Here you use GPL-2.0+

>  /*
>   * Device Tree file for Freescale LS1012A Freedom Board.
>   *
>   * Copyright 2016 Freescale Semiconductor, Inc.
>   *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPLv2 or the X11 license, at your option. Note that this dual

,but the original text says  GPL-2.0, not  GPL-2.0+, so there is a mismatch.
