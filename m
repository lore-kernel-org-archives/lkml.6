Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE038C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805FD2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="A2DalFaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805FD2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbeKPI45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:56:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50750 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeKPI44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:56:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id 124-v6so20454261wmw.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 14:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f8jcBLj+p9ODIMLRV8bXrnlxdP8OIczC2VPtxDvYHOE=;
        b=A2DalFazlGkhvLNSDsrz02tCSkR5oiBMzorQ0Wwyh83wyngwVbcZnMxa98K8hiihAa
         vy0SO6K8PW16qwn3s99ToHIxpTpUZSf8T/LyCFjWSrcP302FRQio7XO+cKHUTcjoXUHB
         RTAvWGQ22+dedo2OD434Ubf6l/vAYODpe5Motao6hA9Qrz8EWMzihw+rk/yqREMHDZnz
         k2/2yhWG1NVD5fyReRPhjoqT9H0qD2e+YQIx8RhFAoJN0V60ldHPQJ1/fpuVJWPaQZc4
         G/7XbdP2PSpwL4C2dePfjOzr/nc/pA8IWTllC2InIuLiRNxu7p+vYUt1OVAasXQiW20x
         vvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f8jcBLj+p9ODIMLRV8bXrnlxdP8OIczC2VPtxDvYHOE=;
        b=nXJWUd+qf3NWR2Rfgu19TCzrqxkAohEFQxR91gFj+FwHCrc195XjlOyZr8KjOn9oEu
         Zcwt8zCsuavzrVkl1w/9+MGD58Xiw8k73z4Xiwt9VnIe6O+sQVdPGdD1oRW2S3uGf4Dp
         EnQm08Adqg/AiJDzy4JI/j9/ZlSSqKrOeiJgWf3OC942EcisG+SfNr0bgcmyyxV8m+3F
         OEvoiaK23rOpuu4ZHDSLOaa9l2nkXZuGTqbrI+QXdRuVL24yix+6fED2PiVcZQLXNAm6
         mFI+TwjRBVxqO5hhVws7jB53g4P3c0xwijgE+ilHlgThsfnN/R8S0rX0EIzP09r0Colm
         XGnQ==
X-Gm-Message-State: AGRZ1gKZ3hj2SpSts6cUFljrhWK2vUtptaKVgYqKaJNxYPgH6nr1pfhx
        wjXV32YqhhpGl4I3JGAtpSI=
X-Google-Smtp-Source: AJdET5fyqT/viFYoM4zuGC/Iz2QjWNECMPkPHGjQ/x6g+RV98o5E4OIijaz0uLu7u9ZlSGOrzTMSXA==
X-Received: by 2002:a1c:83cb:: with SMTP id f194-v6mr652636wmd.26.1542322028143;
        Thu, 15 Nov 2018 14:47:08 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100B85ACE585A885C51.dip0.t-ipconnect.de. [2003:dc:d717:a100:b85a:ce58:5a88:5c51])
        by smtp.googlemail.com with ESMTPSA id x142-v6sm50950160wmd.20.2018.11.15.14.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:47:07 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] clocksource/meson6_timer: implement ARM delay timer
Date:   Thu, 15 Nov 2018 23:46:55 +0100
Message-Id: <20181115224657.14736-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to add support for the ARM TWD Timer and the ARM Global
Timer on Meson8, Meson8b and Meson8m2 (ARM Cortex-A5 and Cortex-A9 SoCs)
I did a review of the existing driver.
Unfortunately I found it hard to review because the pre-processor
#defines did not match the names from the public S805 datasheet. Thus
patch #1 adjusts these. No functional changes here, this is just
preparation work for patch #2.

Using the ARM Global Timer (drivers/clocksource/arm_global_timer.c)
would have given us a timer-based delay implementation (so udelay() and
friends would use the timer instead of using a loop-based delay
implementation). Unfortunately we can't use the ARM Global Timer yet
because it's input clock is derived from the CPU clock (which can change
once we enable CPU frequency scaling on these SoCs, for which I will be
sending patches in the near future).
Amlogic's 3.10 kernel uses Timer E as delay timer which (with the
current configuration) has a resolution of 1us. So patch #2 uses
register_current_timer_delay() to register Timer E as ARM delay timer
(which will be especially useful as we have to use udelay() when
changing the CPU clocks during DVFS).


Changes since v1 at [0]:
- convert the enums for the input clock (meson6_timera_input_clock and
  meson6_timere_input_clock) to simple #defines as these are register
  values and not something driver-internal. All other register values
  are #defines so it makes sense that these are #defines as well.


[0] https://patchwork.kernel.org/cover/10658591/


Martin Blumenstingl (2):
  clocksource: meson6_timer: use register names from the datasheet
  clocksource: meson6_timer: implement ARM delay timer

 drivers/clocksource/meson6_timer.c | 128 +++++++++++++++++++----------
 1 file changed, 85 insertions(+), 43 deletions(-)

-- 
2.19.1

