Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA27C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A0120659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="srdIzaFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A0120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeLDQ6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:58:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35117 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLDQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:58:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so10064157wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFaj5nnpznOUas4Nk4RvpF7kGZOF4xLLF5UsFHMGNEI=;
        b=srdIzaFGu3pA59qfVe5+NL05RLSR+ZodpzQ++pFEEkF3SBMNpKKtM7l7GFFF8VS/UM
         VQaZeDZUN5nyGUTeC1C0o5TFbKcPahJLRJkQj5xZRKE9pfqMZJng4JoUsvlOpx/vEGt/
         OlhC8pJQ2smI52uqwc0RYykhwuYn974zr7BLL7MVMNrRIUl2P8g8DYJAhZYxLZMQXAmC
         cQJg0lMep4Pwxly25zgaIhKYz+C82j0lNJigI6sT4X6L9a7wi0FWBJPT+Do+evnSzBal
         CsNuCthevRzzU/IQuN9NulW2+uIOXoNWk51Qj490eUKcUcoAlnGTSPzMyyB16DQlvUWg
         5nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFaj5nnpznOUas4Nk4RvpF7kGZOF4xLLF5UsFHMGNEI=;
        b=iLNsI3ppAxjrr6vgi2pHmSnlH6Tt6ipOi8cfC28sBpwsEVVf6B/j0i6oNYv33TRiiY
         2S/yKZUMZhJkM6Kk1FQ014q9HOuMK7TODGZIy0z9x2UkCIjZBkvn2gYuxkoOD9QR0gTy
         /vS7ywTnhtiBDYONKg0b+DN7iWkqHwubncU7OYaiWDgpeLvY1LJfBAQ90KWKISgUeGJM
         nUUkr5eUMBtg0a41LKd7kzPi0B3/v9bwzpyr7c4/TBOLdYrs5fZ8uXkTjhOaOJpEh8mR
         46hntT8dTSqIFo+xi/bUXDl5AAlB3c4oR42C/RpfnigZNg70Ou37RhJrZG1/Q2mrFRkM
         eXVw==
X-Gm-Message-State: AA+aEWZAAatVnt2NWYfysSv1J8zZE35m83dM30bNkjUevn29yF57s1Un
        syZxEdSgU6UkgYkNx9yaoRsz3w==
X-Google-Smtp-Source: AFSGD/VnCwtapXZIu6I7LJY17J2Dek32xY3jzoyAR14FToy4ExZQhq3sSRtzaLkb8aGKlbbkb0n8lA==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr12923646wmk.149.1543942708347;
        Tue, 04 Dec 2018 08:58:28 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id x81sm10152521wmg.17.2018.12.04.08.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:58:27 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] clk: meson: add clk-input helper
Date:   Tue,  4 Dec 2018 17:58:17 +0100
Message-Id: <20181204165819.21541-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the related bindings get merged, we will add more input clocks
to the different amlogic clock controllers. Instead of copying this
code around, lets create an helper function and use it.

Jerome Brunet (2):
  clk: meson: add clk-input helper function
  clk: meson: axg-audio: use the clk input helper function

 drivers/clk/meson/Makefile    |  2 +-
 drivers/clk/meson/axg-audio.c | 83 ++++++++++-------------------------
 drivers/clk/meson/clk-input.c | 44 +++++++++++++++++++
 drivers/clk/meson/clkc.h      |  5 +++
 4 files changed, 74 insertions(+), 60 deletions(-)
 create mode 100644 drivers/clk/meson/clk-input.c

-- 
2.19.1

