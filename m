Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282922089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282922089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeHPCWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:22:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:38101 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbeHPCWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:22:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7FNRBLj006078;
        Wed, 15 Aug 2018 18:27:17 -0500
Message-ID: <7ccdc39d7e255547e851497ef9f449715b45f8bd.camel@kernel.crashing.org>
Subject: [PATCH] platform/x86: acer-wmi: Silence "unsupported" message  a bit
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Lee, Chun-Yi" <jlee@suse.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 16 Aug 2018 09:27:10 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver prints that "Unsupported machine..." message on every boot on
ThinkPad X1 Carbon laptops (and I assume a number of other systems), which
causes graphical boots to "glitch" a bit and is rather annoying ...

Make it a pr_debug instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 8952173dd380..7f7192e8fdab 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2216,7 +2216,7 @@ static int __init acer_wmi_init(void)
        if (wmi_has_guid(AMW0_GUID1) &&
            !dmi_check_system(amw0_whitelist) &&
            quirks == &quirk_unknown) {
-               pr_err("Unsupported machine has AMW0_GUID1, unable to load\n");
+               pr_debug("Unsupported machine has AMW0_GUID1, unable to load\n");
                return -ENODEV;
        }
  

