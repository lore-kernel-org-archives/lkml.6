Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6EEC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3584220664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3584220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeJaMCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:02:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36364 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeJaMCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:02:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id x2-v6so12358681eds.3;
        Tue, 30 Oct 2018 20:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVIo0MMj3kBXt29tM4Jx0le+jBJ2nJ6nhYOFsfILsJ0=;
        b=acJqTrlpc1YMHih1EC8WuMy8ps2WG2tvvKBUW00vkYiZJTJoQhb6TD5Ks4x/pneBlu
         U5q9VqQsnLGSknEPug1ZuB71HkmQTSSgtr+Z8t8GX+mx5vzzpsPhpLEJ/d2ScUbK1J0Q
         ZaJlneqViSUbyVW/YwlNHcM/orMWDsqa8OHmbevyCs9rWIYNCJPCqb8WDh4qGzIJmbJO
         WCEeCGpLLw0BMdWz3RLiYhh0ycdbT2PVjJWMBV1qrL6nxhCpjKCqtDuy5+Pq5Efwo1mq
         KauF07Cgaq7XzfpwGy0MJr230XkRrlsFMXSJBeOLIQmLolm6CLPnSRexvGB1K6kbqQd+
         7TrA==
X-Gm-Message-State: AGRZ1gLWfTAulPrCxJ3Jf2L/kioTtI2nLW4EAt+GRHHfEbgLeADJRVYb
        4z2MLhsiecbiWEVsEOKUYphLZip+DVk=
X-Google-Smtp-Source: AJdET5dI7AZKUTZc3HLcUNmeyhtrG77205n8NR8KvHUc1FiCIsqfQezIWrpinNrUcIedPjNAN4FcnQ==
X-Received: by 2002:a17:906:64c:: with SMTP id t12-v6mr473308ejb.113.1540955167625;
        Tue, 30 Oct 2018 20:06:07 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id k26-v6sm2768969ejv.59.2018.10.30.20.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 20:06:07 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id t10-v6so14772486wrn.10;
        Tue, 30 Oct 2018 20:06:06 -0700 (PDT)
X-Received: by 2002:adf:ecc6:: with SMTP id s6-v6mr948652wro.208.1540955166522;
 Tue, 30 Oct 2018 20:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-9-oskari@lemmela.net>
In-Reply-To: <20181023185330.10472-9-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 31 Oct 2018 11:05:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v66cM5NtCQnCBeoimXGmd2DDt+19Qq=xJjATHYEbR_UviQ@mail.gmail.com>
Message-ID: <CAGb2v66cM5NtCQnCBeoimXGmd2DDt+19Qq=xJjATHYEbR_UviQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] arm64: dts: allwinner: a64: pinebook: enable
 power supplies
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
> From: Vasily Khoruzhick <anarsoul@gmail.com>
>
> Pinebook has ACIN connector and 10000 mAh battery.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

You should have your own SoB following the author's when you resend other
people's patches. Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
