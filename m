Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0E7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344BF2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5GrK7QW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbeL1PTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:19:32 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33117 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbeL1PTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:19:32 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so14772479lfc.0;
        Fri, 28 Dec 2018 07:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9d49aBJNh7GrHY65V1PzLXouo3n3U60A46Zt1GxLt60=;
        b=g5GrK7QW5rvkGbZVfcKa0UDTnZMhppExbS7Rh8AtxaYaabOp7Lx3+fXGXbiyA0rzG7
         hIE/R2KfUijQWlH+PL8Q3R1kT7wj8A6WlQSkCdc6Z8plxfWcr8qmivXrlsjSAqLLTQ+L
         cVdbiDy7EhVQ6qV0xmnY12N4BWzGxZkU8Pshr3IObch660jlHqC9xQzEd26TcELpGzyk
         kQbWUMQ7IjkhC9xtIvhp5lFLnGfIYCeHte21bwVptbS+edeqhCMiGI98RZGpvLN6Tx8P
         CaMSy/CYH8BvzWiSOl+VsyQGUDz6KgW8edjRRIAiFm2aDoOfpQmmDi4DLnf5r1ENsAXa
         3PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9d49aBJNh7GrHY65V1PzLXouo3n3U60A46Zt1GxLt60=;
        b=J6LOba9+JeKH8erhMa0zBlLHACNFKSvU/s4d563k5QPkMm63tjNMJb+yQOn3FdceBS
         RuYXnTDrkI+P75wENOtWjCkQ8EV25sSWeaZX4lNd7uE9sUZ0MK3U/PV7NO54469IGK7M
         UWZCg7TveaIhPhB0s33he2KwSjpAbmB0q/PK9sP2KSENWL6PNMQ9Kl/odnqSBxRUT0WN
         W2fyC9TZanVRGKYPNRIkPj2ea/XvPFHQCks6nT0auIfrrni/phyXagjzT9sEvtLWchuW
         A7i8F9BduWzu9x2HpMcNrnIwjTsDPIwxovNYkHpPGlsv3wnNoSeU3XIlZ+k/Dk5ewZw5
         HS/w==
X-Gm-Message-State: AA+aEWaXEqb8sbyV9N1V76a/6ccdGsl4Hv6k9SfjhuGkOeddxGDwu79X
        WAnpESQTdR2Af0eYCnej8KI=
X-Google-Smtp-Source: AFSGD/UTmAYOInFAWM4uvvTang73uSr38uYkOrdHoN7K5qcGiCjGYskp9put4k+MrxVZpvlYqkj5Tw==
X-Received: by 2002:a19:d5:: with SMTP id 204mr13259672lfa.116.1546010369714;
        Fri, 28 Dec 2018 07:19:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id s24sm7872704lfc.30.2018.12.28.07.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:19:28 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     inki.dae@samsung.com, krzk@kernel.org, airlied@linux.ie
Cc:     jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 0/3] drm/exynos: rotator: Add support for s5pv210
Date:   Fri, 28 Dec 2018 16:19:01 +0100
Message-Id: <20181228151904.12079-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for s5pv210 soc, into 
Samsung DRM Rotator driver. Currently only NV12 and XRGB8888 formats
 are supported.

It was tested by using simple tool from 
https://www.spinics.net/lists/linux-samsung-soc/msg60498.html

Changes from v1:
  - fixed order of chipsets in documentation and removed ordering
    from it

Paweł Chmiel (3):
  drm/exynos: rotator: Add support for s5pv210
  dt-bindings: gpu: samsung-rotator: Document s5pv210 support
  ARM: dts: s5pv210: Add node for exynos-rotator

 .../bindings/gpu/samsung-rotator.txt          |  7 +++---
 arch/arm/boot/dts/s5pv210.dtsi                |  9 ++++++++
 drivers/gpu/drm/exynos/exynos_drm_rotator.c   | 23 +++++++++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.17.1

