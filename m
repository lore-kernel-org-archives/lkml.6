Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B821C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E5D21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Vb5yVm4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbeLTQKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:10:46 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39583 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732743AbeLTQKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:10:44 -0500
Received: by mail-wm1-f41.google.com with SMTP id f81so2785773wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z6wPduEXV3XXEuMg2tHDSa+K2V0jh+6poqtPJAz5Pec=;
        b=Vb5yVm4uaaT7v2BVpMx2iilJ3pWRQ9CAUIXrtMcJ5YS4xl0euy3fypl8xLs3B/Hj/B
         Jvq3py6A/Znw6vDkEOEOPKeLEQpYlSXnzmKS4wGbSR5nHoza0XBao0kPepJQRFLK17RW
         C8lq+GQehrxgCfXwDz3nK6G5TUki+GOxQPamM9Zoo5R4IJWgfEJgwQj8a4C8J0jvIGj6
         CQzwBiG2R10RMQvOZZ0/5F6/F5bRckDh415WYaUpRgunm6ildbTqbx6ob7PEqM13CAj5
         UB6+uaL7/TFrMEGzLkTpQWdF6msPWnTjUyVgFFqgafvIwmE5jPlsFoak2Y+BvIpq5sLF
         bg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z6wPduEXV3XXEuMg2tHDSa+K2V0jh+6poqtPJAz5Pec=;
        b=m8IiqVhi73yyIexzwCxP7C9eFtosXVN97uNAyKFcWg5gNsF+BZdX74iCJzMlHdJb7D
         gwQdBjgs3z6j4SzGzo+xNoZ7nGG6vkVPbpOsIZ7Ts+tvL1WBlRSrUc8vMYnyxMhwQcQ9
         +qZIJDXKrRQETyWBbgnz6YhySRvVzW4mo9d+vSfJsjTdtWg2RYkb22EECP6cVaMkO8Gp
         ETsRaBIZGFyaJ4orahLCNord972t41A6FtjZX1ZpWy3667qiai0bGTnGKX6z6xcvCJ2n
         KwXzQAdQfXNE5N0ppUWi1xD6RuOp+9cBtwobN89WreN/ogSwIwZjzCPxiHtVRLjAZ5ka
         lm3g==
X-Gm-Message-State: AA+aEWbJZpE3V9KvbyjoaRe8iK9B31tunlQCjJ0DA03fA5uvutyT+Uot
        0BErnkTN5CU1+E8PW90Xe/q6kw==
X-Google-Smtp-Source: AFSGD/XtoNMEI7iaBRDll2v24vsMtJOSri84lhYvk/AmV3zJaBC1/98hAcqfY53TFPqYvX3ofkSy/A==
X-Received: by 2002:a1c:8548:: with SMTP id h69mr11465403wmd.11.1545322242934;
        Thu, 20 Dec 2018 08:10:42 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id x10sm10941186wrn.29.2018.12.20.08.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 08:10:42 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: libretech-cc: emmc update
Date:   Thu, 20 Dec 2018 17:10:35 +0100
Message-Id: <20181220161037.23756-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides a couple of update for the eMMC on the libretech-cc
It should remove some error message for those who don't have an eMMC
module and improve the performance for those who do have one.

Jerome Brunet (2):
  arm64: dts: meson: libretech-cc: set eMMC as removable
  arm64: dts: meson: libretech-cc: switch eMMC to 1.8v

 .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.19.2

