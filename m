Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B75D6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7B2208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edited-us.20150623.gappssmtp.com header.i=@edited-us.20150623.gappssmtp.com header.b="i0XHNee2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7B2208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=edited.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964914AbeFMPNV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:13:21 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33451 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936068AbeFMPNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:13:17 -0400
Received: by mail-io0-f193.google.com with SMTP id d185-v6so3826449ioe.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edited-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kdbC/aTOlF3Xkp8zB7cGzTxSBVhcXvbaLItjJcFoO0g=;
        b=i0XHNee2u06XjymJZllxt1PP3rLUJMCidOr1ibPRykMuIInzTGOmRsrl0BlsL4rZx2
         /wd9aNbDDJseQHQ3n+dCoNEP7WQJAE4CVLdep3+wy35XFrnHCz4r1MSwlgiHTFNvY3B1
         xAR2nqzpXnh//IqCd+sXsm+52etm1vaUoOnz2HxWo4fpPBLbIAhtPbo+GgcLou5QOqpQ
         bKnwjqw9PhNXfZwb8YCRpBwNnLUMChgULCvS3UcZFN5O1T96KRJ7uOfMuBXjcVgHSHxo
         pOH4v2NC/kvvvooTCyGkOTqNzIpia/7i0Myq+r4+moS6ocRC4sjeo3ZhOmCiYSD+FBfp
         nKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kdbC/aTOlF3Xkp8zB7cGzTxSBVhcXvbaLItjJcFoO0g=;
        b=gZ2/sUJTBYE9pWNfpoUB9hSP+bQ3hYER6c/tiyOH23XPAqeiIBkjNEbxakm+qfI5Xr
         9sAJjvOL/VrQzqVP/MJLYK74mlbt1+8uzt6iQ+u0fH1JxPPxdzbm797gUogbJ4Ha9IIS
         h7IdbUi6xon78e23uYa6WczXi6GfjDSRoPP7j8G79CRbx3sW77Tym5qvYMrHv5kqqYOA
         kZ+uMygUTlVS9vQ+47Cwn42Wv3qpYZzegaaR/S6QH0gL/fD7KWBPTcg3cbhkPpQDb03p
         r6xwiu3U22nPB/ml8CelfbxrUEkwqz88oiNxL7MgGwDTrfQFxJnnZrpqx4jUIBVyYuWh
         Pskw==
X-Gm-Message-State: APt69E3vTURI9pPUqFtg5hbGx8Mr1mm+dUmOMZFgIonwy1O/C9p9m4NK
        ol9R0m63TB+zrDmFMUapFetYZA==
X-Google-Smtp-Source: ADUXVKKPBwLGtUi6qxRZ5kuuGbmPKYh2GMkqUd9zOvcp/dyWXU25YgiAhxlS1CPbpDs285meX0v5HQ==
X-Received: by 2002:a6b:7006:: with SMTP id l6-v6mr4944568ioc.269.1528902796415;
        Wed, 13 Jun 2018 08:13:16 -0700 (PDT)
Received: from localhost.localdomain (ip-17-240-239-173.midwest.us.northamericancoax.com. [173.239.240.17])
        by smtp.gmail.com with ESMTPSA id y20-v6sm1003823iod.39.2018.06.13.08.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:13:14 -0700 (PDT)
From:   Ryan Grachek <ryan@edited.us>
Cc:     Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hikey: Define wl1835 power capabilities
Date:   Wed, 13 Jun 2018 10:13:05 -0500
Message-Id: <20180613151305.17240-1-ryan@edited.us>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These properties are required for compatibility with runtime PM.
Without these properties, MMC host controller will not be aware
of power capabilities. When the wlcore driver attempts to power
on the device, it will erroneously fail with -EACCES.

Signed-off-by: Ryan Grachek <ryan@edited.us>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 38f881955217..c5feca8cd10b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -323,6 +323,8 @@
 			bus-width = <0x4>;
 			cap-sd-highspeed;
 			non-removable;
+			cap-power-off-card;
+			keep-power-in-suspend;
 			vmmc-supply = <&reg_vdd_3v3>;
 			mmc-pwrseq = <&wl1835_pwrseq>;
 
-- 
2.11.0

