Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84066C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160F22147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQHYm1pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160F22147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbeIUHA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:00:28 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35502 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUHA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:00:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id f62-v6so7320701qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 18:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=GqW3VCeNW8NbczlJi2Z4ja1EtL4L5eSPgRPWBGo7TN0=;
        b=VQHYm1pd0L7ZH2Bqv50tIE4PXeKP5hXYF04KFV3HEgUaEMvkyCfnxk8CjNjbHs37C2
         NUWgC0HgBvCMMEEi3RNumGv0hkRr5MqhPNeev6xA3V/4gVXSJps4emOf3PNNnrBvMpEW
         EFpYP/kgG0O5ZRcruvFTwR3C+X1FjoSbOCqvQa7uLv41I96XL0G4iMAE+QHI2BzRoIHs
         O38ojdDUHq7NmG2apMSgWKtXOw6rAXpneDXPK0RrfvAezGh7lakORPIsm5v/eFAH1VNy
         046zKSCtaE3y4EQWXJQNcJL8FK4Ql3OXxlnu6VLhtijM8hKr+057z80+pwHSSLezndeT
         Nw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=GqW3VCeNW8NbczlJi2Z4ja1EtL4L5eSPgRPWBGo7TN0=;
        b=N7n8uL7gidpE2v8vYZ0KiN7GwAK2NhAbE1aXgdWWwqYIByeGx1aIZhzM4DaZ5ZqIwW
         PdkxwHBQOuY5LvwP5lDpAWpqlhFM4oWl4sDghLr6pWIG810eAP8IO+0QK5L4q0E3wJie
         f/xR3d3e1xlVQ2x0jKNwlK08qdqZ42Ao5/ISIvR/M2ohllpBsc9YG34EtHh6RPOSXFcG
         QlFIJD4menGtjj2Y4azZUfukUsXfnvgnNzJCIB3T+AJDB6QklHtzqNLgZUTJnYK3uw9O
         ptxi5UVgSslJQ/XXKqXo8AyFudKZCTckdA8Qizl5QyLoOGL3FfTAY0n1GZAW0vGixSdR
         s+Nw==
X-Gm-Message-State: APzg51DnyrNNDmwRAks4l39CYN0boDoq8p7088B798maCkTP/ekb/iJK
        QP5u0wMRtfQpV/Uc1GqZOfHx6+gg
X-Google-Smtp-Source: ANB0VdYclfdWtlWVM7cMc6ShDfviUT4HpOT+C/zZ14pSvoMVcwbcCZw1XpA9yS33hu4loMEl+p79Zw==
X-Received: by 2002:a37:98c3:: with SMTP id a186-v6mr21483798qke.128.1537492450595;
        Thu, 20 Sep 2018 18:14:10 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id o23-v6sm17162528qtb.23.2018.09.20.18.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 18:14:09 -0700 (PDT)
Date:   Thu, 20 Sep 2018 22:14:05 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drivers/dio : Changes Makefile to avoid acciental
 compilation.
Message-ID: <20180921011405.GA18848@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes Makefile so 'make drivers/dio/' won't compile this driver
unless CONFIG_DIO is enabled.
Previously, it would compile independently of .config file.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/dio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dio/Makefile b/drivers/dio/Makefile
index ae92d17083f2..8fc80e805b90 100644
--- a/drivers/dio/Makefile
+++ b/drivers/dio/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y := dio.o dio-driver.o dio-sysfs.o
+obj-$(CONFIG_DIO) := dio.o dio-driver.o dio-sysfs.o
-- 
2.19.0

