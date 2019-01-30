Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABC2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D6D2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbfA3QeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:34:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41391 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfA3QeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:34:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so143306qtf.8;
        Wed, 30 Jan 2019 08:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euuV6RNzmdpfE6XW8Kl8bVDvDGr6dCVxskMSvSuszAo=;
        b=QfjuZBFH9M4ACxtrEeTZNTnJacuy6ihW5pJIyzjO11UFCqHNsgSG9TdN8WF5TM8QdT
         mcJal7D5+TfK2lgVlbPQTRYElaIbuXq3KHJ8Gzb52mdeA/peJm6mhEVb9xEZYNMbqu+S
         t/NgC7lHCtfXBUFvN9USBgtaO0Cii2jKqmwcVXiSMczr9Vj42KOAHLcsQOaAnc6PIJ0V
         ZySuZ7Onx7yaiZfYbcWS4MtPmRyQDTqbadnFMvSF1ZUWVT5SCW7rdEBM/n+OTNFRxY10
         X0z/0AB8tT8vYdpetWJc2d7dLNrKa6uXZakfKehggOYDFy3HetkIKIOMVvuce1+jrNPb
         4Q+A==
X-Gm-Message-State: AJcUuke90tE0N8CckcUTHbuvcr1Ll/tkOPRzQOXDOB/N9Qe2nExvqwSc
        zANC1cSHwtGa3MESGjabIaVois5HVhiY9JJW+8Y=
X-Google-Smtp-Source: AHgI3IYQuoq+cjxzwUiUrZQHM71psYfzLKuW+YSxHM4NOpLDw9WRFnyLQ+jJUX2YZGMbOzO4P/+tcXyxnmJkAhM3BhA=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr19213617qtl.343.1548866054768;
 Wed, 30 Jan 2019 08:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20190114174533.6134-1-robh@kernel.org>
In-Reply-To: <20190114174533.6134-1-robh@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Jan 2019 17:33:57 +0100
Message-ID: <CAK8P3a28_=urR1h95GN_wvYxJSOTUr_gL-cOzk9Pt1CZFGnJCA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: Remove inconsistent use of 'arm,armv8'
 compatible string
To:     Rob Herring <robh@kernel.org>
Cc:     arm-soc <arm@kernel.org>, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Nishanth Menon <nm@ti.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Chanho Min <chanho.min@lge.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tero Kristo <t-kristo@ti.com>, Wei Xu <xuwei5@hisilicon.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Scott Branden <scott.branden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 6:45 PM Rob Herring <robh@kernel.org> wrote:
>
> The 'arm,armv8' compatible string is only for software models. It adds
> little value otherwise and is inconsistently used as a fallback on some
> platforms. Remove it from those platforms.

Applied on arm/dt, thanks!

      Arnd
