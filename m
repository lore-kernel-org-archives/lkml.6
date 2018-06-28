Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65C7C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7562426BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2Tg12gR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7562426BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeF1Ejv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:39:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35891 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeF1Ejt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:39:49 -0400
Received: by mail-it0-f65.google.com with SMTP id j135-v6so10600732itj.1;
        Wed, 27 Jun 2018 21:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ek/WvT79Vv0MFv/8TGSxbvlBqa84Z9W5eQ9ipuqZF2w=;
        b=t2Tg12gRyS4RLHgcbkGJsWUqKeUd3BzuVVB87vnxkVjzIUtD0ZSAgGlvoKGQN65uC1
         4bf5LDrdERy/AF9LSjEsSw4S9Na6whkz8eq0r+x+Qn7UsYijzmLRLLozOU6KOlWatRa7
         TvOp6+7ruYzS+qNhCMGt/Lg89aEpKNq5pNHwdK87yP6mPDuiZA1gTuO/LHHOtF7sP3t9
         bBQxfIGX0sG+kH9OjLZdQxzPyTOtC0N8E1R1nu+F1TVlswFnwxwqAgt5UoTGz2lLGOB4
         OLHVizr8NiUqHpANjbhNeZa/3S4g7lMvnQcNDJaW0O54QEhsD6bL9GIegaVBj1PqOXxJ
         oqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ek/WvT79Vv0MFv/8TGSxbvlBqa84Z9W5eQ9ipuqZF2w=;
        b=jBqJ9NtrlQLTsYEFQbW+WMB6bjdcW0CYocw4vIkaII2QU/7oELuu/3YEqG+DpYO42/
         UlKoS66ork5/ILvATlkIago1JlhfGJzc2CWumT80dFBdNTrJ6F7Ze8LpT+THcSDXyDIY
         mYjqVQobQ37nEeXAeqKcwWNjN/HOsDu+rKiNB/TveAZDz3Al2/XTOpixbEo8VD6MkO/h
         zB9fjjMkUXrKJnB7z/ntpfhBWyVCXERCr2Hvv8V4I5ngCdg6KcvTlfyjmFLdz6Qq05Wz
         YJLzYD87bypI7nKvxMAvVCl9iKWD45P4WHbiiD7uZMjvi5ahyci2de7oDnj1efl5nL/l
         zZtw==
X-Gm-Message-State: APt69E1/Dtkh+wKRGMec5NOYtQhR/M0NXPm0DgPFhwPTnU2rQqvYPOAb
        VqgOhzYQcLKf+v92bOHshGnlVcQteG3AzVukneM=
X-Google-Smtp-Source: AAOMgpewR+fAffzN7WOPDj62sZdRni4214dSyVaw6jmDy5LY40zvnhlvqem9nFONrsIoqFJWMAA8K2PiQpGJ4PWpqBE=
X-Received: by 2002:a02:9c33:: with SMTP id q48-v6mr6189324jak.103.1530160788959;
 Wed, 27 Jun 2018 21:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180628042424.12664-1-andrew.smirnov@gmail.com> <20180628042424.12664-3-andrew.smirnov@gmail.com>
In-Reply-To: <20180628042424.12664-3-andrew.smirnov@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 27 Jun 2018 21:39:37 -0700
Message-ID: <CAHQ1cqHpX_nz+xyyPg30kXsn2oTp2BBzk-qpCi3z3kezg1PTWg@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP EEPROM nodes
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 9:24 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> ZII's RDU1s come with two EEPROMs attached to RAVE SP. Add

Ugh, the description should read RDU2, not RDU1. Will fix in v2,
tomorrow. Sorry about that.

Thanks,
Andrey Smirnov

> corresponding nodes to make them availible.
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: cphealy@gmail.com
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 19a075aee19e..e4630481d951 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -320,10 +320,28 @@
>         rave-sp {
>                 compatible = "zii,rave-sp-rdu2";
>                 current-speed = <1000000>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
>
>                 watchdog {
>                         compatible = "zii,rave-sp-watchdog";
>                 };
> +
> +               eeprom@a3 {
> +                       compatible = "zii,rave-sp-eeprom";
> +                       reg = <0xa3 0x4000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       zii,eeprom-name = "dds-eeprom";
> +               };
> +
> +               eeprom@a4 {
> +                       compatible = "zii,rave-sp-eeprom";
> +                       reg = <0xa4 0x4000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       zii,eeprom-name = "main-eeprom";
> +               };
>         };
>  };
>
> --
> 2.17.1
>
