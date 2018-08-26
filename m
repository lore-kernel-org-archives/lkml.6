Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B58C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710812086A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/oVb1Kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710812086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeH0A6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:58:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37648 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeH0A6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:58:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so9112083eds.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 14:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wX1TzTruBVv+m8QSn9dlWSxL7KPLTLX652RKtUlYisc=;
        b=l/oVb1KzvYN0VwkJ7RRu/7Dz5qWQqsMMOALeDybHoR4QU7/9SDaa2ikY2nRl0Uqf4l
         esi0SJrMXUflVq5d75Yi2Q49AsBVuLe/mg6VeHrEeqEF9hM7z7BExx/Jip6D8nglV8Lg
         UHNKAJS9TQPAMw8eXmYKa6uVa9oYYj0Sr7hgSmRc2JDqX6oIpBSMaNqjzIsxaHi9cAEJ
         SU5NlDwwc0aESCOc/VWLj2LgqEzNnkVh5ML5dc64hqVKoigIwdhikBFlhHCJyoNumjz+
         L7Dw9thG+E/jxdQ9LQsuAMp+pitf4gc/Stt5SHEmnYu9QTgdXIm1ovHHdtvb0gGEuvND
         wEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wX1TzTruBVv+m8QSn9dlWSxL7KPLTLX652RKtUlYisc=;
        b=cPCGRb3acip75hSZzhI4WfqD27KRbXInDhyQUo5yJJVwxRS0OuN4HxD0O8cFKCGy3A
         RIgOPVNDnheaLKkV/Wfrm3/4fX0qrAHl9IohqSSl1zfhb2FUSfucEujDUnxDFhhli5N0
         LJebWyFaGz8b4ilTPKOkZujQpbIIhn2CoCmNF/EN+R8wR5UVKNZCzqc8s9pQzH8h4YqC
         rAToqm7Oeg6vYllC1zWbAUOxzw/p6XkadYBTvaBwz4qIzHBVA/4Rd9Y5wSEMFUzwmMXi
         I8P8DcMYjNQitDz0IKT7r5Vjiy7Go+SvHwo0wg6Hu7tih+QX5NKMsB1FTXmaY62eyucx
         2LJg==
X-Gm-Message-State: APzg51DsJ0nk2SxV6SkFyqiQKN1MbFZ2cjgpMJVRCXqXnLDWkP88wJCJ
        /WsKYbqtPkFuwKHt2RUiaDnK9AKU
X-Google-Smtp-Source: ANB0VdaiASlHGHeT+4X2Ajbosy53I/aXnYqRunLc6pyofYIlVVExCoSTQd3+PgPRne9RnGJl1gxPYg==
X-Received: by 2002:a50:ce5e:: with SMTP id k30-v6mr13560152edj.207.1535318095294;
        Sun, 26 Aug 2018 14:14:55 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id b47-v6sm5937300eda.79.2018.08.26.14.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 14:14:54 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/21] staging:rtl8192u: r8192U_hw.h - Style
Date:   Sun, 26 Aug 2018 22:14:18 +0100
Message-Id: <20180826211439.14326-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches contain simple coding style changes to the file
r8192U_hw.h, most of the changes are to clear the CamelCase issue in
checkpatch. To minimise the number of CamelCase names which have to be
renamed the unused definitions have been removed from the header file.

John Whitmore (21):
  staging:rtl8192u: Refactor enum VERSION_819xU - Style
  staging:rtl8192u: Refactor RT_RF_TYPE_DEF - Style
  staging:rtl8192u: Make function rtl8192_phyConfigBB static
  staging:rtl8192u: Refactor BaseBand_Config_Type - Style
  staging:rtl8192u: Remove unused definitions - Style
  staging:rtl8192u: Reorder enum _RTL8192Usb_HW members - Style
  staging:rtl8192u: Rename EEPROM_TxPowerDiff - Style
  staging:rtl8192u: Rename EEPROM_ThermalMeter - Style
  staging:rtl8192u: Rename EEPROM_PwDiff - Style
  staging:rtl8192u: Rename EEPROM_CrystalCap - Style
  staging:rtl8192u: Rename EEPROM_TxPwIndex_CCK - Style
  staging:rtl8192u: Rename EEPROM_TxPwIndex_OFDM_24G_V1 - STYLE
  staging:rtl8192u: Rename EEPROM_TxPwIndex_OFDM_24G - Style
  staging:rtl8192u: Rename EEPROM_TxPwIndex_CCK_V1 - Style
  staging:rtl8192u: rename EEPROM_TxPwIndex_Ver - Style
  staging:rtl8192u: Rename EEPROM_Default_ThermalMeter - Style
  staging:rtl8192u: Rename EEPROM_Default_PwDiff - Style
  staging:rtl8192u: Rename EEPROM_Default_CrystalCap - Style
  staging:rtl8192u: Rename EEPROM_Default_TxPower - Style
  staging:rtl8192u: Rename EEPROM_Customer_ID - Style
  staging:rtl8192u: Rename EEPROM_ChannelPlan - Style

 drivers/staging/rtl8192u/r8190_rtl8256.c |   6 +-
 drivers/staging/rtl8192u/r8192U.h        |  16 +-
 drivers/staging/rtl8192u/r8192U_core.c   |  44 ++---
 drivers/staging/rtl8192u/r8192U_hw.h     | 204 +++--------------------
 drivers/staging/rtl8192u/r819xU_phy.c    |  15 +-
 drivers/staging/rtl8192u/r819xU_phy.h    |   6 +-
 6 files changed, 71 insertions(+), 220 deletions(-)

-- 
2.18.0

