Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43FC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F35221CD2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxr2Cm28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F35221CD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbeHIL5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:57:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41697 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeHIL5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:57:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so3946868ljy.8;
        Thu, 09 Aug 2018 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=JzI8wTZ+ADBvRRSu5Qnoau2q0SRcjd7XrpaY+dkyeBE=;
        b=sxr2Cm28mzr3T+73Qjjxg5OnbV2ZyZhGMEupqvpBDqovcbjV4UVgGd+uCMq7GQHA/3
         Ec/BEbAR23NVRUzQfJSfB4L2Ar726UuaG0uk8pnNxU0+AxdfcOuRGL28++3CwcM6TpkU
         Dd/BdCBZ1P4hXxqvVfIu0IexeQvjKTk1M6x9bjBpGgSUZ5AJg9TVLEYzwtfct6SSAYSo
         dDPl6qVQmHa/2+7yu43Qtsye/PGLhoOgsH1rBfYeOw4CGxX+i9Zha0S/AKDeKb4K+AQh
         SB49WdpFuOEdfD3ypZJOL8tX64RN904UYc6BMoszRvbzpj/PIdPz5iZoobj5+OGgZLTC
         ixYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=JzI8wTZ+ADBvRRSu5Qnoau2q0SRcjd7XrpaY+dkyeBE=;
        b=GuDYlBd9j5eqKUptUkdcK2UnEx7eOw8N01Wi7u9y/VoIv7+qsyj1GYiMFlTjZ3EkSk
         2ZPa9PrgWmvDIVZ2jnHqZgtMfDURfrtOK2SFwIrpcECVmE8CH4OxHDVWNkXuH8Z39DGa
         +KdvyXCGvqf8uaa/JO8i3ZzthdJU9a4axgbnuQVECFKYMT6BADvoro+5EjW/VZ98GBFZ
         DBmfD5TCLulUDdBYhoub4kR0h4GujlB+jwDz/1F67icgFaF+RXVjs9XcdMhX7gWNCBY1
         /xBQ5gLws0AFkvbrukXcYW2K8d6JySSRaw3FTi2Hq4PRZYmFEQ3EFGaIbppXJYZCErn2
         5KBg==
X-Gm-Message-State: AOUpUlG4+92kAn2fZg92FbdBnxPh4WHJd6X+kq7Ac5H82RCQnv03vdq2
        iv+UNCnEQH7ggmkmqyazfsfZqQMOPSc=
X-Google-Smtp-Source: AA+uWPzb0AjAiXM0rKP+OG4wu7Wob1yePqDjuOM+ADzWFRGZ+U0de/f5ADkXG+KKn8Hma6SPShbi7A==
X-Received: by 2002:a2e:5243:: with SMTP id g64-v6mr1093565ljb.144.1533807208878;
        Thu, 09 Aug 2018 02:33:28 -0700 (PDT)
Received: from alpha.sai.msu.ru ([93.180.21.1])
        by smtp.gmail.com with ESMTPSA id q15-v6sm1070721ljg.62.2018.08.09.02.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 02:33:28 -0700 (PDT)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        tfiga@chromium.org, laurent.pinchart@ideasonboard.com,
        matwey@sai.msu.ru, stern@rowland.harvard.edu,
        ezequiel@collabora.com, hdegoede@redhat.com, hverkuil@xs4all.nl,
        mchehab@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        isely@pobox.com, bhumirks@gmail.com, colin.king@canonical.com,
        kieran.bingham@ideasonboard.com, keiichiw@chromium.org
Subject: [PATCH v3 0/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Thu,  9 Aug 2018 12:33:05 +0300
Message-Id: <20180809093307.6001-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>

DMA cocherency slows the transfer down on systems without hardware coherent
DMA. In order to demontrate this we introduce performance measurement
facilities in patch 1 and fix the performance issue in patch 2 in order to
obtain 4 times speedup.

Changes since v2:
 * use dma_sync_single_for_cpu() to achive better performance
 * remeasured performance

Changes since v1:
 * trace_pwc_handler_exit() call moved to proper place
 * detailed description added for commit 1
 * additional output added to trace to track separate frames

Matwey V. Kornilov (2):
  media: usb: pwc: Introduce TRACE_EVENTs for pwc_isoc_handler()
  media: usb: pwc: Don't use coherent DMA buffers for ISO transfer

 drivers/media/usb/pwc/pwc-if.c | 54 +++++++++++++++++++++++++++--------
 include/trace/events/pwc.h     | 64 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 12 deletions(-)
 create mode 100644 include/trace/events/pwc.h

-- 
2.16.4

