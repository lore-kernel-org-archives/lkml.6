Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B7CC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E4E22AC6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMWwkmuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E4E22AC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966115AbeF0RNl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:13:41 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:37420 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966001AbeF0RMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:12:50 -0400
Received: by mail-lf0-f52.google.com with SMTP id g21-v6so2118199lfb.4;
        Wed, 27 Jun 2018 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZeDV2lrkxWoqZ1Hk0P1fJIMwbqa38mGZkMdNIOePsPM=;
        b=QMWwkmuh2QszCyStQzveiet3SyuuHBUXe6HBsVCmWay3UhiC51I55MrbqzImmXnCDd
         jii0nlKPkrjl5S+a+ZjAq0H9xah6jRiteoVJklYHxES6tuZ2nVwCm9doQL3KCQVuJ5vy
         QIqYeypUV0pRUvcY4jBKjsNWzWyr335BMmkXLSXa9mgdtzNn7kf33t0/5FkXBWKvEebm
         xq8UEfTUjg74AjbyLJHQAEwHez/arO+fXWYgw1v+9qswdEGQqC5LIf5qURDE0km+Se+R
         OBnm4HiveRIe+Z0vBh7yOWmFShsjpLrDx2CI3bOGTnzcH4ZalD09n+th/4mZ3+vwoo4k
         JyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZeDV2lrkxWoqZ1Hk0P1fJIMwbqa38mGZkMdNIOePsPM=;
        b=AnyPBswpSrOGa2JCLDRTpAz/LY4JcRuGCJFmeKJ88q1U+JwVJj+CBH6ppCxyMSDVH3
         ZAW5KfcpviAmOjnNNGlbEUxcNpUWgwSywl5YPax8u3eHc2nBqnb82xY2n2UAhG30SQhi
         T+7nAJ1w+kRvYStPbMXLvjPHfCSwv0jskvrgBFyFpg3ghINg17su8+I/WdzMzigu5mbK
         9efkLRCjF3MPmSUuHeMHOOPMDSaMWYGdsP37jOAJIr/UL6QkU7i0ct+MAmUn5S5mNq6s
         H7corO2NNHKmoSSv3VhM5uefoGLFUU9EdfG4OAcn4Ednxtt/iR5tFLmhKfmNU03ZNMH/
         q7Tg==
X-Gm-Message-State: APt69E1mAL0NcuG6izS6A7XTYN3DqgqFAmUAL73w2UlGCl9/wmkmyCp/
        D2+Rm8kbEhF55o3tZusgfGk=
X-Google-Smtp-Source: AAOMgpeLpPTbQgFKrvu3WleCzGMkydd4kBqO9j1Oatb6HCT0Iu/RrjaiIpQp11DrSjOyQkl+6KGMAw==
X-Received: by 2002:a19:c004:: with SMTP id q4-v6mr4654075lff.16.1530119568520;
        Wed, 27 Jun 2018 10:12:48 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id n9-v6sm929344lfb.7.2018.06.27.10.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 10:12:47 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v2 08/10] ARM: s5pv210_defconfig: Run make savedefconfig
Date:   Wed, 27 Jun 2018 19:12:22 +0200
Message-Id: <1530119544-30023-9-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is result of running savedefconfig.
It's preparation for adding support for Samsung Aries devices.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/configs/s5pv210_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 09b5a7386414..9c862d366fb3 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -13,7 +13,6 @@ CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_ARCH_S5PV210=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT=y
-CONFIG_AEABI=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
2.7.4

