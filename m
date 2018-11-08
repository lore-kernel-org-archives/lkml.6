Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC66ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316162086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tEZ4byB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316162086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeKHX3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:29:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38014 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeKHX3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:29:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id f2-v6so1270952wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYEtnVfURW7Oc8J9mq00r4Xr/VHBAWTQjn/0fPdzWHs=;
        b=tEZ4byB6IJQefj9smMY14cjtk8uNXiYXigoEWCBGdooKbCkDYXP9QEf0CDQ+Yy/3FA
         OyWP6kKOqgwLAthGd4e8PxKVDGahkf7gAgnMuARX5i2gOhcV1OiwcXEXnYkLRzgibmEz
         jGgAGQLBpCiXp+7SHvTkf4q0bYdFzgYIQCrZODM91xHpRYeWF451HmQLCf3lXF6BKbil
         26W8V2WU/8N1hfQ/5SreKpCwIzdcd0QTvbo3ApOLNMCz4Iu+jnVumcQBU91oRAXJAUHx
         vfNfRZ5JbEOdNLh2FN8++LdNFVwIjd+EZG8pH+aZGRzSkp2T9MkoFpYfQR1ozss6oyEp
         OYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WYEtnVfURW7Oc8J9mq00r4Xr/VHBAWTQjn/0fPdzWHs=;
        b=VnFrw4rKXrFkcCGp2wFMxeY4tB1x6pfZVTj2Eps58KHSrxw4mMV8Wy5ThTpGclhHru
         aekCmD7bWm+6HAq3sQS42WE4Y4WyfTqquBdXodF3cEgVwnvngaPtw4neHq7Y9c5UM4OA
         qYFrl8e5i7HVU/OoO/2Jc8zfEOasl4M5qa40b/Ji61hKm9NFEeQXqE9DoGjqoV0FHsDx
         GrpLUalTjJFIQ+wszowAVKLfGfdcmlYT0AVP++ETjWx53S/Sj9u9+Ke0PJjdT+w6QV0I
         U8uLz+YXo34B91D383ga1nUceEuti7OGF3BU9I/qGbuZqEvVAIoXyjrfqoT/UGNhzxgz
         HXxA==
X-Gm-Message-State: AGRZ1gLhsiOlzHb5omw9EHrwQdhM+7RlvtTci94/BZIPJQkq8wF3pUfJ
        5yRQlW6xysPRHc5eVC5BTo09lQ==
X-Google-Smtp-Source: AJdET5eOf1NXJDiXM5UqnXWkBO4uji2wxbZmIq1t8TgTBYV8tSGTZYQuDj6VWiuzXkDyvod4wzcu8g==
X-Received: by 2002:a1c:e456:: with SMTP id b83-v6mr1302513wmh.143.1541685239706;
        Thu, 08 Nov 2018 05:53:59 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p6sm2740329wrx.39.2018.11.08.05.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 05:53:59 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] arm64: dts: meson-axg: enable SCPI
Date:   Thu,  8 Nov 2018 14:53:48 +0100
Message-Id: <20181108135352.8459-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patchset is to enable SCPI (dvfs and hwmon) the axg
platform. The first patches in this series fix a few issues to acheive
this.

Jerome Brunet (4):
  arm64: dts: meson-axg: fix mailbox address
  arm64: dts: meson-axg: correct sram shared mem unit-address
  Documentation: bindings: Add missing Amlogic SCPI sensor bindings
  arm64: dts: meson-axg: enable SCPI

 .../devicetree/bindings/arm/amlogic,scpi.txt  |  7 ++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 34 ++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.19.1

