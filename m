Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9667C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B738F20842
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w7xlvvSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfBZMOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:14:03 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:39893 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZMOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:14:03 -0500
Received: by mail-wm1-f46.google.com with SMTP id z84so2032461wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Nyp+XvU8Iwf2Gbpf50+YAlGUNo21rB3BtmQX93H+/8=;
        b=w7xlvvSHT+D9QXGWcVXmjqjo+lNl3F30O/fXb4+IWjIQUl4oleryc0fqngzfVrHqhK
         gNk5UEr3iEtxHd7qL9WYnb4PQ8zV2E0HvpRVpYNN+96mAKn7tdTP16GZyG7hrBeVCq/0
         CjftkpijTpqRuw8Xava+zVwuImh8zN7kESwNsiU5zTkg/E0LJuFNvfKu4CvyAY3pHEmO
         Qygv7crr8TWv/S1ZOoxgpRWCqIJfInWSVMgbJTRKQHjXtVHsDPRpG4QVsdYGx/pChmFB
         Gh9mivo+DCx8cXGm7feOUBd0z+9O4BOQqQQSFMMV4q+WnCIG0D1y02PVag38WSFXHBvb
         6z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Nyp+XvU8Iwf2Gbpf50+YAlGUNo21rB3BtmQX93H+/8=;
        b=aSusKCDMlQAC0VUcr+eV8YNMlDgklpS0lKO07YqKfV1fcKmp27I6dPWA8uNjlmS5CA
         BdvP8hGwOeYPGy+rNPLOhJLgA7uCFSHliVs09yWrRl8Vd4Wm68ZraTJGvbvLvKUszGHy
         0mrhIEQVcfvDZVO/05jzh7WDUn3bntUwzWUirDq1S4YgoZdtLbSMPZWkPV07QNCjlpMR
         fQOE5fBRWhNqE52Y0ynVo5e6YT7RwECU2tpR5eOOZj7uBtAHYXm7scsUD/1jPmBObX9x
         sK+OzxR2YaAOr6ZHQqDQY5ebhieRDA2W73iD8Mx+c8S3mK1hmYLkSiLQ2vQR2FCBuPB5
         lLzQ==
X-Gm-Message-State: AHQUAuafxjDYJYMHCuxV424eMR/Tp8iH28t3iMZvrWSPa8ywhxhni455
        N8y9pg/vQjU6ZWWw7ugE2FKBYw==
X-Google-Smtp-Source: AHgI3IZXdoAIAsseBMfkRAKIZI4SRXn8yZHH9eDUwV7R58aPu16CWGLwavGRfzK0LHMsvm+QRPae8w==
X-Received: by 2002:a7b:c752:: with SMTP id w18mr2534264wmk.97.1551183241738;
        Tue, 26 Feb 2019 04:14:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p1sm11401877wrx.50.2019.02.26.04.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:14:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] ARM: make DaVinci part of the ARM v5 multiplatform build
Date:   Tue, 26 Feb 2019 13:13:51 +0100
Message-Id: <20190226121353.19413-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series depends on the interrupts support overhaul and the cpufreq
fix that are queued for v5.1 and on the clocksource rework that's been
posted to LKML[1].

The first one adds necessary bits and pieces for davinci to support
multiplatform build and the second one actually adds all davinci boards
to multi_v5_defconfig.

[1] https://lkml.org/lkml/2019/2/26/363

Bartosz Golaszewski (2):
  ARM: davinci: support multiplatform build for ARM v5
  ARM: multi_v5_defconfig: make DaVinci part of the ARM v5 multiplatform
    build

 arch/arm/Kconfig                       | 21 ---------------------
 arch/arm/configs/davinci_all_defconfig |  5 +++++
 arch/arm/configs/multi_v5_defconfig    | 12 ++++++++++++
 arch/arm/mach-davinci/Kconfig          | 16 ++++++++++++----
 arch/arm/mach-davinci/Makefile         |  2 ++
 5 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.20.1

