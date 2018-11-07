Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D9DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B8020827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kAj0ua70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B8020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeKGUPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:15:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37272 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeKGUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:15:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id o15-v6so13229068wrv.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7sH98AGCXRJic304l/zs3am4IHRLWmhZ7Rz6BqixYE0=;
        b=kAj0ua70fjYki72GwIAGzEgNm3XeI04cc2S06D/3nu4spxckEvfq9GgPJcB0sfy4Kv
         5eLxGRk+IOLr2NAXy4rwFUGI3SKwzZVsvhLQNKj8wkHObfP7yCUB0qLY9Fg1z6yOjrvQ
         K/tQCcjRNLMYjK2bUlw4UXUvsrVcxhZeze7b5mT/VS/XP/Use9fry7MfGdCpX1mcpL3Y
         omnDmp+Yx3HrM40JOIwKVDh5H7gPBCzZyf2CdKPeJc4R/zGjMYNBqxBL0aTq5Ger0ICF
         sgIot6MVNrtvYXdA4zkSXVBwHzMiM7590aqoIcc/DCwqPgapnW4ECXdnRE7lzNQbmJ+K
         nnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7sH98AGCXRJic304l/zs3am4IHRLWmhZ7Rz6BqixYE0=;
        b=hCpZ0fSmY6nKUjjh60qE94tTQ+D0VfpfmKMdf8/r83g958ZmTKtcdQwFhSq2f0uaV8
         /7cDvBDPcvDgqex0o4D2BCJH8aJl1Y61IjbtDg9H8CXsuEsxY3WjsrPzXuoF3CAzehtw
         6q4mp2qEoLrqBOdHqx7b81UgU0ykEtD+FxuKmWpc5vW98DwA2/IkxCBKJMiuwAXtgmUh
         bsnKmQbYYH05tkzuJFGyi+lqiqxR4Mj6qWh227ZlB1mbi50h9nul19Dtjw3oxW3KeCx0
         D0qPlUeKcpwag6I8IgRxJDavUPa8cOMSfVJbu5bpq1jF06X6clXuKLFzLHsXfnEQ9LSv
         NMaQ==
X-Gm-Message-State: AGRZ1gJRobJrhu/TU7ugFH0EMJ5C89kK+gyKEfRs1xuSZ/PNbZsBft8k
        GSvDnzQ2xooueq0ep5Eanr9MFw==
X-Google-Smtp-Source: AJdET5f8eDdnF/KNm0dRfNH10eMzwq2yzJqw8nIWYpGAiEG5WtZauypZWRDnN3y0ERXABXBLMMhgNg==
X-Received: by 2002:adf:e7c6:: with SMTP id e6-v6mr1317643wrn.49.1541587553175;
        Wed, 07 Nov 2018 02:45:53 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h125-v6sm314484wmf.48.2018.11.07.02.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 02:45:52 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] arm64: dts: meson-gx: fix GPIO lines names
Date:   Wed,  7 Nov 2018 11:45:46 +0100
Message-Id: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio line names were set in the pinctrl node instead of the gpio node,
at the time it was merged, it worked, but was obviously wrong.
This patches moves the properties to the gpio nodes for the board DT having
the GPIO lines names.

Neil Armstrong (4):
  arm64: dts: meson-gxl-libretech-cc: fix GPIO lines names
  arm64: dts: meson-gxbb-nanopi-k2: fix GPIO lines names
  arm64: dts: meson-gxbb-odroidc2: fix GPIO lines names
  arm64: dts: meson-gxl-khadas-vim: fix GPIO lines names

 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts         | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts          | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.7.4

