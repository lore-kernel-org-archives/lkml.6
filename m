Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE95ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E9E208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bF571BsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E9E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbeGMHu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:50:56 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40461 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGMHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:50:56 -0400
Received: by mail-io0-f195.google.com with SMTP id l14-v6so20578720iob.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUOvlJC4jFaZ9YAbOBVo6dghVjT8goLNcF2MOpWU+7c=;
        b=bF571BsBSycYC73SbL466EIMw2HZUvpPzqk7Kb/uh8aicyt0iJIjfeebD/QaPetxQs
         2l1VWQQ5WCGfy0Y3avbkqSV1dbUwo94czapUOe3EADT/vor1xKaNkoq7Sb7QKY2j4yl7
         W6prfgqk1fbxN8zu79r2F2CoyE7HcnGaZnMP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUOvlJC4jFaZ9YAbOBVo6dghVjT8goLNcF2MOpWU+7c=;
        b=IefLTrMda6ML8RlLRYZNeqfFIOHbmStOV3KrCAyckiZtNHDPPAMXacisVoQ0MhvtMX
         a+5RHjQOLTu05ivHDKGjdKEyDAZXdiP0Njub9GHtJOG2FWX6kfjTsDaZzx/Sy2e9ucoj
         2TLqYxp+40ZjqhAlAFzUI6kOlfVzO254z1yDy1cSKvvo3dI75JnkHokJspY0jkTSzZ35
         Ik8BFB8S6jdqdlnTTjtvojFSBX+ucd62ai89CF9tiQmzlkq73+8ND3LcpJXELe/3WYJ2
         F8ikg9I/R1B0DdysV5dPu5FhAGNdNFSN1PMZFonFtkcamdtNbqfL3SvYnLrKIiBE+xsy
         7xkA==
X-Gm-Message-State: AOUpUlEhdzUdRgdtlVUyvU59ZGfmP6OUuCf3TKRS0Rs+9D5RhRhPBTfT
        WIdM7cRPHTfZwka++Fr+xMHmd8zxCi9zUA+lTvtI0w==
X-Google-Smtp-Source: AAOMgpeRf0Z6Oh3+3n7AA/cE4eK+dWCSk5F9lV56/ii3Orzxg8A1QrI3GvM2CmKLCCIPfUvSvlAtYgIdxo9H0gpYArA=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr29358826iof.304.1531467452202;
 Fri, 13 Jul 2018 00:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1531294612-29526-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
In-Reply-To: <1531294612-29526-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 09:37:20 +0200
Message-ID: <CACRpkdZOwgj4hCy=L6kKiQOpGNpvFXJk666pauyRv-fdHizMtg@mail.gmail.com>
Subject: Re: [LINUX PATCH v11 1/3] dt-bindings: memory: Add pl353 smc
 controller devicetree binding information
To:     naga.sureshkumar.relli@xilinx.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>, ada@thorsis.co,
        honghui.zhang@mediatek.com,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nagasureshkumarrelli@gmail.com, michals@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 9:37 AM Naga Sureshkumar Relli
<naga.sureshkumar.relli@xilinx.com> wrote:

> Add pl353 static memory controller devicetree binding information.
>
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v11:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Thanks!

Yours,
Linus Walleij
