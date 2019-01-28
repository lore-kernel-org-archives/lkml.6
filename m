Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0222147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tdpOCcRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfA1SXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:23:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34592 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1SXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:23:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id f7so19272620wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqA5ZhkAoBvdzuv086TvCXgnTe2F7DoAV3CeohA+KlQ=;
        b=tdpOCcRQF5RfdDxRMKgumHKV1zlZh/oJbAfa0YKlfdW8OUiAUN23fghZygJIAk3bc2
         dMdDFDOiFnkFvZ0Dh5TDoSNuYI0iqHMCtAkuQFtDf5p5Q4GcrTxdiSjQcTyvKW5xGWqV
         5rec/WfbYhmDXJpd73MAC+r0wMyFhrKv39HuVx2ziBJ96bGSyTyzkEhHHLsE1yfDZsrD
         KrcoMzCpM4RgMon7/3+8kEmL86YqXpeSoa2Gba2lKc5MDhrxjGxyhYfYkg42ix0obO1n
         FK40aAaQ0flqxtV52w+Lt4Y3YHIebqgUUx50KlC+4v92hQ3TZX/xt6PSc98Ez9fDWOhu
         qToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqA5ZhkAoBvdzuv086TvCXgnTe2F7DoAV3CeohA+KlQ=;
        b=Xo2D+lYC1BxLgdlpHYQ5p+Zsb9357ovnk0FktbdVr/kuUpC/nqDAbR1ScgWTrcs35L
         3SNEsWSeAlWf9t+/SEmfQaqiOKvJ6jTVThRdADaFbJXWv1oziAfe7uJACqjl504ZuOca
         00dLPqX6k8mwYozYBKXeSzLghfS4IcEZ9f86X+IdXtcSSdOvZ15IAeTTD4cj4e7k03/i
         Lmk8IA6zHdtjRhSG+nPI/JGdLw1trv4DAXVEAoYMIFIrAGjJB9JI5LE3x/E8bOdlPJ6E
         +AESlBTpKOJDSsojSjNn12nG7eIxCRGeXbnkb3RfVdghWbCQOOk/Zm2nThutaNabyqCc
         2xpg==
X-Gm-Message-State: AJcUukd0t3nUPQPupcu/f/bbCocTTRDqZVVnOL/g12wcJyRxCUSrzgMp
        tbsARxn5u9vxDTHa3rfgOCr3fQ==
X-Google-Smtp-Source: ALg8bN5mghuBM+ajiV5psAYVHnFDrRLNxLgTfnFWOfw5+6S7U8av1hig8IjFL+RS8tBUOjrNOta+lA==
X-Received: by 2002:adf:e407:: with SMTP id g7mr22302220wrm.277.1548699778535;
        Mon, 28 Jan 2019 10:22:58 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s1sm169223758wro.9.2019.01.28.10.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:22:57 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: meson: do not select COMMON_CLK_AMLOGIC
Date:   Mon, 28 Jan 2019 19:22:50 +0100
Message-Id: <20190128182252.32589-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset remove the selection of CONFIG_COMMON_CLK_AMLOGIC.
This CONFIG symbol:
* Is already selected by controller driver which requires it.
* Is being removed by this changeset [0]

Whether or not series [0] is merged, selecting CONFIG_COMMON_CLK_AMLOGIC
is not necessary and it is safe to remove it.

[0]: https://lkml.kernel.org/r/20190128180430.28689-1-jbrunet@baylibre.com

Jerome Brunet (2):
  arm64: meson: remove COMMON_CLK_AMLOGIC selection
  ARM: meson: remove COMMON_CLK_AMLOGIC selection

 arch/arm/mach-meson/Kconfig  | 1 -
 arch/arm64/Kconfig.platforms | 1 -
 2 files changed, 2 deletions(-)

-- 
2.20.1

