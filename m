Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D4EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B1621104
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="iR7xO6Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B1621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbeLKQMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:12:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35098 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeLKQMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:12:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so11198431lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XcMmZDcuTqcuMsOwhKgHSKS/53boXd+a8dFm23kzE0w=;
        b=iR7xO6KjYlu9g5aAltSf1n8E37ftAPJ8R43m9d0dirl8cUlq6Bi1Sm4x6BT2iMzYVL
         9J6jyP8gyCOxKAiAd6dPxzpQQXYp48zPdmid21R07ky/9MQyTZLRYR2RDVOCXZtvky8N
         1osDsnKzOZAPA/SmEBDQ9h6vYhV1JZIwJ2ibwNOq9YxnuELbwh15PlFp9Ax+7/1QUu5D
         1JjZU63CI1iXluaOo3uXBL0uyq4t8ZZzckogxeiPTG7GpaNH763NFlOD4tTvWCgYo9qn
         tGSHqHnRETA3Z63YUy5HFLnG96TA5dWLmcLC8BA79eHt/xw5xVW6XiQo5kYOGuh56OI7
         svVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XcMmZDcuTqcuMsOwhKgHSKS/53boXd+a8dFm23kzE0w=;
        b=dLLTAfvA85j0fOefkwyb+3nBRk+mwzlmycXy1a4aLLneLGMb3klwa3DtxxMavudwt+
         bMdQQzbXXcZs/0la14z9LpOUbtQH3wAH39HSVG38vVAyjH/XcuKTcXERsqd7dCK3pKKO
         NgmK7hAqj28Omm9EuFWrkjLUBrFNBevaVFKW7sLanEGI3pvS3JRZWPUtNFOxnvNtHZFn
         miTMJd0xrZKTXttlEfkP/0WZz7FMGD3kcn0EVMZ+8EJmXA+gUC4EMbpca06G2fJWHOTC
         XOyAVSgtQLkz5tg8gyDcQhUeIUz1CxK+40TogxSF3nRxKwjywv3fsKjC8gxbRYMYfmmi
         EvaA==
X-Gm-Message-State: AA+aEWaiiAd4sXoM8gFRHmLQhks64eRRZXnOVKReJeegh+wpo6lNpPbY
        cYvvSbVb4XtO2hKXpQ1QW4IbxQ==
X-Google-Smtp-Source: AFSGD/V1XRQK4rFa9ph5XxyirZb5Wp5LYBbumockd6O+A/j/2na462KPEyDZG0ivIbv1/wXUOlZq4w==
X-Received: by 2002:a19:5782:: with SMTP id l124mr231769lfb.91.1544544731114;
        Tue, 11 Dec 2018 08:12:11 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id p23sm2721768lfh.47.2018.12.11.08.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 08:12:09 -0800 (PST)
Date:   Tue, 11 Dec 2018 07:41:59 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
Message-ID: <20181211154159.54yaytbp4pyjqjhg@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:33:37PM +0100, Marc Gonzalez wrote:
> On 09/11/2018 01:54, Marc Gonzalez wrote:
> 
> > Hello ARM maintainers,
> > 
> > v3: Keep CRYPTO_DEV_FSL_DPAA2_CAAM in patch 7/9
> > 
> > v2: Improve commit message for a few patches
> > 
> > The set of Kconfig options slowly changes with every kernel version.
> > This patch series regenerates the arm64 defconfig for v4.20
> > No functional change intended, except adding PINCTRL_MTK_MOORE to
> > keep PINCTRL_MT7622, and adding FSL_MC_BUS and FSL_MC_DPIO to
> > keep CRYPTO_DEV_FSL_DPAA2_CAAM.
> > 
> > Marc Gonzalez (9):
> >   arm64: defconfig: Regenerate for v4.20
> >   arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
> >   arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
> >   arm64: defconfig: Drop USB_ULPI_BUS and USB_CHIPIDEA_ULPI
> >   arm64: defconfig: Replace PINCTRL_MT7622 with PINCTRL_MTK_MOORE
> >   arm64: defconfig: Drop redundant SND_SOC_ROCKCHIP_I2S
> >   arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
> >   arm64: defconfig: Change SCSI_UFS_HISI=m
> >   arm64: defconfig: Drop redundant sound codec options
> > 
> >  arch/arm64/configs/defconfig | 108 ++++++++++++++++++++-----------------------
> >  1 file changed, 49 insertions(+), 59 deletions(-)
> 
> Arnd, Olof,
> 
> Would you take this series for 4.21-rc1?

Hi,

Yeah, I'm happy to look at applying it but will do it towards the end of the
staging of new contents so we don't get too much conflicts with pull requests
that come in.


-Olof
