Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0B6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0F820657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIPdLXVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfANCgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 21:36:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33122 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfANCgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 21:36:35 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so14541920lfc.0;
        Sun, 13 Jan 2019 18:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eLVg0+ENJ/5XPW9yjyuBatmV6D3BisOsaCbTr0AZ5dE=;
        b=jIPdLXVyvFed4r/Qmkh91drRraHRHmFajHovy3QOdTXIXOJApw9/znP2w06AW7CCSJ
         mCcbBozgqomsmr7WEHqHzl6+NzqGGfPs78Fpg3fvhquSYoGDFnIOPZjmyR9NcjqUCtHs
         QWl6TAV+z4fHwhbKuHLZ1dl/I0OV0kOLg+B5OcuuqU8qaZV09d1pArbO17231sEilYLG
         ivfr7aVDWW75PjDH4uur+JuWwdd4OV4rbh+GGHDqSRq4H6l+yRor4Hfpv8Hvi4D+fHLy
         1e9mbXFq1b1GszSZyHaBmXyDYzGJaKiAd9GI/dwBtdCyfkv4NpxYdA0L9RGEM6dbxeaB
         iOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eLVg0+ENJ/5XPW9yjyuBatmV6D3BisOsaCbTr0AZ5dE=;
        b=ao7MnuXH3Xri8ZycV2TaqHVovtBeN1Fufj8fiEvWpykNt81n257fRisk11jzTBcZ7R
         pTtIptIXrZEZNkVtsp+PUH1fT20DO8SLsS2oidqXLhhg7aJV4R3QdTc7Acx5hztb1JXc
         22yHIgstVj0uwWDaf5fEI9H1RceEM2cZpZMVANCmZRKBHHFog9L9VuS2VRElOmE6OEcl
         LHsKgF7dSK71yIDsjCf6iH38auUhETFQ/Mb7KilWHTbzJx/D7Nk367froqKeGeb5/oVu
         C0MUjkHD8Ueuku2ioV0tYnY3ChSPa5h5Zr4s8vygaBSzKk49dcQXpvLK9M+h1TUqV1cS
         MqDQ==
X-Gm-Message-State: AJcUukfCcRseQEstQe2qdoWh26gahXPPukcHiEn/iO8CGbOOzruTS92K
        HzWrTRShvNruyj0C8rZ+wvV5JdYFBTQiKA==
X-Google-Smtp-Source: ALg8bN5ma2Ok4zzJSM5U2V1OfAlI94FpM0ZnZDkJJVclDkZcLsrNAa0C/m8yKQfRO5tcRqKXGZT1Pw==
X-Received: by 2002:a19:a104:: with SMTP id k4mr12766802lfe.36.1547433393382;
        Sun, 13 Jan 2019 18:36:33 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id m4-v6sm16876897ljb.58.2019.01.13.18.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 18:36:32 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-watchdog@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 1/4] watchdog: hpwdt: Don't disable watchdog on NMI
Date:   Mon, 14 Jan 2019 07:36:14 +0500
Message-Id: <20190114023617.10656-2-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114023617.10656-1-mironov.ivan@gmail.com>
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing code disables watchdog on NMI right before completely hanging
the system.

There are two problems here:

 * First, watchdog is expected to reset the system in a case of such
   failure, no matter what.
 * Second, this code has no effect if there are more than one watchdog.

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/watchdog/hpwdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index ef30c7e9728d..2467e6bc25c2 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -170,8 +170,6 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (ilo5 && !pretimeout && !mynmi)
 		return NMI_DONE;
 
-	hpwdt_stop();
-
 	hex_byte_pack(panic_msg, mynmi);
 	nmi_panic(regs, panic_msg);
 
-- 
2.20.1

