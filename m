Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822A2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CCA21934
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KUIJ5dNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfBQJOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:14:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43494 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfBQJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:14:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id f90so7224310plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 01:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+0wO2z3ugugrmweRK4PuFUuzn08i1pwgW943uQ5p84=;
        b=KUIJ5dNmh4dYDeVsTYpAUnEKkOKoGI+lQVApFjUIO6k9hotb4VKovcM7u7FnDRmJL1
         hY3ZA299sy0kSvbLcmWm3JyY2bCfAK3/jJwJ/IUfz/JaNNu8GHh9iOT32RCdR631bM0u
         Vn/qE4O9xpqHa2cYXt8FpY0OhV8gjn9Kxp4N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C+0wO2z3ugugrmweRK4PuFUuzn08i1pwgW943uQ5p84=;
        b=p0IHz4Vm2jY4foWf4I2P8r2Y9us9HRwAuARszCa1Q0G2B7mJDV0YTM2bIACFip8drS
         MMmeI16oc4KxHqHShRUXu0lhTPaTLRo0jxbWHt+CZAAFqNqAAIJDXrgFhDiu8XhJJddG
         q+ARDHRoBXdEJYEHZ42zRTfn9iuNGC+KVcCwu5qBTSzobLW7s2It6m8Twf2CP6N6d5AB
         Y1JstuAVAyZgtFK09Kj3eMt1B7dzDhBTnJNy5BTSntn9YT8EWn2dAF0MnDGayfoHsQ4I
         Blp5o/Ti9/3ay80H0gliA/519l5V1VrgkqUN60u+6qh4lO8sTuCrn6MZ4HFrwtI6VIDs
         DyUQ==
X-Gm-Message-State: AHQUAuaXtHQ9pPnxDdEGaUGDAXxiV90RObh2gGrnZXglgY2fnqY108lQ
        IudPWHoS7yBS6aH4wnqKbSv5yg==
X-Google-Smtp-Source: AHgI3IbBM173Fy1fNjh08Kj3gUh89Ci/3aUZahQKtXkBEZCh+yNkIsNjf8Riy/LvcOmG5xxLzmSqFw==
X-Received: by 2002:a17:902:2b8a:: with SMTP id l10mr18368898plb.70.1550394887187;
        Sun, 17 Feb 2019 01:14:47 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id v15sm5565924pfa.75.2019.02.17.01.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 01:14:46 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 0/4] input: touchscreen: Add goodix GT5553 CTP support 
Date:   Sun, 17 Feb 2019 14:44:32 +0530
Message-Id: <20190217091436.3702-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v5 patchset for supporting goodix GT5553 CTP. Here is the
previous version[1]

Changes for v4:
- document AVDD22, DVDD12, VDDIO as optional properties
- use regulator bulk calls, for get, enable and disable functionalities
Changes for v4:
- devm_add_action_or_reset for disabling regulator
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

[1] https://patchwork.kernel.org/cover/10807779/

Jagan Teki (4):
  dt-bindings: input: touchscreen: goodix: Document regulator properties
  Input: goodix - Add regulators support
  dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
  Input: goodix - Add GT5663 CTP support

 .../bindings/input/touchscreen/goodix.txt     |  8 +++
 drivers/input/touchscreen/goodix.c            | 60 +++++++++++++++++--
 2 files changed, 62 insertions(+), 6 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

