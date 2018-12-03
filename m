Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0D7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BA720850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNgoTWCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BA720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeLCMEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:04:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45959 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeLCMEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:04:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so11280675ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 04:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJJ7kyEb2x520IJKCmGS8rH+PEUleJgcDK2KlveNzQU=;
        b=cNgoTWCLTyYHuvnlGKn46wsoxDy0YoLbzbo8wHqj9+rk7v0kDCT8lk5O7RBlcri1Kl
         WL7kWXAn5dkY5qoFB0/oW2vcDRxdVERc3dXyOjuaSkPrJ98EwfVGpvEezfGcF+lDyvcY
         BSKrcMxydy9EV0+n9rGoJMDoo7mM122vE1aPk2kKfDXhyWY+0n8r/Or1LrN9m4pQ5bIH
         Tjfb5xNy1j53ZFMChlKAnSgKxNg7SipRKWwbaOHZV3LeZn2rSxeqU6dRNpuXD4VE/K+G
         WuOlnccOINCq889iLuvdRQc4Uqh4UJwViYQbuQCZ7KM2eza/M1pfV9bqo4xNvqzaHGTx
         +S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJJ7kyEb2x520IJKCmGS8rH+PEUleJgcDK2KlveNzQU=;
        b=O6sY4zpMscT9VEpC9psR8nUSRavHbXvdDrJCiRMCW5Lhdp0pWcKavVlBHC5hkMmsui
         SzHGgcQHSP8OyjxT9UhM4GIlEomUyI+DsfbnL/Zl/GsvYOqSx+d98i8WwVkyM//UZktw
         Shh6ETMKYPEu70cYXKQI4g4z/hPg0RN6OBAycyDde1OHwCi5cpXyLSEP0GIE+bXtziIX
         2BbxbEgF8d6tAlNVF3gJne6FD58VJQRKGYdzDZRK5EWfDSpNRHpbluNHjrYOonGlT8r0
         h/+reqiKDyNc6JpxxOZE36Tz4XrXlvVb9o2NP2+iXumbkuhC5ctfyBgC0lswqGy1wgVU
         /Bfw==
X-Gm-Message-State: AA+aEWbZ51Wu3XmXAxyAi9Z13Q59+H3jxZqBkaGLEyJ5Z3WxixVKVU2A
        U7jeGOZWk55PK68xFyn/uPdh6poqvsuPHD8nc9M=
X-Google-Smtp-Source: AFSGD/V6QHU82I81dyrP3+vbJRLwiObWmnUwAVhaPmbDlZza2VFglekSqlDA9M1S8Gvdcpf1Qdy1mmgcv7vbAw7ujd4=
X-Received: by 2002:a9d:84e:: with SMTP id 72mr10382004oty.203.1543838605612;
 Mon, 03 Dec 2018 04:03:25 -0800 (PST)
MIME-Version: 1.0
References: <1543804767-17650-1-git-send-email-Anson.Huang@nxp.com> <CAOMZO5Bc2z9mtWN5HDDbLggryEaxF6eay2Wnu8AdBSBNFZSmXw@mail.gmail.com>
In-Reply-To: <CAOMZO5Bc2z9mtWN5HDDbLggryEaxF6eay2Wnu8AdBSBNFZSmXw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 3 Dec 2018 10:03:26 -0200
Message-ID: <CAOMZO5CvjtVfQGT2+0k5eGT2=r_7=qDVe7KvFMcPvUythX8m5Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: update the cpu power up timing setting
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 9:42 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Mon, Dec 3, 2018 at 12:45 AM Anson Huang <anson.huang@nxp.com> wrote:
> >
> > The sw2iso count should cover ARM LDO ramp-up time,
> > the MAX ARM LDO ramp-up time may be up to more than
> > 100us on some boards, this patch sets sw2iso to 0xf
> > (~384us) which is the reset value, and it is much
> > more safe to cover different boards, since we have
> > observed that some customer boards failed with current
> > setting of 0x2.
> >
> > Fixes: 05136f0897b5 ("ARM: imx: support arm power off in cpuidle for i.mx6sx")
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Minor nit that maybe Shawn can fix while applying it: Subject should
contain imx6sx as this change only affect this SoC.
