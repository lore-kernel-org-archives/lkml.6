Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC25C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24182177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761895;
	bh=pxLK6hV3n8Bdm6DCTunTEpbKU9W5eK0SZUTJ5JLAQTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=weFOUeoAA99U6Qr8DTX4ElX6uJ4Bscr+EySKayX+fbKWQTkedF1pbJOMgdh0YwET6
	 DAk8jsqxUdiv36haTClyX9aNljDm5NvRHPFrzjgizCyz+Mssjvc9hZkwMrgKQ+QSOB
	 5QMLjyvg6PT2ckBoqVQakNyFi87u8CG/TyvYGQKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfA2LiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbfA2LiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6500F214DA;
        Tue, 29 Jan 2019 11:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761890;
        bh=pxLK6hV3n8Bdm6DCTunTEpbKU9W5eK0SZUTJ5JLAQTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yNdmxpf81zm2BSx9b4ExEEF09RhBLQ9LkmM8wggz903VKRgUq6n3Kkeh2vgRiMZsv
         O+mSnLAzGENNztUz5sSqCxlj3/emAXslBdWiHZz9R3Figzg/Oe6BMkORg16Xgf2gxt
         DlyKUT07xZ3GC9L+16JNps1BCrT22BvIxrGaWC4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-stable@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.20 037/117] clk: socfpga: stratix10: fix naming convention for the fixed-clocks
Date:   Tue, 29 Jan 2019 12:34:48 +0100
Message-Id: <20190129113209.458777345@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinh Nguyen <dinguyen@kernel.org>

commit b488517b28a47d16b228ce8dcf07f5cb8e5b3dc5 upstream.

The fixed clocks in the DTS file have a hyphen, but the clock driver has
the fixed clocks using underbar. Thus the clock driver cannot detect the
other fixed clocks correctly. Change the fixed clock names to a hyphen.

Fixes: 07afb8db7340 ("clk: socfpga: stratix10: add clock driver for
Stratix10 platform")
Cc: linux-stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/socfpga/clk-s10.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -12,17 +12,17 @@
 
 #include "stratix10-clk.h"
 
-static const char * const pll_mux[] = { "osc1", "cb_intosc_hs_div2_clk",
-					"f2s_free_clk",};
+static const char * const pll_mux[] = { "osc1", "cb-intosc-hs-div2-clk",
+					"f2s-free-clk",};
 static const char * const cntr_mux[] = { "main_pll", "periph_pll",
-					 "osc1", "cb_intosc_hs_div2_clk",
-					 "f2s_free_clk"};
-static const char * const boot_mux[] = { "osc1", "cb_intosc_hs_div2_clk",};
+					 "osc1", "cb-intosc-hs-div2-clk",
+					 "f2s-free-clk"};
+static const char * const boot_mux[] = { "osc1", "cb-intosc-hs-div2-clk",};
 
 static const char * const noc_free_mux[] = {"main_noc_base_clk",
 					    "peri_noc_base_clk",
-					    "osc1", "cb_intosc_hs_div2_clk",
-					    "f2s_free_clk"};
+					    "osc1", "cb-intosc-hs-div2-clk",
+					    "f2s-free-clk"};
 
 static const char * const emaca_free_mux[] = {"peri_emaca_clk", "boot_clk"};
 static const char * const emacb_free_mux[] = {"peri_emacb_clk", "boot_clk"};
@@ -33,14 +33,14 @@ static const char * const s2f_usr1_free_
 static const char * const psi_ref_free_mux[] = {"peri_psi_ref_clk", "boot_clk"};
 static const char * const mpu_mux[] = { "mpu_free_clk", "boot_clk",};
 
-static const char * const s2f_usr0_mux[] = {"f2s_free_clk", "boot_clk"};
+static const char * const s2f_usr0_mux[] = {"f2s-free-clk", "boot_clk"};
 static const char * const emac_mux[] = {"emaca_free_clk", "emacb_free_clk"};
 static const char * const noc_mux[] = {"noc_free_clk", "boot_clk"};
 
 static const char * const mpu_free_mux[] = {"main_mpu_base_clk",
 					    "peri_mpu_base_clk",
-					    "osc1", "cb_intosc_hs_div2_clk",
-					    "f2s_free_clk"};
+					    "osc1", "cb-intosc-hs-div2-clk",
+					    "f2s-free-clk"};
 
 /* clocks in AO (always on) controller */
 static const struct stratix10_pll_clock s10_pll_clks[] = {


