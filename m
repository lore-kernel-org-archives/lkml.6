Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D57DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC762081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC762081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbeKFBcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:32:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46678 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeKFBcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:32:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8-v6so7922174edt.13;
        Mon, 05 Nov 2018 08:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9yT1+gq5I+uViHyHy4go/m1gTbPDHe/rA3DyiFVVwY=;
        b=LoupSChtgyChsEYrDv6mHbHuGNJ50/z1+KQ5BJd3R/EsnJKp2GYlBfvTWUPrfRnlh7
         MbpjWEKq4uD7lo3IgaoUBtVN9IhqzNrRX5h7rMWQakc1qVL8gGwQpBcG1g6y18UnpRBk
         aUUH2MEP2oF3PeXoIk+AvibOjMS4+ui6np3YMVYAJUEIt3a9ckkNVZkgz834OQd+f9Ao
         KjhgkIO39tN3SQe5M6OAIeU7JLsiTeoxdrSQXJuEP3IcRpEYnMAV30bG0E3f2GUZHB8U
         7LVoFwGZ1Pb/56vG/kIr3kBfldtY6kM/cxu5U1v9aGcP0HfRN/X0ZFbgmxpOtkrIVslp
         9aSA==
X-Gm-Message-State: AGRZ1gL6PZYf9XwAd0Us+k+f6cBHtdgw+a6cDzhOxLzsGwRvv7qCIbo4
        yde5Ul1V5hd0WLGaWCz+ZUZtoDsJhB8=
X-Google-Smtp-Source: AJdET5dzA0SFS8GYuK5tJyeNybAxMNScrHo4g9EJ6cQYZ1zEkzZ9Q5M8nx18BqTJgX9mDB6qgaKNBQ==
X-Received: by 2002:a17:906:16ca:: with SMTP id t10-v6mr14528555ejd.200.1541434309575;
        Mon, 05 Nov 2018 08:11:49 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id bq26-v6sm873503ejb.3.2018.11.05.08.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:11:49 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id z13-v6so7768531wrs.3;
        Mon, 05 Nov 2018 08:11:49 -0800 (PST)
X-Received: by 2002:adf:ecc5:: with SMTP id s5-v6mr10144826wro.208.1541434308505;
 Mon, 05 Nov 2018 08:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20181105074842.21988-1-jagan@amarulasolutions.com>
In-Reply-To: <20181105074842.21988-1-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 6 Nov 2018 00:11:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v65aJ0LVq8ic1Ru65qhoOHVw21eH8r4p_0Vxzz_83Xgi2Q@mail.gmail.com>
Message-ID: <CAGb2v65aJ0LVq8ic1Ru65qhoOHVw21eH8r4p_0Vxzz_83Xgi2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: sunxi-ng: sun50i: h6: Fix MMC clock mux width
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 3:49 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> MUX bits for MMC clock register range are 25:24 where 24 is shift
> and 2 is width So fix the width number from 3 to 2.
>
> Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

However, given that most of the other module clocks have bits 26:24 as
their mux bits, and the mmc clocks use 3 bits to denote the values and
corresponding clock parents, I would have appreciated you actually doing
tests to confirm which of these errors is the actual error, and not just
say "the user manual says so", because it is not always completely correct.
