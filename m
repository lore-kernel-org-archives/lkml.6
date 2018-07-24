Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC88CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7358420875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ty/Imr3n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ji+EnYRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7358420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388651AbeGXTcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:32:05 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42405 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388409AbeGXTcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:32:05 -0400
Received: by mail-ua0-f195.google.com with SMTP id w7-v6so3387998uan.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=i9QA1ROmh7YjTGQHF5onunBevdWJ/SpMRj28/49KFfQ=;
        b=ty/Imr3nr3voZQ04IdExDpY8Fiya3UA4HKGSaqlfs3vZHe60t5d7S1fwhMUhKAr9VF
         usAkO6pWol4mONB7UJplObGn7G2BgSBw4BTv+fBoz6LXWXKeJTAxlNRHGG6dzz1pDboh
         Ii+lnf5mKAGM2PQBl767m6EkgQUVFSIV5gaAmFcyIEAy8htRBr2YCr4C578ZdTIbAijP
         hbEDBSiG53tl8v/5vEzojZPE8qZHFmKGd4Gog6Dkd+i9GYtA1G8Slw8y5gvMSVZhaLfz
         UBs/K0kaxvsMmYcV1SOpOJ6ZGQr/uv3Z8MbdJ6Xe1gv+i4duKhv2kuc4rcpUx0lcvkI9
         +IyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=i9QA1ROmh7YjTGQHF5onunBevdWJ/SpMRj28/49KFfQ=;
        b=Ji+EnYRx1CcnJmqrcknEiOjL2tpJmaAW9s/FpUywe2oNKkexzvSRZWe2+iVRhpchP6
         LqRycU9HlZCa+Ls7CKhHt2uIYzskao5Sp5VXd9YHRF4FSNiQpSkOIoPfLV8ZRTd0vhpf
         +A5ig6X0aFYc9qnBYO7tIjYnl6uaczeW/4bjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=i9QA1ROmh7YjTGQHF5onunBevdWJ/SpMRj28/49KFfQ=;
        b=c0r87ewmU0YzKWKFFUH787tUhDPfBMo6bdRFaxARYQD8uSarq/pbOiNClaqCddYyo3
         qv7OFighJcwkee2+a0WDg4c0MUiUFNaFmEzIm9TE05lSIDGW8Xt8Jnhod8sSr1MKFj3p
         tU9Gkb3z8u6+saGpxDhO9/grAmKGtRRtFYFbLn2aIzWLbvw23SZTRg1NBK+CuizocuKH
         xea3A+4kdjYlJAGSYc+bJHtv6s5kwinsvxF7+XwneZV6f77z75QC7Uldi77RBhZWs58j
         X5GwWQb6HOnK7fxG3k3YR1MUFWXr8lOTSpaLDzEGsKdkNFbnL+MRQefNny6uOd7ASCwc
         QqRw==
X-Gm-Message-State: AOUpUlE75qG0MtZd+T0W8pn90g/82heo7PHjV5o18H5qqvJ30vd0NeZu
        09i/mnI1gCCKh/N1VJAQHDII14v+DZVpIBZUmuoAng==
X-Google-Smtp-Source: AAOMgpeK4ozmQPHxJ382wDjrL7ZT/Jc7oU3/uQmecpsXbaPnAtQcYc8wGJBC7SFDGgmMctiOJwCczf/RwOiGOe1pNnY=
X-Received: by 2002:ab0:11dd:: with SMTP id q29-v6mr12394790uac.191.1532456660403;
 Tue, 24 Jul 2018 11:24:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 11:24:19 -0700 (PDT)
In-Reply-To: <20180724174513.174018-3-dianders@chromium.org>
References: <20180724174513.174018-1-dianders@chromium.org> <20180724174513.174018-3-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Jul 2018 11:24:19 -0700
X-Google-Sender-Auth: Fuw8uvXFlQMr3jm1AzVeZW9Ed8k
Message-ID: <CAD=FV=W-YDFM2k6080naxPY8bfE8SJE68g60qXBM9+msgSQRzA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] clk: qcom: Add qspi (Quad SPI) clocks for sdm845
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <andy.gross@linaro.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        grahamr@codeaurora.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 10:45 AM, Douglas Anderson
<dianders@chromium.org> wrote:
> Add both the interface and core clock.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> (am from https://lore.kernel.org/patchwork/patch/966680/mbox)

It's just the day for me being a screwup I guess.  :(  That line
(obviously) doesn't belong.  I'm assuming it's easy enough for Stephen
to remove it when he applies so I won't plan to repost.  Sorry for
being so dumb.

-Doug
