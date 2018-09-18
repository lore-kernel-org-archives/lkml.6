Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5910ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFDB21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXL9979S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFDB21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbeISA3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbeISA3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:29:13 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE712150F;
        Tue, 18 Sep 2018 18:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537296917;
        bh=1UAUuPG23woTP1GzfubSujcN8HY2LECS7paKjmCXFZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CXL9979S0pfugD6ZxPH0qUPkgJDkK5oOtEQ6SRK5A3YsyXT9stLfztQI/Ed/7rNt2
         IIX6Ns4G5E2ysMCaXrhHviVgSrrUMSvJDlWDabSKnc9lyGSnk1tuYJ1/WxORI71B01
         EMOzltTWihBBStI+JbILx08F6RDAtsktijEpNSac=
Received: by mail-qk1-f176.google.com with SMTP id n3-v6so1140639qkn.8;
        Tue, 18 Sep 2018 11:55:16 -0700 (PDT)
X-Gm-Message-State: APzg51CbgosLnLI+AhoKBxQHEgdGLXya2p99i8isIkEgaSCrIJY1Hdjw
        g3HUt7sde+Gg5NH8laMRszze1xz/D/y6wu0Ysw==
X-Google-Smtp-Source: ANB0Vdb6nvNso2oveAQuhM//DVWoZAYsyw07DNU8Fo+BdI2SkXbrkeCj4TUamRgvfLfKDG3EsR51sWr35H6lijOPv4Q=
X-Received: by 2002:a37:bec4:: with SMTP id o187-v6mr21197700qkf.326.1537296916057;
 Tue, 18 Sep 2018 11:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180913202828.15372-1-robh@kernel.org> <20180913202828.15372-3-robh@kernel.org>
 <f9684222-fae0-c305-d48a-be77ebb985a3@gmail.com>
In-Reply-To: <f9684222-fae0-c305-d48a-be77ebb985a3@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Sep 2018 11:55:04 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLTcLVGCmjTMi8GojomP=VbFQ5EqKcGnOPo=Wwh5Lc_mw@mail.gmail.com>
Message-ID: <CAL_JsqLTcLVGCmjTMi8GojomP=VbFQ5EqKcGnOPo=Wwh5Lc_mw@mail.gmail.com>
Subject: Re: [PATCH 3/3] scripts/dtc: Update to upstream version v1.4.7-14-gc86da84d30e4
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 2:32 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 09/13/18 13:28, Rob Herring wrote:
> > Major changes are I2C and SPI bus checks, YAML output format (for
> > future validation), some new libfdt functions, and more libfdt
> > validation of dtbs.
> >
> > The YAML addition adds an optional dependency on libyaml. pkg-config is
> > used to test for it and pkg-config became a kconfig dependency in 4.18.
>
> For Ubuntu, the libyaml dependency is provided by the packages:
>
>    libyaml-0-2
>    libyaml-dev

Yes, but as it is not yet required by anything in the kernel I don't
think that needs to be documented yet. Also, offhand, I don't think we
generally document in the kernel distro specifics like package names.

Rob
