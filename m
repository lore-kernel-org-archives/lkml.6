Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFB2C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CC622430
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CC622430
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbeHJTRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:17:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38758 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeHJTRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:17:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id t2-v6so5111792edr.5;
        Fri, 10 Aug 2018 09:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AoSXM4G6+iNRA1bh5Kk9h5NdMX2MP3VH6vl+hUgY9ek=;
        b=pOixr7XL/ntZXTm+iRdfnVVDsUs/3W0dDnh6pBclp2GPwveogSnbYv/bMHyPK2MDi/
         LP1ofpYIWqpVRLEI+a7OnSf0w+s+fyTvC3pbihSpRFniQgMzxG8iRKZMMI2abLAuZHKC
         kCPUYwuN5t0JKmPJHzuBQ6TzrJsXdU7w+Kg3GtpIFTLb4fbFrDb2G/3y8DWinC2dJo41
         4jFs+ZI3TYNpTClZ5mgF4/Nitvp4ZxvZUFn65u1XCdGOEWOeBeIoZ3SSjh/cue8MI9hS
         lIDUt61QVRjToO7PgHXWh57mLCaZckjD72GFAHX7j/zDVtBJL4PHwdsrd12/0G7cJvWD
         2ubw==
X-Gm-Message-State: AOUpUlEHgbjaOKABjOBBvCeWh+9rrItC0WunPAp0ces78vbENyEA1YPV
        Kem5KeGYkqe6b3Ia1cFqirk3DR02/lI=
X-Google-Smtp-Source: AA+uWPwyWrB+cIdM4XO1kANe5X3AW7vLEBDt6IIKvtTQDZhyrqi+CkE4Mn8EWBjTTXc2cEeAzoPhOQ==
X-Received: by 2002:a50:a347:: with SMTP id 65-v6mr9211702edn.299.1533919614814;
        Fri, 10 Aug 2018 09:46:54 -0700 (PDT)
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com. [74.125.82.42])
        by smtp.gmail.com with ESMTPSA id n10-v6sm3827742edr.59.2018.08.10.09.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:46:54 -0700 (PDT)
Received: by mail-wm0-f42.google.com with SMTP id y2-v6so2580380wma.1;
        Fri, 10 Aug 2018 09:46:53 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr2027117wma.143.1533919613811;
 Fri, 10 Aug 2018 09:46:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a101:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 09:46:33
 -0700 (PDT)
In-Reply-To: <20180808171952.17263-1-icenowy@aosc.io>
References: <20180808171952.17263-1-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 11 Aug 2018 00:46:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v64fPkngWR3bxUja5d50fkZcnXAisTsNgaYJ3=D=CkS9YA@mail.gmail.com>
Message-ID: <CAGb2v64fPkngWR3bxUja5d50fkZcnXAisTsNgaYJ3=D=CkS9YA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] clk: sunxi-ng: fix H6 bus clocks divider position
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 1:19 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The bus clocks (AHB/APB) on Allwinner H6 have their second divider start
> at bit 8, according to the user manual and the BSP code. However,
> currently the divider is wrongly set to 16, thus the divider is not
> correctly read and the clock frequency is not correctly calculated.
>
> Fix this bit offset on all affected bus clocks in ccu-sun50i-h6.
>
> Cc: stable@vger.kernel.org # v4.17.y
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

APB1 seems to be the only affected bus. Since there aren't any users ATM,
I've queued this up for 4.20, with a few minor tweaks to the commit log:

  - s/wrongly/incorrectly/
  - subject changed to "clk: sunxi-ng: h6: fix bus clocks' divider position"
  - third line: currently the divider _offset_ is ...

ChenYu
