Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8847BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3BD20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfhlDcdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3BD20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeLFBsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:48:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43103 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeLFBsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:48:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so20572620otr.10;
        Wed, 05 Dec 2018 17:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktRLrqEVd0rHe1ATQCTmpQipaPMRkC9on8qaW5eFxwQ=;
        b=KfhlDcdLy76j3M4SHQh6n0gNFVIaZqVMqC2Djrmtlpz/MIHd1Z2q9UYOZGC5MnZpKs
         x7FGX6KtlBR1GEmXI1Ip7zB6EEr081hhbPBLjkcJLugoF2nczVNxn3NeqoKzBYU2Ba0T
         y6dudlRvfiftXWRbRdD+9RSmUUyjnkHAnyIRjloElurj/JwSXfAYzDuPWlXtZ845HmyP
         mAzSLLX8iASMVUmxDSFiG9MzJUZyg+LL+X0BUTQuvgT/hygQSxnpMjX8nOPjCwCScYmI
         8/3mYXVzOhoQDuZoQ9KfZ0qqxMn05mzU2Q70Nx0dEv71aongIprzwyolq5t9+zj++c25
         NqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktRLrqEVd0rHe1ATQCTmpQipaPMRkC9on8qaW5eFxwQ=;
        b=J2+rxpvHPw3WIED57Wcq3LiDX7fbFt28GLGuy9dW4Ai6V4qZQXCLfyu0wgIVjrtQnR
         7Lvduks24OKatLqMQIobek1jD+HeHz8fNc5pbtyyQQQ+OzE4oOIIdCYWp2pQLASc12JM
         TWl4utzY2oFzkgubkQ1gcElIKwzpeUPbIPGWwfCbFO4lZTZHGdJT/6vP3YfbKc4+ORDd
         uqv6gP2Qf1zz0W+4jKz1DJakzAR62kboATgnMz58dMBM92OpmHwIRw9ov4q6bxMpJXRg
         lqc6q0Im568ePt/GRxlOD2dcavfOnD/Yq17cE8Abs7k5okC1t6OXqYS47fDkl9OK7hs7
         +eMA==
X-Gm-Message-State: AA+aEWZ963qU56F0RcktGrmGVaidEOistmA+HAPkdOdTDNdAfI3FKPYs
        PGLGC63ayOicPBFk9zyn3n58ztc62TISmYqqhcw=
X-Google-Smtp-Source: AFSGD/U2ysRr8LvdamTeTexn5fIj+skIkFyASoCwpGBWeAJZQCBYyfacZnIDNnsvzHbNMXWLBmN0CzwSe0SE84UW2oo=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr18316264otp.225.1544060899603;
 Wed, 05 Dec 2018 17:48:19 -0800 (PST)
MIME-Version: 1.0
References: <1544060203-22163-1-git-send-email-Anson.Huang@nxp.com> <1544060203-22163-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544060203-22163-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Dec 2018 23:48:24 -0200
Message-ID: <CAOMZO5BUPAWJBb8XQrYF7dTfSdoBNbK85d10QN0e4+X=tUPbQg@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] ARM: dts: imx6qdl-sabresd: add light sensor support
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 11:43 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add isl29023 light sensor support on i2c3 bus, the light
> sensor's power is controlled by a fixed regulator, since
> the isl29023 driver and most of other sensors on same
> board like mag3110 and mma8451 do NOT support regulator
> operation currently, they are all controlled by this
> regulator, so this patch also adds the fixed regulator
> support and make it always on.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
