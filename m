Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC586C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8FD20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763418;
	bh=Hxd9HDSCeg+vyKObaunUQ6jWywxW09nCCHijDj1k7EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wGUq/uAIGuF8ndNPP3XyohikG7IRUWeS7/C//CxtfiOmHF/E0XTJu85VK1owH2bjU
	 psIYbDHee82UnxnMrqnIK+XGFEzqQzGqzo4fI6JvEN9/zaCki93GxtFc2wS9RSDZ5X
	 t+qADhgsO0jQg7hASFCk4+vGvjTNcPK8lDvk8NDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfA2Lnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbfA2Lnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCDC820856;
        Tue, 29 Jan 2019 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762218;
        bh=Hxd9HDSCeg+vyKObaunUQ6jWywxW09nCCHijDj1k7EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACjN3Kjka3H5j5cchWRpvdoaUJYfKsFPJUuPu3zDELboZboyFglh1vuUW0YNiUPLZ
         h+xWdMwyWh4aPLjhaBsGjbjF5leLTh4jhZTYVLnG+VHBMTmEpwGshjIHApk5ulOk+h
         xTHkxGjp4PxohxRdEUkBfnUN6WChAJcdZ+gq7pBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-stable@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.19 032/103] clk: socfpga: stratix10: fix naming convention for the fixed-clocks
Date:   Tue, 29 Jan 2019 12:35:09 +0100
Message-Id: <20190129113201.487034014@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


