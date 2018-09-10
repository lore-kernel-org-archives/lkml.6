Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF0FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA69C20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="AeHBLbrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA69C20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sweptlaser.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeIKCde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:33:34 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:41406 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeIKCde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:33:34 -0400
Received: by mail-io0-f181.google.com with SMTP id q4-v6so1907389iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=tKod6Zino/0O/aALEtjbNqJhkF+s9G0LvfPcCRDk3Gk=;
        b=AeHBLbrAxy+7oS+rPYJIVpogyRR5/DLYZg9z3ggTCKQJyazWDp5fFXPKbeKZMlBSSr
         9dy7zKzyt2Q+qIwjiyjPCL0znly/I/3bP8gwAQf+E7x47Eg29UH986Z7mOBz9as6DjJu
         H2/OfPc2p9ISxa3EIsokF/9eSA1m59RT1aZorHvxAv5U10yAYrZrYTHan1d+zOC6W2EO
         yL5TTiIYNCGDoS6shcnQQG7cZrmVDDBJAwZb+wnv4LcjNHuFwKB/mDNls8AFnaL8btJS
         Urs8Nt2jGBTzYW/0wXShLoL3aQ4bvjdBQWPdE0S4vBW8zTb37/4wDY5mL6Zw+Kqui9Yw
         DQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tKod6Zino/0O/aALEtjbNqJhkF+s9G0LvfPcCRDk3Gk=;
        b=VYbVVzMhFHno9nAOwcdBWsaOiAdFu4X6ySTNVcJNK1Bh5uX9alWKLZdioHqdfDYHMH
         ohzJ/msOQ8hIjR17XnQfojMxmz1FTzvFDdTxtmH34DPmzV2FXahFvoxzH6kTJg0gMl01
         tYKBD9Ng6RIvJIXQ2l4EyvHgk476I6kU+Bo1o9LMDqd53ygw8SCGbBdOS8AVfw8WqDfg
         CWmoRwkXqGaa5+ogH1O2zV1iP4/TO8+GB4Wz//1dgx79w0imjc99jWn9D80D3X6VSVSO
         H8LELavMHXX4aUI2rVnroMHeHuJ45+itjLo7zqlaaYZ9nuiNIYdQ7/TC3g+/xB94bVma
         weiw==
X-Gm-Message-State: APzg51CGkUJlLYvuqD+4x/gI+8D9xDqMp5RdMlFd/6uyEh6ewrcj/3WR
        5iGYl5zjY4+XmafDGlYl7EvwMQ==
X-Google-Smtp-Source: ANB0VdaSVOlCg+7W5B30/J2DG0bqZtNjfgABqAl5X/YTGtTMtcCXTNJrwFS2+9LPwmUIOM+PLvOG2Q==
X-Received: by 2002:a6b:928b:: with SMTP id u133-v6mr18225599iod.296.1536615452757;
        Mon, 10 Sep 2018 14:37:32 -0700 (PDT)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id q68-v6sm7377952itb.23.2018.09.10.14.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 14:37:32 -0700 (PDT)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] rtc: abx80x: add basic watchdog support
Date:   Mon, 10 Sep 2018 15:36:52 -0600
Message-Id: <20180910213654.26059-1-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds watchod support for abracon RTC chips which
include basic watchdog functionality.

Changes in v2:
* split out priv structure into a separate patch
* remove new Kconfig option
* fix CONFIG_WATCHDOG dependency
* fix WDT interrupt message


Jeremy Gebben (2):
  rtc: abx80x: use a 'priv' struct for client data
  rtc: abx80x: add basic watchdog support

 drivers/rtc/rtc-abx80x.c | 159 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 147 insertions(+), 12 deletions(-)

-- 
2.17.1

