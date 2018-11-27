Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20385C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61E92082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8LYJDTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61E92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeK0Nyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:54:52 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33273 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeK0Nyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:54:51 -0500
Received: by mail-vs1-f66.google.com with SMTP id p74so12846703vsc.0;
        Mon, 26 Nov 2018 18:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SpCvJ6dOQ1Y5lk0r4h7DY38+z30ZZLzFsOr0MjWx4w=;
        b=I8LYJDTsNmZy4UEtcRhhcXe1sBltqIlquc7E5ObHN/py69RkGWKrr83SQRW0qKYRFR
         u+rkNYa56PnZPOOsYCbncSqQU8m5A/gZoS6500VaUMUkSlMFi9QFFyVV4Kms7syDZ63I
         OAUxfJKY98HSW3s6iVJJR+Nm9Z5h8qnKlU5/mbsqHcI83ePJtlX8+VTHtr5XwgtlHgEt
         EOfm+BfV0loUBgp/XAg5F1OPwG+3bcKrX/EUZcATF0xkE3BLWSWszXnsvIvpEWnIR7Yq
         w6ndAgWOdJMVvMqGr2+mDwJgr0VUo92woXN+MP6YYSAEAN0+2q3ulZT+xleZRSLmJjKm
         OyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+SpCvJ6dOQ1Y5lk0r4h7DY38+z30ZZLzFsOr0MjWx4w=;
        b=mZPgbxryJfphfs2JcqhruO3FpFIlxTwDTEClGFLhNdM8y9INLFsxJI/ijKa/ZA0f71
         4DGY5OyhKMgf33mbDECPVUoR5P3Rlrn1lCwdTHAkXOIpOXmW8Q3m2dQ7i6zWD/kPRtRR
         ZJIKF+cq98qRqgalvxsZ3ZuH5ESehXE603LZDwhDyXwL5XoaQWh5opx8uKBk20QJ/gKa
         so1OHMLa3jx4gcGhvk8yQJaPJ+d2Sz710LZ1ojUc3nRRLLnXkW4mWYbh5rCTzuC3cIxP
         joGk+tLBK/ykfUcE4BQFBb8/THDXLbP5U0CgYKLcSC0SKLFx9++IcpW95eEluMGcnPy/
         KFZQ==
X-Gm-Message-State: AA+aEWZF1i4xINOeXGZ6rrt7/hf05/dzMiFCW3++dkczm9Gs8WqVpNtR
        +zEVZnkOU8nl8f3Kudr4kw==
X-Google-Smtp-Source: AJdET5fCROV/XZnFJ1//ypWwFqmsi1zmNZTbFKQ3ewJ/DgAv/iugvGuMLJmnoVPtyLHcY4ypytXxLw==
X-Received: by 2002:a67:340f:: with SMTP id b15mr13311192vsa.202.1543287510139;
        Mon, 26 Nov 2018 18:58:30 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id j82sm1006934vsd.23.2018.11.26.18.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 18:58:29 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v7 0/3] Huawei laptops
Date:   Mon, 26 Nov 2018 21:57:46 -0500
Message-Id: <20181127025752.6459-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is based on new audio LED triggers in branch topic/leds-trigger from
	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Changes from v6:
* Use audio LED triggers patch set
* Use KEY_CONFIG (XF86Tools) instead of KEY_PROG1.
 In Windows, the key is used to launch Huawei PC manager. XF86Tools is
 used by default on most desktop environments i.e. Gnome.

Ayman Bagabas (3):
  ALSA: hda: fix front speakers on Huawei MBXP.
  x86: add support for Huawei WMI hotkeys.
  ALSA: hda: add support for Huawei WMI micmute LED

 drivers/platform/x86/Kconfig      |  15 ++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei-wmi.c | 247 ++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     |  22 +++
 4 files changed, 285 insertions(+)
 create mode 100644 drivers/platform/x86/huawei-wmi.c

-- 
2.19.1

