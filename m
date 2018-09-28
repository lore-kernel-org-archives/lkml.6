Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7558C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2FC216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2FC216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeI1Ol1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:41:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38904 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbeI1Ol0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:41:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id x8-v6so7404086eds.5;
        Fri, 28 Sep 2018 01:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuaFlWM8aA8SrqzRTpywr4EOqQUXnSS7B7JzFDi6a8g=;
        b=UO/4AyHTXl1N1hqjZZhyQNaiY8RBxXFeOED0SwWTWJVTKg2FEU525rulA5raIfqCHd
         C5dr4ptGiFOULN3CdI2JtApGpLE2xWY6vI0uzuJBWnlDyBB+7YaP179eVj1P8K/eNArG
         RtGCTo3FqRvdeKpCl8ifcZYTxfm2wiemZTpyqslaW11/CU8mMu/C67ZQT3GW8K1Q8x/h
         3WDQfXuROQEOP1t+cvQeiI8tZNhxZN6bB5CAMIuZq7gc5F78HTyCrgTfBvY98EI+V9rO
         IB6nhhNMxUdxzkqxmd+FOl0Xu/YBaPf3fX2ugIwahYMI86UVj3oVWRPrNddqZvKDG55s
         UoVw==
X-Gm-Message-State: ABuFfojJ9sCsSN0H81MN/r588hv+XKQT343/IMnBTn2Gb59lsDvPqUtF
        9Q3GqZhCIGGk5YcmviJNx6aQnaMofAs=
X-Google-Smtp-Source: ACcGV63Ot1g17ooIrNXiBCKHN8ZnM6nD7//VF3g4BIesqVGpINKE+kBFOH6u0N+SRXGIP09424D2/g==
X-Received: by 2002:aa7:da94:: with SMTP id q20-v6mr1613757eds.13.1538122731008;
        Fri, 28 Sep 2018 01:18:51 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id s18-v6sm542911ejq.13.2018.09.28.01.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 01:18:50 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id o18-v6so1273129wmc.0;
        Fri, 28 Sep 2018 01:18:50 -0700 (PDT)
X-Received: by 2002:a1c:4857:: with SMTP id v84-v6mr868558wma.8.1538122730395;
 Fri, 28 Sep 2018 01:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180926132339.24737-1-wens@csie.org> <20180927172837.ucxmqfhazt4xwfh2@flea>
In-Reply-To: <20180927172837.ucxmqfhazt4xwfh2@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 28 Sep 2018 16:18:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v65xs6zASfVGQp=ZsNa5-D_Xa3DSmD7FfM0D5vhbCwt-DA@mail.gmail.com>
Message-ID: <CAGb2v65xs6zASfVGQp=ZsNa5-D_Xa3DSmD7FfM0D5vhbCwt-DA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 1:28 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Sep 26, 2018 at 09:23:39PM +0800, Chen-Yu Tsai wrote:
> > Bananapi released an updated revision of the H3/H5 based Bananapi M2+.
> > Version 1.2 enables voltage control for the CPU's regulator by using
> > a GPIO line to toggle a MOSFET that can change the effective resistance
> > value in the regulator's feedback network.
> >
> > This patch adds a common .dtsi file for this new revision, which
> > includes the original common sunxi-bananapi-m2-plus.dtsi file, and
> > adds the GPIO-controlled regulator and a cpu-supply reference. H3
> > and H5 variant dts files are added as well.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied.
