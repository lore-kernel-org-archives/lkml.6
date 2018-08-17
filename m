Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCE1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CE920845
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AVe4LBjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8CE920845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeHQLMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:12:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39168 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeHQLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:12:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so6314097wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 01:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ld/055jrWeDNT2eNraWlZK1t9CGIyWAbQaXSGqlFHcI=;
        b=AVe4LBjzfmyWcMqJdydHTTf/IAJkG8i9c5qfFaW9O53aesyGwWFieZbtzpzmbHzoF7
         CvmzodLkT85QZsNaID7ogM7xmaNBlPKh+7KQSn3vS4CGCJzOv/PlJCzIiFXnL9HiuQ1n
         QUYH7P6j1+h/X612i8RVQrCtI8esuxmhBBYmjkRXk28fNbA6m9YZS5dQFj6+EZ6zda75
         ayQC5C8z1ZgZlVt9VFV2LsEtXguGqxHsu+qaKtDZfbgzVftWjr2LKdUL8c+XhHc2UH7M
         Ed5ZuUr+P1ud171/Kmz9KkwS8SA+8SLl7WUptbPS6eOGoBVEYuSnb2E2kpt4zzx266dh
         hySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ld/055jrWeDNT2eNraWlZK1t9CGIyWAbQaXSGqlFHcI=;
        b=ssyXmQ6dIEn17DvPqsNIaGphbSxZ4WdgP+htCNlA7bEp2kYDYcPFtD6jgFbUJU6CI4
         OgCvqDhBkEQucGhH4dzY/+h0PhIhRCvJfNcqvhyhaBvP4Z3ax6QsTllDoxb1H6hvaWPU
         75a1nO7Qs+5phCgFC+7hQkQRVAO+10nShKof2V45jJBfGmza1N4hn0WUCOqSubGUaxQh
         FmtAct0sMuI7+D4UAD8Feyaq/NactHx/geM2cIG0XaD0AfeQ9FBKTpDs6a2pIrabPBQI
         RRDGktAL2b4b5/aMz2LVhNP/H5+La61EvcgkDeW0+6VC54UAdRciwXhxdu54srOpFCj3
         InOA==
X-Gm-Message-State: AOUpUlHSKOrPGROcB+oTHBWO55xyfQZtHpiy6viyRf2/ffDlpxNUDsBJ
        cjBtdRqu2FFRyX1+WDkOQFBtJA==
X-Google-Smtp-Source: AA+uWPwXtbtgs+FQyjRDpUbaN4Zqez7d0ILAYxm/mnmwkiUe4ltWGBTIo6udhoCyeElzoB/aKR9oGg==
X-Received: by 2002:adf:f58f:: with SMTP id f15-v6mr3057414wro.59.1534493378886;
        Fri, 17 Aug 2018 01:09:38 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y11-v6sm1706575wrt.4.2018.08.17.01.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 01:09:38 -0700 (PDT)
Message-ID: <8eb76c5b173a8e8f8f90b9d2204c1b3b0de06c51.camel@baylibre.com>
Subject: Re: [PATCH 2/2] PCI: meson: add the Amlogic Meson PCIe phy driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Hanjie Lin <hanjie.lin@amlogic.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Yue Wang <yue.wang@amlogic.com>, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        shawn.lin@rock-chips.com
Date:   Fri, 17 Aug 2018 10:09:37 +0200
In-Reply-To: <91658f21-6934-6085-8deb-b85a1f6b7815@amlogic.com>
References: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
         <1534227134-151584-3-git-send-email-hanjie.lin@amlogic.com>
         <486e8ab477cc22ff231d2e18d7de22efba2c5abd.camel@baylibre.com>
         <2b87e834-41e3-e418-95f0-c6d695cd8b3f@amlogic.com>
         <e5d9d89e79f8ec37b6337e54912f49a0b0856874.camel@baylibre.com>
         <91658f21-6934-6085-8deb-b85a1f6b7815@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 14:12 +0800, Hanjie Lin wrote:
> 
> On 2018/8/16 16:33, Jerome Brunet wrote:
> > On Thu, 2018-08-16 at 11:05 +0800, Hanjie Lin wrote:
> > > 
> > > On 2018/8/14 18:41, Jerome Brunet wrote:
> > > > On Tue, 2018-08-14 at 02:12 -0400, Hanjie Lin wrote:
> > > > > From: Yue Wang <yue.wang@amlogic.com>
> > > > > 
> > > > > The Meson-PCIE-PHY controller supports the 5-Gbps data rate
> > > > > of the PCI Express Gen 2 specification and is backwardcompatible
> > > > > with the 2.5-Gbps Gen 1.1 specification with only
> > > > > inferred idle detection supported on AMLOGIC SoCs.
> > > > 
> > > > It looks like the sole purpose of this driver is to provide the reset lines to
> > > > pcie driver.
> > > > 
> > > > I wonder why we need this ? Can't the pcie driver claim the reset lines itself.
> > > > 
> > > > Also, an init of this phy will always reset both port. What will happen if the
> > > > first port is in use and the 2nd port comes up ?? 
> > > > 
> > > > Looks the the pcie driver should claim 'apb' and 'phy' reset lines as "shared"
> > > > reset and the required 'port' as 'exclusive'
> > > > 
> > > 
> > > Thank you for your response.
> > > 
> > > Yes, 'apb' and 'phy' reset lines are shared, and ‘port' reset line is exclusive.
> > > If we handle all reset lines during the first port initial sequence, 
> > > and when the second port comes up, we will do nothing about the rest lines, 
> > > and don't need a extra API to do ‘port' reset;
> > 
> > With which other driver are your control shared ?
> > 
> > Looks it is the answer is none since this phy driver will reset both port
> > already, even if one is used.
> > 
> > In this case the fact that you are using shared control is just abusing the
> > framework to reset once.
> > 
> > As far as I can tell, this driver makes no sense. The appropriate reset lines
> > should be given directly to your pcie driver. 
> > 
> > 
> > 
> > .
> > 
> 
> Amlogic AXG SOC includes two pcie controllers and pipes when only one pcie phy: 
> 
>                                     (port_a reset)
>                       |PCIE_RC_A---->PCIE_PIPE_A------| 
>     (apb_reset)       |                               |  (phy reset)
>     APB BUS--->       |                               |   PCIE_PHY
>                       |                               |
>                       |             (port_b_reset)    |
>                       |PCIE_RC_B---->PCIE_PIPE_B------|
> 
> The phy_reset affect the PCIE_PHY.
> The port_a_reset affect the PCIE_PIPE_A, port_b_reset affect the PCIE_PIPE_B. 
> 
> As your suggestion we will move the 'port' reset to controller driver,
> and keeping the phy driver to process the 'apb' and 'phy' reset or any
> more changes of the phy in future.

As far as I can tell from this diagram, It would only make sense for the "phy"
reset line to be controlled by your phy driver.

The apb and port is obviously related to the pcie device/driver itself, not the
PHY. And whether you 1 or 2 reset lines in it, IMO it is overkill and
unnecessary to make a phy driver for this. 

> 


