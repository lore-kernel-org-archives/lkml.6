Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B354AECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78938206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlOgXmUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78938206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeKIFVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:21:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46814 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeKIFVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:21:45 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so28575888qkf.13;
        Thu, 08 Nov 2018 11:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3/pBRhFJr0N/8WVCcWBcBPmZEZPBDBOyE8VzlZlAia0=;
        b=YlOgXmUhuN0jKTwWhoUSyptLn/iDU08nDOq1bTty2+fzFFE4fSebyVHWLw3D1kCfjg
         43oi5ADXwJEjibTAEdFu6vdclXzSMJv6B/zC9PIsIjHr0T+SqaSSjDMi26lGHrol/sOX
         n19Wm+nmiSJ39wP7ojbh8XSYEZAfjhUx5wG6UxUZny7Ukv9H1bNk32ejhXKs57z2dJee
         WVV+vnVz7J2ga0ArEy8R5M+JdLVMod7wd0nVVjVBIfpl9/12d2DPY8KM3COuHog/Bhzx
         vlH0jY98xTj86tORBE7u97hEvTD5L3Iuww5WIPtddtP1S0v6qD76cK+6hwWJTBhkZY1g
         3T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3/pBRhFJr0N/8WVCcWBcBPmZEZPBDBOyE8VzlZlAia0=;
        b=rLCZ+PSOYT1eE0mLHwjXxaIG7jFtzMUuoZsJ0pDLdXnyfVtDZvRuYbsNPcVFsapKJv
         8R2Bl/l0TqUUnllfT0Wq8ejdtKW4ohWWE9phd3yHBQp1esAkshC9lKSIjspB5cp+E3eV
         9nj4TOpVY31r9WrB6p+vdN3ht+lOh/3yVyejDd0kZ/Zlk+P8BBN80v1DaOj695Dsj5UW
         Ws3VEqbAcQ+9uEiXsLrDmSg4cZ6/IwjVMgSIKPvSZnaJmzBpu2b8XLyyXorWe+ntLy2A
         3BJm8WoSFECwza1SBB1aPjhy5XtSZBOItJ7bR8iPa0+7tJKMMIWQwWOeknYEFyzNh5NC
         mXJQ==
X-Gm-Message-State: AGRZ1gKEkohk0etIOSyOLCjBuIAL4f/LR8rzGBaNzd3hQ4M6ySf1R2X5
        DnGaahw/d+J2MaXSerlLxpU=
X-Google-Smtp-Source: AJdET5fmjdnl3SM8zkZBkbOwKal5f0THtTVBGvq5UiJQmu+xq/j+tTdanpBLh3bRntyL8eMW9PiT1A==
X-Received: by 2002:a37:15c5:: with SMTP id 66mr5724044qkv.16.1541706288456;
        Thu, 08 Nov 2018 11:44:48 -0800 (PST)
Received: from localhost.localdomain ([50.224.228.202])
        by smtp.gmail.com with ESMTPSA id w52sm3406414qtc.51.2018.11.08.11.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 11:44:47 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v3 0/3] ARM64: dts: meson-gxl: Add dts and bindings for Smartlabs SML-5442TW
Date:   Thu,  8 Nov 2018 23:43:50 +0400
Message-Id: <1541706240-30036-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new bindings and a device-tree file for the Smartlabs
SML-5442TW set-top box.

v3 - change to Smartlabs LLC
   - removed sound node
v2 - removed audio nodes
   - changes soundcard name to "meson-gx-audio"
   - added missing uart-has-rtscts;

Christian Hewitt (3):
  dt-bindings: Add vendor prefix for Smartlabs LLC
  dt-bindings: arm: amlogic: Add support for the Smartlabs SML-5442TW
  ARM64: dts: meson-gxl: Add support for the Smartlabs SML-5442TW

 Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 292 +++++++++++++++++++++
 4 files changed, 295 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts

-- 
2.7.4

