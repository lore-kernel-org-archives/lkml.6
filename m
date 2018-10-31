Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E93CC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322C420664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322C420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeJaMBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:01:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44031 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbeJaMBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:01:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so12342982eds.10;
        Tue, 30 Oct 2018 20:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kinJVyv/a2nqy6YbZQfjLuU2cHZLi482BYxu0jIYVQ=;
        b=YObiSpJM2O9stl6PTj7V+z6KHpjETLpexjm8NwLgPrvgGjrb175VtUGXr09y3KFgLh
         iEXUdkNApvEFSn9GcfTuhRHcG4clhJ3hcBs3NzcNc/22AaqBzqEFuwvq7GcKxiCBaTFd
         qPdDrc83xO4pIGUuPnZYEkd5/NyMP4ukBtf3C9kwB7vFmYSqLHFodKfYZrBkwqCTowhA
         UUILH3yqLqndfoA6jZvMPF7O9a/qJ6JLjdWL4QFc5KXdFLywabM1nQiVd7t5FM2kN3ov
         qEH4VHUNFXTHw81ohclzDZm/V6fP6MOxtNdaoMJ+0BIBI2ufX1TqtV1G80lGd9m2yiwQ
         madA==
X-Gm-Message-State: AGRZ1gJOjwY2J7MWISbwNkLOnaEQ1AWkwminbhtthhyM6mIPN6ikta7t
        qgFNsildhOFo1WflnGo6LF6RCZwhDr0=
X-Google-Smtp-Source: AJdET5esK+WCgPZ9LalN07I3Pszyh6AvsOv9XIavu5NBO9T6xB3RcwyJP8FOBvVN/AzlJppM2UBO8g==
X-Received: by 2002:a17:906:958c:: with SMTP id r12-v6mr471059ejx.125.1540955093877;
        Tue, 30 Oct 2018 20:04:53 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id x15-v6sm8111131edm.26.2018.10.30.20.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 20:04:52 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id v24-v6so3831649wmh.3;
        Tue, 30 Oct 2018 20:04:51 -0700 (PDT)
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr841736wme.8.1540955091416;
 Tue, 30 Oct 2018 20:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-7-oskari@lemmela.net>
In-Reply-To: <20181023185330.10472-7-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 31 Oct 2018 11:04:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ZPHVcruMVhuo_SiFe-z0QsS-w7AT+_0zco7K36zp-8w@mail.gmail.com>
Message-ID: <CAGb2v64ZPHVcruMVhuo_SiFe-z0QsS-w7AT+_0zco7K36zp-8w@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] arm64: dts: allwinner: axp803: add AC and
 battery power supplies
To:     oskari@lemmela.net
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 2:54 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> Parts of the AXP803 are compatible with their counterparts on the AXP813.
> Add DT nodes ADC, GPIO, AC and battery power supplies.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
