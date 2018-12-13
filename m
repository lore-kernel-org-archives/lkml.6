Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D3EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DC02080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Nyil1uEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DC02080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeLMGvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:51:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47049 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeLMGvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:51:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so756172ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 22:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L/ZYQFDf7WS7FvF88HIBsNhg7P6SRIY1tlsTQv7X9W4=;
        b=Nyil1uEG3eMkzXLT0KptVLJOR9WM7yXOKcsgPVvMxHQ62JcnnNd8mgVYhUhV/uDqhx
         oGwbq+s2EKL1VgYetZFHnsaVKzrpfRn3sEZeQ+GZmESDf+Q9jIKAGk/CzYyEGmhCrpxY
         nTjMbgkgkkW8gbHE7kjwdS0/+FTkLDd2gBgR66n9WNwdR2/oR9XuIvsdTEjTeUkYeeEd
         9Bh4nkrS2h34ptQ9NnhJIsRHzmI12oY6T3tu6V/iDsLgOfxzLa68mwCUG5gIcou5bTfv
         ORcxruL0pSy9ujoaIZPRdp8HuCEQSQFUDHF+3QJWr0aUQ8JIwHenwo139f57vrxBmBpB
         U+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L/ZYQFDf7WS7FvF88HIBsNhg7P6SRIY1tlsTQv7X9W4=;
        b=caWRwhN8SPUFRaF77koiHZATaYuBtBfGVh4Jy2jbX7EgbYh7kTx5kuFHesyctlhLEB
         /fAVgehk98rHyIat86HV/ReEl5xrAG8LJBA4IUJvpd1nMJCXk3Zpd4A7J0KifN+aSrxR
         8hcGHvZl61iM574vsTxEs+gSai65SnIJE+mTPl6A8kOyRif6SvCEdcxYvitj7IWQdkKN
         WrxP7II8WS9i4IAGm49Hd0RhpEkVipokIrz8PmRvYA1ad3S7r51i0XCQb+HmPLeWoa7l
         aV+2pIHTDG1mvGph7DPDXmDDOJ3+tkagzWnDxHf3FX0UPzN2/scWrieB2dEhrEa5G4UB
         OL5Q==
X-Gm-Message-State: AA+aEWZGO4W1HYf52qP+N0B2/6FpBq1mvp1NfZ51tlvd+VfgKgU82ita
        Nk/7BiqB1zICjXb41K2f8Gzw+w==
X-Google-Smtp-Source: AFSGD/W8rX3AGDc1cqBWqJknnArBp1Ighz+bpHpu7y9DrfM7vD1oMv+wgZO9pmPhwZMwnUvc6qrv8g==
X-Received: by 2002:a2e:9b15:: with SMTP id u21-v6mr13555035lji.29.1544683907703;
        Wed, 12 Dec 2018 22:51:47 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id f1sm177993lfm.22.2018.12.12.22.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 22:51:46 -0800 (PST)
Date:   Wed, 12 Dec 2018 22:51:13 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
Message-ID: <20181213065113.sz7ce7kpkenyu3dy@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
 <20181211154159.54yaytbp4pyjqjhg@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211154159.54yaytbp4pyjqjhg@localhost>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 07:41:59AM -0800, Olof Johansson wrote:
> On Wed, Dec 05, 2018 at 04:33:37PM +0100, Marc Gonzalez wrote:
> > On 09/11/2018 01:54, Marc Gonzalez wrote:
> > 
> > > Hello ARM maintainers,
> > > 
> > > v3: Keep CRYPTO_DEV_FSL_DPAA2_CAAM in patch 7/9
> > > 
> > > v2: Improve commit message for a few patches
> > > 
> > > The set of Kconfig options slowly changes with every kernel version.
> > > This patch series regenerates the arm64 defconfig for v4.20
> > > No functional change intended, except adding PINCTRL_MTK_MOORE to
> > > keep PINCTRL_MT7622, and adding FSL_MC_BUS and FSL_MC_DPIO to
> > > keep CRYPTO_DEV_FSL_DPAA2_CAAM.
> > > 
> > > Marc Gonzalez (9):
> > >   arm64: defconfig: Regenerate for v4.20
> > >   arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
> > >   arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
> > >   arm64: defconfig: Drop USB_ULPI_BUS and USB_CHIPIDEA_ULPI
> > >   arm64: defconfig: Replace PINCTRL_MT7622 with PINCTRL_MTK_MOORE
> > >   arm64: defconfig: Drop redundant SND_SOC_ROCKCHIP_I2S
> > >   arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
> > >   arm64: defconfig: Change SCSI_UFS_HISI=m
> > >   arm64: defconfig: Drop redundant sound codec options
> > > 
> > >  arch/arm64/configs/defconfig | 108 ++++++++++++++++++++-----------------------
> > >  1 file changed, 49 insertions(+), 59 deletions(-)
> > 
> > Arnd, Olof,
> > 
> > Would you take this series for 4.21-rc1?
> 
> Hi,
> 
> Yeah, I'm happy to look at applying it but will do it towards the end of the
> staging of new contents so we don't get too much conflicts with pull requests
> that come in.

I've applied the patches from the series that were still needed. When
re-running savedefconfig as part of patch 1, several of them were no longer
applicable.


-Olof
