Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB4BC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A84C21A12
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A84C21A12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbeHGIix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:38:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45526 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeHGIix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:38:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16-v6so6325354edq.12;
        Mon, 06 Aug 2018 23:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jNLNuJ2Ex0TsyD7idG77K7I9k/3mbsKRGvdvyIc/OPs=;
        b=SagVx2XKKAHMHb2D9tWx/OfLZi0HoPb6PJGSLyDveoVB88/23uoPjOfQSiO8DhWqAA
         EPl1FaYKqon/XsoBFeV1xkttsjAsff1vTsfbHx08qrEHRn2z3D+ypk9Rf5Cx589vYL03
         OW2lbErSpjFJDtLpVa0laY1DIeDbmZTNG3ZkWNSbj2ohjd55CMhuyrTYL+Gjzita/eQY
         1/G/YC6BNVYKpSZE0xqSmHeYkEoYZdzwFgMua+2x8ig/FEwOPwHA5mBW8/He9QugoK6B
         RKIs3PQN9a0hhd1RheuRAaKeRtjryyOh6lb/WH9DjKz/Av8aYlzQra+eZk1qvGugvgn5
         /Hjg==
X-Gm-Message-State: AOUpUlGCqa3odf12Hhs5kSP582ASPJb+jZdrbVMfzMBY7CFTnwdnidKb
        QSngIU9IFYRVLLbJJxsIrrJYEMn4jJQ=
X-Google-Smtp-Source: AAOMgpcXIGsjkOOMBDbNL5hISgTEp7uf9RyK0pV8e3RHsOnIDH1CA4MbeC3lKJa2tlqQbv3qkazHDw==
X-Received: by 2002:a50:f501:: with SMTP id t1-v6mr21715699edm.199.1533623165430;
        Mon, 06 Aug 2018 23:26:05 -0700 (PDT)
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com. [74.125.82.53])
        by smtp.gmail.com with ESMTPSA id i15-v6sm461549ede.66.2018.08.06.23.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 23:26:05 -0700 (PDT)
Received: by mail-wm0-f53.google.com with SMTP id w24-v6so16672165wmc.1;
        Mon, 06 Aug 2018 23:26:05 -0700 (PDT)
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr719084wmc.58.1533623165008;
 Mon, 06 Aug 2018 23:26:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a101:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 23:25:44 -0700 (PDT)
In-Reply-To: <20180801094801.26627-1-embed3d@gmail.com>
References: <20180801094801.26627-1-embed3d@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 7 Aug 2018 14:25:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v66oe71CEtqkB2S-AYRzGnTQiJjVPUoRPkefd=9aqK+XbA@mail.gmail.com>
Message-ID: <CAGb2v66oe71CEtqkB2S-AYRzGnTQiJjVPUoRPkefd=9aqK+XbA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] IR support for A83T
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Russell King <linux@armlinux.org.uk>, sean@mess.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 5:47 PM, Philipp Rossak <embed3d@gmail.com> wrote:
> This patch series adds support for the sunxi A83T ir module and enhances
> the sunxi-ir driver. Right now the base clock frequency for the ir driver
> is a hard coded define and is set to 8 MHz.
> This works for the most common ir receivers. On the Sinovoip Bananapi M3
> the ir receiver needs, a 3 MHz base clock frequency to work without
> problems with this driver.
>
> This patch series adds support for an optinal property that makes it able
> to override the default base clock frequency and enables the ir interface
> on the a83t and the Bananapi M3.

Queued up for 4.20.

Thanks!
