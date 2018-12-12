Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB70C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E5C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkxhFGDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E5C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeLLXII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:08:08 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40245 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeLLXII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:08:08 -0500
Received: by mail-vs1-f68.google.com with SMTP id z3so71706vsf.7;
        Wed, 12 Dec 2018 15:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imi6XQagD7h0xSaZmNzgPAYDGjcHJSTylP/Kj4iCe3U=;
        b=NkxhFGDtqj00GSXzONIpIhLoDIXJ1xpACYd+xNJU8OaCDRLxU45UsnICjA1SWM5L88
         OAr54Boc24Djsz6laG375V/YMKHP4k5omDOsW+vunL0ZNUNNzD6//RmKO78U7HfYyxPA
         UB41D9L6Ti6qxPO05a+0pQQzgCvIKQsMKdnNIkSWcOiDHM0ippj4M7dw+kEBigWb9MJf
         Q6RQSJfAQEy84pmdkjIAyEkE3KfjE9qlJcm4efh+yCGQ1DvB6msDwZWdYbkFUD0tZfjH
         Bf1FtGGO09iONVGYc30lWtCPWfmz/lXyryOItS38dK/7PIV7sDrE3Aff7HKp2cC6etpj
         sJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=imi6XQagD7h0xSaZmNzgPAYDGjcHJSTylP/Kj4iCe3U=;
        b=rcdNMRuI8YElMdFgvOaor+gFsk/KYJ9diFBbOgEGr6G+VqExjnO1DJ7hHA8BTMhr3I
         mjoMP+YqX+0OJwWHazOOOx+hWY5VI11gtcQhFFpxCDyYgbVUmB2URMkxSuev6T/+wEJI
         R6VRJMr6xd/V3tszK1AKRH+vnfSlCiA02y9NnmT8zhutb13SaPBE+chjAPJII7f9oSIq
         pDccqm93szXBOBLWI/UuFjwFxiV0mhBtdkHPePvx2UdyFxcNiTvtn2dJ7qyY3lTh/Qa5
         quMGIFX7DwRgrzGtsAyhEk15a064076OgsQIGN6Mtm3AnNnqEnaGs7xoL9CBJCY0/6jQ
         tcqw==
X-Gm-Message-State: AA+aEWbqMozARS80e5LShpXdQKN8A/xmZPV+WSRXiKbUjy/MTk2cQTWI
        rD6Xrf0d/f4fEa276XXhxw==
X-Google-Smtp-Source: AFSGD/VyWX3hzvuS7OOZvy35fe9txElaFTCqPfach4UnYwh7BwSWUHvQRJUHAJ8J6UgmCQSw7nJQZQ==
X-Received: by 2002:a67:358b:: with SMTP id x11mr10079213vsh.145.1544656086382;
        Wed, 12 Dec 2018 15:08:06 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id f68sm36630uaf.9.2018.12.12.15.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 15:08:05 -0800 (PST)
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
Subject: [PATCH v11 0/3] Huawei laptops
Date:   Wed, 12 Dec 2018 18:07:56 -0500
Message-Id: <20181212230802.21140-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is based on the new audio LED triggers in topic/leds-trigger branch from
        git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Changes in v11:
* Minor code changes

Changes in v10:
* Use ec_get_handle instead of acpi_get_handle since we are using the ec device
* Switch to WMI0_EXPENSIVE_GUID and wmi_query_block to fetch keycode when WMI0 is used

Changes in v9:
* Explicitly use NULL in acpi_get_handle
* Drop __initconst from huawei_wmi_keymap

Changes in v8:
* Switch to wmi_driver
* Use devm to allocate and manage devices
* Skip registering LED subsystem if a ACPI controller method was not found

Changes in v7:
* Use audio LED triggers patch set
* Use KEY_CONFIG (XF86Tools) instead of KEY_PROG1.
 In Windows, the key is used to launch Huawei PC manager. XF86Tools is
 used by default on most desktop environments i.e. Gnome.

Changes in v6:
* Review tags

Changes in v5:
* Consistency in file names
* How module would be enabled (Kconfig)
* Match license in SPDX and MODULE_LICENSE 

Changes in v4:
* Code formatting

Changes in v3:
* Support for Huawei MBX
* Style and formatting issues

Ayman Bagabas (3):
  ALSA: hda: fix front speakers on Huawei MBXP.
  x86: add support for Huawei WMI hotkeys.
  ALSA: hda: add support for Huawei WMI micmute LED

 drivers/platform/x86/Kconfig      |  17 +++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei-wmi.c | 208 ++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     |  22 ++++
 4 files changed, 248 insertions(+)
 create mode 100644 drivers/platform/x86/huawei-wmi.c

-- 
2.19.2

