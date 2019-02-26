Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E91C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D9A2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6hbdVXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfBZMyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:54:38 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40934 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBZMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:54:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id v20so10956518otk.7;
        Tue, 26 Feb 2019 04:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfGzKP/OLXFBdjiuVCs3RGt0v2kXfo/dPlY5xcAlpsY=;
        b=m6hbdVXkG9ZxucmX1mzVB7b51wIhJgICWRNbXc6Nua2Fnp4ot427x+gms/YlDuWRkX
         yaU2RVsCpReESSwy5hqRrpm+d8pA2B0wMuNGayihWd80QCF7mIz3r9ckVTPbSz6DptGj
         SQYUiNM9ccDu9u4LuMxZLDN5rF4txNH/IxJ2s/CzZc6MtsaQyAO4Pd1APC8tSQ6yG+0V
         Z5FurLuLgQJLqa4ZFTqQ6gCweFGTCiSH2jiR8wg1zHeMCpJVarrG3GiJ74DXLI+ovDu2
         IG9vkqdVnCICLoZqYqn6L+xGVqzsfcNlQS0+y8y5jXwu9f2VhIak7YxUc+luGG+lFfAd
         x68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfGzKP/OLXFBdjiuVCs3RGt0v2kXfo/dPlY5xcAlpsY=;
        b=OjkhDWNUAW6puZbih1+YaiMTmFfqlCF0+UU/GJT47e1kRGqM9oyQl2TTgKsPXQi4mP
         1V+b/ygNHMI2nZnpuJZ456q3ZCV4764wiEM5SF6uGxF7eLWu7ehIlMPWlxbAkYoM51Zr
         GdfQJ5g7zSvYCMjyFbWgn93/QdDKaoUQgd6StrljUJd1bbVI7peIlJtOxQXfcpeIFAQO
         KcabKu/UAhWFqJ+yjZV9wYryFAPkWqy0D6arnrSb+mOfFZnENvAhM0q6vwSgkECoBrHm
         KN9aK8tXSp7zr9e9vhd3WfaE3vhF68FoTNedCMqHSTB28im1bldDDGLq4dZeKL9kRy5H
         9byg==
X-Gm-Message-State: AHQUAub0uTlHMiCxy1VleTAllxo3wD5Fx1dyIlY8BJE+iPRSKhe84Xfx
        NHcPZZ01lWV0JksecTDVXEkTvFtIzbDlpEuh9fkHZ2fg
X-Google-Smtp-Source: AHgI3IaSYAQqg6JF8aKCdphdBJRlWfYUmGrsWTG0Xua+jMIdFKm0WEXRHRaYN6ZcBy7kK/DqmUfyhvikcf1YuomGo3c=
X-Received: by 2002:a9d:7645:: with SMTP id o5mr15927777otl.225.1551185677777;
 Tue, 26 Feb 2019 04:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com> <20190226070742.30551-3-daniel.baluta@nxp.com>
In-Reply-To: <20190226070742.30551-3-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Feb 2019 09:54:27 -0300
Message-ID: <CAOMZO5AzUzyr_xixDcntoNt1KNSRih_2ZRFnzQHcg6pZmHsYig@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: imx8mq: Add SAI2 node
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 4:08 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> SAI2 is part of AIPS-3 memory region and it's the DAI through
> which the wm8524 codec gets its data.

Please do not mention wm8524 in a SoC dtsi file commit message.

It is the imx8mq-evk board that uses this codec and this information
is not SoC related.
