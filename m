Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A629C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05412744A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6Y1vCXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05412744A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753820AbeF1NdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:33:07 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44314 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753731AbeF1NdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:33:05 -0400
Received: by mail-ot0-f193.google.com with SMTP id w13-v6so6125856ote.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZtgAyUiVNi1sXuvy58010NaUUFSMhwS8WiPIrv9+eEo=;
        b=e6Y1vCXt2N2ZgaaUup+KRoArCI904G/QNypkTZ6nhOH43ya1TJB18126cdg8f4XtS1
         Cp9kFMmJ4d0ITpO3cRnPiN38MItiNZbvfT2PCGrKdSqg+VT43CRvCYWsiDe8SOEM1vm4
         k4J/jFCWNRLyz85Tou1oDAvclEtvCkhSgw9f7qEz6EcR6+3hyuupNd5JPjT0mY6a+AuC
         9PwPn9f6BP5hQe1MtVlzUt+gmox9nz803uBTfexwxhDfgPjSvLJABBWkEMnNBliEa7rl
         iSgA4qa2O0w3kkfqWeEWbxcG8PnaD4U1EdHRTMJ7iMNrMN3QgluRrk8hlcawQHGv4dyg
         pFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZtgAyUiVNi1sXuvy58010NaUUFSMhwS8WiPIrv9+eEo=;
        b=Gi7o2sfB3PyuO5hPQos+x9cxDgkFEZje4QOeqVjbj96xMwNYInWDjeFxRG+u5DBvBD
         H3Es3A3i4YydQpPV5+DMP4+eaPul6TPB7VS9wuM13z4i5gloDb5/i9nhtplrQIBINgJm
         FXjFW3HKCfWOm1gnSrQHysuJ8ViExG3jU9Uio44nWp+Q+gDFBn31tpcRmQ5QafcTECQB
         pVr0drZ+vJ4U6fPb1D7zCa7ftNLzCcgoFysr1Uat+NUWhyyI1YjZrSH6L9cbKR7Yy9/t
         8TiWsnnC/tDijeMTCZG+z0/oHdIY/MM2krk4dZvSEWsaaD/zxY+Udz9vfUYH4VYzqN9D
         TECg==
X-Gm-Message-State: APt69E1/I0EfhtXHIPb7WQu1x/f2oh8ae9aUcsY5FBqmBWkTFrt+tbQj
        kTVVtjgD0kDSUF6k5tvN+g+grhfSvZf//0Pzqc0=
X-Google-Smtp-Source: AAOMgpeDkMeiLA/fvMcyAE+WcBpQ7OKmCD6ECNRFQhhuFE2QrPQouSeerU4M9RwcdOvNWc+dt0RNa+bQVNgO+HORUFY=
X-Received: by 2002:a9d:30c2:: with SMTP id r2-v6mr6267779otg.25.1530192785264;
 Thu, 28 Jun 2018 06:33:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 06:33:04
 -0700 (PDT)
In-Reply-To: <20180628043713.14425-2-andrew.smirnov@gmail.com>
References: <20180628043713.14425-1-andrew.smirnov@gmail.com> <20180628043713.14425-2-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 28 Jun 2018 10:33:04 -0300
Message-ID: <CAOMZO5A_fpyf+qEBhbQRW2nEATb+sAXcLfkQeptNWk7V8ezZrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx51-babbage: Make use of pinctrl_usbh1reg
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 1:37 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Pinctrl_usbh1reg defines pinmux setting for reset GPIO used by
> usbh1phy, but is not referenced by that node. Fix that.
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
