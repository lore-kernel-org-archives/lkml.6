Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF7C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B447F214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hz/eEePb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B447F214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbeLFC5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:57:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33445 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeLFC5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:57:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so20310777ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 18:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoGV4cHlFSsCqXr2TQJpja6bP8AgGtPeV4rCmYlaUPE=;
        b=Hz/eEePbgcFSrPv8YSLe0O2jC2z/79YjERgMKnwdUdh6BJ28pvu9vUm39Nk3vQL9/p
         egsmKQDVHoreTSDssYBty7BUQfePxd/pALYXbDjRrL2BybjjJ+DcDNiFYtIdazADDiK7
         pkcjxowYpAKqrpxAjhuswTSkyt3A0e8L8wvHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoGV4cHlFSsCqXr2TQJpja6bP8AgGtPeV4rCmYlaUPE=;
        b=CiMvcnDqMWSeZJFJf9V6oFA9tQmRiJwe7eJHMMcVlKaxwgBpbtvFlBTEY5wA/QD7i+
         IXM+8Ff5UB4iitPqoB8yDfvtwPlYWxvmtpOy8hb9IWKrAYMPQLTQgWohfqlM+D9ZJAlC
         ea+aittKzxsBKRmJl5zobZ2W2aBZHsF4PcP8TtumRKyMqvRiajKGqWCXpwF4/EssLumj
         JZ5Tui594eZ/Vp/Ci6Y1SHaC2PoUf6YIWsxJSwco5+J1sRdl6icqETrxsn7uf88tU3xA
         HeRkRaQ83XcUIcnAUWZ6sZYLNhwyneXpb90ialhPwQw+dlz4n4LLJrU1jxlrj3n716T4
         G/lg==
X-Gm-Message-State: AA+aEWYEr0ZsBJrsaHk7xexqCLTb0JSjTpYwaMTMI8l16/CkmCKsmeJd
        jd7OyEf3Oiw81eywVId6GSK/+HB+owEk74rwfYHiEg==
X-Google-Smtp-Source: AFSGD/X6S2yhg0JKz4YMrY4hsQOCFpnifhVcHqTVugz3Ezd2jnzJxxgtfvuGXUW6ogaMVxZww29zznCdbqEH/nnVWVo=
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr5949804ljb.52.1544065060863;
 Wed, 05 Dec 2018 18:57:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542185618.git.baolin.wang@linaro.org> <20181206001048.awfhmigouztqs6td@earth.universe>
In-Reply-To: <20181206001048.awfhmigouztqs6td@earth.universe>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 6 Dec 2018 10:57:31 +0800
Message-ID: <CAMz4kuJ1ghPs1Vg9tE9hMrC1GpuwruwfUV02szQ8_L=3ocsG-Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add new features for SC27XX fuel gauge driver
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Thu, 6 Dec 2018 at 08:10, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Wed, Nov 14, 2018 at 05:07:03PM +0800, Baolin Wang wrote:
> > This patch set adds some new features for SC27XX fuel gauge driver.
> >
> > 1. Read calibration data from eFuse device to calibrate fuel gauge.
> > 2. Add low voltage alarm to adjust the battery capacity in lower
> > voltage stage.
> > 3. Add power management interfaces
> > 4. Save last optimized battery capacity to be used as the initial
> > battery capacity if system is not first power-on.
> >
> > Baolin Wang (2):
> >   dt-bindings: power: supply: Add nvmem properties to calibrate FGU
> >   power: supply: sc27xx: Add fuel gauge calibration
> >
> > Yuanjiang Yu (3):
> >   power: supply: sc27xx: Add fuel gauge low voltage alarm
> >   power: supply: sc27xx: Add suspend/resume interfaces
> >   power: supply: sc27xx: Save last battery capacity
> >
> >  .../devicetree/bindings/power/supply/sc27xx-fg.txt |    4 +
> >  drivers/power/supply/sc27xx_fuel_gauge.c           |  453 +++++++++++++++++++-
> >  2 files changed, 444 insertions(+), 13 deletions(-)
>
> I applied patches 1-4 and skipped patch 5 due to pending changes.

I will send new version with addressing comments in patch 5. Thanks.

-- 
Baolin Wang
Best Regards
