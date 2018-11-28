Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B1FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3DC20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3DC20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeK1Up3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:45:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37012 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbeK1Up3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:45:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so21522357edb.4;
        Wed, 28 Nov 2018 01:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8L73hWa2Rbe1pct5sx5N8Rgy222BMSrNaMLd1w8jBk=;
        b=azPpBDV0WOgrPdMJalgrNPv+9bN+OAMAaop0ejEgvt6qZuSNuv8mb6n5/VXYkjj0Pa
         ULmO8o8gwsUOMBohhxJKJreafT/Ojg3ghv9S4LwMXLU393vTfAEuo1LB9ClSu7Ssxn4K
         WwJYolvk1urR6LRO/qj/IDQyFL67X5YuVZitQLg+sg3R5DFxMfgGX8ZzMfNzCAXAAkcX
         P7qdr5S+tj2X5T7TEt92+MzPDQNtUL4sNMaHALY4C0V6t3JHPa1Lg9X1e2qabPSlu5b5
         z8zJMlDJA6YIsUsYpY1z4vECd6gRcWS2jWMQ1c1XZn3urLEkGovQyKTKAgAC4QeW+hhY
         kalQ==
X-Gm-Message-State: AGRZ1gI7AUDCSLtXQ8PIPFS1aBGhSmEfjuOg/udjFbBJnKV/Y1jJ6mPx
        +yMuEV++Z9n5Meae7UB0hbZEuzyCMZo=
X-Google-Smtp-Source: AJdET5eoXI+TAD2glE4h8i7pchjrx+iQlmInYtXngob9j4ILhM0IlpemgDbTrHagvNnp4Kyzc8R5VQ==
X-Received: by 2002:a17:906:7a9c:: with SMTP id f28-v6mr26267704ejo.135.1543398264810;
        Wed, 28 Nov 2018 01:44:24 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id p16-v6sm978743eju.73.2018.11.28.01.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 01:44:24 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id g67so1851479wmd.2;
        Wed, 28 Nov 2018 01:44:24 -0800 (PST)
X-Received: by 2002:a1c:f611:: with SMTP id w17mr2145389wmc.116.1543398263655;
 Wed, 28 Nov 2018 01:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20181128093013.24442-1-wens@csie.org> <20181128093013.24442-9-wens@csie.org>
In-Reply-To: <20181128093013.24442-9-wens@csie.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 28 Nov 2018 17:44:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v669CSQLq+jQPkzn0MH3Avt2tf0vEA4E29epeXrQA4=yww@mail.gmail.com>
Message-ID: <CAGb2v669CSQLq+jQPkzn0MH3Avt2tf0vEA4E29epeXrQA4=yww@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 07/15] rtc: sun6i: Add support for all known variants
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        alexandre.belloni@bootlin.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 5:30 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> There are different variants to the RTC hardware first seen on sun6i
> (A31). The differences we care about in this driver are the clock rate
> for the internal oscillator, prescalers, and the presence of an external
> clock output.
>
> This patch adds support for all the known base compatibles using the
> variants data structure previously introduced.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

This one was from a prior WiP version. Please ignore it.

ChenYu
