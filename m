Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FD6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1D720881
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="nWaL9hDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1D720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeGKG4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:56:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43086 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeGKG4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:56:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id u11-v6so18335987eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 23:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=j58CmjEPdUUebNEmaWOWj1rQ4epJQWgB/y3ZtJIAoAI=;
        b=nWaL9hDuucIyv/Iix7bPop8bLnKUnsElcws20qWowIbHccx7Il8wQS95ewytubUvel
         FWCoRKpZNAfUzyGf6gbXd2o6nF+U+yJWxUH69wEKOGhw1dLEsKV/OD/iuVsbsmhIzAeL
         7wtAABIVeNSq8Twy8s0BBxWEbXrU+EyH4FfSXU5HvDKG39TZWMGpkXw1qdNvP4Z+CdLw
         GQYzP8ALyTkniH79GUX2K6z8UyPe9cURnC5S3AQZb0OdJqkL9vPYlvzwyxlsFHeUVt4P
         HbsiztDgINmEiGBMuFNpJVS4A1v5EnbKW8U829y5i3MsCCYENfk8KxNbDhnwYIvmdoNj
         zx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j58CmjEPdUUebNEmaWOWj1rQ4epJQWgB/y3ZtJIAoAI=;
        b=hHlyZBU06BS7PBSKTV1E/zyhjfWqakfvesl3jl1qBxOxbfW7q2WFI7dnx0Y6uaotHv
         /rL41jC2oF5YIHH7y7Vh2cCYqsOxwJbGdkfQXSOQ7FBMrmfqbhOl6qV2MVcZpt1hy5ev
         IxHjFn/ZVs6o5PGq0LC2DGKM6B7oWfgImrTAx1cBsYZPDh9/3qAVmNZygMZqvXQSSEbx
         TuZE1AAeD1gyQ0zO064Eos9Dc85Yyj5ZyvBW6helgxfI9mWpN34pCanBIrDEEuDe/vy8
         8SWS/tTNeOrEInSpl19mBjM5mWTn59ou1jcx9Q+ne2+EacyjvVuGGtCs1G5+kZm5SRjL
         31wA==
X-Gm-Message-State: APt69E0U2Sgs1rynLj1bQZUbQXvIOVTffAExlsekNgyXOLGFycO8fm1p
        wxaSfkKQtHzMHkwK/VC5XtsBsXOw
X-Google-Smtp-Source: AAOMgpcTVQMqd+Lnuti7b1Vr3d+tDJ+X9ZjQJgUaIETadfR50NK2FDnPV6C0PL9nyKT3wVzP0t8wmw==
X-Received: by 2002:aa7:c6c2:: with SMTP id b2-v6mr27063207eds.302.1531292001502;
        Tue, 10 Jul 2018 23:53:21 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id x40-v6sm13829565ede.23.2018.07.10.23.53.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:53:20 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: dts: am3355: add support for the Sancloud Beaglebone Enhanced
Date:   Wed, 11 Jul 2018 08:53:08 +0200
Message-Id: <1531291992-30512-1-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Beaglebone Enhanced" by Sancloud is based on the Beaglebone Black,
but with the following differences:

 * Gigabit capable PHY
 * Extra USB hub, optional i2c control
 * lps3331ap barometer connected over i2c
 * MPU6050 6 axis MEMS accelerometer/gyro connected over i2c
 * 1GiB DDR3 RAM
 * RTL8723 Wifi/Bluetooth connected over USB

This series adds the Sancloud vendor prefix as well as the actual dts.

Koen Kooi (2):
  dt-bindings: Add vendor prefix for Sancloud
  ARM: dts: am335x: add am335x-sancloud-bbe board support

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-sancloud-bbe.dts          | 146 +++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-sancloud-bbe.dts

-- 
2.0.1

