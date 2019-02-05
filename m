Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5F4C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3CF2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCp/YM+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfBEGnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:43:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41884 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfBEGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:43:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so1005087pgq.8;
        Mon, 04 Feb 2019 22:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AoCtcolpsDq3ZvsC0O7qKcicqzlwuQY8E2inQ9xRxj4=;
        b=tCp/YM+ed56uM7agCblTkxfj2QquvOOh02Rq+KD7HLlaomCsUG89rahICi/lGqRBzm
         NtvhNBdB9UpHq7XqDPajkSPC7jxhXj+fImLeR8j4QZfnFurUe/Rh72EFkbiSB0IeElUW
         nx2YwVnQaUO/e+5sHvntRIUen5TFlRxUFIQT+MqQC224V1S5kwOIxGneQ47eNaD7pSZc
         WrcjQQTA9xZFx4mDrSAr/Ngqn2xV3pJ8ENd4AYxHIcEDMQOcadf6/abJ2vCP1at3DKVW
         ZVBSIg2RU2Ryv8e4Vywqobob3TnE2MfU9TboH3K/V4uIofUHs3leChIrsN5wTODt3iXV
         J/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AoCtcolpsDq3ZvsC0O7qKcicqzlwuQY8E2inQ9xRxj4=;
        b=R3hxXADSIX16TCXoBMP1NrVoAb+DAL34Z8BuoW5Si5prKaiSQ/g5USQP3BzkE15lhx
         ygIf3+A9AJ5HrSoeY/FJrSuH2kQ6jIp6j1b0PE872/1MxkFrf51GFIHw+/WRkFF/ARnZ
         ekMGI0ibBJo0IAmTkWkO4lwhuNRFOcnkyYav70QUMWZfs2mUWpwvvW1fs8uHRtSg6x0D
         TRMVBV3kheHWyOx+ni6wQ09pZKC9ejRu0WQY5lkAOWwxiSTnzgSTHjM7OBbkz3LFA+Pb
         YNdfSQ5JDmsJnjLoFfKpyf+7mTxP+Vzreb3v4U4YnFJ+zuJ6nS9HzNdz2b/8SAPD6H0I
         n3Ew==
X-Gm-Message-State: AHQUAuYtwr79ugQFqbJdGoRgtE/WGTcmD0Hm0s/NMXfgsMqekGD55LeG
        mXYw+3rIHFvOn2rdVz8jyDU=
X-Google-Smtp-Source: AHgI3Ia8QT2QGTQHKAjk55ul7Va9m/0OlbFIv6NIuAZa8VoXX38GTQ7xPAFua1bY7pbhImAxxdFY4w==
X-Received: by 2002:a63:c444:: with SMTP id m4mr3178253pgg.310.1549348984849;
        Mon, 04 Feb 2019 22:43:04 -0800 (PST)
Received: from localhost.localdomain (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.googlemail.com with ESMTPSA id k24sm2823687pfj.13.2019.02.04.22.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 22:43:04 -0800 (PST)
From:   Myungho Jung <mhjungk@gmail.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Myungho Jung <mhjungk@gmail.com>
Subject: [PATCH v3 0/2] Bluetooth: Add NULL check for tiocmget() and tiocmset()
Date:   Mon,  4 Feb 2019 22:41:40 -0800
Message-Id: <cover.1549346039.git.mhjungk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tiocmget() and tiocmset() operations are optional and some tty drivers
like pty miss the operations. Add NULL checks to prevent from
dereference.

Myungho Jung (2):
  Bluetooth: hci_ath: Add NULL check for tiocmget() and tiocmset() in
    ath_setup()
  Bluetooth: hci_ldisc: Add NULL check for tiocmget() and tiocmset() in
    hci_uart_set_flow_control()

 drivers/bluetooth/hci_ath.c   | 6 ++++++
 drivers/bluetooth/hci_ldisc.c | 4 ++++
 2 files changed, 10 insertions(+)

-- 
2.17.1

