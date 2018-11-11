Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E28C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D98020866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D98020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeKLAIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:08:48 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55072 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727817AbeKLAIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:08:48 -0500
X-Greylist: delayed 1869 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2018 19:08:47 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wABDHN9p031814;
        Sun, 11 Nov 2018 15:17:24 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id 2C4C462EDE; Sun, 11 Nov 2018 15:47:22 +0200 (IST)
From:   tali.perry1@gmail.com
To:     brendanhiggins@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        avifishman70@gmail.com, tmaimon77@gmail.com, raltherr@google.com,
        mturquette@baylibre.com, sboyd@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH v1 0/1] clk: npcm7xx: fix base address and of_clk_get_by_name
Date:   Sun, 11 Nov 2018 15:47:11 +0200
Message-Id: <20181111134712.318321-1-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tali Perry <tali.perry1@gmail.com>

Nuvoton NPCM7XX Clock Controller
fix base address and of_clk_get_by_name error handling.
    Also update error messages to be more informative.
    
    In case clk_base allocation is erronoeous the return value is null.
    Also fix handling of of_clk_get_by_name returns an error. 
    Print a better error message pointing to the dt-binding documention.

This patch is re-submitted since it was already pushed to main 
(just the diff, without the full driver which is already in 
master branch.)


Signed-off-by: Tali Perry <tali.perry1@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

---

Tali Perry (1):
  clk: npcm7xx: get fixed clocks from DT

 drivers/clk/clk-npcm7xx.c | 99 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 75 insertions(+), 24 deletions(-)

-- 
2.14.1

