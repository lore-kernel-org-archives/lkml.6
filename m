Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C883C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC2D267E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC2D267E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeF0Hf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:35:27 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38386 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeF0HfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:35:25 -0400
Received: by mail-lf0-f67.google.com with SMTP id a4-v6so780977lff.5;
        Wed, 27 Jun 2018 00:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=23G3w/KHCgSTbKTderbuvcLK4r+DhAFNHdB7atp9ojw=;
        b=J5AbC4OgMxRFdiPrKOvxTOU6jzaIrujchhSjOaRXSD2dtgO3AeMa6/WUTyiiR9k52s
         cXJIilIGgeyoJdSQ8+JgnveZ5gHD/MIFHQVCx15aU/6Z6ylYPGU8AysslKy1303zobA1
         d5Mercxr06ZyAJh0Larjqyc7K74n2v0Q7nV9L5jylOH0/gdbs+MU/+nnHVjcxd682euT
         CAFRRAX7C25tI5jc5z2uCnNugW+nSE7bHX+YsosWybzNqqpgiCLHh3MMNJ+SJFk8ocZ6
         4p8J3EvbsE93pvik7YVyLQZ5aMl3+ZgaS6o0Ql3oIRxHAyKTgv9hVKdupwPv3Gu+tA5F
         FfEg==
X-Gm-Message-State: APt69E1hPvsCaMM0hCDFsFaIoxXF9RN1XJ3GR8tZekyacGykaNgayU/P
        knY7XtN+pAc18tKzLvmvFsA=
X-Google-Smtp-Source: AAOMgpde/jOVYw1rhVyTFki1Esq3Cb7pHpgGyhJz5rscTtaLHb5zqkywp53AmS8BPh+Wfa2DDvWahg==
X-Received: by 2002:a19:120d:: with SMTP id h13-v6mr3481451lfi.13.1530084924234;
        Wed, 27 Jun 2018 00:35:24 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y67-v6sm563140lje.74.2018.06.27.00.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 00:35:23 -0700 (PDT)
Date:   Wed, 27 Jun 2018 10:34:58 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     dmitry.torokhov@gmail.com, robh@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        jeffy.chen@rock-chips.com, matti.vaittinen@fi.rohmeurope.com
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] input: gpio_keys: add missing include to gpio_keys.h
Message-ID: <20180627073458.GA27800@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio_keys.h uses 'bool' - type which is defined in linux/types.h.
Include this header.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 include/linux/gpio_keys.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 7160df54a6fe..3f84aeb81e48 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -2,6 +2,8 @@
 #ifndef _GPIO_KEYS_H
 #define _GPIO_KEYS_H
 
+#include <linux/types.h>
+
 struct device;
 
 /**
-- 
2.14.3

