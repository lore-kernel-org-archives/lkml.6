Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2ADC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F6B2146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzylELZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F6B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbeLGO3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:29:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35992 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeLGO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:29:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so3737489ljk.3;
        Fri, 07 Dec 2018 06:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sF0pCHT7D1F2NOjqJwt6ksiA4U85wwi9Q90+TSNTC9s=;
        b=rzylELZ+EaX3sCY/9gbV+UlMtq9pMzIL6/l3zhtPrt2X8c1OwvretUdvx2GNdlH5+W
         d42GBNkdkq5YNJwJubIsFFV+YECLTYPCnzd/kPZifg+bjsEhEqd5RSU94pvdNW8sv2V1
         7biz2NHi1OIcG4nTSXMnewds5r3Qe8hwjQAIQjArgyrc/5nNYh7L7WZa26P1Q8DWM2/D
         lMu9rOXAJyvUb7D0HsQ9I8LTknFoLY03AisY9/p36yCBznTbZocvUjJr2ya4MT+Yns5O
         kA2ble84SCREjUWO4ogY9jmsTivpZ2DO/ctX0+THUHfe/PoHte+5aaoZyX0cgOc9PfIK
         QoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sF0pCHT7D1F2NOjqJwt6ksiA4U85wwi9Q90+TSNTC9s=;
        b=sGUBCDbH1pTiiP2eSzsNgE+9QcsuWsEm9VnqdMxSSYiYlB4QpBS4W0l+JcpiMrhoca
         3lI/79YbugqNfJA/Mc/4GgOjhqkZBepiCKgDaBXK5M8Dm49tf+GzTF1Ijj/hSzhON9NS
         zSN1aQAieZbS7FQiPnqpBlgvJzacbWNXkm6iPfZnXOKl6rKXdA69M8mcMTZA+91ZIubV
         xhu9OsZ8maBu0hVuZxuTdFXOr/0WabmUnBFuLJ06oOQfMo3/LwcU52rS3gHjxrZXpduJ
         tAHrIPnuaPTWdmj+PMWdtM5JGQInK2XUbHc+60xiXTxQP8RnZbqLSSG6DiQ7cOrnRDKw
         6zOA==
X-Gm-Message-State: AA+aEWZkyzQh/Ve4aU/FhSzxvZYWZYCFBVHYGvgCHD4xVqW8puurML/d
        QfaK+pOdJBufWnA/RueDYU4owBFZNko=
X-Google-Smtp-Source: AFSGD/UB6LFrnIqC0oafrWYff6XsukLwntM2AiDS5RqUneHgtitpZgg3O4yijeEypsTs9NsoSkzsNg==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr1438248ljd.137.1544192941567;
        Fri, 07 Dec 2018 06:29:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id v64sm630504lfa.48.2018.12.07.06.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:29:00 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v4 0/3] Input: atmel_mxt_ts: Add support for optional regulators
Date:   Fri,  7 Dec 2018 15:28:54 +0100
Message-Id: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds optional regulator support to atmel_mxt_ts.
First patch adds regulators to driver.
Second patch ensures that device is ready for communication.
Third patch updates documentation.

Changes from v3:
  - Checkpatch fixes
  - Drop punctuation from subject of one of patches

Changes from v2:
  - Add reviewed-by to one patch
  - Move code for enabling regulators into separate method,
    to make code more readable.
  - Add wait code, to ensure that device is ready for communication.

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get.

Paweł Chmiel (3):
  Input: atmel_mxt_ts: Add support for  optional regulators
  Input: atmel_mxt_ts: Wait for device be ready for communication
  Input: atmel_mxt_ts: Document optional voltage regulators

 .../bindings/input/atmel,maxtouch.txt         |  8 ++
 drivers/input/touchscreen/atmel_mxt_ts.c      | 76 +++++++++++++++++--
 2 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.17.1

