Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2C7C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1610920866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1610920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeJPMGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:06:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46757 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbeJPMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:06:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so19876532edg.13;
        Mon, 15 Oct 2018 21:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Er564hTXslHteqRZjHBPt3rebRF6uCHU3efgUONFU5E=;
        b=jOW7hoglxsTlDIL4mn86nKIugcBUrgn3JqkFd18P9O8E3iHNb6KiSWAVdZ87mccinY
         bjmYj2EW63/0AtPenRpkN9OgNQpYAqEH6CKg2XlfvOg6s8iysaZBZ0OcVwXP1EIqVoSZ
         zHrr92eP+d7ueSArsO0k5OleBbXrW7r7YaCY77IYmSQRE35zrhxSCDF51+635Kq6lPL9
         WPCEsjCQ8YKe/uli1w5wML3mksjKC4YDmf/YmuZIsPinU0TnlDJWeW+pvorW76nCVtRP
         8oQX4VSfQVlnbCiqZhcAEzzYiA96YcIHxmC3aNSNv8IFGEG0OOSNBLSx1nTGFAE7YrTs
         LoGQ==
X-Gm-Message-State: ABuFfogonvDVDDWQYoIgi1d2vvy7FEfoJRUhOgY2J0C9JGJNOfn6dxmN
        Xn/UIPoJ+t2kvNws/ARAaEiISiglmEg=
X-Google-Smtp-Source: ACcGV60i1DjRR7450FkfA+aVhDxgb7AxBxgMMrzh8ArTTZ+rwvaGuReP2HH+rl/aZIADH5RaIvmv6A==
X-Received: by 2002:a17:906:4747:: with SMTP id j7-v6mr21619613ejs.216.1539663470131;
        Mon, 15 Oct 2018 21:17:50 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id e10-v6sm2626968ejf.28.2018.10.15.21.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 21:17:50 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id a8-v6so21608037wmf.1;
        Mon, 15 Oct 2018 21:17:49 -0700 (PDT)
X-Received: by 2002:a1c:1d6:: with SMTP id 205-v6mr15484046wmb.151.1539663469187;
 Mon, 15 Oct 2018 21:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181013080848.29894-1-oskari@lemmela.net> <20181013080848.29894-8-oskari@lemmela.net>
In-Reply-To: <20181013080848.29894-8-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 16 Oct 2018 12:17:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v66aJUYOkZL=b5TfnvLsbLk_mU8AQtR3BSBRM-49rh2yOA@mail.gmail.com>
Message-ID: <CAGb2v66aJUYOkZL=b5TfnvLsbLk_mU8AQtR3BSBRM-49rh2yOA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] mfd: axp20x: Add supported cells for AXP803
To:     oskari@lemmela.net
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:09 PM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 is compatible with AXP813.
> Adding cells for GPIO, ADC, AC and battery power supplies.

They are not _completely_ compatible. A better way to phrase this would be:

Parts of the AXP803 are compatible with their counterparts on the AXP813.
These include the GPIO, ADC, AC and battery power supplies.

> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
