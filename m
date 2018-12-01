Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA14C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF8121473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJOzTOxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF8121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeLBCEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:04:30 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:34885 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBCEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:04:30 -0500
Received: by mail-pl1-f172.google.com with SMTP id p8so4270071plo.2;
        Sat, 01 Dec 2018 06:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tPDeejCpyylczuJaP6jpNw2gWvr3Xq7v02s5amTrTSU=;
        b=nJOzTOxBJUrMGvWsLf2CElYHmx6vphhDByvfRtcqLz2BqbL3JS2T1Db1kVzXbMNDLr
         HKrKPxyZOlo7JIPl0fRgR2iOqXif0ZX7hPdhmlFqth97/CLoJrHolJ7M2LH6aUrb7wMq
         YkB3h1ftqHGFtUkMxNqir8kU5cT1Afak7Un31A/Yy9BGCOVUXdD97kLTdDMu4dNR3O93
         70tPxA/03yBSe9o9ePBc9jWBtxrsH2wbFldyh67rQQAuOReEXjraaN+6xW/1w4A9oXBG
         ljGsHjLppSxjCWBw0XR9rBh3rEkrHEmGA+o+dHlpOZPFlQtkectikUGy2ZBYk8GW3VYv
         F2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tPDeejCpyylczuJaP6jpNw2gWvr3Xq7v02s5amTrTSU=;
        b=J8DjJCQNre5Z0OzBdjVRYx7HDCtP8X5jKnJwAg3AABt0iCNtJ1Ij/tWq1Eq0XGASZi
         v8DrwFi1YByPeHbIVw449z7QvPam9IFn/0+480D5xHtSTUhEgIFIrwu6QjXovT8Klo4z
         NMiGA/TjIj76VsXezARFXZwdOhUn/kjADCQBBN/2yXJbxiPvNbkY1DWthgBwbhwhZdxW
         xDINlOtnhccwlfJ6h4CDlm51NVf5VWV71PBS4Tpf30GDvqF9NRhhmjBpTsWhQgEuhL4E
         +AEGZWbGG1lf8+2JVNK3mSBH66pFNbOJAhgZ2nameR7emnkw8X3lB8uQ9+Ygmql+NuiQ
         AZsw==
X-Gm-Message-State: AA+aEWZx6K7THH8lrR4V/6MAjIWLEtn8VFDV5OoN5NzBPy8YYjvoYtjz
        cMXJpi3iiVOvN6G568VH85M=
X-Google-Smtp-Source: AFSGD/Viqe60P4+vfKfde9IGQIs3HFqe/bMrLE0uPc26+fiQkIhmeQXr7uxPusO41bBxoycVKh09Yw==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr9630614plp.213.1543675909907;
        Sat, 01 Dec 2018 06:51:49 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z8sm21120854pgz.53.2018.12.01.06.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 06:51:49 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/2] watchdog: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 09:51:38 -0500
Message-Id: <20181201145140.8088-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Yangtao Li (2):
  watchdog: bcm281xx: convert to DEFINE_SHOW_ATTRIBUTE
  watchdog: convert to DEFINE_SHOW_ATTRIBUTE

 drivers/watchdog/bcm_kona_wdt.c | 16 +++-------------
 drivers/watchdog/ie6xx_wdt.c    | 16 +++-------------
 2 files changed, 6 insertions(+), 26 deletions(-)

-- 
2.17.0

