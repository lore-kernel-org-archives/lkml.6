Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856ACC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2377B20854
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="HRjY7gkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2377B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeKKEJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:09:23 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:33805 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbeKKEJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:09:22 -0500
Received: by mail-it1-f177.google.com with SMTP id t189-v6so7146532itf.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 10:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUqP3ndube11ugshf3TvxRDPaowUqnSqci8JMN30TIM=;
        b=HRjY7gkTjxF728ZPWqiLrDQsncu9eOpdvyk6eR3mGK0FYejO1kt1l8H8Zd8whpCAuA
         r5tmIp9lV6Cnq2RTUodGnMNAssUVwl/D2pTfWbUlapcJTTPV8w95u67sZdc9f5kxRO3C
         KPkufnA8JY3FsKzfkZCUyWxPSzHkoA63135qdgYjBuRX936gkwkzt/qxHnFFWPMSqSyw
         ytd2KmVkviYwClE5bI7LDhVgpzWS4xempRkPbXEun+zT3LZu/tI7KaFqfO6WlFdFbREz
         GNZ/im0CgO2ZYd97FzqPQsPIQOONJIAr6RrtdZEHaD1GjjGcreH5x+wVLCvwP24BbVZe
         zB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUqP3ndube11ugshf3TvxRDPaowUqnSqci8JMN30TIM=;
        b=nAq7k8tuhPAzTktoaWCUL8JK69AptuloDaZ80HhlKhwmEy4cAUvghlvzlNU42IplfA
         cEr5/eOu0WKopFvyIs8CqQyK3umVRD2HhqtZx1+4jND3yHfbQgmg3+dxoZxDb2dSBeeI
         rIRzw3Uv6dvMBSzwol/ULt+wFGsgJ5cKOoNcxVlvHdY0qLHi4nH0EVcJ7C8t2Q164jWs
         gL2J9zXDdNNuSZ0VW5D/Q9v/6DyMHkoRypYA/ul1WIi9xSJM4H/kcvnGnAz+bu/5z4js
         Uen7ApaPuT2du4JPduoEMM9xbxtSCeZIRObPtmnOXfZlPjLWGsXwIdkh7giFHwPiT3JW
         Qmsw==
X-Gm-Message-State: AGRZ1gIDhOaOLJeEkQQpGEqmfbL3sh96VcB00hQMYlO/mATmixt9SQ8J
        xHKc6wHgNGTQ5MSnctF+TEznAaZYS7QA3UpCGPN2XQ==
X-Google-Smtp-Source: AJdET5c5X+EreuJ9/gFazZA3YXtoDlvmOjjYDAxxOOpWg9ZtTf7N7l2sdVQfhVx9ES24bdAHbQIYMaDsgLL56GpaK/I=
X-Received: by 2002:a24:3a4f:: with SMTP id m76-v6mr6742151itm.122.1541874208545;
 Sat, 10 Nov 2018 10:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
 <20181109220044.24843-6-matheus.bernardino@usp.br> <CAOMZO5DVr7TBoNtB7Bwjv1rpaCdOyg8+iU=iCwBRjSD4iWeBUw@mail.gmail.com>
 <CAHd-oW4wo7fShsNMf7a1udnCepUL+ok+Gk7jzVoEUEUjaPCXpw@mail.gmail.com>
 <20181110002018.GA3938@kroah.com> <CAHd-oW4uWFco9qcVwMphetXE9LK4YJQmDAbBUPBEBCT3UHZSkA@mail.gmail.com>
 <CAOMZO5Bx-aMEZ9Wn4+3E_Y6QukkkKO1W_67P4jd9kbOOQaWOvg@mail.gmail.com>
In-Reply-To: <CAOMZO5Bx-aMEZ9Wn4+3E_Y6QukkkKO1W_67P4jd9kbOOQaWOvg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 10 Nov 2018 16:23:17 -0200
Message-ID: <CAHd-oW5HdNMBjLW1FRqeMzGM=nf0-o+6SBeyGs6uNNSJtUDgxg@mail.gmail.com>
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add SPDX license identifier
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Victor Colombo <victorcolombo@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 11:23 AM Fabio Estevam <festevam@gmail.com> wrote:>
> Hi Matheus,
>
> On Fri, Nov 9, 2018 at 10:27 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
>
> > Got it, thanks for the explanation! I'll correct this in v2.
>
> One more suggestion: in v2 you could also consider to remove the legal
> text that says GPL v2, as you are adding the SPDX tag.

Okay, I'll do it! Thanks again for the review and suggestions!

Matheus
