Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FB8C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBBB21477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cvp9YDIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBBB21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJDPyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:54:39 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39890 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeJDPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:54:38 -0400
Received: by mail-it1-f194.google.com with SMTP id w200-v6so12973150itc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nd4YaaiCa8aW22lqtr67fuZpOf0h0ZYxIkjTip6oSO4=;
        b=Cvp9YDIyz44xKpCKgKqeIBbknIaWbKCIAcVeFotnST5lY6Z6OiYN33VDVch1HV2hQe
         IifCXaiWUXf3U+Ucio66PakjG8PG6oVwlBfjfjvUtowB8usLdFl/ykzHRCTT/A/Tkgr7
         HJFSxAbgeFp4BGKRe25f3h60WREcXpb0BtXCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nd4YaaiCa8aW22lqtr67fuZpOf0h0ZYxIkjTip6oSO4=;
        b=QHvI96sQpu0ls5/O2PoObTCPwfEPbs2TV+1NHQJcLGlwMmZYlZGOZIAR0XPcFK4g8T
         Plid7vtfFh1yHXgBqpP1DMLXaa4JKLRRqiGcyI3STlAcDn99NvcL5tRUmf+LVaTdYkML
         4QyUjyg8bJhvyEjLBieMfwi2CFntkBoYebAVpJX6g1Invg+c1ZorFmvv6L89dUqOI+tA
         b7bWQJEJwxLCtKYCi9shi6Ff0swH331Bn4WMWFwN0ybkTCiEulKBBZEEeXtxXJbfBgYn
         eDvbi0iPK49+gSEdpP65EwfpkHiXfn3hz6UzRlvGhd2+wQS5R7kdkdCgxUdqimtIeiN5
         iGqQ==
X-Gm-Message-State: ABuFfogm5eK4wXNLuMbKNufgCq5y/7Tmkdy/t/UzIdBo4WottjLydm/T
        R2xOs+iDSAwdEflC9l6SVngA/8LOhCvE5PqObHXr6GFW
X-Google-Smtp-Source: ACcGV60oBYCWOo79QqqDVuzosBF0pzxPv1+jtACWcCoEAvgFzTyn9W3JnexxkJgQDHQQhtiyN7nW07wbiuhSO5oTvVs=
X-Received: by 2002:a05:660c:45:: with SMTP id p5mr3250528itk.62.1538643742235;
 Thu, 04 Oct 2018 02:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <1147be600733a1bcde194f7df61866019f34a531.1538504729.git.leonard.crestez@nxp.com>
 <CACRpkdajdjLUEwv8ABSBuy4dVMXqrUfxVDmu55aEiRAK877urQ@mail.gmail.com> <234ccbfccc26701bd0b9fd9cf2ffb5ad2414adec.camel@nxp.com>
In-Reply-To: <234ccbfccc26701bd0b9fd9cf2ffb5ad2414adec.camel@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Oct 2018 11:02:10 +0200
Message-ID: <CACRpkda_Jhoiq12wtUA9s1hfsypfVztgmPQWCgmdOZE-Ct0CUg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Fix enet phy regulator
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 1:49 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> On Tue, 2018-10-02 at 21:56 +0200, Linus Walleij wrote:

> > I guess I could hack to make "gpios" be ignored by the
> > regulator GPIO quirks in gpiolib, but I take it you probably
> > prefer to fix up the real issue like this.
>
> Maybe you could document in fixed-regulator bindings that it now
> supports the standard "gpios" property as well? There still seems to be
> a restriction that the list must contain a single element.

OK you're right, fixing the docs to be more standards compliant
is indeed better.

> Anyway, what my patch fixes is a board-specific issue which exists even
> outside your patch: the enet phy regulator never worked as expected.

Indeed.

Yours,
Linus Walleij
