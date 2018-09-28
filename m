Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5740C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E005206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbBAIoGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E005206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeI2FpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:45:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52947 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2FpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:45:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so3357957wmw.2;
        Fri, 28 Sep 2018 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7oaLS8ACfLUPYqaIS+pJ6VIS3KUj/1jvMEuK+sFryvM=;
        b=nbBAIoGdm6jLuGkXagmvLabK6Gj7ZZP92UPlfKpDtUEyqph8/e8kWst6/eZlhEeVd3
         xOjX5yWGxHUiGYNd4q1jFyYpg0Xqpp7LTxtgunyOY/QIxeHUYPGJPOy7Cb4eFM53x8Ro
         RzxT2un7EQLwTn2ip9QOlSYwmGiIDxlxvj9hxDn6kjhGLJU8r9A7iFhfFMeBYtHD8io8
         3xk12RW6UHNBhOpe+gb4+G1ExXN52bVnwbCkNtem43uAVv6dYJYJPCjCqAQm/0/2T+rH
         bAgWoGYGlPIbOGEt8wb28d0qPkoJHEz8xi2PAYvsziK25hi3u4cQGmjjnNyrRdLw1c94
         DwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7oaLS8ACfLUPYqaIS+pJ6VIS3KUj/1jvMEuK+sFryvM=;
        b=Tg6TV8GtHYpQlte+wx0EnZEzwbi3fx8wNBNuEEXMUkMfAas3jn5MfrRrjx1aB2/VUo
         shh3MZgFA/4H2fOtu+KCbmhINXgNz1adyrm3wLazu75oQpqxPjN6ITXS95ETac9Y+Krn
         GbhnysIqR6oNKjgh/f8x0JKaV8HJCRlMpBwzemCqw6AmSLCYE1xqdeexdBhbfgtBqc4o
         o+ifHY3A9krU7HHuCqGhjDY7tNUH/UnteC+H4KMUremJ//qVY9pnTuTuZ01o3pWVHtI7
         ANKp5VCYGuYHP4qC+gGMtgrBAaEqto4BQ2AQg1anevxYF3q+ST5oTBlNf00Q31c7TTZ2
         qPgw==
X-Gm-Message-State: ABuFfogezW7FQ3aY5NpI1ItN+2iaMNs4+TZIT4eiuAt6/7XXwmmSeSnq
        Qss/uBTfmqcSP0YdPk1riQxoEKIi
X-Google-Smtp-Source: ACcGV613l1miQtb6kj41UOlVUvffXBLKWW0d8/O+lYvbbZG3PrT1P/BAPaE+DHp1xxngwbN9eVvbzw==
X-Received: by 2002:a1c:f4e:: with SMTP id 75-v6mr3045159wmp.79.1538176750026;
        Fri, 28 Sep 2018 16:19:10 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 11-v6sm8590730wrb.95.2018.09.28.16.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:19:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Kees Cook <keescook@chromium.org>,
        Alexander Kurz <akurz@blala.de>,
        Hayes Wang <hayeswang@realtek.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Grant Grundler <grundler@chromium.org>,
        zhong jiang <zhongjiang@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ran Wang <ran.wang_1@nxp.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 0/7] net: usb: Check for Wake-on-LAN modes
Date:   Fri, 28 Sep 2018 16:18:49 -0700
Message-Id: <20180928231856.3587-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Most of our USB Ethernet drivers don't seem to be checking properly
whether the user is supplying a correct Wake-on-LAN mode to enter, so
the experience as an user could be confusing, since it would generally
lead to either no wake-up, or the device not being marked for wake-up.

Please review!

Changes in v2:

- fixed lan78xx handling, thanks Woojung!

Florian Fainelli (7):
  asix: Check for supported Wake-on-LAN modes
  ax88179_178a: Check for supported Wake-on-LAN modes
  lan78xx: Check for supported Wake-on-LAN modes
  sr9800: Check for supported Wake-on-LAN modes
  r8152: Check for supported Wake-on-LAN Modes
  smsc75xx: Check for Wake-on-LAN modes
  smsc95xx: Check for Wake-on-LAN modes

 drivers/net/usb/asix_common.c  |  3 +++
 drivers/net/usb/ax88179_178a.c |  3 +++
 drivers/net/usb/lan78xx.c      | 17 ++++-------------
 drivers/net/usb/r8152.c        |  3 +++
 drivers/net/usb/smsc75xx.c     |  3 +++
 drivers/net/usb/smsc95xx.c     |  3 +++
 drivers/net/usb/sr9800.c       |  3 +++
 7 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.17.1

