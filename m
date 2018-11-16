Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6237C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D8520854
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j75AmHmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D8520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeKQG4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:56:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37630 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbeKQG4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:56:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so22116181wmc.2;
        Fri, 16 Nov 2018 12:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KTaFDwY1DKFSjaZYpt+Am8XybGZoiNM5S/9QAbN/oHI=;
        b=j75AmHmbxA58fE90a1adjJV6r90P7r5VRAN6uxHz0ikG/9XxBeWLnmSXnt3z97m5n+
         G+qC4FEjC9LeLaG6j6LuJya1eRuh4zv0x1ltHfLHbCmVphsiuSMXDttZQveztNpRl7gp
         Gccz540tmwDXJfIAaB+UlKq4efMp0CtjxRvcxbNPyXESWdA3JcPLy02UD/vld53Q9b7P
         fXPW2HhaZsMPc2XsI93tuNcMnrazJJ68Kl0W29U/PcceKWuymSHX6E5/4jNvJu9uueEU
         2CtVGnIQDkNYINpFw3l1xznJ7HiqYnuFA+VQjQZh66qJYR1rlWPWGni2ofyW9PJWQ/b6
         ixpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KTaFDwY1DKFSjaZYpt+Am8XybGZoiNM5S/9QAbN/oHI=;
        b=IobqPZF+PAr8wJwkn//aKhtnUwz5s3bqK8v2I9PqRNxuM62AQV0UUWevnx7vVhFGb8
         bha/5O6ptC18a7bcc4936lnJHugDP2PK0O+BgrZE6mEDOiAMKcgJ3nxyfm0IvmNKLNUv
         eUMDA5qILj+z+gzShMtww3PQWf0ZpRDkAY5Mu3y2INFRC8toS6ckMnBzqCDsDXVzRMoW
         A3HFmEOWhdHE/nuIqetW3X5azUxYa4DpFCTSn93zlBqCPXCCYKb0mvutk4WLxvkkpBD+
         cFPh+qj5nNnngud+I0SXqnoVN0tBhrFN2iQ7W0YDA6ohBxTjs1Hmv2gUVakfmpVLIFTQ
         BtDg==
X-Gm-Message-State: AGRZ1gKRZ/PiQHRGMLoNT9ZNJAMZgPWRmUOdhMh9KIbCw43nX95cakRb
        5xazkCWSRReBnWkWESXHxGw=
X-Google-Smtp-Source: AFSGD/Vzz6jCj2cqavV9mOVHLDrZJLtzsNXe7PG89qp4bzbvWRO44sjotxiYHEHB8c5CHMcKWY2BYA==
X-Received: by 2002:a1c:88c1:: with SMTP id k184-v6mr3727964wmd.84.1542400973065;
        Fri, 16 Nov 2018 12:42:53 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A1006D214A3B023844E6.dip0.t-ipconnect.de. [2003:dc:d717:a100:6d21:4a3b:238:44e6])
        by smtp.googlemail.com with ESMTPSA id y34sm6000758wrd.68.2018.11.16.12.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 12:42:52 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        carlo@caione.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] ARM: dts: meson: add the timer interrupts and clocks
Date:   Fri, 16 Nov 2018 21:42:33 +0100
Message-Id: <20181116204235.3925-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up of my series "meson6_timer: dt-bindings updates"
from [0].
We were missing the interrupts for timer B, C and D. This is harmless
so far because the meson6_timer driver only implements timer A. Timer
E doesn't have any interrupt.

Additionally the timer IP block has two clock inputs. This also adds
them.

NOTE: the alias "timer_abcde" was chosen because there's a second
timer instance (F..I which are similar to A..D and J which is
similar to E).


[0] https://patchwork.kernel.org/cover/10658573/

Martin Blumenstingl (2):
  ARM: dts: meson: add the TIMER B/C/D interrupts
  ARM: dts: meson: add the clock inputs for the Meson timer

 arch/arm/boot/dts/meson.dtsi   | 7 +++++--
 arch/arm/boot/dts/meson6.dtsi  | 5 +++++
 arch/arm/boot/dts/meson8.dtsi  | 5 +++++
 arch/arm/boot/dts/meson8b.dtsi | 5 +++++
 4 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.19.1

