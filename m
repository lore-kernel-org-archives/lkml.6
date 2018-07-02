Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BC8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C12B25DD2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6Q7R6a/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C12B25DD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeGBNpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:45:54 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40807 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeGBNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:45:51 -0400
Received: by mail-io0-f195.google.com with SMTP id t135-v6so14794018iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jRjxnP1VjNBh2JMbUYte+iCD6AV3eMohS9E3Aeigt4=;
        b=R6Q7R6a/pu6wPIOKoL2Jf0A7OH6m1kgyfwzHriPQUhQV/xY4lMd+LRHMtPxvXdQcnb
         HWRq8PdcCNMY7xth9sNbIic1fi/gKjIUt9D4GEy7uKAUx5P40iLNA4jsCqvh/MK/2axd
         d5kP2cn4aodkW+mLJojruuzl+ZB+/eek2NplU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jRjxnP1VjNBh2JMbUYte+iCD6AV3eMohS9E3Aeigt4=;
        b=k7JeLJIT+Wo0CWgNX5B6KmCtNyZQu5Sx/4VnnohftnsOqcdfiQg2oVpkqEmhxCNkbv
         oJXAoqXYB71AIRswaHd08xOtn/zUpEvsriXrDeIeneJCetAqEnjEte1WHRoJkuWrqqSe
         tRXK5cSEg5ocGOy+VJJ0XEJ4BDeppNSHEjFuHXYNLrYh5zh01liv6dXOmGIm4WrMHm8d
         J1iPcFw67TRgohtKqR2Ztv2tuyXW5JYn7I4s2gCv3wsXw/DPK2flAN8hbukTImieuTSa
         jlYsdlKo2CdvSD+4RCsFHpfhchmf0YRiZuC1KenpJH49sp0w9fD1tn5B40lA/z08klxB
         Jfng==
X-Gm-Message-State: APt69E287HmEDiscXp9YwFupTB7A2rGOcvRuCyqUlJCL0AuL6NCJuqaf
        wJe/MyRzSj3rH78xm0+29QERlBVai9zztCD6710Eug==
X-Google-Smtp-Source: AAOMgpcl70LiVbShlrhavbY6tRFYXjpgdcKW/gPWvuoLlyPvAMHu8apE0z1ZHC13aewvjuzj5T9OtnXbDgAMgaYllT8=
X-Received: by 2002:a6b:1902:: with SMTP id 2-v6mr20495267ioz.304.1530539150889;
 Mon, 02 Jul 2018 06:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <1530243004-10529-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1530243004-10529-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Jul 2018 15:45:39 +0200
Message-ID: <CACRpkdbbbbO-94i-ZTSunzuUQcJ8dQpuPHBYODrvdWQyuri7yw@mail.gmail.com>
Subject: Re: [PATCH] bindings: add clocks optional binding for imx gpio
To:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 5:34 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> Some i.MX SoCs have GPIO clock gate in CCM, accessing
> GPIO registers needs to enable GPIO clock gate first,
> i.MX GPIO driver will enable clock gate if there is
> clock property in GPIO node of dtb, add optional property
> to i.MX GPIO binding doc.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Make sense since the gpio-mxc driver already supports this :)

> +Optional properties:
> +- clocks: the clocks used by gpio bank

Should the text be "the clock for clocking the GPIO silicon"
I guess that is what it is. And singularis?

Does it hurt to give the clock a name? Like the common
"pclk" for peripheral clock or something similar that other
i.MX silicon uses?

Fabio: can we have your ACK on this too.

Yours,
Linus Walleij
