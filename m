Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51FBECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB4120869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QrgZUbw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB4120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbeKEUER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:04:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38133 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeKEUER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:04:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id l2-v6so7555153wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 02:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BA8N+sCteaXCfPVHW2cboUva9koABLAGqJTeFtPRALs=;
        b=QrgZUbw/Z+5QapFPCs5f7igD3Q/cXFRshjqjrNpWIAPeW+Q3Dh2YLWjXcqJkxarXD9
         PR07BzPEfiluT+xqJc7UigH1yl2JaQA3hNb1I+PdDsTKqeeRI2sFvYmxnMM7tzurPDEV
         tUQZcZs028BZjcruVY82sOinA/Qmxa67miatWkHbuDBEQqp2IpKUhMU94+OgjbSWCsUn
         lpnmys5yAlUMrTA8jogHhVCBbDfHyUTouKsOvfXPvlhF6WqKZ3fmljCblqgVgSGSMvTJ
         ffdzl8PNWygYiQv/OhyQdVLC4eqmBdauCpcePIfzbGdFaaJ6kH6ljQGvWj9+p4xsGbFn
         /+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BA8N+sCteaXCfPVHW2cboUva9koABLAGqJTeFtPRALs=;
        b=MsCIaNSMcRCODmzZeK9qP+YnKAJwZTwxj4OTtZu5DCCc+Pf5UYDBmcpaT4gNf71k/9
         drJF3hay9i3CAArBCj7KssllBh7vNz3/d3pmUPXfXbyZNdxuBk8zEMT/FOaE+azgcMFx
         9dAuWsKyRO0aMwU9K0IUbI58NeTgPwtAvmMx0wT9a8taDYnYEcq7ZtbZbhLO2oeYefP6
         HjPNT+EN0fmXY/eBZxxuNZWadgUUc4IIAxkKbQphLbm0uVUgc2wriNXUZmY2KVwFJNpF
         F+p+UCG3cgAY8k2OTViThrORisHF//iiaenzeTx2m9a1kX9pKRK3MwMv1f1N6xxcolMI
         fbIQ==
X-Gm-Message-State: AGRZ1gJevh19LziSDaq7JSSPCR/sAKWFdd6FvjTnoEzb1J5xL0GzkPv+
        tfYlGqORzS3R4QDiDkeOUKfg3Q==
X-Google-Smtp-Source: AJdET5ffyrbHKofheAQX4EhJER7l83tSzvr9StrlcNqYzBYnMb1o2tbxCNNmqvNxQpO7nbLtM2XNzg==
X-Received: by 2002:a1c:7508:: with SMTP id o8-v6mr5801533wmc.76.1541414711736;
        Mon, 05 Nov 2018 02:45:11 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id p125-v6sm8033114wmp.2.2018.11.05.02.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 02:45:10 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm/meson: Allow using optional canvas provider
Date:   Mon,  5 Nov 2018 11:45:06 +0100
Message-Id: <20181105104508.23090-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meson DRM driver currently uses constant, static canvas indexes.

This is not optimal and could conflict with other drivers also using
canvases.

This patch series allows the driver to optionnally use a canvas provider
module that is able to dispatch canvases, on demand and free of conflict.

In the future, the current way of doing things will be deprecated.

Maxime Jourdan (2):
  dt-bindings: display: amlogic, meson-vpu: Add optional canvas provider
    node
  drm/meson: Use optional canvas provider

 .../bindings/display/amlogic,meson-vpu.txt    |  2 +
 drivers/gpu/drm/meson/Kconfig                 |  1 +
 drivers/gpu/drm/meson/meson_crtc.c            | 14 ++++--
 drivers/gpu/drm/meson/meson_drv.c             | 46 ++++++++++++-------
 drivers/gpu/drm/meson/meson_drv.h             |  4 ++
 drivers/gpu/drm/meson/meson_plane.c           |  8 +++-
 6 files changed, 53 insertions(+), 22 deletions(-)

-- 
2.19.1

