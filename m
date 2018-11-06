Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450EFC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED657204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDPSyHiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED657204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbeKGHfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35043 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbeKGHfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so12958235ljb.2;
        Tue, 06 Nov 2018 14:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ncxkvlahrlQd8xetQT4yJLWgC7JMkvJiyHG2Fph0ZVU=;
        b=aDPSyHiG7nrI2cc9tfq45R6jOd7PRptvhLfT4OGUiol1oDbGH8VC03+oVekBJtHMKl
         ddP0CbNULbpRXoY08yrCtiirJpJZW4F4MQBJ5t0T3F7lsnKXsP9Ib3/F5fOV4C0st/CL
         RpG//iXr3x/ZxaKm7gpHxY8ZYPHlaZR1ci8cqvr0xkGUqFx2GULp7Vz53IyEjT4mwuAz
         kWtP1HJyDPuUu1UB+1VuvnYLbdxL21aKva2P/900IJNApF/XE3lbNy9/hETDMvKl16P+
         ULaElOghQouF6DooMRY/eqVUnv78r3X7HUlbGNvRfSqaY9LsfCH8voLaCDkvFnn3rQY6
         UG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ncxkvlahrlQd8xetQT4yJLWgC7JMkvJiyHG2Fph0ZVU=;
        b=lHeYlVsRBvPKiyMaHQHAMnMS23kEk2EEuG4im8ni9+l/QnIgrRoON2JdYRNvuXnJHJ
         wfwGop9jMNIsRjKYLTWXnO3Y/e/nZUpW5tgIH8MwKL6GizKJaMmlHrZJPj6A+oEOXLGg
         xl/j5iIjKRBp5v6WZ1L9k7xoMVyPbMuKUp09wsbPRZbPM0HdjJpMhpVFHSRwDCFQ8dGn
         fnqL4e//w+oIbPJwlP32iXrTzZR3RBQ+YgQE/rtzi52q9z/HnVkgl3UGUfZhqetydfZr
         6D1zX6we8mhnMF02PYVhm9NJnj/y1+Ac8JoD2DslKizZGLCy5G0p4BLvLMxXivPZH0cR
         GgPQ==
X-Gm-Message-State: AGRZ1gICeQ+KaZovbDJmBGOj5lMjEXPMvDyIMtwUJrwDRc6FYlLs8/Hm
        aPvmxY6zlY5pYyVgPTDYCUReQGnL
X-Google-Smtp-Source: AJdET5fHtEUp21cUhJ98thpAmJHxNsrMflVOlvneks7XxU7Ct3I8JbkWwYEVSLI2KJtDSNUXEWF07w==
X-Received: by 2002:a2e:9d86:: with SMTP id c6-v6mr4677914ljj.146.1541542069769;
        Tue, 06 Nov 2018 14:07:49 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:07:49 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Subject: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
Date:   Tue,  6 Nov 2018 23:07:11 +0100
Message-Id: <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common LED function definitions for use in Device Tree.
The function names were extracted from existing dts files
after eliminating oddities.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
---
 include/dt-bindings/leds/functions.h | 101 +++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 include/dt-bindings/leds/functions.h

diff --git a/include/dt-bindings/leds/functions.h b/include/dt-bindings/leds/functions.h
new file mode 100644
index 0000000..3f94e09
--- /dev/null
+++ b/include/dt-bindings/leds/functions.h
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define LED_FUNCTION_2G "2g"
+#define LED_FUNCTION_ACTIVITY "activity"
+#define LED_FUNCTION_ADSL "adsl"
+#define LED_FUNCTION_ALARM "alarm"
+#define LED_FUNCTION_ALIVE "alive"
+#define LED_FUNCTION_ALL "all"
+#define LED_FUNCTION_APP "app"
+#define LED_FUNCTION_AUX "aux"
+#define LED_FUNCTION_BACKUP "backup"
+#define LED_FUNCTION_BACKLIGHT "backlight"
+#define LED_FUNCTION_BACKLIGHT_CLUSTER "backlight_cluster"
+#define LED_FUNCTION_BEEP "beep"
+#define LED_FUNCTION_BLUETOOTH "bluetooth"
+#define LED_FUNCTION_BOOT "boot"
+#define LED_FUNCTION_BOTTOM "bottom"
+#define LED_FUNCTION_BRICK_STATUS "brick-status"
+#define LED_FUNCTION_CEL "cel"
+#define LED_FUNCTION_CEL_PWR "cel-pwr"
+#define LED_FUNCTION_CEL_RESET "cel-reset"
+#define LED_FUNCTION_CHRG "chrg"
+#define LED_FUNCTION_COM "com"
+#define LED_FUNCTION_COPY "copy"
+#define LED_FUNCTION_CPU "cpu"
+#define LED_FUNCTION_DEBUG "debug"
+#define LED_FUNCTION_DIA "dia"
+#define LED_FUNCTION_DISK "disk"
+#define LED_FUNCTION_DISPLAY_CLUSTER "display_cluster"
+#define LED_FUNCTION_DOWN "down"
+#define LED_FUNCTION_DSL "dsl"
+#define LED_FUNCTION_ENOCEAN "enocean"
+#define LED_FUNCTION_ENTER "enter"
+#define LED_FUNCTION_ERROR "error"
+#define LED_FUNCTION_ESATA "esata"
+#define LED_FUNCTION_ETHERNET_STATUS "ethernet-status"
+#define LED_FUNCTION_FAIL "fail"
+#define LED_FUNCTION_FAULT "fault"
+#define LED_FUNCTION_FLASH "flash"
+#define LED_FUNCTION_FRONT "front"
+#define LED_FUNCTION_FUNC "func"
+#define LED_FUNCTION_GPIO "gpio"
+#define LED_FUNCTION_GSM "gsm"
+#define LED_FUNCTION_HD "hd"
+#define LED_FUNCTION_HDD "hdd"
+#define LED_FUNCTION_HDDERR "hdderr"
+#define LED_FUNCTION_HEALTH "health"
+#define LED_FUNCTION_HEARTBEAT "heartbeat"
+#define LED_FUNCTION_HOME "home"
+#define LED_FUNCTION_INDICATOR "indicator"
+#define LED_FUNCTION_INET "inet"
+#define LED_FUNCTION_INFO "info"
+#define LED_FUNCTION_INTERNET "internet"
+#define LED_FUNCTION_KEYPAD "keypad"
+#define LED_FUNCTION_LAN "lan"
+#define LED_FUNCTION_LEFT "left"
+#define LED_FUNCTION_LIVE "live"
+#define LED_FUNCTION_MICROSD "microsd"
+#define LED_FUNCTION_MISC "misc"
+#define LED_FUNCTION_MMC "mmc"
+#define LED_FUNCTION_NAND "nand"
+#define LED_FUNCTION_NETWORK "network"
+#define LED_FUNCTION_ON "on"
+#define LED_FUNCTION_OS "os"
+#define LED_FUNCTION_PANEL "panel"
+#define LED_FUNCTION_PMU_STAT "pmu_stat"
+#define LED_FUNCTION_PROG "prog"
+#define LED_FUNCTION_PROGRAMMING "programming"
+#define LED_FUNCTION_PULSE "pulse"
+#define LED_FUNCTION_PWR "pwr"
+#define LED_FUNCTION_QSS "qss"
+#define LED_FUNCTION_REAR "rear"
+#define LED_FUNCTION_REBUILD "rebuild"
+#define LED_FUNCTION_RIGHT "right"
+#define LED_FUNCTION_ROUTER "router"
+#define LED_FUNCTION_RS "rs"
+#define LED_FUNCTION_RX "rx"
+#define LED_FUNCTION_SATA "sata"
+#define LED_FUNCTION_SD "sd"
+#define LED_FUNCTION_SLEEP "sleep"
+#define LED_FUNCTION_STANDBY "standby"
+#define LED_FUNCTION_STATUS "status"
+#define LED_FUNCTION_SW "sw"
+#define LED_FUNCTION_SWRDY "swrdy"
+#define LED_FUNCTION_SYSTEM "system"
+#define LED_FUNCTION_TEL "tel"
+#define LED_FUNCTION_TOP "top"
+#define LED_FUNCTION_TORCH "torch"
+#define LED_FUNCTION_TV "tv"
+#define LED_FUNCTION_TX "tx"
+#define LED_FUNCTION_UP "up"
+#define LED_FUNCTION_USB "usb"
+#define LED_FUNCTION_USB_COPY "usb_copy"
+#define LED_FUNCTION_USER "user"
+#define LED_FUNCTION_USR "usr"
+#define LED_FUNCTION_WAN "wan"
+#define LED_FUNCTION_WIFI "wifi"
+#define LED_FUNCTION_WIRELESS "wireless"
+#define LED_FUNCTION_WLAN "wlan"
+#define LED_FUNCTION_WMODE "wmode"
+#define LED_FUNCTION_WPS "wps"
-- 
2.1.4

