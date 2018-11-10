Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5DAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 13:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1128D20818
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 13:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQJulcy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1128D20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeKJXIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 18:08:02 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:33939 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbeKJXIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 18:08:02 -0500
Received: by mail-oi1-f176.google.com with SMTP id i138-v6so3783431oib.1;
        Sat, 10 Nov 2018 05:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xyv11LBZfnLnE6qlFZgsd4I4EIQbqUk0eUUVIrH9/E0=;
        b=TQJulcy84V5JSqP+2EZsS2oWgphoA6aAkxyy9f4Qjc9V+gi/hfA5XZ6semAD3NvTix
         UclLTObTaxYt52FSOgF3DNtM7ZQi5iPF3nJ37KRpymgsRBBWyV0H3+ky1Zba3iS9pZ3j
         RKJd6JqLOiRpex39K+C+q2fssfDGH5suUcFNTDeTR2A5eHJRBT9Uf2UiRhDY3bwXicrE
         Td/ujQso+dz4r40Z2me0TdJLoIGl/SFTLzR6bdaGuN7CD7fy5KU61qN+PL0f6539rE8f
         ZXRueop5xNrGhxcgEjfEkBZloMscGvAQo/kIhbE+opjk6TyOGdyGFwEMqrodDPfsnjAv
         E4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xyv11LBZfnLnE6qlFZgsd4I4EIQbqUk0eUUVIrH9/E0=;
        b=n6uyKgBNHQWgDm2j2X7cDj4eP2ALeKyGbA3DzNIa27Tl36HK4nBACyer334tOcWyp6
         LgWg0554xPOStaz+NLxtwxqPYeFqV2VQkpkDJyQAr4QU6bGIaQ73HcR10xxGxvsBxNOy
         wocTagQrsMYb2/T4aaS4Dm//7oLcZJn5xcUu9IYyCoFBMU4DWk3kw0Zen15aITnijOk4
         PLCvPutKMlf+WtZN4iGwAveLNhbcrPc27Kp1Ff74bDBVn4WcyCGKXR9XZ9BQ6WY8sLn6
         y4xkOBDfcxrlP2p9eL0CN70K/j6Wbrj/yKtTJxYG76C6msP3rK3CIjqCPj/2PztWX0fj
         jpqQ==
X-Gm-Message-State: AGRZ1gKqnzHARIZsVchlzXUz/CdHkWF4Kdu4f9WaV4pl9yHDdlEWTy1F
        3tYYNx3tklwLVvJsdrH0Xsl7eiCbjiprO26ToyA=
X-Google-Smtp-Source: AJdET5fpGfAuNW8W0PWrDHAlGGlv70ttNCzFvTA987ud8+m9Qu2s62HZkPe9TBbDWIr1ijq7tuI0OWp0S7a8Nr1EzWw=
X-Received: by 2002:aca:4d14:: with SMTP id a20-v6mr6741780oib.43.1541856181568;
 Sat, 10 Nov 2018 05:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
 <20181109220044.24843-6-matheus.bernardino@usp.br> <CAOMZO5DVr7TBoNtB7Bwjv1rpaCdOyg8+iU=iCwBRjSD4iWeBUw@mail.gmail.com>
 <CAHd-oW4wo7fShsNMf7a1udnCepUL+ok+Gk7jzVoEUEUjaPCXpw@mail.gmail.com>
 <20181110002018.GA3938@kroah.com> <CAHd-oW4uWFco9qcVwMphetXE9LK4YJQmDAbBUPBEBCT3UHZSkA@mail.gmail.com>
In-Reply-To: <CAHd-oW4uWFco9qcVwMphetXE9LK4YJQmDAbBUPBEBCT3UHZSkA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 10 Nov 2018 11:22:56 -0200
Message-ID: <CAOMZO5Bx-aMEZ9Wn4+3E_Y6QukkkKO1W_67P4jd9kbOOQaWOvg@mail.gmail.com>
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add SPDX license identifier
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        alexandru.ardelean@analog.com,
        Victor Colombo <victorcolombo@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

On Fri, Nov 9, 2018 at 10:27 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:

> Got it, thanks for the explanation! I'll correct this in v2.

One more suggestion: in v2 you could also consider to remove the legal
text that says GPL v2, as you are adding the SPDX tag.
