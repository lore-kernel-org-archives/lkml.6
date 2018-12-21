Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B466C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90E321917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N73YiC2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbeLUKsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:48:18 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45081 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731433AbeLUKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:48:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so4299454ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEINN3mANyAktaPqVwcLrQGpdVnfAL3aH2Fc5Id1ldM=;
        b=N73YiC2+QCy90EvZ13CTXm6b3OniH0/5BYxttgGTRyO82foZEgx8VOGkgp1rcdxdOB
         XGAzjcXAfxBsyFeLEtR0ACTWTTujc+HLuc1hWHdjnRK8xH2gt/BHIA9dZfjJgCuwVbHe
         Z+ionqnUdA3obVKNAjYhcbmBIY8tBiqzs8XqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEINN3mANyAktaPqVwcLrQGpdVnfAL3aH2Fc5Id1ldM=;
        b=Yg3ZwzG2WWzSE+rNdZ1KAqkMfAD61CI5jWXUFnct0m97zN2HW+XokRGPw29zChjQT9
         9UzkI3G95dcvI6Zqj5yvs38S+41mYew39I2m7nlAUcw8xDfu0abI71FbaVn3VrWq1Jee
         N4xnJKKupMyj/DL2BiTnjgznQjtV4EzgdP7W/IaPr4UEPiReFuyrBXSLR/tkMAVUPtS4
         fINv9l1sGo28D08utVz94DnUvjwNyeZ0TFMlf4H9ktgzeh1iScEaHYFoGteGlsOmbC9I
         b1xEWDkzbx6Aj3/UyngJc92z1lkWIUYHlasMTAs86iwEzTqfu0kXPswQEZZGDr1RLf0F
         ObwQ==
X-Gm-Message-State: AJcUukebGpqA5oiUii0hlCbM+uLXzpn2p07jmueQJHSFZpt0u7E2vHTW
        0ehzZHRe4OsizzOM8Qt38obxBogliHEJJselbI/GUA==
X-Google-Smtp-Source: ALg8bN6IxmGSWfBzaDNlmOVuOGcqS6B1uqUDoZWGaNzy6p3rt2YlhSf5lOPJrwh4hG+Nr1ORgZalVwkYOOy5HdkFMVk=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr1262057ljj.9.1545389296412;
 Fri, 21 Dec 2018 02:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20181218200619.8281-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20181218200619.8281-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:48:04 +0100
Message-ID: <CACRpkdagN74C_j1Fg5_fOPANCjLi3Xfxhp=0yTgkFKZ0iGqP2w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: add MSCC Jaguar2 support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 9:06 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Jaguar2 has the same register layout as Ocelot but it has 64 pins, meaning
> that there are 2 registers instead of one.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Patch applied.

You know what you're doing and the DT binding update is completely
uncontroversial.

Yours,
Linus Walleij
