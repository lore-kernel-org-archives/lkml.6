Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A0FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EF52082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EF52082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeLJGlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:41:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34438 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJGlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:41:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so8518302ede.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atH8zS5OgaZST1pVXvLr4RfgGWyoL9o/JLLsFLaIbck=;
        b=gL/cy54l/YVscTjOc2Dpf5Sc9dBWDKJwbyi36+Oxd2ovVpWgC66fWdYTVC0UmyfLcv
         xRyARPyFQiILeZP4TgZdl0YP6626CGPHbSBKqAiXjjSqLTL1GWgkGISrpDlNzwHew8eb
         igAkF3mtHJePq/KANLH0ZV6fUGSrPlIS8meZvLhk4uuR/qltwz7ozUHWyeZBwhMNx1Zg
         K+PFDxbKGuSJskd+mvxHG2mY4N21vP9LOO+73cyNC9TCxElE1mG/97HmZA0nPzeGAB//
         /YGxL0CiCvKHF5TTDrQvUixuNquSh+jI1bmZH8wkoLAjBtkbh2ISKt0aJ2hn2yhBZsn4
         S34g==
X-Gm-Message-State: AA+aEWau8taWew1XKmxfUZxfs0xPglJfvmsCNutd11mkjt/8oxBv6K83
        FmpJmfRgxQDNEHUX9fk5RkQ5KgYIozw=
X-Google-Smtp-Source: AFSGD/UkIBsC/Isz98vxZgMoXtpAbaHFYGj7R1+H/Xn40XfNx8oR04HMdXFGMQuM/PmhPGCvH2RfaA==
X-Received: by 2002:aa7:d487:: with SMTP id b7mr10032714edr.256.1544424111177;
        Sun, 09 Dec 2018 22:41:51 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id c11-v6sm1650028ejz.70.2018.12.09.22.41.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 22:41:50 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id a62so2242131wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:41:50 -0800 (PST)
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr9317190wmd.111.1544424110078;
 Sun, 09 Dec 2018 22:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20181208175847.32068-1-oskari@lemmela.net> <20181208175847.32068-3-oskari@lemmela.net>
 <20181210063534.GS26661@dell>
In-Reply-To: <20181210063534.GS26661@dell>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 10 Dec 2018 14:41:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v6797iHnQ_JxU6yheO1YSOeEgVcXMbXAgnsroE8PaJ=YJw@mail.gmail.com>
Message-ID: <CAGb2v6797iHnQ_JxU6yheO1YSOeEgVcXMbXAgnsroE8PaJ=YJw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] mfd: axp20x: Add supported cells for AXP803
To:     Lee Jones <lee.jones@linaro.org>
Cc:     oskari@lemmela.net, Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 2:35 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Sat, 08 Dec 2018, Oskari Lemmela wrote:
>
> > Parts of the AXP803 are compatible with their counterparts on the AXP813.
> > These include the GPIO, ADC, AC and battery power supplies.
> >
> > Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> I'm happy to fix this, but ...
>
> Can you explain these tags for me please?
>
> Specifically the last one.
>
> Why does Chen-Yu Tsai have an SoB there?

I picked his patch to rebase off the previous one, and reworked the ordering.
I then pushed it onto GitHub [1], but didn't get around to sending it to the
mailing lists. Oskari said on IRC that he would handle it.

I'm not sure what would be appropriate here though? Oskari's first SoB should
be kept, since he's the original author. Maybe he should've added his SoB
again as the final entry? Either way I suppose it would be confusing without
any explanation.

ChenYu

[1] https://github.com/wens/linux/commit/951afe2dc32086174ab07a1a997d748f69bf5bf2
[2] https://freenode.irclog.whitequark.org/linux-sunxi/2018-12-08#23644905;
