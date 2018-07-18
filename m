Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12114ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C792075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EXcxmdSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C792075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeGRSo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:44:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35211 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeGRSo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:44:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so2355215pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VzmT8reurK3GjtsBKt+jY4aHrklGn5BcfvO9JLO2jtc=;
        b=EXcxmdSvdpmSVzFkX9ZcdomgiZIm6RMTkgFjXsEYk4eDUxL2ut4QuSCovuxSpR8/0j
         KbQvqmZNLolFWOCb6AAzg/dCJJCbolSwAtxcgnQb1STtilazjToV6nllLOOY6WpwMVpI
         S0uaS+olravbuji3c6EEDQnJHCechc12bo+Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VzmT8reurK3GjtsBKt+jY4aHrklGn5BcfvO9JLO2jtc=;
        b=Nm1IziVrQFmQGgv5CinqTcVQyTV8fi//4NqGsnbOHRdDdvHd/kwAEQop0SE0jOL2hy
         b8eW5geGieQmufUFhCZsXUB5ruyKZCw3C0oZNe+HxLEGRekjW/uk9cxTGIpmqBAbEB1X
         OUlbv2tV334lrcsxN5ftCLTJHq0TD3/+c4xNTDP2qP2N7BLBh+PHJUzFkpw0EZQ+3/9h
         sDCGxOER1belbz9eL3PPFFKrNKN6AYwo6l4n2ir5jlAkXfsszfhcZ7ouUV3s42mLj3zW
         HLasuGXWTs/ReBxN0MzvLhvn3i+Qw/bdbuEBYeYUEgWCEtnrnnGx5/T51CRFCFkqTqVt
         ZEzg==
X-Gm-Message-State: AOUpUlEJqCxRtraRXFeHsywTk2/C81xTldnbPu1eDxRzpBRWmPSuag8V
        uQ93kKBtFZ1TWB9EqgYiDoUXMw==
X-Google-Smtp-Source: AAOMgpcYcor6R/AN4Lt3jH/UmVVXQL3+HbXfMGrmRDZUIF8r9ERBQi3NczyCybkC6r15XZZwe8jMHw==
X-Received: by 2002:a63:1262:: with SMTP id 34-v6mr6917620pgs.154.1531937123065;
        Wed, 18 Jul 2018 11:05:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id f5-v6sm12818857pga.58.2018.07.18.11.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 11:05:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     sboyd@kernel.org, andy.gross@linaro.org
Cc:     tdas@codeaurora.org, girishm@codeaurora.org,
        anischal@codeaurora.org, bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [RFC PATCH 0/2] clk: qcom: Quad SPI (qspi) clock support for sdm845
Date:   Wed, 18 Jul 2018 11:04:28 -0700
Message-Id: <20180718180431.48580-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This two-series patch adds the needed clock bits to use the Quad SPI
(qspi) part on sdm845.  It's expected that the bindings part of this
patch could land in the clock tree with an immutable git hash and then
be pulled into the Qualcomm tree so it could be used by dts files.

NOTE: though I seem to have some register defines for these clocks, I
don't actually have a clock plan that includes them.  I also didn't
see any use of Quad SPI in the sdm845 Android tree I looked at.  Thus
the frequency table here is totally made up.  Specifically:
- I know that GPLL0 is running at 600 MHz and that I can have parents
  of GPLL0, GPLL0_EVEN (AKA 300 MHz), and TCXO (AKA 19.2 MHz).
- It seemed sane to add an entry in the table to come straight from
  BI_TCXO.
- From probing lines, it appears that the Quad SPI block has a divide
  by 4 somewhere inside it (probably so it can oversample the lines,
  or possibly so it can generate phase-offset clocks).  Thus we need
  the core to go 4 times faster than we'd expect to run the SPI bus.
- At least one SPI flash part I looked at supported a clock frequency
  of 104 MHz, so it semeed nice to add clocks up to ~400 MHz.

This is the first time I've tried to map Qualcomm register definition
into the clock driver, so it'd be nice if someone could double-check
and make sure I mapped all the numbers correctly.  If nothing else it
does appear to work though.


Douglas Anderson (2):
  clk: qcom: Add qspi (Quad SPI) clock defines for sdm845 to header
  clk: qcom: Add qspi (Quad SPI) clocks for sdm845

 drivers/clk/qcom/gcc-sdm845.c               | 73 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm845.h |  3 +
 2 files changed, 76 insertions(+)

-- 
2.18.0.233.g985f88cf7e-goog

