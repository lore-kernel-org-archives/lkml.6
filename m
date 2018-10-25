Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4ADC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F47320854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyoxVC3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F47320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeJZAa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:30:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40914 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZAa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:30:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id m15so8190566otl.7;
        Thu, 25 Oct 2018 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wc5oX/S3ce8uXzI4oURJHDp/j0pTK7GnwLfSlix9b1Y=;
        b=fyoxVC3Zarxxm5qogj8An/EpgkFJ17nlixIFqgc3rBtUKHkDfVBQNIZoqrqBN9GujU
         RDrnFGq3AIhfyRHnAibzuYkIwdDPx4ZtUT71YRzyVC5Lwuxq0x9d+Isq4LtzSp1oTw5W
         yfFUgWMvZyXrOv2p/4SOQSvxFde4yRkKRu9K2G4YS3Opqj0SPXc4a5bDKWg0gayBf62W
         gnBI4yhMFJT7qfknXtfx5nv3CbYgpuoHp/VkRzE5nQdMRUKYQUuPHb6pvM8QgiVrPQDa
         HbQK8f4yTaIhRFDp9PxtuNdgj5qg4fE14MoG+Ppq3KcWm0QfHoIhPaeJVNaJgYyBhmkU
         OwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wc5oX/S3ce8uXzI4oURJHDp/j0pTK7GnwLfSlix9b1Y=;
        b=b5gP2akQ5iQegFniw/abhdnAoU3Fw40mbDEDoLwTsdhcGU/YOY0DPRmFWrMC+xUF0H
         36kzTdUY4gbqcToLWqfLhiPhQJpnkJp8sSNgsYfHpFsNEq2jV5cGGSYPmjk2+0QV1oym
         dm1FPPp+lp6wXTSAixCzyLVotE1wEi1q2MaPmwTjWlafVenvtEKogA2tfVIu9svFH4RJ
         x+G9n+AasunGVDwHU5gaMqjDfmLq1C3Mn2cK7KtH206WWl5nQkg0v1MiF6NOJaLnpSK4
         rKWteEW3TpbyyJ8TOuVNfUbdwv+rC84MJQo0AylFJMw5xzRlBJW0b/jCcRvei7PG9ynO
         lngw==
X-Gm-Message-State: AGRZ1gK5QNk06H5puekjqui8tOVQ+i1dPyKR8R/Y0JDvhX3N52yNeV5j
        KZ8OPTxzsEilLEOXuehPm6fSmCoAvX5ADurl2iY=
X-Google-Smtp-Source: AJdET5dGRN/8S1YoeHjsg3u6WujYGZH9w1Nw/1wrLBk9bukCzWDC/rgM18bIq9FiBKIwprdSPuresRRgQKRgGAn+OCo=
X-Received: by 2002:a9d:7d06:: with SMTP id v6mr1723575otn.196.1540483055068;
 Thu, 25 Oct 2018 08:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com> <1540480173-12009-5-git-send-email-alex.gonzalez@digi.com>
In-Reply-To: <1540480173-12009-5-git-send-email-alex.gonzalez@digi.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 25 Oct 2018 12:57:34 -0300
Message-ID: <CAOMZO5AByRkUQG=JYzZ1-sLSretusMxy3Xd0T5_bTVsL20K2ZQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] ARM: dts: ccimx6ulsbcpro: Add support for Goodix
 touch controller
To:     "Gonzalez, Alex" <alex.gonzalez@digi.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:10 PM Alex Gonzalez <alex.gonzalez@digi.com> wrote:
>
> The ConnectCore 6UL SBC Pro has an AUO/Goodix LCD accessory kit that is
> connected on the LVDS interface through an on-board LVDS transceiver.
>
> This change adds support for the touch interface.
>
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
