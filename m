Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582FBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0BA20824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E/vacghz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0BA20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407787AbeKWImp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:42:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37337 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407687AbeKWImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:42:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so10313275wmc.2;
        Thu, 22 Nov 2018 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gU7vZ4TEcNR+iX/8e1jjEXCv15wOJIXKwYuArGkpSlU=;
        b=E/vacghzsDB9d10XukuAhGCinS+kKd76iYQIwUCm86YomDLCJz05S/YOBqiMOZiBe9
         MT8y3iTXZ0IuLBKuztS95e7RlNQsi6Wtk4+hMH3qO36v+PHZ/an26ct/yANuFXrReIjo
         CdVRq73MenMGwWduT9pPJ2rZ5dZ31ld8GJ1t7kzemWlHvOHo1tOnD5YUdPfw6uXwavWg
         LCfEiozKSZR2VEs6xo8pUsIbLXh0Js3MJEk8+VoDcYpRzB/bm+ANTVKNsIwsNp5T1eUE
         0PNXY15MtZXIdpo1qcsDSTd37N169FrX6yQh+Ki2T0deyegPy1k9wO48ySPsdbJKaPTQ
         wdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gU7vZ4TEcNR+iX/8e1jjEXCv15wOJIXKwYuArGkpSlU=;
        b=O8hXIGvTIAtzFSu+k8opd5gQawl2sadV9DmaDRva1tAPukLVCBSdlaxHmJNWKQPws3
         hYpzkFn8xfvPaPceDwaFtx2cAXk9SCe1dYfbmrCIDEMn1mVa16zyMzsPXbDQIjM2ZxHL
         EwzhWkWAopSjDg5HqHw7HOMBW0lxtH+fCeDWnaK1FCyx2vxRcNTJXR4ImeZz+/9+tP9u
         plkNgOM0lelJC4PIGDUScUkHYpf5oaR3Y2rerUL4BVFEgJChQXV//6P5mA9lgN3uqGIc
         xD/LBRYBroRcWK7WGGJ5WWot1r4B6uQiwom/UlLjwy/sUjq3/Cz1gKUgufoxDfyWv4Kj
         wU9w==
X-Gm-Message-State: AA+aEWZXeRlU8prIs19axz7BZO4N6jxJThAoPOmBt9TBk6aOUMN1shJ4
        vtsCXvvfURQskBwwzNCSDKI=
X-Google-Smtp-Source: AFSGD/X0YQE0UqTJR5Wdwx/MvllEB59Ov+/uMPHbrhn7xWBVstCkqherFsuXT75muwEGnAkSefGdCw==
X-Received: by 2002:a1c:c483:: with SMTP id u125mr11071192wmf.14.1542924083581;
        Thu, 22 Nov 2018 14:01:23 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F5007DE18DA1F72FF8D9.dip0.t-ipconnect.de. [2003:dc:d732:f500:7de1:8da1:f72f:f8d9])
        by smtp.googlemail.com with ESMTPSA id y81-v6sm3327823wmd.11.2018.11.22.14.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 14:01:22 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] meson-saradc: fix internal clock names
Date:   Thu, 22 Nov 2018 23:01:10 +0100
Message-Id: <20181122220111.28808-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the internal clock names which (prior to this change)
contained slashes. That breaks the debugfs structure for these clocks
in /sys/kernel/debug/clk.

The idea for this fix is shamelessly taken from commit b96e9eb62841c5
("pwm: meson: Fix mux clock names").

NOTE: This is meant to be applied on top of "iio: adc: meson-saradc:
check for devm_kasprintf failure" from [0]


[0] https://patchwork.kernel.org/patch/10693631/


Martin Blumenstingl (1):
  iio: adc: meson-saradc: fix internal clock names

 drivers/iio/adc/meson_saradc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.19.1

