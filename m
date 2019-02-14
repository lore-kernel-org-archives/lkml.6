Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ED0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6464E2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhR0xAQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfBNIbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:31:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38132 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfBNIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:31:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so5138720wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QJEStO10BrnZ2B24LMVFy4GfmZeL/MrbI49P/PhmFYM=;
        b=xhR0xAQp6wqm1ZAu2R5vhtGuvhol4tTj9QxqAsvATX43QHImZafXW4utCoHqIzBO1p
         0Bvml6q+r+axr3EmRwgayNPntvwSX1aNw3etZUGiyDL5F+E8ICqzZfaio11gPhk2KJw6
         nmUSSkvrTRUVyg4NFkQadMgeIfQ/C/ukLVkB0foMhB4wA5MVzNIu95QRzsyIj00QrIdl
         /yzgheq8D1YRKJV5Xy/bZ8tl118z1PIA89KS4MdGUMSaMWRPqBMHmACC1rd/CknAYSyx
         TgYfXwp2nbnhgel0KRFbJq7B4gG1Z/rvzmojZMCExBckkIds0HL2NkQDeCNPSD+LBbcJ
         uLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QJEStO10BrnZ2B24LMVFy4GfmZeL/MrbI49P/PhmFYM=;
        b=pNVYTaRcU7OeN0qffmR04bg3HVo79RcdAXT1P3+qGv6Hty7ntatcC7bWyc/hf4ue26
         NjmIp/NQkTUh9UlA1NFcSfR49ZJQZaOQYSafDBdrZQ+CTAsRDfxykZTeZRkc/nhdTyRX
         9Q2SK+NE+bt8zCGEqXohHibSb+O454TgF/KvAoblz3IvS1KMIFOQgO0waMAHViMFYVmQ
         MXmDbqhO0jcuZ0HL1yXZYVWX0Y5N26s6ESHcy1e3O4petfnW5ZW6ckxBPVWnoZpx60Y1
         XQxgEZUd3XCAgcMb+cpk97NrHhy3rF+wijI8fYetqXoAsL03JZbernNNpEZAlw8gFuCb
         Ga1A==
X-Gm-Message-State: AHQUAubXeD3BBvlnb6rwG6TgxfTBeEvtIMoNppwJRoLk3J7dqb+TU/c7
        F1lhb4hDpsXExhSmr1SodvaKbw==
X-Google-Smtp-Source: AHgI3IZ5jqE8J2z5X3FrSGajwzhMwb9UGCvVdSlAcAyG42tLFy9ZOCEZqmei5K2EW2wto16CJq57lA==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr1704122wmc.38.1550133107624;
        Thu, 14 Feb 2019 00:31:47 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:104b:51c7:1dcf:5141:50b9:8a8])
        by smtp.gmail.com with ESMTPSA id q6sm944673wmq.4.2019.02.14.00.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 00:31:47 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     linux@armlinux.org.uk, arnd@arndb.de, alexandre.torgue@st.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        benjamin.gaignard@linaro.org
Subject: [PATCH v2 0/2] ARM errata 814220
Date:   Thu, 14 Feb 2019 09:31:43 +0100
Message-Id: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ARM errata 814220 for Cortex A7.

This patch has been wroten by Jason Liu years ago but never send upstream.
I have tried to contact the author on multiple email addresses but I haven't
found any valid one...
I have keep Jason's sign-off and just rebase the patch on to v5-rc6.

version 2:
- limite help lines to 80 columns.
- Add  Arnd Bergmann acks.
  
Benjamin Gaignard (2):
  ARM: errata 814220-B-Cache maintenance by set/way operations can
    execute out of order.
  ARM: stm32: select ARM errata 814220

 arch/arm/Kconfig            | 12 ++++++++++++
 arch/arm/mach-stm32/Kconfig |  1 +
 arch/arm/mm/cache-v7.S      |  3 +++
 3 files changed, 16 insertions(+)

-- 
2.15.0

