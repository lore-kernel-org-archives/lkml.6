Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881B5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BD1208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFcw4XOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BD1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLGS6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:58:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36126 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGS6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:58:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so4215001oix.3;
        Fri, 07 Dec 2018 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uqBZCPjpNkexhrwjTJS+KeBj4us7H+/UVMQZ3/Fjv38=;
        b=QFcw4XOYfPDdzrpw2tsVkTkNGIJDf32n9DHxhEFr9AQA3lw/bp/FDfWsIRoALLK83p
         Peal6XfNYxpIzMWF1X4W9IO95sVhr5bnsGe3Mf7oUw3V3KtX849Nt05Jcl0unwgzwQZ0
         AWXwGZhoyc9bgrJAXH5jPKK1VBxc/MY3Re/TZDcyDGBwruspjKXZqzBt3NALU2PY4Uqa
         Pqf3JyT5Cvku2iKoozdQgk+934HV15l4wwwqbCg/n8ESp4UdueEtBQDIkLEugraH0B1N
         e3VyQSCxygQSq15s1u67GBFA8YjWaeU2kW0CjXu5GAwBUCcz6auWqoT2F8qRVBg9cEQY
         QyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uqBZCPjpNkexhrwjTJS+KeBj4us7H+/UVMQZ3/Fjv38=;
        b=TRj5uW9pufIuMxt9HHT/J5cdea+eeGBoaN4pORSOq7fU2g7uKWCloCghiNtymD9qKm
         njBe8hYUEu5rZCTD2QDETAYbOyC4zsja7TFE7V/eoEaL3lSg7e37Bo97vGDZxlTnxxdV
         JhLmwoHSz31SdTLBiuVa2GKc/b5xHQAuXkjOgbXW+KV+FBuKlhQrUIdV811F+Pokqfxq
         1vmG+wiZ4bBu1Jqi1aQe+tYWzgnjhHl2VYYX81h1CqNVN/GESqnDfx9B5pAVfXux0PPS
         4wVNDoLf/7oupLcKjQMeIixnDuNVkssC+S52JNU9HodDq6Sc0fYNlfWH9twh1M3MCMRw
         89gA==
X-Gm-Message-State: AA+aEWZRssWg5Dik/fr/rYICkiNYqtLRvqnADGKr7oza1a5QGQNvBomW
        kEwLsJkfZwKXoM32NOfEN6nFG8rs713iRyROXmwesA==
X-Google-Smtp-Source: AFSGD/WiWGXnBIRXCBpLzZcg1Dnyo3MhDmfO3spE34fENs/5D6oFkxLCYSdDMvUyRwLCyDZML2tixIVbxJDA/znoJhw=
X-Received: by 2002:aca:6545:: with SMTP id j5mr1967927oiw.70.1544209125845;
 Fri, 07 Dec 2018 10:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20181120175211.3913-1-oskari@lemmela.net> <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
In-Reply-To: <20181207164011.GI26661@dell>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 7 Dec 2018 10:58:22 -0800
Message-ID: <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Oskari Lemmela <oskari@lemmela.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        quentin.schulz@bootlin.com, linux-pm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 8:40 AM Lee Jones <lee.jones@linaro.org> wrote:

> My OCD-dar is going crazy.
>
> Why haven't you used the same alignment as is already there?
>
> If it starts to run over 80-chars then bring the others back.
>
> Also why is there a single liner shoved in the middle of the
> multi-line entries?  Please move the singles to the top or the
> bottom.

Hi Lee,

Could you please reformat it in the way that makes your OCD-dar happy?
It would be really nice to get
AC and battery support for APX8x3 merged -- it'll make Pinebook and
Teres-I pretty well supported by mainline kernel.

Thanks,
Vasily

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
