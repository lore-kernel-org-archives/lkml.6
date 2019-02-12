Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B609C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCC82084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Q3R1m+17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfBLLYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:24:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42233 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfBLLYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:24:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so1105864pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fnBRQ8uW3dGz+L2nLKWVJhEIG0b8tWoqTQeTFXLqzHg=;
        b=Q3R1m+17F/nDIuCcPHGumBUl3y2x1CA6owJ5e3wjEONAiPZeaedGBPaU/SaIjxugGt
         EG9vliV5JeO5154+0BEC8BeD0cuZeCJIfPEVorn/mQP4a792fIaK1zw7Lmqst+yVEI6B
         Rb4UWo+E7rDozlR/IYhzW40E91Vo7IqPBPFFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fnBRQ8uW3dGz+L2nLKWVJhEIG0b8tWoqTQeTFXLqzHg=;
        b=TuZ8uYeo+duy5kzw6LtZ+p/OPBmX/bLi0G+l773nrEQkstFgaoDXqkEMewPG0bHvLY
         +bnzU6RM4NgpdLGaDqM4iRS0gtEc+KudUEoFqU2tlDykctRvY5Kh534ow58DNBvnANAT
         TuZOsPtyYWoKcwLl+CLF6Z/2AasKVSFpowUWzBRoQ+yUfzjF/J7Wzh0lA5u/7PJZqZuO
         8SoOIZZBhDNpXZBklhHieSl94k0UMXhjDq48E95sGtLJQGKlL8PYPxx7dSe17avsqH5M
         B3Z/ruqyltCVIl7sSIrzuAxU3c1bf0a9Db0A1LsQNSAdDxPfLxzuC7eoAa/u2VGJokxg
         B9dQ==
X-Gm-Message-State: AHQUAuaBLEkMNk3ySag0yTzeN0lhv3b3xBLZWSwnHDFZ4LypgpFpZOGG
        nTL5xFq74aJHE92u5t3WJQxXbA==
X-Google-Smtp-Source: AHgI3IakX8OzEGY3t2K0nkxo+KasSViEV6QQ/N2eTW0IDDGo8whfHQRtOjQOrN1bUwYsy4kRfmpD7Q==
X-Received: by 2002:a63:d104:: with SMTP id k4mr3098534pgg.227.1549970690610;
        Tue, 12 Feb 2019 03:24:50 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id q28sm22399460pgl.35.2019.02.12.03.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:24:49 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 0/4] input: touchscreen: Add goodix GT5553 CTP support 
Date:   Tue, 12 Feb 2019 16:54:35 +0530
Message-Id: <20190212112439.2025-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset support goodix GT5553 CTP.

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

Jagan Teki (4):
  dt-bindings: input: touchscreen: goodix: Document AVDD28-supply
    property
  Input: goodix - Add AVDD28-supply regulator support
  dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
  Input: goodix - Add GT5663 CTP support

 .../bindings/input/touchscreen/goodix.txt     |  2 +
 drivers/input/touchscreen/goodix.c            | 46 +++++++++++++++++--
 2 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.18.0.321.gffc6fa0e3

