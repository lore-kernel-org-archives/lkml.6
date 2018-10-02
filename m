Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D57C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AA62089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AA62089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbeJBUOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34018 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730860AbeJBUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:35 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 098C0BF0;
        Tue,  2 Oct 2018 13:31:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Akshu Agrawal <akshu.agrawal@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 223/228] clk: x86: Set default parent to 48Mhz
Date:   Tue,  2 Oct 2018 06:25:20 -0700
Message-Id: <20181002132512.522484975@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akshu Agrawal <akshu.agrawal@amd.com>

[ Upstream commit bded6c03e398dc6e862dc8301fb9a60175740653 ]

System clk provided in ST soc can be set to:
48Mhz, non-spread
25Mhz, spread
To get accurate rate, we need it to set it at non-spread
option which is 48Mhz.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Fixes: 421bf6a1f061 ("clk: x86: Add ST oscout platform clock")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/x86/clk-st.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-st.c
@@ -46,7 +46,7 @@ static int st_clk_probe(struct platform_
 		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
 		0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
 
-	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
+	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
 
 	hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
 		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,


