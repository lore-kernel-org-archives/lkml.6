Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41753C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BE5223BD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyejiE5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BE5223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeHJFt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34646 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeHJFtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so3719807pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mrqlrgu8pIcAcIuMO7yVFruYmFb5F8XpGe5Ej+8pz+s=;
        b=EyejiE5dVv0BpwK7dyyeZKg/uD03HPddshETdNoPdMoQL4atMbijOczo3Qr9lKqb2q
         /GoQTgTOsLTgCUIYQloKqAM4L27q85OKiG+eVQBo/0xtDZmuF35VyWUEBB2RqKYKuNfU
         W/FL4c6OkOWoVvVxZW4REPEnl4gQI5t6KemBYH8+dxk2cbyeIqx4Jgd2Csn6AJLj239U
         Q/FOQQP0qxGC/uib6MOES6DQuEtY7gz0ucytFJmY5OEcd/O1yb1oBKx1QdKVt+kO+T9g
         em4lTfSemIHPRRAz8xh+BB5pT7UpEOPl25isxoRz8szy8G2ENItVzL12FzrV8f5g3Qtq
         YvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mrqlrgu8pIcAcIuMO7yVFruYmFb5F8XpGe5Ej+8pz+s=;
        b=OCBIut0XWZT3hy/cguHrb5sHUhrAYNLhZnGw/P+lWpwGk2vGhK+QV0PBJZyE/VOa48
         ndWoRXavCq0CfnSw1w54c0TjgyH/O9ko6UdEza08Z4aFlbr3ron5DhKepoU8qbnio6mV
         gg5O6208HKE2WJe1eCjtgNGBzur8AdoTQddn6DZ9+Ht+Abru/xhTUiv9fwKRYAzIX1hD
         pLfsR/t+kBpIOAwrAc5ihblYT25pX/vHFXXAgfPti+DQ+GO8l3G7HG6acJaBoG23dHrG
         QjGQuuW4mUYTy4iHqvpDFMoWEmDqvHtd1RTPZAl5dG1tsTnuSZ5cDVt8hLsFyql2iI5Z
         gCDw==
X-Gm-Message-State: AOUpUlGSFop6jUvsW4YEFvTQjp79ggpazeJAdOg7IhSxdNYIQCgxfzgo
        6Bwsnh+EqJlQCWOVoP2uS80=
X-Google-Smtp-Source: AA+uWPwiTX/DOK11GnVMYekWphcolUVBGfDUYmuPTppv4DtgkfG6zUn46ji+bsZisxze4uvY6Iqrxg==
X-Received: by 2002:a62:ca0d:: with SMTP id n13-v6mr5033041pfg.69.1533871292056;
        Thu, 09 Aug 2018 20:21:32 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:31 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 09/16] staging: gasket: core: switch to relaxed memory-mapped I/O
Date:   Thu,  9 Aug 2018 20:21:04 -0700
Message-Id: <20180810032111.197743-10-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Use of readl() is deprecated; readl_relaxed() with appropriate memory
barriers is preferred.  Switch to relaxed reads and writes for better
performance as well.  Memory barriers required for I/O vs. normal
memory access on Apex devices have already been explicitly coded in the
page table routines.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 275fd0b345b6e..fd7e75b765a6d 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -590,25 +590,25 @@ const char *gasket_num_name_lookup(uint num,
 static inline ulong gasket_dev_read_64(struct gasket_dev *gasket_dev, int bar,
 				       ulong location)
 {
-	return readq(&gasket_dev->bar_data[bar].virt_base[location]);
+	return readq_relaxed(&gasket_dev->bar_data[bar].virt_base[location]);
 }
 
 static inline void gasket_dev_write_64(struct gasket_dev *dev, u64 value,
 				       int bar, ulong location)
 {
-	writeq(value, &dev->bar_data[bar].virt_base[location]);
+	writeq_relaxed(value, &dev->bar_data[bar].virt_base[location]);
 }
 
 static inline void gasket_dev_write_32(struct gasket_dev *dev, u32 value,
 				       int bar, ulong location)
 {
-	writel(value, &dev->bar_data[bar].virt_base[location]);
+	writel_relaxed(value, &dev->bar_data[bar].virt_base[location]);
 }
 
 static inline u32 gasket_dev_read_32(struct gasket_dev *dev, int bar,
 				     ulong location)
 {
-	return readl(&dev->bar_data[bar].virt_base[location]);
+	return readl_relaxed(&dev->bar_data[bar].virt_base[location]);
 }
 
 static inline void gasket_read_modify_write_64(struct gasket_dev *dev, int bar,
-- 
2.18.0.597.ga71716f1ad-goog

