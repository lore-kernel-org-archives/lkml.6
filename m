Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09331C282D7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C854F222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEMAz8Xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbfBLU7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:59:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52366 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbfBLU7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:59:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so115011wml.2;
        Tue, 12 Feb 2019 12:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3f4KLlAiEUlxzoSJheNg+BcuiDkj9KlFe0rF13N5YY=;
        b=QEMAz8XpmkYi4DxGIai+BtR1UehJe50Zn2lVvmTIahk/b0jvqwzwU0K7b+7ikYUsY3
         CbgB+XQsJzubFBFAV1jP6Jq5NMs6OE+nTCCcWstwtNOON0VEtRCBjXZlJUwxCpgYqn0G
         xIb15vj23B4EXIllf0NfrFYQM2y4j/3ehvaeRk29Q0EfUCi6xhk/Ipi3QQohq3QVS3lx
         S55+lQqtbuCsFJQ3vEI1eO/KRs26XENzmz47kJrkFSa9Z80+jwm7eGNsIv+8w8EpPXjh
         JeOrHiDmIYxv/rXLKCGdwKH89iSsvfD1fUblc9Ajor8orlNoRy9CoR45q0sR0dzyMsp2
         /8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3f4KLlAiEUlxzoSJheNg+BcuiDkj9KlFe0rF13N5YY=;
        b=sIFolOwaFs+iZbWUYOqSqWzBnVDy+DKAR5Bq4Gl0UTFgkwdUJZ5OrnEvzETkK1+npP
         hIHhBPKKEFdcuu1FZPDEqOLyA2dqyz1SLGQEO1DxikEGVdMd8u0kA6XFRqsLZOAKPwAK
         W62QQctqEnlj0WOyd11g34mSILLmzRGzKmmdxzlj10QlPxnbqMhFYIBf66wVCslSMdFF
         1HEpVPPiAvNmUbXQBSkTp7M2Y0CJCYdxU1UUIEUBtA/6cS1No28toAq+d/IfmhMY/2jg
         bfci8+NfhZb+a7Z6XnWFg0VGTPdd87pc/L96PeVZWH8GDOA6O76TbBLO4vOfmL2H7gt+
         VJkA==
X-Gm-Message-State: AHQUAuY9aTua4xw14WwalcJuiBeMdr214spdWDuzOjpZoD8eZpoDOd1+
        INMmRVL7BQCbHudcbe86km9040B+
X-Google-Smtp-Source: AHgI3IbJuOxsib73hClcmjicj10rLH45upC37IsSGKIfAnjocit+YE8JBaUk6FgL8xocIa7kSABNOQ==
X-Received: by 2002:a1c:2804:: with SMTP id o4mr614720wmo.150.1550005161773;
        Tue, 12 Feb 2019 12:59:21 -0800 (PST)
Received: from localhost.localdomain ([46.216.128.70])
        by smtp.gmail.com with ESMTPSA id 126sm3834581wmd.1.2019.02.12.12.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 12:59:20 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1gtf9D-0003PE-6M; Tue, 12 Feb 2019 23:59:19 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v2 0/2] Intel Cherry Trail Whiskey Cove LEDs support
Date:   Tue, 12 Feb 2019 23:58:59 +0300
Message-Id: <20190212205901.13037-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces new driver for controlling LEDs connected
to Intel Cherry Trail Whiskey Cove PMIC (general-purpose LED and charger
status led). Only simple 'always on' and blinking modes are supported
for now, no breathing.

Driver was tested only with Lenovo Yoga Book notebook, and I don't have
any documentation for the PMIC, so proposals and testing are welcome.

v2:
  - Fix comments and code style
  - Add mutex to protect led state
  - Add defaults triggers
  - Fix module license declaration

Yauhen Kharuzhy (2):
  leds: Add Intel Cherry Trail Whiskey Cove PMIC LEDs
  mfd: Add leds MFD cell for intel_soc_pmic_chtwc

 drivers/leds/Kconfig               |  11 ++
 drivers/leds/Makefile              |   1 +
 drivers/leds/leds-cht-wcove.c      | 293 +++++++++++++++++++++++++++++
 drivers/mfd/intel_soc_pmic_chtwc.c |   1 +
 4 files changed, 306 insertions(+)
 create mode 100644 drivers/leds/leds-cht-wcove.c

-- 
2.20.1

