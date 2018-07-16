Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82B9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8207F208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y70OBVTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8207F208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbeGPTeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:34:10 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:45089 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbeGPTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:34:10 -0400
Received: by mail-ed1-f42.google.com with SMTP id i20-v6so17740258eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0v3l1kNCatU6AGmaOr95xAIrHZ0QRpqReY2/nqJA/q0=;
        b=Y70OBVTVMgQgAlhxBadgyAe/xHLQkEUNejB52sC7w9/lkYjeuLiwWbJUXXS83W0TaI
         eSdzv1eO+8ZR2VAjL+dGEfo6qxckjH71vUiNtsFlZ+zixF+lbphsSKvGsTnzdU3uSXyG
         JyxdRNx9cxY0SRFpPHYnxXpjPD4NRKa95npCz/iW83D30YMkhiK35knOuoVL22K31e1c
         rd3xeOD8qLC1U/Le053L8He//znA7+P7wjlOMUs7Ilyb347qYUKCV3X6L92ftZDrDLwP
         Pn3c6PCj3wmCwTnBF+MTMof1UtC1/Nm0RX2nroBYHThWpFyO6pNPQRRjg4knkWkmsEEj
         2iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0v3l1kNCatU6AGmaOr95xAIrHZ0QRpqReY2/nqJA/q0=;
        b=pliTh9msK/upI/Hrxz3nKWv4Nm79XTB1Tlkjo87wsobk5q5az8T2cWc7CME6xhUONC
         sMwOaCsSsX3ZpDK6UG82vkiAnb+p9hMsAssitEMEb60JrRxQ0e6Y8/WjgTJAl9bQOdjS
         nu+4jJHMKOOWWT2oWd7qk04H5Zk4fIBec+Qd1O9nrzXPY89bbkiaNrfYvg6vBDHVcYI/
         7fW77ipeWUbpsaoOc3NVlZb47+WlGI1NbZX8w6K21kuVL7Tm+GH7gBFBY/oarUyDk/RP
         PL4XT0t1lwqQjnSz9aevKDWxdYAPv5h2ERFjvUfKxvUzZyhE8R1Jp5yVnlTONwfO1lnZ
         BIQg==
X-Gm-Message-State: AOUpUlH2NpMMCyg7lKYo5+LLXsi5h5Cq4TsAR6DsiZyz3j7ZAdQs/pa5
        Pxj97Z/E+Rk3q5FgZEMzZXfGgQ==
X-Google-Smtp-Source: AAOMgpcRW14+CG7T/KD5OYdmVxYVTnc2tnXGDIB7AfpsRdsi3s7f8hP+J4leiS0b6SDTFLYaIIkb+w==
X-Received: by 2002:a50:b807:: with SMTP id j7-v6mr18309228ede.206.1531767923252;
        Mon, 16 Jul 2018 12:05:23 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id g14-v6sm19098643edm.25.2018.07.16.12.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 12:05:22 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 00/10] staging:rtl8192u: Coding style changes.
Date:   Mon, 16 Jul 2018 20:04:44 +0100
Message-Id: <20180716190454.31489-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple coding style changes to avoid CamelCase.

John Whitmore (10):
  staging:rtl8192u: remove typedef of enumeration TR_SELECT - Style
  staging:rtl8192u: remove typedef of struct TS_COMMON_INFO - Style
  staging:rtl8192u: Rename List > list - Coding style
  staging:rtl8192u: rename SetupTimer > setup_timer - Style
  staging:rtl8192u: Rename InactTimer > inact_timer - Style
  staging:rtl8192u: Rename Addr > addr - Style
  staging:rtl8192u: Rename TSpec > t_spec - Style
  staging:rtl8192u: Rename TClass > t_class - Style
  staging:trl8192u: Rename TClasProc > t_clas_proc - Style
  staging:rtl8192u: Rename TClasNum > t_clas_num - Style

 .../staging/rtl8192u/ieee80211/ieee80211.h    |   6 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c |   4 +-
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |   4 +-
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       |  30 ++--
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |  28 ++--
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 142 +++++++++---------
 6 files changed, 107 insertions(+), 107 deletions(-)

-- 
2.18.0

