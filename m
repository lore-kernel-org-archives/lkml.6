Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C2FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D30021741
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DbqeLa8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbeLOPSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:18:18 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40972 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbeLOPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:18:17 -0500
Received: by mail-yw1-f65.google.com with SMTP id f65so3529794ywc.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 07:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHOhA3bJ+bVuHW2xO0YPGdWfH+kDWglkOW/6eeT4ID8=;
        b=DbqeLa8UNk6ECD/Xm1xZNRr5fW1f25LdzNyiRBpXpglmBzvIhfIafAX7GYZUvyq4yd
         VtOOL4AWFLVhdHPd63IaZ4pCkSPA8BoR40BzhdRcnJGYrwGlaFQUD3fz8RoG4J/fYhtp
         c9ZKPCq8gbWt1sZ8Y2KOISkCrclZhykHtMdf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHOhA3bJ+bVuHW2xO0YPGdWfH+kDWglkOW/6eeT4ID8=;
        b=KuptLRIknBk3yQxRap6JYYYQQWhTeGU2aE63IYzJ8Cw/TmBtRx/VPq28e17YzjYpj9
         q9Ob/HoAmCh3PpoDosKtKqLZ79vmHQRU3wZAVvPv7kRulVXK39fpEYZf85zWujHwW5Fy
         F99LBpwmWI2wwYEJ9sNvEJv6FH1YHRfDswUz61vJEEdoCia66ExJIgt0n4o7cIKqqaN7
         IyNcwqH9CbJyikWiVxeUXCkvnPhrtoJ3MtQwoLcedje5I6xAWLqaEdOhMpaXwfb0wShT
         Lzqyycz0khVpq5eOuxKy1ruMX1lNAMjzzl9ALHRkqijx1EXaHy4M0rjFmZs9fTmRLKg0
         1mng==
X-Gm-Message-State: AA+aEWYYL7000Cg8GNy0yt+jweSzlK5NB0CZqlwX2qjVU91QMttn/Rvb
        SUpc9mJys6ShrDU9D5B05X6dsQ==
X-Google-Smtp-Source: AFSGD/XnMuYVkLldg68EJfKChV7ppXhhC04BoqamAYZ16aSWTZ3oSDPfeFN2F25OZMr0H+/wgdu6kQ==
X-Received: by 2002:a81:a8c5:: with SMTP id f188mr7139038ywh.73.1544887096558;
        Sat, 15 Dec 2018 07:18:16 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it (host211-95-static.0-79-b.business.telecomitalia.it. [79.0.95.211])
        by smtp.gmail.com with ESMTPSA id x203sm2855664ywd.41.2018.12.15.07.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 07:18:15 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 0/4] input: touchscreen: Add goodix GT5553 CTP support
Date:   Sat, 15 Dec 2018 20:47:58 +0530
Message-Id: <20181215151802.18592-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset support goodix GT5553 CTP.

Changes for v3:
- add cover-letter
- s/ADVV28/AVDD28 on commit head
- fix few typo
Changes for v2:
- Rename vcc-supply with AVDD28-supply
- disable regulator in remove
- fix to setup regulator in probe code
- add chipdata
- drop example node in dt-bindings

Jagan Teki (4):
  dt-bindings: input: touchscreen: goodix: Document AVDD28-supply
    property
  Input: goodix - Add AVDD28-supply regulator support
  dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
  Input: goodix - Add GT5663 CTP support

 .../bindings/input/touchscreen/goodix.txt     |  2 ++
 drivers/input/touchscreen/goodix.c            | 35 ++++++++++++++++---
 2 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

