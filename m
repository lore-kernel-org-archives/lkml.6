Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED42ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29C02075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U15pDx7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29C02075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeGQQil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:38:41 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36665 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbeGQQil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:38:41 -0400
Received: by mail-lf0-f65.google.com with SMTP id b22-v6so1245185lfa.3;
        Tue, 17 Jul 2018 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iz2HmXy+IgRzqq5TIQtfL8/OgQKj1WYmRin7lzO8LyE=;
        b=U15pDx7Pz+B+QVtbccIDf2OTbN8zYzFjrZBQDw/gLBLHRhuuFz1Qf2H6h06O6Zm6y1
         ePLHsLSes2Fbxt0E0DJ6vgpGGtm192+jXNDm+3DOs6syVScYtbkoSM/jVNeEkCVaFQOY
         27jEU2ypJ5FL0Z/TYruMxk5jO3gJK/SHQxetyyqYfqYV+/0RH7FZT9SG9Y2L165LI/V5
         U/ziZO+8qW5ZMB1jpWwcrI8mInMJCHk0k9BbEpXMuo7A9e6b8SYr5piigYMZvT/EhcVu
         5iRiOoKT+3KQt35yPM0mD+7g3TE/umJtC4xe1g5BqHHLhAeC7xpWiRzifQMfrMvKACTI
         XHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iz2HmXy+IgRzqq5TIQtfL8/OgQKj1WYmRin7lzO8LyE=;
        b=GZc2ddcnz1FQ+YZ/h5Z0D1PxLj8fwY3cZ/VIG2T06VliYM7xX4Fgcz/lfrVAqOoOqk
         WkDSQIRQKpAgcmPNmwZaZZWAJBYqYkXOdxbrPyJqPSn/x6oXddC/n3TY71G7a3FAb/OJ
         cMA8/TKkn5s4z1ObQp8uooX7gjP74Bc2OJgGQpmaT9S2JnC51SiEDQ5PB6oijM2uwGHq
         GqzM3So0I4ilpGszGOOlmJFbDR2GNTN3BIi3OdkT4bENBLu0GaXLULvdM/GxYujqtVsB
         1cxn2L2UhEoYi1sStIRmMlHAfsmsm1xTkoW7J5KUg+hslhb1xz+8GaTZYBD47rezXlXe
         xT6w==
X-Gm-Message-State: AOUpUlGZsbb64tD8RFs2ybqNToxhsRzwhylTbmKl5KeXECtd1ASnv/jr
        pBRfYaKokvptE7Q4AH3bnKc=
X-Google-Smtp-Source: AAOMgpebAO6sDxZxz7YpAkuIs3tEGRjbVCUHWYD0EuHLucHq8dTnaH6i2gSm3i+Uen1Ib3e69tKfFA==
X-Received: by 2002:a19:5d54:: with SMTP id p20-v6mr1608146lfj.143.1531843518396;
        Tue, 17 Jul 2018 09:05:18 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id d23-v6sm229861ljg.17.2018.07.17.09.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 09:05:17 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 0/3] power: supply: max8998-charger: Device Tree support
Date:   Tue, 17 Jul 2018 18:05:06 +0200
Message-Id: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series compose of 3 patches.

First patch, fixes platform data retrieval issue in max8998 charger
driver, which could cause NULL pointer dereference.

Second patch, updates max8998 charger driver, so it's possible to parse
devicetree for configuration.

Third patch, updates max8998 documentation, so it includes new node 
and properties, needed for charger.

All patches has been tested on, Samsung Galaxy S (i9000) phone.

Changes from v2:
  - Make charge-restart-level-microvolt and charge-timeout-hours
    properties optional. If they're not present, assume they're disabled.

Changes from v1:
  - Removed unneeded Fixes tag
  - Correct description of all charger values
  - Added missing property unit for charger properties
  - Removed already applied patch

Paweł Chmiel (2):
  power: supply: max8998-charger: Parse device tree for required data.
  dt-bindings: mfd: max8998: Add charger subnode binding

Tomasz Figa (1):
  power: supply: max8998-charger: Fix platform data retrieval

 Documentation/devicetree/bindings/mfd/max8998.txt | 25 +++++++++
 drivers/power/supply/max8998_charger.c            | 62 ++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

-- 
2.7.4

