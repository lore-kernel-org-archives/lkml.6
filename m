Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16450C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78D82085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9nxdeZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfAGSyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:54:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38677 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfAGSyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:54:08 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so1259280lja.5;
        Mon, 07 Jan 2019 10:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnAaD5v04AJRtpB0U8mPxZk5J2eEyt7HDmhShVqVL3A=;
        b=W9nxdeZQ+psSRwkqmXCLD1XzTsFGcSpZmV6r9eUKTaHX3uJzCYWLaTHVYGevEm4fGW
         B1TY9YLiyp3rOCvQKQNg5LkPYg5zfDAT7YQ7iP+ozMwxP5CEPycb68XxSUzrspkm6zuj
         h5AKWIbNo/iRsOyL3a0qtOP3qJqx0JM8oMwTzBqIZ7RPrgFCv9q51+LxscJheTtHAAnh
         r/zoPSaaMZ0fvv+qsyp1XNMI0p/gyk1QtZOO6fS2Yh/vzyXjar9pnLxraqlucucVG+K+
         TuCVKMku2ZWMNMOxREYj/HfUZq10hJgA1g2mHvdU1HYEecFJMjRaRiZQcG5mgvM58SxG
         jTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnAaD5v04AJRtpB0U8mPxZk5J2eEyt7HDmhShVqVL3A=;
        b=gtB1P9YQshU/q6KogD5NZAVJThhYM0Pk7ltw2vovK7YNspks/DPKG0GBrAP3oggMdi
         fimtRZoPripokut13yOBEJCFChZH3JK9a/gPlskARU3GtsybS4/mFTS2mtGLPGmaKnXY
         r+62wHsyc/MEc0hF0qFHnSabYSG1+onV7zgBKVfom9zwTPjpoieA1RN86pbfnbDRmmvI
         EIz7QR/wUzcRy/EcCc0DrdVNfG2Hpj3oR8EtLYa/uiV9gY2ZBPlVfjrPjz9/NxUDCK8B
         5XHATALoBvExs89juPTFBtNPZA6XDTO0zjCJl3ktZVNGNHMXEXUpflYj4rHaUWVKbEBv
         dg5Q==
X-Gm-Message-State: AJcUukcX9dAEImHAVylhtjAqYpJlEhdEZ0b06unTElKw+KY/YL/ozsJm
        hfVLsYj8sNwxUMM+fiNylEk=
X-Google-Smtp-Source: AFSGD/V9tqcLlaaEZ9CLNiF5+QAdVa3O5W+9AoSlpaQ7c4SW+fPgEWvJ0POU9J5LuZS/LOVGEE8irQ==
X-Received: by 2002:a2e:4299:: with SMTP id h25-v6mr33291488ljf.5.1546887246216;
        Mon, 07 Jan 2019 10:54:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:c050:d453:6c2:1d01])
        by smtp.googlemail.com with ESMTPSA id h203sm12825007lfe.44.2019.01.07.10.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:54:05 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v3 0/7] Input: tm2-touchkey: Add support for Aries and Midas
Date:   Mon,  7 Jan 2019 19:53:39 +0100
Message-Id: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches adds support for Aries (Samsung i9000) and Midas (Samsung S3)
based devices to TM2 Touchkey driver.

Changes from v2:
  - Change property name from keycodes to linux,keycodes

Changes from v1:
  - Added Reviewed-by to some patches
  - Use ints for keycodes (they could be bigger than 255)
  - Droped separate name changes
  - Added missing const in few places
  - Removed redundant cast

Jonathan Bakker (5):
  Input: tm2-touchkey: Correct initial brightness
  Input: tm2-touchkey: Allow specifying custom keycodes
  Input: dt-bindings: tm2-touchkey: Document new keycodes property
  Input: tm2-touchkey: Add support for aries touchkey variant
  Input: dt-bindings: tm2-touchkey: Add support for aries touchkey

Simon Shields (2):
  Input: tm2-touchkey: Add support for midas touchkey
  Input: dt-bindings: tm2-touchkey: Add support for midas touchkey

 .../bindings/input/cypress,tm2-touchkey.txt   |   9 +-
 drivers/input/keyboard/tm2-touchkey.c         | 132 +++++++++++++-----
 2 files changed, 108 insertions(+), 33 deletions(-)

-- 
2.17.1

