Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EACC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE9E23F9E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOL+LQDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE9E23F9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeFVMEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:04:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43087 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeFVMEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:04:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id l15-v6so1881411lfc.10;
        Fri, 22 Jun 2018 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=YRCdVBtDwY78RfM+e0jjmUD7XrrdFIb/V2c/3KFd/30=;
        b=qOL+LQDR5tH0CHywaXr/p257RuZSjudNudZF/IbpUNqXb6OXp2haqJygTAv6/mpV++
         7Cscta5GvUMbEGDjiXKXtpRgTnOGvUkYpBYO1s1Rdqfp2xGc3T6Dxp1zEBhKavT2IuvO
         Ry2b4dAylq2skz7w1PfeAV3cQpzKroa8PbeLqkmNpOkPJXjbomP0gIQjSbDFti+MX8gN
         QpEw7HjJYjH4JEiAJ5PnqvSzof5pmCbLusq4rb6rf7NAf2+zcq/Vt9Z52HSPu44E5BAu
         nNOvV/kp7GUrF/dWIXB0RiX5RrsUNfc+lUpV6cJrCcPwxTirXBLKbI+KNL5OfDMlOfki
         dbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=YRCdVBtDwY78RfM+e0jjmUD7XrrdFIb/V2c/3KFd/30=;
        b=EBrF74escS/l4bU0fuTAFHjBOs64fl3A73X4yneXFZOd/CDF24h3yI9GEW6Rq3Rw8i
         1El/8llxrldDw/ZyILky/lUYwmiD0L/MOLZ7/ZVV9jm2b/609ppIRsHCdlUdFL6gyz6h
         SUh4JMIfCI3vEv49/kzE+QI3hqNCyfo19VCP1KcdLOJR69w/1Lda1+E6oAu3DAbWOTlr
         f7Sa4uyDr0HMzKRkcX8zYzzD1UaWkz7CzMZH4il/w9A4M74cElkugPQSWU1us4FLzg54
         lrx6hjGxOZLen/kQYUOPX7H5uhHn34PozCjHSG7XwlEIsdL1fxgnONBKgJphrwsb4MnD
         jzGg==
X-Gm-Message-State: APt69E0chBQtKJ8P8xOCFr8TeOh/QbzPiMIwZSROLs4Z7TZgrlSbDiF6
        WkmXv6e8N2GFNratKRCzf6c=
X-Google-Smtp-Source: ADUXVKLIxHoB7XLENFM+abvSbEQ2egeYkmOxpL36mydicq4NHEGks9zFr691QnjxWqCBHQgGO9dw1g==
X-Received: by 2002:a19:9dca:: with SMTP id g193-v6mr1214714lfe.65.1529669070529;
        Fri, 22 Jun 2018 05:04:30 -0700 (PDT)
Received: from alpha.sai.msu.ru ([93.180.21.1])
        by smtp.gmail.com with ESMTPSA id a77-v6sm1433663lfb.37.2018.06.22.05.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 05:04:29 -0700 (PDT)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        rostedt@goodmis.org, mingo@redhat.com, isely@pobox.com,
        bhumirks@gmail.com, colin.king@canonical.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ezequiel@collabora.com, laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 0/2] Don't use coherent DMA buffers for ISO transfer
Date:   Fri, 22 Jun 2018 15:04:17 +0300
Message-Id: <20180622120419.7675-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>

DMA cocherency slows the transfer down on systems without hardware coherent
DMA. In order to demontrate this we introduce performance measurement
facilities in patch 1 and fix the performance issue in patch 2 in order to
obtain 5.5 times speedup.

Changes since v1:
 * trace_pwc_handler_exit() call moved to proper place
 * detailed description added for commit 1
 * additional output added to trace to track separate frames

Matwey V. Kornilov (2):
  media: usb: pwc: Introduce TRACE_EVENTs for pwc_isoc_handler()
  media: usb: pwc: Don't use coherent DMA buffers for ISO transfer

 drivers/media/usb/pwc/pwc-if.c | 19 +++++++------
 include/trace/events/pwc.h     | 64 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 9 deletions(-)
 create mode 100644 include/trace/events/pwc.h

-- 
2.16.4

