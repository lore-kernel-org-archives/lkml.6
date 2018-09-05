Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624D120645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624D120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeIFAkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:40:31 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41903 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeIFAkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:40:31 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so16071650oiw.8;
        Wed, 05 Sep 2018 13:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkSVo0lcHD+mhT/pdzQFbFOUgNYCXmWpzKU/6TiF/W4=;
        b=QL71yPIPX5rPMhwixJMSIGgA5FxzUPg6oURBugGAXYHwkabRPUSXPC8tEIL98jeSOm
         SU2BaAZpGev8KrgsEyApSUKk4BAixql4ppIrJZwmeQE+vftKNQsguMGrFag8Kol+iCUe
         pWEPJEJgudFFyV3qDxHuOiE5Qsu3N2leKCziBxDsp9gK++61D/N1SB/ssnQeuvPcfU8I
         p47E/0GqRXG8HgQjmkX8uhhvSf6mYRsHahg5qnydh7L0NioHfXMCWAVPW2TIL5MR1gMs
         WgAA/GnSNG9OoRvEZ6eb119p65zexTNsb+bE0XFuAx2XzCioM+Ft+7NYgIUzUhg7rnUH
         lB+g==
X-Gm-Message-State: APzg51DNfBnbYq8nrHX6IdOPz6C26YntPCW7v2ztRZlTblDB5bs9jXqQ
        vlpiDUKTC6O4UisMPIg1S4rx0tpQ7lc=
X-Google-Smtp-Source: ANB0VdZVy0WcgbzaZxvu0fKwqamTy67D6EQ9W858s/EPih2FctiIAJNhu77zukaynvKF/qBP8yinpw==
X-Received: by 2002:a54:4d86:: with SMTP id y6-v6mr33094262oix.261.1536178125899;
        Wed, 05 Sep 2018 13:08:45 -0700 (PDT)
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id j125-v6sm1815381oih.53.2018.09.05.13.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 13:08:44 -0700 (PDT)
Received: by mail-oi0-f54.google.com with SMTP id p84-v6so16136810oic.4;
        Wed, 05 Sep 2018 13:08:43 -0700 (PDT)
X-Received: by 2002:aca:e2d3:: with SMTP id z202-v6mr29456612oig.121.1536178123710;
 Wed, 05 Sep 2018 13:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180829073324.36866-1-yinbo.zhu@nxp.com>
In-Reply-To: <20180829073324.36866-1-yinbo.zhu@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 5 Sep 2018 15:08:32 -0500
X-Gmail-Original-Message-ID: <CADRPPNQLy4vor9ABCZn98eS9m4VtbkmSPd-UPvWMH+xpCaQL1w@mail.gmail.com>
Message-ID: <CADRPPNQLy4vor9ABCZn98eS9m4VtbkmSPd-UPvWMH+xpCaQL1w@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: dwc3: Add description of 'configure-gfladj'
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>, Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 2:38 AM Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> This patch is to add description of 'configure-gfladj' to binding
> so that configuring devicetree
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

This patch should be sent to the DWC3 driver maintainer to review and
probably merged through usb tree.  You shouldn't use the arm64: dts:
prefix for this patch either.

> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 3e4c38b..40c6568 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -101,6 +101,7 @@ Optional properties:
>                         When just one value, which means INCRX burst mode enabled. When
>                         more than one value, which means undefined length INCR burst type
>                         enabled. The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
> + - configure-gfladj: determine whether frame length adjustment is required or not.
>
>   - in addition all properties from usb-xhci.txt from the current directory are
>     supported as well
> --
> 1.7.1
>
