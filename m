Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DDDC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6AD2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6AD2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeKLGTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:19:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50474 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730424AbeKLFsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:21 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsh-0000l5-BV; Sun, 11 Nov 2018 19:58:51 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001rh-A7; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Max Filippov" <jcmvbkbc@gmail.com>,
        "Stephen Boyd" <sboyd@codeaurora.org>,
        "Krzysztof Kozlowski" <k.kozlowski@samsung.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.975907741@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 342/366] clk: si5351: Constify clock names and struct
 regmap_config
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

commit 8234caed27f7bce141c9fb1f7e76c91a2a66d248 upstream.

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const.

Replace doubled const in the arrays of clock names with proper const
pointer to const data. This fixes the warnings:

drivers/clk/clk-si5351.c:71:25: warning: duplicate const
drivers/clk/clk-si5351.c:74:25: warning: duplicate const
drivers/clk/clk-si5351.c:77:25: warning: duplicate const
drivers/clk/clk-si5351.c:80:25: warning: duplicate const

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/clk/clk-si5351.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -68,16 +68,16 @@ struct si5351_driver_data {
 	struct si5351_hw_data	*clkout;
 };
 
-static const char const *si5351_input_names[] = {
+static const char * const si5351_input_names[] = {
 	"xtal", "clkin"
 };
-static const char const *si5351_pll_names[] = {
+static const char * const si5351_pll_names[] = {
 	"plla", "pllb", "vxco"
 };
-static const char const *si5351_msynth_names[] = {
+static const char * const si5351_msynth_names[] = {
 	"ms0", "ms1", "ms2", "ms3", "ms4", "ms5", "ms6", "ms7"
 };
-static const char const *si5351_clkout_names[] = {
+static const char * const si5351_clkout_names[] = {
 	"clk0", "clk1", "clk2", "clk3", "clk4", "clk5", "clk6", "clk7"
 };
 
@@ -207,7 +207,7 @@ static bool si5351_regmap_is_writeable(s
 	return true;
 }
 
-static struct regmap_config si5351_regmap_config = {
+static const struct regmap_config si5351_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.cache_type = REGCACHE_RBTREE,

