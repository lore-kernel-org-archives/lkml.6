Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5745DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282B2214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KUEgFTlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfA1ONp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:13:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42226 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfA1ONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:13:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so18204067wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpNbFL6ONdQohI3xz9B61W4M/fvLpOFKy8Sisbnkre4=;
        b=KUEgFTlJMz7xraqDOiQGsYrJ2t9STMcHTRhKY/T31n3swojOjnSPdPGe3jQXj50aqq
         Aa2kjX6rM98KpEgVVUKvaqevVNR7H4vVE/zAK0b9Bi1naOXKIzqjy1h0V6x/5ntbVvJl
         b2d6fgOIJaKh4dWNzP9mCEiShFxgddiLXX2DILxjSWvzHJagBHQfVGST0NswauCmLwN6
         3JY2kl0i9P7KkXJ/MAzX8nfVVr0UHng3Onr22kZ9DHyG+GmuLq2F6V+A5+/jbpNtxncP
         Q3El9iMBb7jQsU5sU+srB9QwQS/rMUGZF/2Hr5/nwqcpQSMj8SprygZC5+SIIOYw2ew+
         AQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpNbFL6ONdQohI3xz9B61W4M/fvLpOFKy8Sisbnkre4=;
        b=o8+SJTFN65NgjrrPJv7kY4qr4+36is/vRQTYCOhLSfU3vMXkjLJcPxPidGmI4Zzm0f
         aJYajiB4d8Gn+MFM0prmaMD2S5BRu44R0nZ0fmhPdgywe2o+FH7w1BcKmTEpFKEY2qy/
         9OdF/tJ0rHKzThkYU+beJdD7U5BVOaQ/IboF7Xz8iOfnZSNSjNt/aqp6mMsB/EMlB8rV
         BsjY7WZzpGnlXKh3Xq/0Mt4BYX5dxUQ6C1s3AGrQumVYR5W0JaUJnaBdDo+nYYxgKa9u
         /H297cLRSL7OJuBGlKiGRvMZptcvy4MXYYLGbeoEvDzBy+9ka82sj3cE7ojaFYYLyZsj
         bU5Q==
X-Gm-Message-State: AJcUukdn6m2DGi4X6LYGZvqvxsrPnn7lpCFiDwoapkFHzkzr9OhTYstF
        SEakAVp1rgUm2nks9qYnSv0OWw==
X-Google-Smtp-Source: ALg8bN5GughM5mUUiNMpin2eKNC4qYdUU+6AqYPcenyQnI8cc8C4gk2sQBlHEYHaJl2c7d1MM+tZbA==
X-Received: by 2002:adf:b649:: with SMTP id i9mr22438177wre.70.1548684822582;
        Mon, 28 Jan 2019 06:13:42 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id o9sm44131913wmh.3.2019.01.28.06.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 06:13:41 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] reset: meson: add g12a SoC support
Date:   Mon, 28 Jan 2019 15:13:28 +0100
Message-Id: <20190128141330.21927-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds new dt-bindings for the reset lines of amlogic g12a SoC
and the related compatible in the driver.

Jerome Brunet (2):
  dt-bindings: reset: meson: add g12a bindings
  reset: meson: add g12a and generic compatible string

 .../bindings/reset/amlogic,meson-reset.txt    |   7 +-
 drivers/reset/reset-meson.c                   |   1 +
 .../reset/amlogic,meson-g12a-reset.h          | 134 ++++++++++++++++++
 3 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h

-- 
2.20.1

