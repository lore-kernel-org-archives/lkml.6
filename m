Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF3FC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AC521470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3W3Pd+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AC521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJDP2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:28:02 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52060 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbeJDP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:28:01 -0400
Received: by mail-it1-f194.google.com with SMTP id 74-v6so12044980itw.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8blL1VbBUwGLzRvV/kTjV0qM1m7oBSOsIs9hWIjH+I=;
        b=f3W3Pd+YnATFK+DJIpteMXCy7PUer2TSpz6b06h9r8nUvL9gSrnZ3P+H15u5AEPhTc
         9DilaeJj9jkE8pKMFrJZ0mbs6oesbFBmiK6VHwJN9Y0RfeOEt7us/pFg7+Rcw42NlSCM
         61dH2K8WA46jwjSrYcY7QjpCw7lQG8LR1+iZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8blL1VbBUwGLzRvV/kTjV0qM1m7oBSOsIs9hWIjH+I=;
        b=N1UpqxXMb+keEPm1oCj7bYKne3DwG/lDIfSunCv+k0Csp/vJcGq/XycXLI8mphQsuV
         /EDO2hFrTpz1XjzCrSUe6PLsr4uf6sL4JocMsFH8RGFIU95l04qM3FWUDEzsnNDVp5uw
         AJiycENatZBLMVK4M6gbdV60pztI3LyOBfsdgBL7Na22f3mOEQzo82HAuG6wKkCT+g2p
         g2pIprRmd1vB3kogCrWRy0TM3lErTi2tvmlsLmRQNHJ2Hmnref0CmZAhpZRO0B6tsCq6
         FtRbxVIgK2ZNC5tyFizPj4CknY799SKxofr41e2rHI9A3oWC0K4ybnhKnTi2RXWpkS9J
         Exng==
X-Gm-Message-State: ABuFfoiW+wj+6OO5AxfDiBS9qo2hf+3OMAFjwAUyejmlqJBuWT4yC81M
        ZO7PuNINc6tf8WkuoJ0uxCp5BGy69pJMhY4eAPzYsg==
X-Google-Smtp-Source: ACcGV60QsOM9dgXPkJ3MpRi/b5b5yr+vmNDa0gcPHRJ+WiUmp4RcyMfaBWB0Ek+go6RcMkd79sVzHbbfOITKZHHPVvI=
X-Received: by 2002:a02:3f5d:: with SMTP id c29-v6mr4240596jaf.107.1538642152759;
 Thu, 04 Oct 2018 01:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181003132212.12619-1-boris.brezillon@bootlin.com> <20181003132212.12619-11-boris.brezillon@bootlin.com>
In-Reply-To: <20181003132212.12619-11-boris.brezillon@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Oct 2018 10:35:41 +0200
Message-ID: <CACRpkdZz2eFmt-_Nx_Xp0sqsaLNE96m1qSCr1zvcAZjUNS9rsw@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] dt-bindings: gpio: Add bindings for Cadence I3C
 gpio expander
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        ext Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>, pgaj@cadence.com,
        Peter Rosin <peda@axentia.se>, mshettel@codeaurora.org,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 3:22 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> Document the Cadence I3C gpio expander bindings.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v8:
> - None

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
